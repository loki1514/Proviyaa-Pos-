// Superseded by the real Drift schema in `app_database.dart` (tables
// `Orders`, `OrderLines`, `PendingUploadIntents`) — see R17 in
// docs/REQUIREMENT-TRACEABILITY.txt. This class is no longer referenced
// anywhere; kept only so the table shapes it originally proposed stay in
// the repository's history instead of disappearing silently.
//
// ignore_for_file: unused_element
class SqliteSchema {
  static const currentVersion = 1;
  static const createStatements = <String>[
    'CREATE TABLE orders (client_order_id TEXT PRIMARY KEY, location_id TEXT NOT NULL, currency_code TEXT NOT NULL, status TEXT NOT NULL, created_at TEXT NOT NULL)',
    'CREATE TABLE order_lines (client_order_id TEXT NOT NULL, item_id TEXT NOT NULL, name TEXT NOT NULL, unit_minor INTEGER NOT NULL, quantity INTEGER NOT NULL, PRIMARY KEY (client_order_id, item_id))',
    'CREATE TABLE pending_upload_intents (intent_id TEXT PRIMARY KEY, client_order_id TEXT NOT NULL, operation TEXT NOT NULL, payload_hash TEXT NOT NULL, state TEXT NOT NULL, retry_count INTEGER NOT NULL DEFAULT 0, created_at TEXT NOT NULL, UNIQUE (client_order_id, operation))',
  ];
}
