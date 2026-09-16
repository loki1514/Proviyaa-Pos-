// Auth/device-bootstrap service — PRD §7. Deliberately split in two:
// the online sign-in call (AuthBackend, real network, requires
// connectivity) and the offline-grant cache (DeviceSessionStore, real
// local persistence, no network at all). A device that has signed in
// once can keep working for D04's 24-hour window without asking the
// network anything.

import '../domain/staff_session.dart';

abstract interface class DeviceSessionStore {
  Future<void> saveGrant(StaffSession session);
  Future<StaffSession?> findGrant(String deviceId);
  Future<void> clearGrant(String deviceId);
}

/// The online half. Throws on failure — no network, wrong password,
/// account disabled, etc. — the caller decides what to show; this
/// service does not swallow or reinterpret auth errors.
abstract interface class AuthBackend {
  Future<({String staffId, String staffName})> signInWithPassword(
      {required String email, required String password});
}

class AuthService {
  AuthService(this.backend, this.store,
      {this.offlineGrantDuration = const Duration(hours: 24)});
  final AuthBackend backend;
  final DeviceSessionStore store;
  final Duration offlineGrantDuration;

  /// Online sign-in. Requires connectivity (PRD §7: "New cloud
  /// authentication and password resets require connectivity") and, on
  /// success, refreshes this device's offline grant so later startups
  /// don't need the network again until it expires.
  Future<StaffSession> signIn(
      {required String email,
      required String password,
      required String deviceId,
      required String locationId}) async {
    final result =
        await backend.signInWithPassword(email: email, password: password);
    final now = DateTime.now();
    final session = StaffSession(
        staffId: result.staffId,
        staffName: result.staffName,
        deviceId: deviceId,
        locationId: locationId,
        grantedAt: now,
        grantExpiresAt: now.add(offlineGrantDuration));
    await store.saveGrant(session);
    return session;
  }

  /// The offline half — PRD §7: "Later startup can use the cached
  /// offline grant and local staff unlock." No network call at all.
  /// Returns null for "no grant on this device" and a session with
  /// `isValid == false` for "grant exists but expired" — those are
  /// different states a caller needs to tell apart (PRD §11: an
  /// expired grant still preserves data and allows finishing open
  /// work; it only denies *new* privileged work).
  Future<StaffSession?> currentGrant(String deviceId) =>
      store.findGrant(deviceId);

  Future<void> signOut(String deviceId) => store.clearGrant(deviceId);
}
