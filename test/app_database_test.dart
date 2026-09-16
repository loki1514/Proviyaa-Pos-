import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proviyaa_pos/application/order_service.dart';
import 'package:proviyaa_pos/data/app_database.dart';
import 'package:proviyaa_pos/data/drift_local_store.dart';
import 'package:proviyaa_pos/domain/order.dart';

void main() {
  group('AppDatabase (Drift/SQLite)', () {
    test('creates all tables automatically on first launch', () async {
      final dir = await Directory.systemTemp.createTemp('proviyaa_pos_db_');
      final file = File('${dir.path}/first_launch.sqlite');
      addTearDown(() => dir.delete(recursive: true));

      expect(await file.exists(), isFalse,
          reason: 'the database file must not exist before first open');

      final db = AppDatabase(NativeDatabase(file));
      final tableNames = await db
          .customSelect("SELECT name FROM sqlite_master WHERE type = 'table'")
          .map((row) => row.read<String>('name'))
          .get();
      await db.close();

      expect(await file.exists(), isTrue,
          reason: 'opening the database must auto-create the file');
      expect(
          tableNames,
          containsAll(
              <String>['orders', 'order_lines', 'pending_upload_intents']));
    });

    test('saves a cash order with pending status and totals', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final store = DriftLocalStore(db);

      final order = await OrderService(store).saveCashOrder(
          clientOrderId: 'order-1',
          locationId: 'location-demo',
          orderType: OrderType.takeaway,
          lines: const [
            OrderLine(
                itemId: 'chai',
                name: 'Masala Chai',
                unitMinor: 1200,
                quantity: 2)
          ]);

      expect(order.status, LocalOrderStatus.pendingUpload);
      expect(order.subtotalMinor, 2400);
      expect((await store.findOrder('order-1'))?.clientOrderId, 'order-1');
    });

    test('local replay is idempotent', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final store = DriftLocalStore(db);
      final svc = OrderService(store);

      const lines = [
        OrderLine(itemId: 'dal', name: 'Dal', unitMinor: 1800, quantity: 1)
      ];
      await svc.saveCashOrder(
          clientOrderId: 'order-2',
          locationId: 'location-demo',
          orderType: OrderType.takeaway,
          lines: lines);
      await svc.saveCashOrder(
          clientOrderId: 'order-2',
          locationId: 'location-demo',
          orderType: OrderType.takeaway,
          lines: lines);

      expect((await store.findOrder('order-2'))?.subtotalMinor, 1800);
      final lineCount = await db.select(db.orderLines).get();
      expect(lineCount.length, 1,
          reason: 'a replayed save must not duplicate order lines either');
    });

    test('local data survives an interrupted session (close and reopen)',
        () async {
      final dir = await Directory.systemTemp.createTemp('proviyaa_pos_db_');
      final file = File('${dir.path}/recovery.sqlite');
      addTearDown(() => dir.delete(recursive: true));

      // Simulate the shift being interrupted right after a cash sale is
      // saved locally but before it has synced anywhere.
      final firstSession = AppDatabase(NativeDatabase(file));
      await DriftLocalStore(firstSession).saveOrderWithPendingIntent(
          const LocalOrder(
              clientOrderId: 'order-3',
              locationId: 'location-demo',
              currencyCode: 'INR',
              status: LocalOrderStatus.pendingUpload,
              orderType: OrderType.dineIn,
              tableLabel: 'T7',
              lines: [
            OrderLine(
                itemId: 'thali',
                name: 'Veg Thali',
                unitMinor: 22000,
                quantity: 1)
          ]));
      await firstSession.close();

      // App restarts and reopens the same on-disk file.
      final secondSession = AppDatabase(NativeDatabase(file));
      addTearDown(secondSession.close);
      final recovered =
          await DriftLocalStore(secondSession).findOrder('order-3');

      expect(recovered, isNotNull);
      expect(recovered!.status, LocalOrderStatus.pendingUpload);
      expect(recovered.subtotalMinor, 22000);

      // Reopening an existing file must not rerun onCreate/drop data: the
      // pending-upload intent recorded before the "restart" must still be
      // there, queued, with no automatic deletion of unsynced records.
      final intents =
          await secondSession.select(secondSession.pendingUploadIntents).get();
      expect(intents, hasLength(1));
      expect(intents.single.clientOrderId, 'order-3');
      expect(intents.single.state, 'queued');
    });
  });
}
