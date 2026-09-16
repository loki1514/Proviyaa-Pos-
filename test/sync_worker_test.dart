import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proviyaa_pos/application/kitchen_service.dart';
import 'package:proviyaa_pos/application/order_service.dart';
import 'package:proviyaa_pos/application/sync_worker.dart';
import 'package:proviyaa_pos/data/app_database.dart';
import 'package:proviyaa_pos/data/drift_kitchen_store.dart';
import 'package:proviyaa_pos/data/drift_local_store.dart';
import 'package:proviyaa_pos/data/drift_sync_outbox_store.dart';
import 'package:proviyaa_pos/domain/order.dart';

/// A scriptable fake transport — the real transport doesn't exist yet
/// (no authorized-command API is live; PRD §10 calls its own contracts
/// "proposals, not existing endpoints"), so this stands in to prove the
/// retry/idempotency logic around whatever transport is eventually
/// plugged in.
class _FakeTransport implements CommandTransport {
  _FakeTransport(this._outcomes);
  final Map<String, CommandOutcome> _outcomes;
  final calls = <String>[];

  @override
  Future<CommandOutcome> submit(
      {required String commandId,
      required String operation,
      required String payloadHash}) async {
    calls.add(commandId);
    return _outcomes[commandId] ?? CommandOutcome.accepted;
  }
}

class _ThrowingTransport implements CommandTransport {
  @override
  Future<CommandOutcome> submit(
      {required String commandId,
      required String operation,
      required String payloadHash}) {
    throw Exception('network unreachable');
  }
}

void main() {
  group('SyncWorker', () {
    late AppDatabase db;
    late DriftSyncOutboxStore outbox;

    setUp(() => db = AppDatabase(NativeDatabase.memory()));
    tearDown(() => db.close());

    Future<void> aSavedOrder(String id) async {
      await OrderService(DriftLocalStore(db)).saveCashOrder(
          clientOrderId: id,
          locationId: 'loc-1',
          orderType: OrderType.takeaway,
          lines: const [
            OrderLine(
                itemId: 'chai', name: 'Chai', unitMinor: 1200, quantity: 1)
          ]);
    }

    test('an accepted command marks its intent synchronized', () async {
      outbox = DriftSyncOutboxStore(db);
      await aSavedOrder('order-1');
      final worker = SyncWorker(outbox, _FakeTransport({}));

      final result = await worker.flushOnce();

      expect(result.submitted, 1);
      expect(result.synchronized, 1);
      final intents = await outbox.listQueued();
      expect(intents, isEmpty,
          reason: 'synchronized intents leave the queued list');
    });

    test('a duplicate outcome is treated the same as accepted', () async {
      outbox = DriftSyncOutboxStore(db);
      await aSavedOrder('order-2');
      final intentId = (await outbox.listQueued()).single.intentId;
      final worker = SyncWorker(
          outbox, _FakeTransport({intentId: CommandOutcome.duplicate}));

      final result = await worker.flushOnce();

      expect(result.synchronized, 1);
      expect(result.needsReview, 0);
    });

    test('a rejected command needs review and does not block other intents',
        () async {
      outbox = DriftSyncOutboxStore(db);
      await aSavedOrder('order-3');
      await aSavedOrder('order-4');
      final intents = await outbox.listQueued();
      final rejectedId = intents.first.intentId;
      final worker = SyncWorker(
          outbox, _FakeTransport({rejectedId: CommandOutcome.rejected}));

      final result = await worker.flushOnce();

      expect(result.submitted, 2);
      expect(result.needsReview, 1);
      expect(result.synchronized, 1);
    });

    test('a conflict is treated like a rejection, not a success', () async {
      outbox = DriftSyncOutboxStore(db);
      await aSavedOrder('order-5');
      final intentId = (await outbox.listQueued()).single.intentId;
      final worker = SyncWorker(
          outbox, _FakeTransport({intentId: CommandOutcome.conflict}));

      final result = await worker.flushOnce();

      expect(result.needsReview, 1);
      expect(result.synchronized, 0);
    });

    test(
        'a network failure increments retry count and leaves the intent queued',
        () async {
      outbox = DriftSyncOutboxStore(db);
      await aSavedOrder('order-6');
      final worker = SyncWorker(outbox, _ThrowingTransport());

      final result = await worker.flushOnce();

      expect(result.retried, 1);
      final stillQueued = await outbox.listQueued();
      expect(stillQueued, hasLength(1));
      expect(stillQueued.single.retryCount, 1);
    });

    test('flushing an empty outbox is a safe no-op', () async {
      outbox = DriftSyncOutboxStore(db);
      final worker = SyncWorker(outbox, _FakeTransport({}));
      final result = await worker.flushOnce();
      expect(result.submitted, 0);
    });

    test(
        'kitchen tickets do not create their own sync intents (only orders do, for now)',
        () async {
      outbox = DriftSyncOutboxStore(db);
      await aSavedOrder('order-7');
      final localStore = DriftLocalStore(db);
      final order = await localStore.findOrder('order-7');
      await KitchenService(DriftKitchenStore(db)).createTicketForOrder(order!);

      final intents = await outbox.listQueued();
      expect(intents, hasLength(1),
          reason: 'still just the one create-order intent');
    });
  });
}
