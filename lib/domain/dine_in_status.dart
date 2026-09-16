// Dine In board status — v1/POS-DINE-IN-V3.png. Distinct from
// TableStatus (restaurant_table.dart), which is the Tables page's own
// vocabulary (available/occupied/reserved/cleaning). The Dine In board
// tracks order-progress instead (waiting on KOT, preparing, ready,
// payment pending) — the two pages show the same physical tables
// through different lenses, so the status sets are kept separate rather
// than forcing one enum to serve both screens.

enum DineInTableStatus {
  available,
  ready,
  waitingKot,
  preparing,
  paymentPending
}
