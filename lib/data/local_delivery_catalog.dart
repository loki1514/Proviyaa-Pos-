// Seeded 1:1 from v1/POS-DELIVERY-V3.png's visible cards. Only 4 of the
// 8 "Out for Delivery" cards are fully visible before the screenshot is
// cropped by the fold (a 5th, Vikas Rao, is visible but its ETA/action
// row is cut off) — those 4 complete cards are reproduced exactly;
// the partial 5th is left out rather than inventing its missing values.

enum DeliveryStage { confirmed, preparing, pickedUp, delivered }

class DeliveryOrder {
  const DeliveryOrder(
      {required this.orderId,
      required this.time,
      required this.platform,
      required this.customer,
      required this.address,
      required this.itemsLabel,
      required this.amountMinor,
      required this.riderName,
      required this.stage,
      required this.etaMinutes});

  final String orderId,
      time,
      platform,
      customer,
      address,
      itemsLabel,
      riderName;
  final int amountMinor, etaMinutes;
  final DeliveryStage stage;
}

class LocalDeliveryCatalog {
  static const totalToday = 28;
  static const tabCounts = <String, int>{
    'All': 28,
    'New': 4,
    'Confirmed': 6,
    'Preparing': 5,
    'Out for Delivery': 8,
    'Delivered': 4,
    'Cancelled': 1,
  };

  static const orders = <DeliveryOrder>[
    DeliveryOrder(
        orderId: '#DEL-2847',
        time: '5:45 PM',
        platform: 'Direct',
        customer: 'Rahul Mehta',
        address: '42, MG Road, Indiranagar, Bangalore',
        itemsLabel: '3 items',
        amountMinor: 89000,
        riderName: 'Kiran S',
        stage: DeliveryStage.pickedUp,
        etaMinutes: 15),
    DeliveryOrder(
        orderId: '#DEL-2848',
        time: '5:40 PM',
        platform: 'Zomato',
        customer: 'Arjun Kapoor',
        address: 'House 15, Koramangala 4th Block, Bangalore',
        itemsLabel: '2 items',
        amountMinor: 45000,
        riderName: 'Ramesh K',
        stage: DeliveryStage.pickedUp,
        etaMinutes: 12),
    DeliveryOrder(
        orderId: '#DEL-2849',
        time: '5:35 PM',
        platform: 'Swiggy',
        customer: 'Sneha Patil',
        address: 'Apt 302, Green Glen Layout, Bellandur',
        itemsLabel: '4 items',
        amountMinor: 120000,
        riderName: 'Sumit V',
        stage: DeliveryStage.pickedUp,
        etaMinutes: 18),
    DeliveryOrder(
        orderId: '#DEL-2850',
        time: '5:30 PM',
        platform: 'Direct',
        customer: 'Preeti Singh',
        address: 'Flat 4B, Shanthi Niketan Apartments, Domlur',
        itemsLabel: '1 item',
        amountMinor: 31000,
        riderName: 'Vijay M',
        stage: DeliveryStage.pickedUp,
        etaMinutes: 8),
  ];
}
