// PowerSync connector — SPIKE ONLY, not wired into the running app.
// Q05 in docs/DECISIONS-AND-QUESTIONS.txt asks for a compatibility/cost
// spike before any production rollout; this is that spike's client-side
// half. It has never connected to a live PowerSync instance — none
// exists (that needs a PowerSync Cloud account, which this session does
// not create — see the chat turn that reported this) — so this class is
// "compiles against the documented SDK," not "tested against a real
// sync."
//
// IMPORTANT ARCHITECTURAL FINDING for the go/no-go decision: adopting
// PowerSync would REPLACE lib/application/sync_worker.dart's outbox,
// not sit alongside it. PowerSync tracks local writes itself (via
// SQLite triggers on watched tables) into its own CRUD queue, and
// uploadData() below reads from THAT queue — not from our
// pending_upload_intents table. Standing up both would be exactly the
// "second competing queue" D05 explicitly forbids. The two are
// alternatives, not complements.
//
// The coexistence pattern for our existing Drift schema (confirmed via
// PowerSync's own docs): our AppDatabase class doesn't change at all —
// it already takes a plain QueryExecutor. Only the connection
// construction would change, from drift_flutter's driftDatabase() to
// SqliteAsyncDriftConnection(powerSyncDatabase):
//
//   final powerSyncDb = PowerSyncDatabase(schema: schema, path: ...);
//   final db = AppDatabase(SqliteAsyncDriftConnection(powerSyncDb));
//
// None of our table definitions in app_database.dart would need to
// change for that swap.

import 'package:powersync/powersync.dart';

/// Fetches a PowerSync auth token from the app's existing Supabase
/// session — PowerSync's own Supabase integration guide has the
/// PowerSync Service validate the same Supabase JWT directly when
/// configured with Supabase Auth in its Client Auth settings (a
/// dashboard step, not code). No separate PowerSync-specific login
/// exists in this design.
class SupabasePowerSyncConnector extends PowerSyncBackendConnector {
  SupabasePowerSyncConnector(
      {required this.powerSyncUrl, required this.fetchSupabaseAccessToken});

  /// e.g. `https://your-instance.powersync.journeyapps.com` — created in the
  /// PowerSync dashboard once an instance exists; there is no such
  /// instance yet.
  final String powerSyncUrl;

  /// Returns the current Supabase session's access token, or null if
  /// signed out. Kept as an injected function rather than a direct
  /// Supabase dependency here, so this file doesn't assume which
  /// AuthBackend is active.
  final Future<String?> Function() fetchSupabaseAccessToken;

  @override
  Future<PowerSyncCredentials?> fetchCredentials() async {
    final token = await fetchSupabaseAccessToken();
    if (token == null) return null;
    return PowerSyncCredentials(endpoint: powerSyncUrl, token: token);
  }

  @override
  Future<void> uploadData(PowerSyncDatabase database) async {
    // Deliberately unimplemented — see the file header. Implementing
    // this for real means committing to PowerSync's own CRUD queue as
    // the one outbox, which is exactly the go/no-go decision Q05 asks
    // the owner to make, not something to decide unilaterally here.
    throw UnimplementedError(
        'PowerSync upload is not wired in — see Q05 in docs/DECISIONS-AND-QUESTIONS.txt. '
        'This would replace, not extend, SyncWorker/CommandTransport.');
  }
}
