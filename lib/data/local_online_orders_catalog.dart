// Seeded 1:1 from v1/POS-ONLINE-ORDERS-V3.png's 10 visible rows.

class OnlineOrderRow {
  const OnlineOrderRow(
      {required this.orderId,
      required this.platform,
      required this.customer,
      required this.itemsLabel,
      required this.amountMinor,
      required this.status,
      required this.time,
      required this.actionLabel});

  final String orderId,
      platform,
      customer,
      itemsLabel,
      status,
      time,
      actionLabel;
  final int amountMinor;
}

class LocalOnlineOrdersCatalog {
  static const totalToday = 30;
  static const platforms = ['All Platforms', 'Zomato', 'Swiggy', 'Website'];
  static const statusTabs = <String, int>{
    'All': 30,
    'Pending': 5,
    'Accepted': 8,
    'Preparing': 7,
    'Ready': 4,
    'Dispatched': 3,
    'Delivered': 2,
    'Cancelled': 1,
  };

  static const rows = <OnlineOrderRow>[
    OnlineOrderRow(
        orderId: '#ZOM-4821',
        platform: 'Z',
        customer: 'Priya Verma',
        itemsLabel: '2x Butter Chicken, 1x Naan, 1x Coke',
        amountMinor: 62000,
        status: 'Pending',
        time: '6:10 PM',
        actionLabel: 'Accept'),
    OnlineOrderRow(
        orderId: '#SWG-8824',
        platform: 'S',
        customer: 'Rohan Khanna',
        itemsLabel: '1x Paneer Butter Masala, 2x Tandoori Roti',
        amountMinor: 38000,
        status: 'Preparing',
        time: '6:05 PM',
        actionLabel: 'Ready'),
    OnlineOrderRow(
        orderId: '#ZOM-4819',
        platform: 'Z',
        customer: 'Amit Sharma',
        itemsLabel: '1x Veg Biryani, 1x Coke',
        amountMinor: 35000,
        status: 'Accepted',
        time: '5:58 PM',
        actionLabel: 'Prepare'),
    OnlineOrderRow(
        orderId: '#WEB-9912',
        platform: 'W',
        customer: 'Vikram Sen',
        itemsLabel: '1x Masala Dosa, 1x Mango Lassi',
        amountMinor: 27000,
        status: 'Ready',
        time: '5:50 PM',
        actionLabel: 'Dispatch'),
    OnlineOrderRow(
        orderId: '#SWG-8815',
        platform: 'S',
        customer: 'Sneha Patil',
        itemsLabel: '3x Garlic Naan, 1x Dal Makhani',
        amountMinor: 40000,
        status: 'Preparing',
        time: '5:42 PM',
        actionLabel: 'Ready'),
    OnlineOrderRow(
        orderId: '#ZOM-4812',
        platform: 'Z',
        customer: 'Karan Johar',
        itemsLabel: '1x Chicken Tikka, 1x Coke',
        amountMinor: 45000,
        status: 'Dispatched',
        time: '5:30 PM',
        actionLabel: 'Complete'),
    OnlineOrderRow(
        orderId: '#WEB-9910',
        platform: 'W',
        customer: 'Aditi Rao',
        itemsLabel: '2x Margherita Pizza, 1x Coke',
        amountMinor: 77000,
        status: 'Delivered',
        time: '5:15 PM',
        actionLabel: 'Archive'),
    OnlineOrderRow(
        orderId: '#SWG-8809',
        platform: 'S',
        customer: 'Rajesh K',
        itemsLabel: '1x Gulab Jamun, 1x Caesar Salad',
        amountMinor: 38000,
        status: 'Cancelled',
        time: '5:00 PM',
        actionLabel: 'Restore'),
    OnlineOrderRow(
        orderId: '#ZOM-4805',
        platform: 'Z',
        customer: 'Neha Juneja',
        itemsLabel: '2x Butter Chicken, 4x Garlic Naan',
        amountMinor: 88000,
        status: 'Delivered',
        time: '4:45 PM',
        actionLabel: 'Archive'),
    OnlineOrderRow(
        orderId: '#WEB-9904',
        platform: 'W',
        customer: 'Siddharth',
        itemsLabel: '1x Dal Makhani, 2x Tandoori Roti',
        amountMinor: 28000,
        status: 'Delivered',
        time: '4:30 PM',
        actionLabel: 'Archive'),
  ];
}
