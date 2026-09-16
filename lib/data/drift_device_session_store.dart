import '../application/auth_service.dart';
import '../domain/staff_session.dart';
import 'app_database.dart';

class DriftDeviceSessionStore implements DeviceSessionStore {
  DriftDeviceSessionStore(this._db);
  final AppDatabase _db;

  @override
  Future<void> saveGrant(StaffSession session) async {
    await _db.into(_db.deviceSessions).insertOnConflictUpdate(
        DeviceSessionsCompanion.insert(
            deviceId: session.deviceId,
            staffId: session.staffId,
            staffName: session.staffName,
            locationId: session.locationId,
            grantedAt: session.grantedAt,
            grantExpiresAt: session.grantExpiresAt));
  }

  @override
  Future<StaffSession?> findGrant(String deviceId) async {
    final row = await (_db.select(_db.deviceSessions)
          ..where((t) => t.deviceId.equals(deviceId)))
        .getSingleOrNull();
    if (row == null) return null;
    return StaffSession(
        staffId: row.staffId,
        staffName: row.staffName,
        deviceId: row.deviceId,
        locationId: row.locationId,
        grantedAt: row.grantedAt,
        grantExpiresAt: row.grantExpiresAt);
  }

  @override
  Future<void> clearGrant(String deviceId) async {
    await (_db.delete(_db.deviceSessions)
          ..where((t) => t.deviceId.equals(deviceId)))
        .go();
  }
}
