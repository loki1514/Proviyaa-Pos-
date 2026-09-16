import '../domain/dine_in_status.dart';

class DineInTable {
  const DineInTable(
      {required this.label,
      required this.status,
      this.seats,
      this.guestCount,
      this.elapsedMinutes,
      this.orderTotalMinor});

  final String label;
  final DineInTableStatus status;

  /// Available only.
  final int? seats;

  /// Ready / Waiting KOT / Preparing / Payment Pending only.
  final int? guestCount;
  final int? elapsedMinutes;
  final int? orderTotalMinor;
}

/// Seeded 1:1 from v1/POS-DINE-IN-V3.png's 12 visible cards — same
/// values, same order (T1..T12), matching the reference exactly rather
/// than reusing LocalTableCatalog's different 18-table/4-status shape.
class LocalDineInCatalog {
  static const tables = <DineInTable>[
    DineInTable(label: 'T1', status: DineInTableStatus.available, seats: 4),
    DineInTable(
        label: 'T2',
        status: DineInTableStatus.ready,
        guestCount: 4,
        elapsedMinutes: 12,
        orderTotalMinor: 48000),
    DineInTable(
        label: 'T3',
        status: DineInTableStatus.waitingKot,
        guestCount: 2,
        elapsedMinutes: 5,
        orderTotalMinor: 32000),
    DineInTable(
        label: 'T4',
        status: DineInTableStatus.preparing,
        guestCount: 6,
        elapsedMinutes: 42,
        orderTotalMinor: 142000),
    DineInTable(
        label: 'T5',
        status: DineInTableStatus.ready,
        guestCount: 4,
        elapsedMinutes: 25,
        orderTotalMinor: 64000),
    DineInTable(label: 'T6', status: DineInTableStatus.available, seats: 2),
    DineInTable(
        label: 'T7',
        status: DineInTableStatus.preparing,
        guestCount: 4,
        elapsedMinutes: 18,
        orderTotalMinor: 82000),
    DineInTable(
        label: 'T8',
        status: DineInTableStatus.waitingKot,
        guestCount: 4,
        elapsedMinutes: 15,
        orderTotalMinor: 51000),
    DineInTable(
        label: 'T9',
        status: DineInTableStatus.paymentPending,
        guestCount: 2,
        elapsedMinutes: 58,
        orderTotalMinor: 96000),
    DineInTable(
        label: 'T10',
        status: DineInTableStatus.preparing,
        guestCount: 4,
        elapsedMinutes: 22,
        orderTotalMinor: 72000),
    DineInTable(label: 'T11', status: DineInTableStatus.available, seats: 6),
    DineInTable(
        label: 'T12',
        status: DineInTableStatus.paymentPending,
        guestCount: 8,
        elapsedMinutes: 70,
        orderTotalMinor: 210000),
  ];
}
