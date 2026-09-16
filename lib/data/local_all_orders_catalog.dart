// Seeded 1:1 from v1/POS-ALL-ORDERS-V3.png's 8 visible rows.

class AllOrdersRow {
  const AllOrdersRow(
      {required this.orderId,
      required this.type,
      required this.source,
      required this.tableOrCustomer,
      required this.itemsLabel,
      required this.amountMinor,
      required this.status,
      required this.time});

  final String orderId, type, source, tableOrCustomer, itemsLabel, status, time;
  final int amountMinor;
}

class LocalAllOrdersCatalog {
  static const totalToday = 184;

  static const filterCounts = <String, int>{
    'All': 184,
    'Dine In': 84,
    'Takeaway': 42,
    'Delivery': 28,
    'Zomato': 18,
    'Swiggy': 12,
  };

  static const rows = <AllOrdersRow>[
    AllOrdersRow(
        orderId: '#1087',
        type: 'Dine In',
        source: 'Walk-in',
        tableOrCustomer: 'Table 22',
        itemsLabel: '3 items',
        amountMinor: 80850,
        status: 'New',
        time: '6:23 PM'),
    AllOrdersRow(
        orderId: '#1086',
        type: 'Takeaway',
        source: 'Walk-in',
        tableOrCustomer: 'Amit Patel',
        itemsLabel: '1 item',
        amountMinor: 34000,
        status: 'Ready',
        time: '6:15 PM'),
    AllOrdersRow(
        orderId: '#1085',
        type: 'Delivery',
        source: 'Zomato',
        tableOrCustomer: 'Priya Singh',
        itemsLabel: '2 items',
        amountMinor: 62000,
        status: 'Preparing',
        time: '6:10 PM'),
    AllOrdersRow(
        orderId: '#1084',
        type: 'Dine In',
        source: 'Walk-in',
        tableOrCustomer: 'Table 4',
        itemsLabel: '4 items',
        amountMinor: 124000,
        status: 'Completed',
        time: '5:55 PM'),
    AllOrdersRow(
        orderId: '#1083',
        type: 'Delivery',
        source: 'Swiggy',
        tableOrCustomer: 'Karan Johar',
        itemsLabel: '3 items',
        amountMinor: 91000,
        status: 'Preparing',
        time: '5:48 PM'),
    AllOrdersRow(
        orderId: '#1082',
        type: 'Takeaway',
        source: 'Walk-in',
        tableOrCustomer: 'Neha Sen',
        itemsLabel: '2 items',
        amountMinor: 48000,
        status: 'Completed',
        time: '5:32 PM'),
    AllOrdersRow(
        orderId: '#1081',
        type: 'Dine In',
        source: 'Walk-in',
        tableOrCustomer: 'Table 11',
        itemsLabel: '5 items',
        amountMinor: 145000,
        status: 'Cancelled',
        time: '5:15 PM'),
    AllOrdersRow(
        orderId: '#1080',
        type: 'Delivery',
        source: 'Zomato',
        tableOrCustomer: 'Rajesh Kumar',
        itemsLabel: '1 item',
        amountMinor: 72000,
        status: 'Completed',
        time: '5:02 PM'),
  ];
}
