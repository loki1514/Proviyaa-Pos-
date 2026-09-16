import 'package:drift/drift.dart';

import '../application/kitchen_service.dart';
import '../domain/kitchen_ticket.dart';
import 'app_database.dart';

class DriftKitchenStore implements KitchenLocalStore {
  DriftKitchenStore(this._db);
  final AppDatabase _db;

  @override
  Future<void> createTicket(KitchenTicket ticket) async {
    await _db.into(_db.kitchenTickets).insert(
        KitchenTicketsCompanion.insert(
            ticketId: ticket.ticketId,
            clientOrderId: ticket.clientOrderId,
            status: ticket.status.name,
            createdAt: Value(ticket.createdAt)),
        mode: InsertMode.insertOrIgnore);
  }

  @override
  Future<KitchenTicket?> findTicket(String ticketId) async {
    final row = await (_db.select(_db.kitchenTickets)
          ..where((t) => t.ticketId.equals(ticketId)))
        .getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  @override
  Future<void> advanceStatus(String ticketId, KitchenTicketStatus to) async {
    await (_db.update(_db.kitchenTickets)
          ..where((t) => t.ticketId.equals(ticketId)))
        .write(KitchenTicketsCompanion(status: Value(to.name)));
  }

  @override
  Future<List<KitchenTicket>> listOpen() async {
    final rows = await (_db.select(_db.kitchenTickets)
          ..where(
              (t) => t.status.isNotValue(KitchenTicketStatus.completed.name))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
    return rows.map(_toDomain).toList(growable: false);
  }

  KitchenTicket _toDomain(KitchenTicketRow row) => KitchenTicket(
      ticketId: row.ticketId,
      clientOrderId: row.clientOrderId,
      status: KitchenTicketStatus.values.byName(row.status),
      createdAt: row.createdAt);
}
