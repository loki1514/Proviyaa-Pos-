// Real Supabase Auth wiring — compiles against the current
// supabase_flutter 2.17.2 API and uses the project's publishable key
// already confirmed by the owner (Q04, in .env.local). This has NOT
// been exercised against the live project: there is no Supabase MCP
// access in this environment to inspect what auth/staff schema
// actually exists there, and no test account exists to sign in with —
// entering or generating account credentials is not something this
// session does. Treat this class as "correct against the documented
// SDK, unverified against the real backend" until someone with a real
// staff login tries it.
//
// staffName in particular is a guess: Supabase Auth's signInWithPassword
// only returns the auth user (id, email, user_metadata) — it says
// nothing about the actual staff/role/membership schema PRD §5 and §7
// describe (Product Architecture §5 "Merchant Actors": Owner, Manager,
// Cashier, Kitchen Staff...). That schema lives in the central database
// this repo cannot inspect yet. Falling back to user_metadata or the
// email keeps this class honest about what it actually knows, rather
// than inventing a `staff` table shape here — a competing schema this
// repo isn't allowed to define (D06: Proviyaa OS owns central
// contracts).

import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../application/auth_service.dart';

class SupabaseAuthBackend implements AuthBackend {
  SupabaseAuthBackend(this._client);
  final supabase.SupabaseClient _client;

  @override
  Future<({String staffId, String staffName})> signInWithPassword(
      {required String email, required String password}) async {
    final response =
        await _client.auth.signInWithPassword(email: email, password: password);
    final user = response.user;
    if (user == null) {
      throw StateError('Sign-in returned no user for $email.');
    }
    final metadataName = user.userMetadata?['full_name'] as String?;
    return (staffId: user.id, staffName: metadataName ?? email);
  }
}

/// Initializes the Supabase client from the same allowlisted
/// --dart-define values tool/run_local.sh already passes (see
/// lib/config/app_config.dart) — never a service-role key or database
/// password, per the standing rule in README.md and D06.
Future<supabase.SupabaseClient> initSupabaseClient(
    {required String url, required String publishableKey}) async {
  await supabase.Supabase.initialize(url: url, publishableKey: publishableKey);
  return supabase.Supabase.instance.client;
}
