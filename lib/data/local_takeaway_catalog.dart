// Seeded 1:1 from v1/POS-TAKEAWAY-V3.png's 6 visible "New" cards.

class TakeawayOrder {
  const TakeawayOrder(
      {required this.orderId,
      required this.time,
      required this.customer,
      required this.itemsSummary,
      this.moreCount = 0,
      required this.totalMinor,
      required this.agoLabel});

  final String orderId, time, customer, itemsSummary, agoLabel;
  final int moreCount;
  final int totalMinor;
}

class LocalTakeawayCatalog {
  static const totalToday = 42;
  static const tabCounts = <String, int>{
    'New': 6,
    'Preparing': 8,
    'Ready': 4,
    'Completed': 24
  };

  static const orders = <TakeawayOrder>[
    TakeawayOrder(
        orderId: '#1086',
        time: '6:18 PM',
        customer: 'Rahul Sharma',
        itemsSummary: '2x Butter Chicken, 1x Naan',
        moreCount: 2,
        totalMinor: 42000,
        agoLabel: '8 min ago'),
    TakeawayOrder(
        orderId: '#1085',
        time: '6:12 PM',
        customer: 'Walk-in',
        itemsSummary: '1x Margherita Pizza, 1x Garlic Bread',
        totalMinor: 41000,
        agoLabel: '14 min ago'),
    TakeawayOrder(
        orderId: '#1084',
        time: '6:05 PM',
        customer: 'Priya Patel',
        itemsSummary: '2x Veg Biryani, 1x Raita',
        moreCount: 1,
        totalMinor: 62000,
        agoLabel: '21 min ago'),
    TakeawayOrder(
        orderId: '#1083',
        time: '5:58 PM',
        customer: 'Walk-in',
        itemsSummary: '1x Masala Dosa, 1x Filter Coffee',
        totalMinor: 23000,
        agoLabel: '28 min ago'),
    TakeawayOrder(
        orderId: '#1082',
        time: '5:50 PM',
        customer: 'Amit Singh',
        itemsSummary: '3x Paneer Tikka, 2x Lachha Paratha',
        moreCount: 3,
        totalMinor: 78000,
        agoLabel: '36 min ago'),
    TakeawayOrder(
        orderId: '#1081',
        time: '5:45 PM',
        customer: 'Walk-in',
        itemsSummary: '1x Pasta Arrabbiata, 1x Coke',
        totalMinor: 39000,
        agoLabel: '41 min ago'),
  ];
}
