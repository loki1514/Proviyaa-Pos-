import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// The device-local working store. This is a restricted store for the
/// current shift's local data and unsent pending-upload intents — it is
/// not a second independent cloud backend. Central Postgres, reached
/// through the authorized sync adapter, remains the reconciled business
/// record. See docs/SOURCE-UNDERSTANDING.txt section 2.

@DataClassName('OrderRow')
class Orders extends Table {
  TextColumn get clientOrderId => text()();
  TextColumn get locationId => text()();
  TextColumn get currencyCode => text()();
  TextColumn get status => text()();
  TextColumn get orderType => text()();
  TextColumn get tableLabel => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {clientOrderId};
}

@DataClassName('OrderLineRow')
class OrderLines extends Table {
  TextColumn get clientOrderId => text()();
  TextColumn get itemId => text()();
  TextColumn get name => text()();
  IntColumn get unitMinor => integer()();
  IntColumn get quantity => integer()();

  @override
  Set<Column> get primaryKey => {clientOrderId, itemId};
}

@DataClassName('PendingUploadIntentRow')
class PendingUploadIntents extends Table {
  TextColumn get intentId => text()();
  TextColumn get clientOrderId => text()();
  TextColumn get operation => text()();
  TextColumn get payloadHash => text()();
  TextColumn get state => text().withDefault(const Constant('queued'))();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {intentId};

  @override
  List<Set<Column>> get uniqueKeys => [
        {clientOrderId, operation},
      ];
}

@DataClassName('KitchenTicketRow')
class KitchenTickets extends Table {
  TextColumn get ticketId => text()();
  TextColumn get clientOrderId => text()();
  TextColumn get status => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {ticketId};
}

@DataClassName('ShiftRow')
class Shifts extends Table {
  TextColumn get shiftId => text()();
  TextColumn get locationId => text()();
  IntColumn get openingFloatMinor => integer()();
  DateTimeColumn get openedAt => dateTime()();
  DateTimeColumn get closedAt => dateTime().nullable()();
  IntColumn get countedCashMinor => integer().nullable()();

  @override
  Set<Column> get primaryKey => {shiftId};
}

@DataClassName('PaymentRow')
class Payments extends Table {
  TextColumn get paymentId => text()();
  TextColumn get clientOrderId => text()();
  TextColumn get method => text()();
  IntColumn get amountMinor => integer()();
  IntColumn get receivedMinor => integer()();
  DateTimeColumn get recordedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {paymentId};

  @override
  List<Set<Column>> get uniqueKeys => [
        {clientOrderId},
      ];
}

/// Cached offline authorization grant — PRD §11 "Expired offline grant:
/// preserve data and allow designated recovery/finish-open-work
/// behavior" and D04: 24-hour offline staff authorization, one row per
/// device (this device serves one location, D02).
@DataClassName('DeviceSessionRow')
class DeviceSessions extends Table {
  TextColumn get deviceId => text()();
  TextColumn get staffId => text()();
  TextColumn get staffName => text()();
  TextColumn get locationId => text()();
  DateTimeColumn get grantedAt => dateTime()();
  DateTimeColumn get grantExpiresAt => dateTime()();

  @override
  Set<Column> get primaryKey => {deviceId};
}

@DriftDatabase(tables: [
  Orders,
  OrderLines,
  PendingUploadIntents,
  KitchenTickets,
  Shifts,
  Payments,
  DeviceSessions
])
class AppDatabase extends _$AppDatabase {
  /// Kept for tests and any caller that wants to hand in its own
  /// [QueryExecutor] (e.g. an in-memory database).
  AppDatabase(super.executor);

  /// The real on-device database: auto-creates `proviyaa_pos.sqlite` under
  /// the platform's application-documents directory on first launch, via
  /// package:drift_flutter (native on Windows/macOS/Linux/Android/iOS).
  ///
  /// The `web:` option is required, not optional, for a web build —
  /// drift_flutter throws ArgumentError at runtime without it (see
  /// drift_flutter's own web.dart) — but is simply ignored on every
  /// native platform, so one call serves both without a conditional
  /// import. `sqlite3.wasm` and `drift_worker.js` are real files
  /// checked into web/ (a released sqlite3.dart build matching the
  /// pinned `sqlite3` package version, and drift's own prebuilt
  /// worker), not placeholders.
  AppDatabase.defaults()
      : super(driftDatabase(
            name: 'proviyaa_pos',
            web: DriftWebOptions(
                sqlite3Wasm: Uri.parse('sqlite3.wasm'),
                driftWorker: Uri.parse('drift_worker.js'))));

  // Bump this and add a numbered step under `migration` whenever the
  // schema changes. Never drop or recreate a table that may hold unsynced
  // data — local orders and pending_upload_intents rows must survive
  // every upgrade; see D10 in docs/DECISIONS-AND-QUESTIONS.txt.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        // No upgrade steps yet — this is the first shipped schema. When
        // v2 lands, add an explicit `if (from < 2) { ... }` step here
        // that alters/adds rather than recreates, so existing local
        // orders and pending upload intents are preserved.
      );
}
