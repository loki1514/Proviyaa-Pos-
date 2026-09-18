class OnlineOrderRow {
  const OnlineOrderRow({
    required this.orderId,
    required this.platform,
    required this.customer,
    required this.itemsLabel,
    required this.amountMinor,
    required this.status,
    required this.time,
    required this.actionLabel,
  });

  final String orderId;
  final String platform;
  final String customer;
  final String itemsLabel;
  final String status;
  final String time;
  final String actionLabel;
  final int amountMinor;

  OnlineOrderRow copyWith({
    String? orderId,
    String? platform,
    String? customer,
    String? itemsLabel,
    int? amountMinor,
    String? status,
    String? time,
    String? actionLabel,
  }) {
    return OnlineOrderRow(
      orderId: orderId ?? this.orderId,
      platform: platform ?? this.platform,
      customer: customer ?? this.customer,
      itemsLabel: itemsLabel ?? this.itemsLabel,
      amountMinor: amountMinor ?? this.amountMinor,
      status: status ?? this.status,
      time: time ?? this.time,
      actionLabel: actionLabel ?? this.actionLabel,
    );
  }

  factory OnlineOrderRow.fromJson(Map<String, dynamic> json) {
    final rawAmount = json['amount_minor'] ?? json['amountMinor'] ?? 0;
    final parsedAmount =
        rawAmount is int ? rawAmount : int.tryParse(rawAmount.toString()) ?? 0;

    return OnlineOrderRow(
      orderId: (json['order_id'] ?? json['orderId'] ?? '').toString(),
      platform: (json['platform'] ?? '').toString(),
      customer: (json['customer'] ?? '').toString(),
      itemsLabel: (json['items_label'] ?? json['itemsLabel'] ?? '').toString(),
      amountMinor: parsedAmount,
      status: (json['status'] ?? 'Pending').toString(),
      time: (json['time'] ?? '').toString(),
      actionLabel:
          (json['action_label'] ?? json['actionLabel'] ?? 'Accept').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'platform': platform,
      'customer': customer,
      'items_label': itemsLabel,
      'amount_minor': amountMinor,
      'status': status,
      'time': time,
      'action_label': actionLabel,
    };
  }
}

class LocalOnlineOrdersCatalog {
  static const platforms = ['All Platforms', 'Zomato', 'Swiggy', 'Website'];
}
