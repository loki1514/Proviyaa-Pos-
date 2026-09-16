// Staff/device session domain — PRD §7 bootstrap: "Secure online
// enrollment binds device, organization and location... Later startup
// can use the cached offline grant and local staff unlock. New cloud
// authentication and password resets require connectivity." D04: 24
// hour offline staff authorization.

class StaffSession {
  const StaffSession(
      {required this.staffId,
      required this.staffName,
      required this.deviceId,
      required this.locationId,
      required this.grantedAt,
      required this.grantExpiresAt});
  final String staffId, staffName, deviceId, locationId;
  final DateTime grantedAt, grantExpiresAt;

  /// PRD §11: "Expired offline grant: preserve data and allow
  /// designated recovery/finish-open-work behavior; privileged new work
  /// is denied." This flag is how a caller tells those two cases apart
  /// — the row itself is never deleted just because it expired.
  bool get isValid => DateTime.now().isBefore(grantExpiresAt);
}
