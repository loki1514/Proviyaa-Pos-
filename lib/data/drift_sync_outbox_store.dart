import 'package:drift/drift.dart';

import '../application/sync_worker.dart';
import '../domain/sync_intent.dart';
import 'app_database.dart';

class DriftSyncOutboxStore implements SyncOutboxStore {
  DriftSyncOutboxStore(this._db);
  final AppDatabase _db;

  @override
  Future<List<SyncIntent>> listQueued() async {
    final rows = await (_db.select(_db.pendingUploadIntents)
          ..where((t) => t.state.equals(SyncIntentState.queued.name))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
    return rows.map(_toDomain).toList(growable: false);
  }

  @override
  Future<void> markSynchronized(String intentId) =>
      _setState(intentId, SyncIntentState.synchronized);

  @override
  Future<void> markNeedsReview(String intentId) =>
      _setState(intentId, SyncIntentState.needsReview);

  Future<void> _setState(String intentId, SyncIntentState state) async {
    await (_db.update(_db.pendingUploadIntents)
          ..where((t) => t.intentId.equals(intentId)))
        .write(PendingUploadIntentsCompanion(state: Value(state.name)));
  }

  @override
  Future<void> incrementRetry(String intentId) async {
    final row = await (_db.select(_db.pendingUploadIntents)
          ..where((t) => t.intentId.equals(intentId)))
        .getSingleOrNull();
    if (row == null) return;
    await (_db.update(_db.pendingUploadIntents)
          ..where((t) => t.intentId.equals(intentId)))
        .write(PendingUploadIntentsCompanion(
            retryCount: Value(row.retryCount + 1)));
  }

  SyncIntent _toDomain(PendingUploadIntentRow row) => SyncIntent(
      intentId: row.intentId,
      clientOrderId: row.clientOrderId,
      operation: row.operation,
      payloadHash: row.payloadHash,
      state: SyncIntentState.values.byName(row.state),
      retryCount: row.retryCount,
      createdAt: row.createdAt);
}
