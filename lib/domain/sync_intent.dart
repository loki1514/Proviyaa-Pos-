// Sync outbox domain — PRD §10 "Integration contracts": "Retry with the
// same ID and same payload returns the original result; same ID/
// different payload is rejected." The pending_upload_intents table
// already existed (R04); this gives its rows a real status vocabulary
// instead of the raw 'queued' string the table defaulted to.

enum SyncIntentState { queued, synchronized, needsReview }

class SyncIntent {
  const SyncIntent(
      {required this.intentId,
      required this.clientOrderId,
      required this.operation,
      required this.payloadHash,
      required this.state,
      required this.retryCount,
      required this.createdAt});
  final String intentId, clientOrderId, operation, payloadHash;
  final SyncIntentState state;
  final int retryCount;
  final DateTime createdAt;
}
