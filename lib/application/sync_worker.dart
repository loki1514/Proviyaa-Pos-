// Sync/outbox worker — PRD §10 "Integration contracts" and §6 ("the
// sync worker submits pending commands and receives server results").
// This is the piece R04/R09 were missing: durable local save existed,
// but nothing ever tried to send it anywhere. CommandTransport is
// deliberately just an interface — no real authorized-command API
// exists yet (PRD §10 itself: "proposals, not existing endpoints"), and
// this repo does not get to invent one unilaterally (D06: Proviyaa OS
// owns central contracts). What's real here is the retry/idempotency
// logic around whatever transport eventually gets plugged in.

import '../domain/sync_intent.dart';

abstract interface class SyncOutboxStore {
  Future<List<SyncIntent>> listQueued();
  Future<void> markSynchronized(String intentId);
  Future<void> markNeedsReview(String intentId);
  Future<void> incrementRetry(String intentId);
}

enum CommandOutcome { accepted, duplicate, rejected, conflict }

abstract interface class CommandTransport {
  /// Submits one command. Must be safe to call twice with the same
  /// (commandId, payloadHash) — PRD §10: "Retry with the same ID and
  /// same payload returns the original result [accepted/duplicate];
  /// same ID/different payload is rejected."
  Future<CommandOutcome> submit(
      {required String commandId,
      required String operation,
      required String payloadHash});
}

class SyncFlushResult {
  const SyncFlushResult(
      {required this.submitted,
      required this.synchronized,
      required this.needsReview,
      required this.retried});
  final int submitted, synchronized, needsReview, retried;
}

class SyncWorker {
  const SyncWorker(this.store, this.transport);
  final SyncOutboxStore store;
  final CommandTransport transport;

  /// Submits every queued intent once. A rejected/conflicted or
  /// network-failed intent does not stop the rest of the queue — PRD
  /// §6: "The server may reject a local command; rejection creates a
  /// visible reconciliation issue rather than silently deleting the
  /// sale," and retries are an expected, ordinary occurrence, not a
  /// failure of the whole flush.
  Future<SyncFlushResult> flushOnce() async {
    final pending = await store.listQueued();
    var synchronized = 0, needsReview = 0, retried = 0;

    for (final intent in pending) {
      try {
        final outcome = await transport.submit(
            commandId: intent.intentId,
            operation: intent.operation,
            payloadHash: intent.payloadHash);
        switch (outcome) {
          case CommandOutcome.accepted:
          case CommandOutcome.duplicate:
            // Both mean the server now has exactly one business effect
            // for this command — that is the whole point of an
            // idempotent submit, and both are a local success.
            await store.markSynchronized(intent.intentId);
            synchronized++;
          case CommandOutcome.rejected:
          case CommandOutcome.conflict:
            await store.markNeedsReview(intent.intentId);
            needsReview++;
        }
      } catch (_) {
        // Transport/network failure, not a business rejection — stays
        // queued for the next flush rather than being marked as a
        // reconciliation issue.
        await store.incrementRetry(intent.intentId);
        retried++;
      }
    }

    return SyncFlushResult(
        submitted: pending.length,
        synchronized: synchronized,
        needsReview: needsReview,
        retried: retried);
  }
}
