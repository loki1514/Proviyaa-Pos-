// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $OrdersTable extends Orders with TableInfo<$OrdersTable, OrderRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clientOrderIdMeta =
      const VerificationMeta('clientOrderId');
  @override
  late final GeneratedColumn<String> clientOrderId = GeneratedColumn<String>(
      'client_order_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationIdMeta =
      const VerificationMeta('locationId');
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
      'location_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currencyCodeMeta =
      const VerificationMeta('currencyCode');
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
      'currency_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderTypeMeta =
      const VerificationMeta('orderType');
  @override
  late final GeneratedColumn<String> orderType = GeneratedColumn<String>(
      'order_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tableLabelMeta =
      const VerificationMeta('tableLabel');
  @override
  late final GeneratedColumn<String> tableLabel = GeneratedColumn<String>(
      'table_label', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        clientOrderId,
        locationId,
        currencyCode,
        status,
        orderType,
        tableLabel,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(Insertable<OrderRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_order_id')) {
      context.handle(
          _clientOrderIdMeta,
          clientOrderId.isAcceptableOrUnknown(
              data['client_order_id']!, _clientOrderIdMeta));
    } else if (isInserting) {
      context.missing(_clientOrderIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
          _locationIdMeta,
          locationId.isAcceptableOrUnknown(
              data['location_id']!, _locationIdMeta));
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
          _currencyCodeMeta,
          currencyCode.isAcceptableOrUnknown(
              data['currency_code']!, _currencyCodeMeta));
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('order_type')) {
      context.handle(_orderTypeMeta,
          orderType.isAcceptableOrUnknown(data['order_type']!, _orderTypeMeta));
    } else if (isInserting) {
      context.missing(_orderTypeMeta);
    }
    if (data.containsKey('table_label')) {
      context.handle(
          _tableLabelMeta,
          tableLabel.isAcceptableOrUnknown(
              data['table_label']!, _tableLabelMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientOrderId};
  @override
  OrderRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderRow(
      clientOrderId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}client_order_id'])!,
      locationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_id'])!,
      currencyCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_code'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      orderType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_type'])!,
      tableLabel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}table_label']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class OrderRow extends DataClass implements Insertable<OrderRow> {
  final String clientOrderId;
  final String locationId;
  final String currencyCode;
  final String status;
  final String orderType;
  final String? tableLabel;
  final DateTime createdAt;
  const OrderRow(
      {required this.clientOrderId,
      required this.locationId,
      required this.currencyCode,
      required this.status,
      required this.orderType,
      this.tableLabel,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_order_id'] = Variable<String>(clientOrderId);
    map['location_id'] = Variable<String>(locationId);
    map['currency_code'] = Variable<String>(currencyCode);
    map['status'] = Variable<String>(status);
    map['order_type'] = Variable<String>(orderType);
    if (!nullToAbsent || tableLabel != null) {
      map['table_label'] = Variable<String>(tableLabel);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      clientOrderId: Value(clientOrderId),
      locationId: Value(locationId),
      currencyCode: Value(currencyCode),
      status: Value(status),
      orderType: Value(orderType),
      tableLabel: tableLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(tableLabel),
      createdAt: Value(createdAt),
    );
  }

  factory OrderRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderRow(
      clientOrderId: serializer.fromJson<String>(json['clientOrderId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      status: serializer.fromJson<String>(json['status']),
      orderType: serializer.fromJson<String>(json['orderType']),
      tableLabel: serializer.fromJson<String?>(json['tableLabel']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientOrderId': serializer.toJson<String>(clientOrderId),
      'locationId': serializer.toJson<String>(locationId),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'status': serializer.toJson<String>(status),
      'orderType': serializer.toJson<String>(orderType),
      'tableLabel': serializer.toJson<String?>(tableLabel),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  OrderRow copyWith(
          {String? clientOrderId,
          String? locationId,
          String? currencyCode,
          String? status,
          String? orderType,
          Value<String?> tableLabel = const Value.absent(),
          DateTime? createdAt}) =>
      OrderRow(
        clientOrderId: clientOrderId ?? this.clientOrderId,
        locationId: locationId ?? this.locationId,
        currencyCode: currencyCode ?? this.currencyCode,
        status: status ?? this.status,
        orderType: orderType ?? this.orderType,
        tableLabel: tableLabel.present ? tableLabel.value : this.tableLabel,
        createdAt: createdAt ?? this.createdAt,
      );
  OrderRow copyWithCompanion(OrdersCompanion data) {
    return OrderRow(
      clientOrderId: data.clientOrderId.present
          ? data.clientOrderId.value
          : this.clientOrderId,
      locationId:
          data.locationId.present ? data.locationId.value : this.locationId,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      status: data.status.present ? data.status.value : this.status,
      orderType: data.orderType.present ? data.orderType.value : this.orderType,
      tableLabel:
          data.tableLabel.present ? data.tableLabel.value : this.tableLabel,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderRow(')
          ..write('clientOrderId: $clientOrderId, ')
          ..write('locationId: $locationId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('status: $status, ')
          ..write('orderType: $orderType, ')
          ..write('tableLabel: $tableLabel, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(clientOrderId, locationId, currencyCode,
      status, orderType, tableLabel, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderRow &&
          other.clientOrderId == this.clientOrderId &&
          other.locationId == this.locationId &&
          other.currencyCode == this.currencyCode &&
          other.status == this.status &&
          other.orderType == this.orderType &&
          other.tableLabel == this.tableLabel &&
          other.createdAt == this.createdAt);
}

class OrdersCompanion extends UpdateCompanion<OrderRow> {
  final Value<String> clientOrderId;
  final Value<String> locationId;
  final Value<String> currencyCode;
  final Value<String> status;
  final Value<String> orderType;
  final Value<String?> tableLabel;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const OrdersCompanion({
    this.clientOrderId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.status = const Value.absent(),
    this.orderType = const Value.absent(),
    this.tableLabel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrdersCompanion.insert({
    required String clientOrderId,
    required String locationId,
    required String currencyCode,
    required String status,
    required String orderType,
    this.tableLabel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : clientOrderId = Value(clientOrderId),
        locationId = Value(locationId),
        currencyCode = Value(currencyCode),
        status = Value(status),
        orderType = Value(orderType);
  static Insertable<OrderRow> custom({
    Expression<String>? clientOrderId,
    Expression<String>? locationId,
    Expression<String>? currencyCode,
    Expression<String>? status,
    Expression<String>? orderType,
    Expression<String>? tableLabel,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clientOrderId != null) 'client_order_id': clientOrderId,
      if (locationId != null) 'location_id': locationId,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (status != null) 'status': status,
      if (orderType != null) 'order_type': orderType,
      if (tableLabel != null) 'table_label': tableLabel,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrdersCompanion copyWith(
      {Value<String>? clientOrderId,
      Value<String>? locationId,
      Value<String>? currencyCode,
      Value<String>? status,
      Value<String>? orderType,
      Value<String?>? tableLabel,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return OrdersCompanion(
      clientOrderId: clientOrderId ?? this.clientOrderId,
      locationId: locationId ?? this.locationId,
      currencyCode: currencyCode ?? this.currencyCode,
      status: status ?? this.status,
      orderType: orderType ?? this.orderType,
      tableLabel: tableLabel ?? this.tableLabel,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientOrderId.present) {
      map['client_order_id'] = Variable<String>(clientOrderId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (orderType.present) {
      map['order_type'] = Variable<String>(orderType.value);
    }
    if (tableLabel.present) {
      map['table_label'] = Variable<String>(tableLabel.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('clientOrderId: $clientOrderId, ')
          ..write('locationId: $locationId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('status: $status, ')
          ..write('orderType: $orderType, ')
          ..write('tableLabel: $tableLabel, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrderLinesTable extends OrderLines
    with TableInfo<$OrderLinesTable, OrderLineRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clientOrderIdMeta =
      const VerificationMeta('clientOrderId');
  @override
  late final GeneratedColumn<String> clientOrderId = GeneratedColumn<String>(
      'client_order_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
      'item_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unitMinorMeta =
      const VerificationMeta('unitMinor');
  @override
  late final GeneratedColumn<int> unitMinor = GeneratedColumn<int>(
      'unit_minor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [clientOrderId, itemId, name, unitMinor, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_lines';
  @override
  VerificationContext validateIntegrity(Insertable<OrderLineRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_order_id')) {
      context.handle(
          _clientOrderIdMeta,
          clientOrderId.isAcceptableOrUnknown(
              data['client_order_id']!, _clientOrderIdMeta));
    } else if (isInserting) {
      context.missing(_clientOrderIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('unit_minor')) {
      context.handle(_unitMinorMeta,
          unitMinor.isAcceptableOrUnknown(data['unit_minor']!, _unitMinorMeta));
    } else if (isInserting) {
      context.missing(_unitMinorMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientOrderId, itemId};
  @override
  OrderLineRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderLineRow(
      clientOrderId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}client_order_id'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      unitMinor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unit_minor'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
    );
  }

  @override
  $OrderLinesTable createAlias(String alias) {
    return $OrderLinesTable(attachedDatabase, alias);
  }
}

class OrderLineRow extends DataClass implements Insertable<OrderLineRow> {
  final String clientOrderId;
  final String itemId;
  final String name;
  final int unitMinor;
  final int quantity;
  const OrderLineRow(
      {required this.clientOrderId,
      required this.itemId,
      required this.name,
      required this.unitMinor,
      required this.quantity});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_order_id'] = Variable<String>(clientOrderId);
    map['item_id'] = Variable<String>(itemId);
    map['name'] = Variable<String>(name);
    map['unit_minor'] = Variable<int>(unitMinor);
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  OrderLinesCompanion toCompanion(bool nullToAbsent) {
    return OrderLinesCompanion(
      clientOrderId: Value(clientOrderId),
      itemId: Value(itemId),
      name: Value(name),
      unitMinor: Value(unitMinor),
      quantity: Value(quantity),
    );
  }

  factory OrderLineRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderLineRow(
      clientOrderId: serializer.fromJson<String>(json['clientOrderId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      name: serializer.fromJson<String>(json['name']),
      unitMinor: serializer.fromJson<int>(json['unitMinor']),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientOrderId': serializer.toJson<String>(clientOrderId),
      'itemId': serializer.toJson<String>(itemId),
      'name': serializer.toJson<String>(name),
      'unitMinor': serializer.toJson<int>(unitMinor),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  OrderLineRow copyWith(
          {String? clientOrderId,
          String? itemId,
          String? name,
          int? unitMinor,
          int? quantity}) =>
      OrderLineRow(
        clientOrderId: clientOrderId ?? this.clientOrderId,
        itemId: itemId ?? this.itemId,
        name: name ?? this.name,
        unitMinor: unitMinor ?? this.unitMinor,
        quantity: quantity ?? this.quantity,
      );
  OrderLineRow copyWithCompanion(OrderLinesCompanion data) {
    return OrderLineRow(
      clientOrderId: data.clientOrderId.present
          ? data.clientOrderId.value
          : this.clientOrderId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      name: data.name.present ? data.name.value : this.name,
      unitMinor: data.unitMinor.present ? data.unitMinor.value : this.unitMinor,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderLineRow(')
          ..write('clientOrderId: $clientOrderId, ')
          ..write('itemId: $itemId, ')
          ..write('name: $name, ')
          ..write('unitMinor: $unitMinor, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(clientOrderId, itemId, name, unitMinor, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderLineRow &&
          other.clientOrderId == this.clientOrderId &&
          other.itemId == this.itemId &&
          other.name == this.name &&
          other.unitMinor == this.unitMinor &&
          other.quantity == this.quantity);
}

class OrderLinesCompanion extends UpdateCompanion<OrderLineRow> {
  final Value<String> clientOrderId;
  final Value<String> itemId;
  final Value<String> name;
  final Value<int> unitMinor;
  final Value<int> quantity;
  final Value<int> rowid;
  const OrderLinesCompanion({
    this.clientOrderId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.name = const Value.absent(),
    this.unitMinor = const Value.absent(),
    this.quantity = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrderLinesCompanion.insert({
    required String clientOrderId,
    required String itemId,
    required String name,
    required int unitMinor,
    required int quantity,
    this.rowid = const Value.absent(),
  })  : clientOrderId = Value(clientOrderId),
        itemId = Value(itemId),
        name = Value(name),
        unitMinor = Value(unitMinor),
        quantity = Value(quantity);
  static Insertable<OrderLineRow> custom({
    Expression<String>? clientOrderId,
    Expression<String>? itemId,
    Expression<String>? name,
    Expression<int>? unitMinor,
    Expression<int>? quantity,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clientOrderId != null) 'client_order_id': clientOrderId,
      if (itemId != null) 'item_id': itemId,
      if (name != null) 'name': name,
      if (unitMinor != null) 'unit_minor': unitMinor,
      if (quantity != null) 'quantity': quantity,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrderLinesCompanion copyWith(
      {Value<String>? clientOrderId,
      Value<String>? itemId,
      Value<String>? name,
      Value<int>? unitMinor,
      Value<int>? quantity,
      Value<int>? rowid}) {
    return OrderLinesCompanion(
      clientOrderId: clientOrderId ?? this.clientOrderId,
      itemId: itemId ?? this.itemId,
      name: name ?? this.name,
      unitMinor: unitMinor ?? this.unitMinor,
      quantity: quantity ?? this.quantity,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientOrderId.present) {
      map['client_order_id'] = Variable<String>(clientOrderId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (unitMinor.present) {
      map['unit_minor'] = Variable<int>(unitMinor.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderLinesCompanion(')
          ..write('clientOrderId: $clientOrderId, ')
          ..write('itemId: $itemId, ')
          ..write('name: $name, ')
          ..write('unitMinor: $unitMinor, ')
          ..write('quantity: $quantity, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PendingUploadIntentsTable extends PendingUploadIntents
    with TableInfo<$PendingUploadIntentsTable, PendingUploadIntentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingUploadIntentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _intentIdMeta =
      const VerificationMeta('intentId');
  @override
  late final GeneratedColumn<String> intentId = GeneratedColumn<String>(
      'intent_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clientOrderIdMeta =
      const VerificationMeta('clientOrderId');
  @override
  late final GeneratedColumn<String> clientOrderId = GeneratedColumn<String>(
      'client_order_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadHashMeta =
      const VerificationMeta('payloadHash');
  @override
  late final GeneratedColumn<String> payloadHash = GeneratedColumn<String>(
      'payload_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
      'state', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('queued'));
  static const VerificationMeta _retryCountMeta =
      const VerificationMeta('retryCount');
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
      'retry_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        intentId,
        clientOrderId,
        operation,
        payloadHash,
        state,
        retryCount,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_upload_intents';
  @override
  VerificationContext validateIntegrity(
      Insertable<PendingUploadIntentRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('intent_id')) {
      context.handle(_intentIdMeta,
          intentId.isAcceptableOrUnknown(data['intent_id']!, _intentIdMeta));
    } else if (isInserting) {
      context.missing(_intentIdMeta);
    }
    if (data.containsKey('client_order_id')) {
      context.handle(
          _clientOrderIdMeta,
          clientOrderId.isAcceptableOrUnknown(
              data['client_order_id']!, _clientOrderIdMeta));
    } else if (isInserting) {
      context.missing(_clientOrderIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload_hash')) {
      context.handle(
          _payloadHashMeta,
          payloadHash.isAcceptableOrUnknown(
              data['payload_hash']!, _payloadHashMeta));
    } else if (isInserting) {
      context.missing(_payloadHashMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    }
    if (data.containsKey('retry_count')) {
      context.handle(
          _retryCountMeta,
          retryCount.isAcceptableOrUnknown(
              data['retry_count']!, _retryCountMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {intentId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {clientOrderId, operation},
      ];
  @override
  PendingUploadIntentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingUploadIntentRow(
      intentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}intent_id'])!,
      clientOrderId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}client_order_id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      payloadHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload_hash'])!,
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state'])!,
      retryCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retry_count'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PendingUploadIntentsTable createAlias(String alias) {
    return $PendingUploadIntentsTable(attachedDatabase, alias);
  }
}

class PendingUploadIntentRow extends DataClass
    implements Insertable<PendingUploadIntentRow> {
  final String intentId;
  final String clientOrderId;
  final String operation;
  final String payloadHash;
  final String state;
  final int retryCount;
  final DateTime createdAt;
  const PendingUploadIntentRow(
      {required this.intentId,
      required this.clientOrderId,
      required this.operation,
      required this.payloadHash,
      required this.state,
      required this.retryCount,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['intent_id'] = Variable<String>(intentId);
    map['client_order_id'] = Variable<String>(clientOrderId);
    map['operation'] = Variable<String>(operation);
    map['payload_hash'] = Variable<String>(payloadHash);
    map['state'] = Variable<String>(state);
    map['retry_count'] = Variable<int>(retryCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PendingUploadIntentsCompanion toCompanion(bool nullToAbsent) {
    return PendingUploadIntentsCompanion(
      intentId: Value(intentId),
      clientOrderId: Value(clientOrderId),
      operation: Value(operation),
      payloadHash: Value(payloadHash),
      state: Value(state),
      retryCount: Value(retryCount),
      createdAt: Value(createdAt),
    );
  }

  factory PendingUploadIntentRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingUploadIntentRow(
      intentId: serializer.fromJson<String>(json['intentId']),
      clientOrderId: serializer.fromJson<String>(json['clientOrderId']),
      operation: serializer.fromJson<String>(json['operation']),
      payloadHash: serializer.fromJson<String>(json['payloadHash']),
      state: serializer.fromJson<String>(json['state']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'intentId': serializer.toJson<String>(intentId),
      'clientOrderId': serializer.toJson<String>(clientOrderId),
      'operation': serializer.toJson<String>(operation),
      'payloadHash': serializer.toJson<String>(payloadHash),
      'state': serializer.toJson<String>(state),
      'retryCount': serializer.toJson<int>(retryCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PendingUploadIntentRow copyWith(
          {String? intentId,
          String? clientOrderId,
          String? operation,
          String? payloadHash,
          String? state,
          int? retryCount,
          DateTime? createdAt}) =>
      PendingUploadIntentRow(
        intentId: intentId ?? this.intentId,
        clientOrderId: clientOrderId ?? this.clientOrderId,
        operation: operation ?? this.operation,
        payloadHash: payloadHash ?? this.payloadHash,
        state: state ?? this.state,
        retryCount: retryCount ?? this.retryCount,
        createdAt: createdAt ?? this.createdAt,
      );
  PendingUploadIntentRow copyWithCompanion(PendingUploadIntentsCompanion data) {
    return PendingUploadIntentRow(
      intentId: data.intentId.present ? data.intentId.value : this.intentId,
      clientOrderId: data.clientOrderId.present
          ? data.clientOrderId.value
          : this.clientOrderId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadHash:
          data.payloadHash.present ? data.payloadHash.value : this.payloadHash,
      state: data.state.present ? data.state.value : this.state,
      retryCount:
          data.retryCount.present ? data.retryCount.value : this.retryCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingUploadIntentRow(')
          ..write('intentId: $intentId, ')
          ..write('clientOrderId: $clientOrderId, ')
          ..write('operation: $operation, ')
          ..write('payloadHash: $payloadHash, ')
          ..write('state: $state, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(intentId, clientOrderId, operation,
      payloadHash, state, retryCount, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingUploadIntentRow &&
          other.intentId == this.intentId &&
          other.clientOrderId == this.clientOrderId &&
          other.operation == this.operation &&
          other.payloadHash == this.payloadHash &&
          other.state == this.state &&
          other.retryCount == this.retryCount &&
          other.createdAt == this.createdAt);
}

class PendingUploadIntentsCompanion
    extends UpdateCompanion<PendingUploadIntentRow> {
  final Value<String> intentId;
  final Value<String> clientOrderId;
  final Value<String> operation;
  final Value<String> payloadHash;
  final Value<String> state;
  final Value<int> retryCount;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PendingUploadIntentsCompanion({
    this.intentId = const Value.absent(),
    this.clientOrderId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadHash = const Value.absent(),
    this.state = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PendingUploadIntentsCompanion.insert({
    required String intentId,
    required String clientOrderId,
    required String operation,
    required String payloadHash,
    this.state = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : intentId = Value(intentId),
        clientOrderId = Value(clientOrderId),
        operation = Value(operation),
        payloadHash = Value(payloadHash);
  static Insertable<PendingUploadIntentRow> custom({
    Expression<String>? intentId,
    Expression<String>? clientOrderId,
    Expression<String>? operation,
    Expression<String>? payloadHash,
    Expression<String>? state,
    Expression<int>? retryCount,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (intentId != null) 'intent_id': intentId,
      if (clientOrderId != null) 'client_order_id': clientOrderId,
      if (operation != null) 'operation': operation,
      if (payloadHash != null) 'payload_hash': payloadHash,
      if (state != null) 'state': state,
      if (retryCount != null) 'retry_count': retryCount,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PendingUploadIntentsCompanion copyWith(
      {Value<String>? intentId,
      Value<String>? clientOrderId,
      Value<String>? operation,
      Value<String>? payloadHash,
      Value<String>? state,
      Value<int>? retryCount,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return PendingUploadIntentsCompanion(
      intentId: intentId ?? this.intentId,
      clientOrderId: clientOrderId ?? this.clientOrderId,
      operation: operation ?? this.operation,
      payloadHash: payloadHash ?? this.payloadHash,
      state: state ?? this.state,
      retryCount: retryCount ?? this.retryCount,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (intentId.present) {
      map['intent_id'] = Variable<String>(intentId.value);
    }
    if (clientOrderId.present) {
      map['client_order_id'] = Variable<String>(clientOrderId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payloadHash.present) {
      map['payload_hash'] = Variable<String>(payloadHash.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingUploadIntentsCompanion(')
          ..write('intentId: $intentId, ')
          ..write('clientOrderId: $clientOrderId, ')
          ..write('operation: $operation, ')
          ..write('payloadHash: $payloadHash, ')
          ..write('state: $state, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KitchenTicketsTable extends KitchenTickets
    with TableInfo<$KitchenTicketsTable, KitchenTicketRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KitchenTicketsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ticketIdMeta =
      const VerificationMeta('ticketId');
  @override
  late final GeneratedColumn<String> ticketId = GeneratedColumn<String>(
      'ticket_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clientOrderIdMeta =
      const VerificationMeta('clientOrderId');
  @override
  late final GeneratedColumn<String> clientOrderId = GeneratedColumn<String>(
      'client_order_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [ticketId, clientOrderId, status, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kitchen_tickets';
  @override
  VerificationContext validateIntegrity(Insertable<KitchenTicketRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ticket_id')) {
      context.handle(_ticketIdMeta,
          ticketId.isAcceptableOrUnknown(data['ticket_id']!, _ticketIdMeta));
    } else if (isInserting) {
      context.missing(_ticketIdMeta);
    }
    if (data.containsKey('client_order_id')) {
      context.handle(
          _clientOrderIdMeta,
          clientOrderId.isAcceptableOrUnknown(
              data['client_order_id']!, _clientOrderIdMeta));
    } else if (isInserting) {
      context.missing(_clientOrderIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ticketId};
  @override
  KitchenTicketRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KitchenTicketRow(
      ticketId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ticket_id'])!,
      clientOrderId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}client_order_id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $KitchenTicketsTable createAlias(String alias) {
    return $KitchenTicketsTable(attachedDatabase, alias);
  }
}

class KitchenTicketRow extends DataClass
    implements Insertable<KitchenTicketRow> {
  final String ticketId;
  final String clientOrderId;
  final String status;
  final DateTime createdAt;
  const KitchenTicketRow(
      {required this.ticketId,
      required this.clientOrderId,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ticket_id'] = Variable<String>(ticketId);
    map['client_order_id'] = Variable<String>(clientOrderId);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  KitchenTicketsCompanion toCompanion(bool nullToAbsent) {
    return KitchenTicketsCompanion(
      ticketId: Value(ticketId),
      clientOrderId: Value(clientOrderId),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory KitchenTicketRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KitchenTicketRow(
      ticketId: serializer.fromJson<String>(json['ticketId']),
      clientOrderId: serializer.fromJson<String>(json['clientOrderId']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ticketId': serializer.toJson<String>(ticketId),
      'clientOrderId': serializer.toJson<String>(clientOrderId),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  KitchenTicketRow copyWith(
          {String? ticketId,
          String? clientOrderId,
          String? status,
          DateTime? createdAt}) =>
      KitchenTicketRow(
        ticketId: ticketId ?? this.ticketId,
        clientOrderId: clientOrderId ?? this.clientOrderId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  KitchenTicketRow copyWithCompanion(KitchenTicketsCompanion data) {
    return KitchenTicketRow(
      ticketId: data.ticketId.present ? data.ticketId.value : this.ticketId,
      clientOrderId: data.clientOrderId.present
          ? data.clientOrderId.value
          : this.clientOrderId,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KitchenTicketRow(')
          ..write('ticketId: $ticketId, ')
          ..write('clientOrderId: $clientOrderId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(ticketId, clientOrderId, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KitchenTicketRow &&
          other.ticketId == this.ticketId &&
          other.clientOrderId == this.clientOrderId &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class KitchenTicketsCompanion extends UpdateCompanion<KitchenTicketRow> {
  final Value<String> ticketId;
  final Value<String> clientOrderId;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const KitchenTicketsCompanion({
    this.ticketId = const Value.absent(),
    this.clientOrderId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KitchenTicketsCompanion.insert({
    required String ticketId,
    required String clientOrderId,
    required String status,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : ticketId = Value(ticketId),
        clientOrderId = Value(clientOrderId),
        status = Value(status);
  static Insertable<KitchenTicketRow> custom({
    Expression<String>? ticketId,
    Expression<String>? clientOrderId,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ticketId != null) 'ticket_id': ticketId,
      if (clientOrderId != null) 'client_order_id': clientOrderId,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KitchenTicketsCompanion copyWith(
      {Value<String>? ticketId,
      Value<String>? clientOrderId,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return KitchenTicketsCompanion(
      ticketId: ticketId ?? this.ticketId,
      clientOrderId: clientOrderId ?? this.clientOrderId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ticketId.present) {
      map['ticket_id'] = Variable<String>(ticketId.value);
    }
    if (clientOrderId.present) {
      map['client_order_id'] = Variable<String>(clientOrderId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KitchenTicketsCompanion(')
          ..write('ticketId: $ticketId, ')
          ..write('clientOrderId: $clientOrderId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShiftsTable extends Shifts with TableInfo<$ShiftsTable, ShiftRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShiftsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _shiftIdMeta =
      const VerificationMeta('shiftId');
  @override
  late final GeneratedColumn<String> shiftId = GeneratedColumn<String>(
      'shift_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationIdMeta =
      const VerificationMeta('locationId');
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
      'location_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _openingFloatMinorMeta =
      const VerificationMeta('openingFloatMinor');
  @override
  late final GeneratedColumn<int> openingFloatMinor = GeneratedColumn<int>(
      'opening_float_minor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _openedAtMeta =
      const VerificationMeta('openedAt');
  @override
  late final GeneratedColumn<DateTime> openedAt = GeneratedColumn<DateTime>(
      'opened_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _closedAtMeta =
      const VerificationMeta('closedAt');
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
      'closed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _countedCashMinorMeta =
      const VerificationMeta('countedCashMinor');
  @override
  late final GeneratedColumn<int> countedCashMinor = GeneratedColumn<int>(
      'counted_cash_minor', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        shiftId,
        locationId,
        openingFloatMinor,
        openedAt,
        closedAt,
        countedCashMinor
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shifts';
  @override
  VerificationContext validateIntegrity(Insertable<ShiftRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('shift_id')) {
      context.handle(_shiftIdMeta,
          shiftId.isAcceptableOrUnknown(data['shift_id']!, _shiftIdMeta));
    } else if (isInserting) {
      context.missing(_shiftIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
          _locationIdMeta,
          locationId.isAcceptableOrUnknown(
              data['location_id']!, _locationIdMeta));
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('opening_float_minor')) {
      context.handle(
          _openingFloatMinorMeta,
          openingFloatMinor.isAcceptableOrUnknown(
              data['opening_float_minor']!, _openingFloatMinorMeta));
    } else if (isInserting) {
      context.missing(_openingFloatMinorMeta);
    }
    if (data.containsKey('opened_at')) {
      context.handle(_openedAtMeta,
          openedAt.isAcceptableOrUnknown(data['opened_at']!, _openedAtMeta));
    } else if (isInserting) {
      context.missing(_openedAtMeta);
    }
    if (data.containsKey('closed_at')) {
      context.handle(_closedAtMeta,
          closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta));
    }
    if (data.containsKey('counted_cash_minor')) {
      context.handle(
          _countedCashMinorMeta,
          countedCashMinor.isAcceptableOrUnknown(
              data['counted_cash_minor']!, _countedCashMinorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {shiftId};
  @override
  ShiftRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShiftRow(
      shiftId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shift_id'])!,
      locationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_id'])!,
      openingFloatMinor: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}opening_float_minor'])!,
      openedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}opened_at'])!,
      closedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}closed_at']),
      countedCashMinor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}counted_cash_minor']),
    );
  }

  @override
  $ShiftsTable createAlias(String alias) {
    return $ShiftsTable(attachedDatabase, alias);
  }
}

class ShiftRow extends DataClass implements Insertable<ShiftRow> {
  final String shiftId;
  final String locationId;
  final int openingFloatMinor;
  final DateTime openedAt;
  final DateTime? closedAt;
  final int? countedCashMinor;
  const ShiftRow(
      {required this.shiftId,
      required this.locationId,
      required this.openingFloatMinor,
      required this.openedAt,
      this.closedAt,
      this.countedCashMinor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shift_id'] = Variable<String>(shiftId);
    map['location_id'] = Variable<String>(locationId);
    map['opening_float_minor'] = Variable<int>(openingFloatMinor);
    map['opened_at'] = Variable<DateTime>(openedAt);
    if (!nullToAbsent || closedAt != null) {
      map['closed_at'] = Variable<DateTime>(closedAt);
    }
    if (!nullToAbsent || countedCashMinor != null) {
      map['counted_cash_minor'] = Variable<int>(countedCashMinor);
    }
    return map;
  }

  ShiftsCompanion toCompanion(bool nullToAbsent) {
    return ShiftsCompanion(
      shiftId: Value(shiftId),
      locationId: Value(locationId),
      openingFloatMinor: Value(openingFloatMinor),
      openedAt: Value(openedAt),
      closedAt: closedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(closedAt),
      countedCashMinor: countedCashMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(countedCashMinor),
    );
  }

  factory ShiftRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShiftRow(
      shiftId: serializer.fromJson<String>(json['shiftId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      openingFloatMinor: serializer.fromJson<int>(json['openingFloatMinor']),
      openedAt: serializer.fromJson<DateTime>(json['openedAt']),
      closedAt: serializer.fromJson<DateTime?>(json['closedAt']),
      countedCashMinor: serializer.fromJson<int?>(json['countedCashMinor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shiftId': serializer.toJson<String>(shiftId),
      'locationId': serializer.toJson<String>(locationId),
      'openingFloatMinor': serializer.toJson<int>(openingFloatMinor),
      'openedAt': serializer.toJson<DateTime>(openedAt),
      'closedAt': serializer.toJson<DateTime?>(closedAt),
      'countedCashMinor': serializer.toJson<int?>(countedCashMinor),
    };
  }

  ShiftRow copyWith(
          {String? shiftId,
          String? locationId,
          int? openingFloatMinor,
          DateTime? openedAt,
          Value<DateTime?> closedAt = const Value.absent(),
          Value<int?> countedCashMinor = const Value.absent()}) =>
      ShiftRow(
        shiftId: shiftId ?? this.shiftId,
        locationId: locationId ?? this.locationId,
        openingFloatMinor: openingFloatMinor ?? this.openingFloatMinor,
        openedAt: openedAt ?? this.openedAt,
        closedAt: closedAt.present ? closedAt.value : this.closedAt,
        countedCashMinor: countedCashMinor.present
            ? countedCashMinor.value
            : this.countedCashMinor,
      );
  ShiftRow copyWithCompanion(ShiftsCompanion data) {
    return ShiftRow(
      shiftId: data.shiftId.present ? data.shiftId.value : this.shiftId,
      locationId:
          data.locationId.present ? data.locationId.value : this.locationId,
      openingFloatMinor: data.openingFloatMinor.present
          ? data.openingFloatMinor.value
          : this.openingFloatMinor,
      openedAt: data.openedAt.present ? data.openedAt.value : this.openedAt,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
      countedCashMinor: data.countedCashMinor.present
          ? data.countedCashMinor.value
          : this.countedCashMinor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShiftRow(')
          ..write('shiftId: $shiftId, ')
          ..write('locationId: $locationId, ')
          ..write('openingFloatMinor: $openingFloatMinor, ')
          ..write('openedAt: $openedAt, ')
          ..write('closedAt: $closedAt, ')
          ..write('countedCashMinor: $countedCashMinor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(shiftId, locationId, openingFloatMinor,
      openedAt, closedAt, countedCashMinor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShiftRow &&
          other.shiftId == this.shiftId &&
          other.locationId == this.locationId &&
          other.openingFloatMinor == this.openingFloatMinor &&
          other.openedAt == this.openedAt &&
          other.closedAt == this.closedAt &&
          other.countedCashMinor == this.countedCashMinor);
}

class ShiftsCompanion extends UpdateCompanion<ShiftRow> {
  final Value<String> shiftId;
  final Value<String> locationId;
  final Value<int> openingFloatMinor;
  final Value<DateTime> openedAt;
  final Value<DateTime?> closedAt;
  final Value<int?> countedCashMinor;
  final Value<int> rowid;
  const ShiftsCompanion({
    this.shiftId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.openingFloatMinor = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.countedCashMinor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShiftsCompanion.insert({
    required String shiftId,
    required String locationId,
    required int openingFloatMinor,
    required DateTime openedAt,
    this.closedAt = const Value.absent(),
    this.countedCashMinor = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : shiftId = Value(shiftId),
        locationId = Value(locationId),
        openingFloatMinor = Value(openingFloatMinor),
        openedAt = Value(openedAt);
  static Insertable<ShiftRow> custom({
    Expression<String>? shiftId,
    Expression<String>? locationId,
    Expression<int>? openingFloatMinor,
    Expression<DateTime>? openedAt,
    Expression<DateTime>? closedAt,
    Expression<int>? countedCashMinor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (shiftId != null) 'shift_id': shiftId,
      if (locationId != null) 'location_id': locationId,
      if (openingFloatMinor != null) 'opening_float_minor': openingFloatMinor,
      if (openedAt != null) 'opened_at': openedAt,
      if (closedAt != null) 'closed_at': closedAt,
      if (countedCashMinor != null) 'counted_cash_minor': countedCashMinor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShiftsCompanion copyWith(
      {Value<String>? shiftId,
      Value<String>? locationId,
      Value<int>? openingFloatMinor,
      Value<DateTime>? openedAt,
      Value<DateTime?>? closedAt,
      Value<int?>? countedCashMinor,
      Value<int>? rowid}) {
    return ShiftsCompanion(
      shiftId: shiftId ?? this.shiftId,
      locationId: locationId ?? this.locationId,
      openingFloatMinor: openingFloatMinor ?? this.openingFloatMinor,
      openedAt: openedAt ?? this.openedAt,
      closedAt: closedAt ?? this.closedAt,
      countedCashMinor: countedCashMinor ?? this.countedCashMinor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shiftId.present) {
      map['shift_id'] = Variable<String>(shiftId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (openingFloatMinor.present) {
      map['opening_float_minor'] = Variable<int>(openingFloatMinor.value);
    }
    if (openedAt.present) {
      map['opened_at'] = Variable<DateTime>(openedAt.value);
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    if (countedCashMinor.present) {
      map['counted_cash_minor'] = Variable<int>(countedCashMinor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShiftsCompanion(')
          ..write('shiftId: $shiftId, ')
          ..write('locationId: $locationId, ')
          ..write('openingFloatMinor: $openingFloatMinor, ')
          ..write('openedAt: $openedAt, ')
          ..write('closedAt: $closedAt, ')
          ..write('countedCashMinor: $countedCashMinor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments
    with TableInfo<$PaymentsTable, PaymentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _paymentIdMeta =
      const VerificationMeta('paymentId');
  @override
  late final GeneratedColumn<String> paymentId = GeneratedColumn<String>(
      'payment_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clientOrderIdMeta =
      const VerificationMeta('clientOrderId');
  @override
  late final GeneratedColumn<String> clientOrderId = GeneratedColumn<String>(
      'client_order_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
      'method', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMinorMeta =
      const VerificationMeta('amountMinor');
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
      'amount_minor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _receivedMinorMeta =
      const VerificationMeta('receivedMinor');
  @override
  late final GeneratedColumn<int> receivedMinor = GeneratedColumn<int>(
      'received_minor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _recordedAtMeta =
      const VerificationMeta('recordedAt');
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
      'recorded_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        paymentId,
        clientOrderId,
        method,
        amountMinor,
        receivedMinor,
        recordedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(Insertable<PaymentRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('payment_id')) {
      context.handle(_paymentIdMeta,
          paymentId.isAcceptableOrUnknown(data['payment_id']!, _paymentIdMeta));
    } else if (isInserting) {
      context.missing(_paymentIdMeta);
    }
    if (data.containsKey('client_order_id')) {
      context.handle(
          _clientOrderIdMeta,
          clientOrderId.isAcceptableOrUnknown(
              data['client_order_id']!, _clientOrderIdMeta));
    } else if (isInserting) {
      context.missing(_clientOrderIdMeta);
    }
    if (data.containsKey('method')) {
      context.handle(_methodMeta,
          method.isAcceptableOrUnknown(data['method']!, _methodMeta));
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
          _amountMinorMeta,
          amountMinor.isAcceptableOrUnknown(
              data['amount_minor']!, _amountMinorMeta));
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('received_minor')) {
      context.handle(
          _receivedMinorMeta,
          receivedMinor.isAcceptableOrUnknown(
              data['received_minor']!, _receivedMinorMeta));
    } else if (isInserting) {
      context.missing(_receivedMinorMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
          _recordedAtMeta,
          recordedAt.isAcceptableOrUnknown(
              data['recorded_at']!, _recordedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {paymentId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {clientOrderId},
      ];
  @override
  PaymentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentRow(
      paymentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_id'])!,
      clientOrderId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}client_order_id'])!,
      method: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}method'])!,
      amountMinor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_minor'])!,
      receivedMinor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}received_minor'])!,
      recordedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}recorded_at'])!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class PaymentRow extends DataClass implements Insertable<PaymentRow> {
  final String paymentId;
  final String clientOrderId;
  final String method;
  final int amountMinor;
  final int receivedMinor;
  final DateTime recordedAt;
  const PaymentRow(
      {required this.paymentId,
      required this.clientOrderId,
      required this.method,
      required this.amountMinor,
      required this.receivedMinor,
      required this.recordedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['payment_id'] = Variable<String>(paymentId);
    map['client_order_id'] = Variable<String>(clientOrderId);
    map['method'] = Variable<String>(method);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['received_minor'] = Variable<int>(receivedMinor);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      paymentId: Value(paymentId),
      clientOrderId: Value(clientOrderId),
      method: Value(method),
      amountMinor: Value(amountMinor),
      receivedMinor: Value(receivedMinor),
      recordedAt: Value(recordedAt),
    );
  }

  factory PaymentRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentRow(
      paymentId: serializer.fromJson<String>(json['paymentId']),
      clientOrderId: serializer.fromJson<String>(json['clientOrderId']),
      method: serializer.fromJson<String>(json['method']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      receivedMinor: serializer.fromJson<int>(json['receivedMinor']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'paymentId': serializer.toJson<String>(paymentId),
      'clientOrderId': serializer.toJson<String>(clientOrderId),
      'method': serializer.toJson<String>(method),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'receivedMinor': serializer.toJson<int>(receivedMinor),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
    };
  }

  PaymentRow copyWith(
          {String? paymentId,
          String? clientOrderId,
          String? method,
          int? amountMinor,
          int? receivedMinor,
          DateTime? recordedAt}) =>
      PaymentRow(
        paymentId: paymentId ?? this.paymentId,
        clientOrderId: clientOrderId ?? this.clientOrderId,
        method: method ?? this.method,
        amountMinor: amountMinor ?? this.amountMinor,
        receivedMinor: receivedMinor ?? this.receivedMinor,
        recordedAt: recordedAt ?? this.recordedAt,
      );
  PaymentRow copyWithCompanion(PaymentsCompanion data) {
    return PaymentRow(
      paymentId: data.paymentId.present ? data.paymentId.value : this.paymentId,
      clientOrderId: data.clientOrderId.present
          ? data.clientOrderId.value
          : this.clientOrderId,
      method: data.method.present ? data.method.value : this.method,
      amountMinor:
          data.amountMinor.present ? data.amountMinor.value : this.amountMinor,
      receivedMinor: data.receivedMinor.present
          ? data.receivedMinor.value
          : this.receivedMinor,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentRow(')
          ..write('paymentId: $paymentId, ')
          ..write('clientOrderId: $clientOrderId, ')
          ..write('method: $method, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('receivedMinor: $receivedMinor, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      paymentId, clientOrderId, method, amountMinor, receivedMinor, recordedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentRow &&
          other.paymentId == this.paymentId &&
          other.clientOrderId == this.clientOrderId &&
          other.method == this.method &&
          other.amountMinor == this.amountMinor &&
          other.receivedMinor == this.receivedMinor &&
          other.recordedAt == this.recordedAt);
}

class PaymentsCompanion extends UpdateCompanion<PaymentRow> {
  final Value<String> paymentId;
  final Value<String> clientOrderId;
  final Value<String> method;
  final Value<int> amountMinor;
  final Value<int> receivedMinor;
  final Value<DateTime> recordedAt;
  final Value<int> rowid;
  const PaymentsCompanion({
    this.paymentId = const Value.absent(),
    this.clientOrderId = const Value.absent(),
    this.method = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.receivedMinor = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentsCompanion.insert({
    required String paymentId,
    required String clientOrderId,
    required String method,
    required int amountMinor,
    required int receivedMinor,
    this.recordedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : paymentId = Value(paymentId),
        clientOrderId = Value(clientOrderId),
        method = Value(method),
        amountMinor = Value(amountMinor),
        receivedMinor = Value(receivedMinor);
  static Insertable<PaymentRow> custom({
    Expression<String>? paymentId,
    Expression<String>? clientOrderId,
    Expression<String>? method,
    Expression<int>? amountMinor,
    Expression<int>? receivedMinor,
    Expression<DateTime>? recordedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (paymentId != null) 'payment_id': paymentId,
      if (clientOrderId != null) 'client_order_id': clientOrderId,
      if (method != null) 'method': method,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (receivedMinor != null) 'received_minor': receivedMinor,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentsCompanion copyWith(
      {Value<String>? paymentId,
      Value<String>? clientOrderId,
      Value<String>? method,
      Value<int>? amountMinor,
      Value<int>? receivedMinor,
      Value<DateTime>? recordedAt,
      Value<int>? rowid}) {
    return PaymentsCompanion(
      paymentId: paymentId ?? this.paymentId,
      clientOrderId: clientOrderId ?? this.clientOrderId,
      method: method ?? this.method,
      amountMinor: amountMinor ?? this.amountMinor,
      receivedMinor: receivedMinor ?? this.receivedMinor,
      recordedAt: recordedAt ?? this.recordedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (paymentId.present) {
      map['payment_id'] = Variable<String>(paymentId.value);
    }
    if (clientOrderId.present) {
      map['client_order_id'] = Variable<String>(clientOrderId.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (receivedMinor.present) {
      map['received_minor'] = Variable<int>(receivedMinor.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('paymentId: $paymentId, ')
          ..write('clientOrderId: $clientOrderId, ')
          ..write('method: $method, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('receivedMinor: $receivedMinor, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DeviceSessionsTable extends DeviceSessions
    with TableInfo<$DeviceSessionsTable, DeviceSessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeviceSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _staffIdMeta =
      const VerificationMeta('staffId');
  @override
  late final GeneratedColumn<String> staffId = GeneratedColumn<String>(
      'staff_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _staffNameMeta =
      const VerificationMeta('staffName');
  @override
  late final GeneratedColumn<String> staffName = GeneratedColumn<String>(
      'staff_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationIdMeta =
      const VerificationMeta('locationId');
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
      'location_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _grantedAtMeta =
      const VerificationMeta('grantedAt');
  @override
  late final GeneratedColumn<DateTime> grantedAt = GeneratedColumn<DateTime>(
      'granted_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _grantExpiresAtMeta =
      const VerificationMeta('grantExpiresAt');
  @override
  late final GeneratedColumn<DateTime> grantExpiresAt =
      GeneratedColumn<DateTime>('grant_expires_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [deviceId, staffId, staffName, locationId, grantedAt, grantExpiresAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'device_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<DeviceSessionRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('staff_id')) {
      context.handle(_staffIdMeta,
          staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta));
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('staff_name')) {
      context.handle(_staffNameMeta,
          staffName.isAcceptableOrUnknown(data['staff_name']!, _staffNameMeta));
    } else if (isInserting) {
      context.missing(_staffNameMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
          _locationIdMeta,
          locationId.isAcceptableOrUnknown(
              data['location_id']!, _locationIdMeta));
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('granted_at')) {
      context.handle(_grantedAtMeta,
          grantedAt.isAcceptableOrUnknown(data['granted_at']!, _grantedAtMeta));
    } else if (isInserting) {
      context.missing(_grantedAtMeta);
    }
    if (data.containsKey('grant_expires_at')) {
      context.handle(
          _grantExpiresAtMeta,
          grantExpiresAt.isAcceptableOrUnknown(
              data['grant_expires_at']!, _grantExpiresAtMeta));
    } else if (isInserting) {
      context.missing(_grantExpiresAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {deviceId};
  @override
  DeviceSessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeviceSessionRow(
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id'])!,
      staffId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}staff_id'])!,
      staffName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}staff_name'])!,
      locationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_id'])!,
      grantedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}granted_at'])!,
      grantExpiresAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}grant_expires_at'])!,
    );
  }

  @override
  $DeviceSessionsTable createAlias(String alias) {
    return $DeviceSessionsTable(attachedDatabase, alias);
  }
}

class DeviceSessionRow extends DataClass
    implements Insertable<DeviceSessionRow> {
  final String deviceId;
  final String staffId;
  final String staffName;
  final String locationId;
  final DateTime grantedAt;
  final DateTime grantExpiresAt;
  const DeviceSessionRow(
      {required this.deviceId,
      required this.staffId,
      required this.staffName,
      required this.locationId,
      required this.grantedAt,
      required this.grantExpiresAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['device_id'] = Variable<String>(deviceId);
    map['staff_id'] = Variable<String>(staffId);
    map['staff_name'] = Variable<String>(staffName);
    map['location_id'] = Variable<String>(locationId);
    map['granted_at'] = Variable<DateTime>(grantedAt);
    map['grant_expires_at'] = Variable<DateTime>(grantExpiresAt);
    return map;
  }

  DeviceSessionsCompanion toCompanion(bool nullToAbsent) {
    return DeviceSessionsCompanion(
      deviceId: Value(deviceId),
      staffId: Value(staffId),
      staffName: Value(staffName),
      locationId: Value(locationId),
      grantedAt: Value(grantedAt),
      grantExpiresAt: Value(grantExpiresAt),
    );
  }

  factory DeviceSessionRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeviceSessionRow(
      deviceId: serializer.fromJson<String>(json['deviceId']),
      staffId: serializer.fromJson<String>(json['staffId']),
      staffName: serializer.fromJson<String>(json['staffName']),
      locationId: serializer.fromJson<String>(json['locationId']),
      grantedAt: serializer.fromJson<DateTime>(json['grantedAt']),
      grantExpiresAt: serializer.fromJson<DateTime>(json['grantExpiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'deviceId': serializer.toJson<String>(deviceId),
      'staffId': serializer.toJson<String>(staffId),
      'staffName': serializer.toJson<String>(staffName),
      'locationId': serializer.toJson<String>(locationId),
      'grantedAt': serializer.toJson<DateTime>(grantedAt),
      'grantExpiresAt': serializer.toJson<DateTime>(grantExpiresAt),
    };
  }

  DeviceSessionRow copyWith(
          {String? deviceId,
          String? staffId,
          String? staffName,
          String? locationId,
          DateTime? grantedAt,
          DateTime? grantExpiresAt}) =>
      DeviceSessionRow(
        deviceId: deviceId ?? this.deviceId,
        staffId: staffId ?? this.staffId,
        staffName: staffName ?? this.staffName,
        locationId: locationId ?? this.locationId,
        grantedAt: grantedAt ?? this.grantedAt,
        grantExpiresAt: grantExpiresAt ?? this.grantExpiresAt,
      );
  DeviceSessionRow copyWithCompanion(DeviceSessionsCompanion data) {
    return DeviceSessionRow(
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      staffName: data.staffName.present ? data.staffName.value : this.staffName,
      locationId:
          data.locationId.present ? data.locationId.value : this.locationId,
      grantedAt: data.grantedAt.present ? data.grantedAt.value : this.grantedAt,
      grantExpiresAt: data.grantExpiresAt.present
          ? data.grantExpiresAt.value
          : this.grantExpiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeviceSessionRow(')
          ..write('deviceId: $deviceId, ')
          ..write('staffId: $staffId, ')
          ..write('staffName: $staffName, ')
          ..write('locationId: $locationId, ')
          ..write('grantedAt: $grantedAt, ')
          ..write('grantExpiresAt: $grantExpiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      deviceId, staffId, staffName, locationId, grantedAt, grantExpiresAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceSessionRow &&
          other.deviceId == this.deviceId &&
          other.staffId == this.staffId &&
          other.staffName == this.staffName &&
          other.locationId == this.locationId &&
          other.grantedAt == this.grantedAt &&
          other.grantExpiresAt == this.grantExpiresAt);
}

class DeviceSessionsCompanion extends UpdateCompanion<DeviceSessionRow> {
  final Value<String> deviceId;
  final Value<String> staffId;
  final Value<String> staffName;
  final Value<String> locationId;
  final Value<DateTime> grantedAt;
  final Value<DateTime> grantExpiresAt;
  final Value<int> rowid;
  const DeviceSessionsCompanion({
    this.deviceId = const Value.absent(),
    this.staffId = const Value.absent(),
    this.staffName = const Value.absent(),
    this.locationId = const Value.absent(),
    this.grantedAt = const Value.absent(),
    this.grantExpiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DeviceSessionsCompanion.insert({
    required String deviceId,
    required String staffId,
    required String staffName,
    required String locationId,
    required DateTime grantedAt,
    required DateTime grantExpiresAt,
    this.rowid = const Value.absent(),
  })  : deviceId = Value(deviceId),
        staffId = Value(staffId),
        staffName = Value(staffName),
        locationId = Value(locationId),
        grantedAt = Value(grantedAt),
        grantExpiresAt = Value(grantExpiresAt);
  static Insertable<DeviceSessionRow> custom({
    Expression<String>? deviceId,
    Expression<String>? staffId,
    Expression<String>? staffName,
    Expression<String>? locationId,
    Expression<DateTime>? grantedAt,
    Expression<DateTime>? grantExpiresAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (deviceId != null) 'device_id': deviceId,
      if (staffId != null) 'staff_id': staffId,
      if (staffName != null) 'staff_name': staffName,
      if (locationId != null) 'location_id': locationId,
      if (grantedAt != null) 'granted_at': grantedAt,
      if (grantExpiresAt != null) 'grant_expires_at': grantExpiresAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DeviceSessionsCompanion copyWith(
      {Value<String>? deviceId,
      Value<String>? staffId,
      Value<String>? staffName,
      Value<String>? locationId,
      Value<DateTime>? grantedAt,
      Value<DateTime>? grantExpiresAt,
      Value<int>? rowid}) {
    return DeviceSessionsCompanion(
      deviceId: deviceId ?? this.deviceId,
      staffId: staffId ?? this.staffId,
      staffName: staffName ?? this.staffName,
      locationId: locationId ?? this.locationId,
      grantedAt: grantedAt ?? this.grantedAt,
      grantExpiresAt: grantExpiresAt ?? this.grantExpiresAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<String>(staffId.value);
    }
    if (staffName.present) {
      map['staff_name'] = Variable<String>(staffName.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (grantedAt.present) {
      map['granted_at'] = Variable<DateTime>(grantedAt.value);
    }
    if (grantExpiresAt.present) {
      map['grant_expires_at'] = Variable<DateTime>(grantExpiresAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeviceSessionsCompanion(')
          ..write('deviceId: $deviceId, ')
          ..write('staffId: $staffId, ')
          ..write('staffName: $staffName, ')
          ..write('locationId: $locationId, ')
          ..write('grantedAt: $grantedAt, ')
          ..write('grantExpiresAt: $grantExpiresAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $OrderLinesTable orderLines = $OrderLinesTable(this);
  late final $PendingUploadIntentsTable pendingUploadIntents =
      $PendingUploadIntentsTable(this);
  late final $KitchenTicketsTable kitchenTickets = $KitchenTicketsTable(this);
  late final $ShiftsTable shifts = $ShiftsTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $DeviceSessionsTable deviceSessions = $DeviceSessionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        orders,
        orderLines,
        pendingUploadIntents,
        kitchenTickets,
        shifts,
        payments,
        deviceSessions
      ];
}

typedef $$OrdersTableCreateCompanionBuilder = OrdersCompanion Function({
  required String clientOrderId,
  required String locationId,
  required String currencyCode,
  required String status,
  required String orderType,
  Value<String?> tableLabel,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$OrdersTableUpdateCompanionBuilder = OrdersCompanion Function({
  Value<String> clientOrderId,
  Value<String> locationId,
  Value<String> currencyCode,
  Value<String> status,
  Value<String> orderType,
  Value<String?> tableLabel,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$OrdersTableFilterComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clientOrderId => $composableBuilder(
      column: $table.clientOrderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderType => $composableBuilder(
      column: $table.orderType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tableLabel => $composableBuilder(
      column: $table.tableLabel, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$OrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clientOrderId => $composableBuilder(
      column: $table.clientOrderId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderType => $composableBuilder(
      column: $table.orderType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tableLabel => $composableBuilder(
      column: $table.tableLabel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$OrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clientOrderId => $composableBuilder(
      column: $table.clientOrderId, builder: (column) => column);

  GeneratedColumn<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get orderType =>
      $composableBuilder(column: $table.orderType, builder: (column) => column);

  GeneratedColumn<String> get tableLabel => $composableBuilder(
      column: $table.tableLabel, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$OrdersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrdersTable,
    OrderRow,
    $$OrdersTableFilterComposer,
    $$OrdersTableOrderingComposer,
    $$OrdersTableAnnotationComposer,
    $$OrdersTableCreateCompanionBuilder,
    $$OrdersTableUpdateCompanionBuilder,
    (OrderRow, BaseReferences<_$AppDatabase, $OrdersTable, OrderRow>),
    OrderRow,
    PrefetchHooks Function()> {
  $$OrdersTableTableManager(_$AppDatabase db, $OrdersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> clientOrderId = const Value.absent(),
            Value<String> locationId = const Value.absent(),
            Value<String> currencyCode = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> orderType = const Value.absent(),
            Value<String?> tableLabel = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrdersCompanion(
            clientOrderId: clientOrderId,
            locationId: locationId,
            currencyCode: currencyCode,
            status: status,
            orderType: orderType,
            tableLabel: tableLabel,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String clientOrderId,
            required String locationId,
            required String currencyCode,
            required String status,
            required String orderType,
            Value<String?> tableLabel = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrdersCompanion.insert(
            clientOrderId: clientOrderId,
            locationId: locationId,
            currencyCode: currencyCode,
            status: status,
            orderType: orderType,
            tableLabel: tableLabel,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$OrdersTable, OrderRow>(table),
                    BaseReferences<_$AppDatabase, $OrdersTable, OrderRow>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OrdersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrdersTable,
    OrderRow,
    $$OrdersTableFilterComposer,
    $$OrdersTableOrderingComposer,
    $$OrdersTableAnnotationComposer,
    $$OrdersTableCreateCompanionBuilder,
    $$OrdersTableUpdateCompanionBuilder,
    (OrderRow, BaseReferences<_$AppDatabase, $OrdersTable, OrderRow>),
    OrderRow,
    PrefetchHooks Function()>;
typedef $$OrderLinesTableCreateCompanionBuilder = OrderLinesCompanion Function({
  required String clientOrderId,
  required String itemId,
  required String name,
  required int unitMinor,
  required int quantity,
  Value<int> rowid,
});
typedef $$OrderLinesTableUpdateCompanionBuilder = OrderLinesCompanion Function({
  Value<String> clientOrderId,
  Value<String> itemId,
  Value<String> name,
  Value<int> unitMinor,
  Value<int> quantity,
  Value<int> rowid,
});

class $$OrderLinesTableFilterComposer
    extends Composer<_$AppDatabase, $OrderLinesTable> {
  $$OrderLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clientOrderId => $composableBuilder(
      column: $table.clientOrderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get unitMinor => $composableBuilder(
      column: $table.unitMinor, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));
}

class $$OrderLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $OrderLinesTable> {
  $$OrderLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clientOrderId => $composableBuilder(
      column: $table.clientOrderId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unitMinor => $composableBuilder(
      column: $table.unitMinor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));
}

class $$OrderLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrderLinesTable> {
  $$OrderLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clientOrderId => $composableBuilder(
      column: $table.clientOrderId, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get unitMinor =>
      $composableBuilder(column: $table.unitMinor, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);
}

class $$OrderLinesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrderLinesTable,
    OrderLineRow,
    $$OrderLinesTableFilterComposer,
    $$OrderLinesTableOrderingComposer,
    $$OrderLinesTableAnnotationComposer,
    $$OrderLinesTableCreateCompanionBuilder,
    $$OrderLinesTableUpdateCompanionBuilder,
    (
      OrderLineRow,
      BaseReferences<_$AppDatabase, $OrderLinesTable, OrderLineRow>
    ),
    OrderLineRow,
    PrefetchHooks Function()> {
  $$OrderLinesTableTableManager(_$AppDatabase db, $OrderLinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrderLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrderLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrderLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> clientOrderId = const Value.absent(),
            Value<String> itemId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> unitMinor = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrderLinesCompanion(
            clientOrderId: clientOrderId,
            itemId: itemId,
            name: name,
            unitMinor: unitMinor,
            quantity: quantity,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String clientOrderId,
            required String itemId,
            required String name,
            required int unitMinor,
            required int quantity,
            Value<int> rowid = const Value.absent(),
          }) =>
              OrderLinesCompanion.insert(
            clientOrderId: clientOrderId,
            itemId: itemId,
            name: name,
            unitMinor: unitMinor,
            quantity: quantity,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$OrderLinesTable, OrderLineRow>(table),
                    BaseReferences<_$AppDatabase, $OrderLinesTable,
                        OrderLineRow>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OrderLinesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrderLinesTable,
    OrderLineRow,
    $$OrderLinesTableFilterComposer,
    $$OrderLinesTableOrderingComposer,
    $$OrderLinesTableAnnotationComposer,
    $$OrderLinesTableCreateCompanionBuilder,
    $$OrderLinesTableUpdateCompanionBuilder,
    (
      OrderLineRow,
      BaseReferences<_$AppDatabase, $OrderLinesTable, OrderLineRow>
    ),
    OrderLineRow,
    PrefetchHooks Function()>;
typedef $$PendingUploadIntentsTableCreateCompanionBuilder
    = PendingUploadIntentsCompanion Function({
  required String intentId,
  required String clientOrderId,
  required String operation,
  required String payloadHash,
  Value<String> state,
  Value<int> retryCount,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$PendingUploadIntentsTableUpdateCompanionBuilder
    = PendingUploadIntentsCompanion Function({
  Value<String> intentId,
  Value<String> clientOrderId,
  Value<String> operation,
  Value<String> payloadHash,
  Value<String> state,
  Value<int> retryCount,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$PendingUploadIntentsTableFilterComposer
    extends Composer<_$AppDatabase, $PendingUploadIntentsTable> {
  $$PendingUploadIntentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get intentId => $composableBuilder(
      column: $table.intentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clientOrderId => $composableBuilder(
      column: $table.clientOrderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payloadHash => $composableBuilder(
      column: $table.payloadHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$PendingUploadIntentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingUploadIntentsTable> {
  $$PendingUploadIntentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get intentId => $composableBuilder(
      column: $table.intentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clientOrderId => $composableBuilder(
      column: $table.clientOrderId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payloadHash => $composableBuilder(
      column: $table.payloadHash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$PendingUploadIntentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingUploadIntentsTable> {
  $$PendingUploadIntentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get intentId =>
      $composableBuilder(column: $table.intentId, builder: (column) => column);

  GeneratedColumn<String> get clientOrderId => $composableBuilder(
      column: $table.clientOrderId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payloadHash => $composableBuilder(
      column: $table.payloadHash, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PendingUploadIntentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PendingUploadIntentsTable,
    PendingUploadIntentRow,
    $$PendingUploadIntentsTableFilterComposer,
    $$PendingUploadIntentsTableOrderingComposer,
    $$PendingUploadIntentsTableAnnotationComposer,
    $$PendingUploadIntentsTableCreateCompanionBuilder,
    $$PendingUploadIntentsTableUpdateCompanionBuilder,
    (
      PendingUploadIntentRow,
      BaseReferences<_$AppDatabase, $PendingUploadIntentsTable,
          PendingUploadIntentRow>
    ),
    PendingUploadIntentRow,
    PrefetchHooks Function()> {
  $$PendingUploadIntentsTableTableManager(
      _$AppDatabase db, $PendingUploadIntentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingUploadIntentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PendingUploadIntentsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PendingUploadIntentsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> intentId = const Value.absent(),
            Value<String> clientOrderId = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<String> payloadHash = const Value.absent(),
            Value<String> state = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PendingUploadIntentsCompanion(
            intentId: intentId,
            clientOrderId: clientOrderId,
            operation: operation,
            payloadHash: payloadHash,
            state: state,
            retryCount: retryCount,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String intentId,
            required String clientOrderId,
            required String operation,
            required String payloadHash,
            Value<String> state = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PendingUploadIntentsCompanion.insert(
            intentId: intentId,
            clientOrderId: clientOrderId,
            operation: operation,
            payloadHash: payloadHash,
            state: state,
            retryCount: retryCount,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$PendingUploadIntentsTable,
                        PendingUploadIntentRow>(table),
                    BaseReferences<_$AppDatabase, $PendingUploadIntentsTable,
                        PendingUploadIntentRow>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PendingUploadIntentsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $PendingUploadIntentsTable,
        PendingUploadIntentRow,
        $$PendingUploadIntentsTableFilterComposer,
        $$PendingUploadIntentsTableOrderingComposer,
        $$PendingUploadIntentsTableAnnotationComposer,
        $$PendingUploadIntentsTableCreateCompanionBuilder,
        $$PendingUploadIntentsTableUpdateCompanionBuilder,
        (
          PendingUploadIntentRow,
          BaseReferences<_$AppDatabase, $PendingUploadIntentsTable,
              PendingUploadIntentRow>
        ),
        PendingUploadIntentRow,
        PrefetchHooks Function()>;
typedef $$KitchenTicketsTableCreateCompanionBuilder = KitchenTicketsCompanion
    Function({
  required String ticketId,
  required String clientOrderId,
  required String status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$KitchenTicketsTableUpdateCompanionBuilder = KitchenTicketsCompanion
    Function({
  Value<String> ticketId,
  Value<String> clientOrderId,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$KitchenTicketsTableFilterComposer
    extends Composer<_$AppDatabase, $KitchenTicketsTable> {
  $$KitchenTicketsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get ticketId => $composableBuilder(
      column: $table.ticketId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clientOrderId => $composableBuilder(
      column: $table.clientOrderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$KitchenTicketsTableOrderingComposer
    extends Composer<_$AppDatabase, $KitchenTicketsTable> {
  $$KitchenTicketsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get ticketId => $composableBuilder(
      column: $table.ticketId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clientOrderId => $composableBuilder(
      column: $table.clientOrderId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$KitchenTicketsTableAnnotationComposer
    extends Composer<_$AppDatabase, $KitchenTicketsTable> {
  $$KitchenTicketsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get ticketId =>
      $composableBuilder(column: $table.ticketId, builder: (column) => column);

  GeneratedColumn<String> get clientOrderId => $composableBuilder(
      column: $table.clientOrderId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$KitchenTicketsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KitchenTicketsTable,
    KitchenTicketRow,
    $$KitchenTicketsTableFilterComposer,
    $$KitchenTicketsTableOrderingComposer,
    $$KitchenTicketsTableAnnotationComposer,
    $$KitchenTicketsTableCreateCompanionBuilder,
    $$KitchenTicketsTableUpdateCompanionBuilder,
    (
      KitchenTicketRow,
      BaseReferences<_$AppDatabase, $KitchenTicketsTable, KitchenTicketRow>
    ),
    KitchenTicketRow,
    PrefetchHooks Function()> {
  $$KitchenTicketsTableTableManager(
      _$AppDatabase db, $KitchenTicketsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KitchenTicketsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KitchenTicketsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KitchenTicketsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> ticketId = const Value.absent(),
            Value<String> clientOrderId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KitchenTicketsCompanion(
            ticketId: ticketId,
            clientOrderId: clientOrderId,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String ticketId,
            required String clientOrderId,
            required String status,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KitchenTicketsCompanion.insert(
            ticketId: ticketId,
            clientOrderId: clientOrderId,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$KitchenTicketsTable, KitchenTicketRow>(table),
                    BaseReferences<_$AppDatabase, $KitchenTicketsTable,
                        KitchenTicketRow>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$KitchenTicketsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $KitchenTicketsTable,
    KitchenTicketRow,
    $$KitchenTicketsTableFilterComposer,
    $$KitchenTicketsTableOrderingComposer,
    $$KitchenTicketsTableAnnotationComposer,
    $$KitchenTicketsTableCreateCompanionBuilder,
    $$KitchenTicketsTableUpdateCompanionBuilder,
    (
      KitchenTicketRow,
      BaseReferences<_$AppDatabase, $KitchenTicketsTable, KitchenTicketRow>
    ),
    KitchenTicketRow,
    PrefetchHooks Function()>;
typedef $$ShiftsTableCreateCompanionBuilder = ShiftsCompanion Function({
  required String shiftId,
  required String locationId,
  required int openingFloatMinor,
  required DateTime openedAt,
  Value<DateTime?> closedAt,
  Value<int?> countedCashMinor,
  Value<int> rowid,
});
typedef $$ShiftsTableUpdateCompanionBuilder = ShiftsCompanion Function({
  Value<String> shiftId,
  Value<String> locationId,
  Value<int> openingFloatMinor,
  Value<DateTime> openedAt,
  Value<DateTime?> closedAt,
  Value<int?> countedCashMinor,
  Value<int> rowid,
});

class $$ShiftsTableFilterComposer
    extends Composer<_$AppDatabase, $ShiftsTable> {
  $$ShiftsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get shiftId => $composableBuilder(
      column: $table.shiftId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get openingFloatMinor => $composableBuilder(
      column: $table.openingFloatMinor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get openedAt => $composableBuilder(
      column: $table.openedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get closedAt => $composableBuilder(
      column: $table.closedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get countedCashMinor => $composableBuilder(
      column: $table.countedCashMinor,
      builder: (column) => ColumnFilters(column));
}

class $$ShiftsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShiftsTable> {
  $$ShiftsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get shiftId => $composableBuilder(
      column: $table.shiftId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get openingFloatMinor => $composableBuilder(
      column: $table.openingFloatMinor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get openedAt => $composableBuilder(
      column: $table.openedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get closedAt => $composableBuilder(
      column: $table.closedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get countedCashMinor => $composableBuilder(
      column: $table.countedCashMinor,
      builder: (column) => ColumnOrderings(column));
}

class $$ShiftsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShiftsTable> {
  $$ShiftsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get shiftId =>
      $composableBuilder(column: $table.shiftId, builder: (column) => column);

  GeneratedColumn<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => column);

  GeneratedColumn<int> get openingFloatMinor => $composableBuilder(
      column: $table.openingFloatMinor, builder: (column) => column);

  GeneratedColumn<DateTime> get openedAt =>
      $composableBuilder(column: $table.openedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => column);

  GeneratedColumn<int> get countedCashMinor => $composableBuilder(
      column: $table.countedCashMinor, builder: (column) => column);
}

class $$ShiftsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ShiftsTable,
    ShiftRow,
    $$ShiftsTableFilterComposer,
    $$ShiftsTableOrderingComposer,
    $$ShiftsTableAnnotationComposer,
    $$ShiftsTableCreateCompanionBuilder,
    $$ShiftsTableUpdateCompanionBuilder,
    (ShiftRow, BaseReferences<_$AppDatabase, $ShiftsTable, ShiftRow>),
    ShiftRow,
    PrefetchHooks Function()> {
  $$ShiftsTableTableManager(_$AppDatabase db, $ShiftsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShiftsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShiftsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShiftsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> shiftId = const Value.absent(),
            Value<String> locationId = const Value.absent(),
            Value<int> openingFloatMinor = const Value.absent(),
            Value<DateTime> openedAt = const Value.absent(),
            Value<DateTime?> closedAt = const Value.absent(),
            Value<int?> countedCashMinor = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ShiftsCompanion(
            shiftId: shiftId,
            locationId: locationId,
            openingFloatMinor: openingFloatMinor,
            openedAt: openedAt,
            closedAt: closedAt,
            countedCashMinor: countedCashMinor,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String shiftId,
            required String locationId,
            required int openingFloatMinor,
            required DateTime openedAt,
            Value<DateTime?> closedAt = const Value.absent(),
            Value<int?> countedCashMinor = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ShiftsCompanion.insert(
            shiftId: shiftId,
            locationId: locationId,
            openingFloatMinor: openingFloatMinor,
            openedAt: openedAt,
            closedAt: closedAt,
            countedCashMinor: countedCashMinor,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$ShiftsTable, ShiftRow>(table),
                    BaseReferences<_$AppDatabase, $ShiftsTable, ShiftRow>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ShiftsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ShiftsTable,
    ShiftRow,
    $$ShiftsTableFilterComposer,
    $$ShiftsTableOrderingComposer,
    $$ShiftsTableAnnotationComposer,
    $$ShiftsTableCreateCompanionBuilder,
    $$ShiftsTableUpdateCompanionBuilder,
    (ShiftRow, BaseReferences<_$AppDatabase, $ShiftsTable, ShiftRow>),
    ShiftRow,
    PrefetchHooks Function()>;
typedef $$PaymentsTableCreateCompanionBuilder = PaymentsCompanion Function({
  required String paymentId,
  required String clientOrderId,
  required String method,
  required int amountMinor,
  required int receivedMinor,
  Value<DateTime> recordedAt,
  Value<int> rowid,
});
typedef $$PaymentsTableUpdateCompanionBuilder = PaymentsCompanion Function({
  Value<String> paymentId,
  Value<String> clientOrderId,
  Value<String> method,
  Value<int> amountMinor,
  Value<int> receivedMinor,
  Value<DateTime> recordedAt,
  Value<int> rowid,
});

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get paymentId => $composableBuilder(
      column: $table.paymentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clientOrderId => $composableBuilder(
      column: $table.clientOrderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountMinor => $composableBuilder(
      column: $table.amountMinor, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get receivedMinor => $composableBuilder(
      column: $table.receivedMinor, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnFilters(column));
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get paymentId => $composableBuilder(
      column: $table.paymentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clientOrderId => $composableBuilder(
      column: $table.clientOrderId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountMinor => $composableBuilder(
      column: $table.amountMinor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get receivedMinor => $composableBuilder(
      column: $table.receivedMinor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnOrderings(column));
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get paymentId =>
      $composableBuilder(column: $table.paymentId, builder: (column) => column);

  GeneratedColumn<String> get clientOrderId => $composableBuilder(
      column: $table.clientOrderId, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
      column: $table.amountMinor, builder: (column) => column);

  GeneratedColumn<int> get receivedMinor => $composableBuilder(
      column: $table.receivedMinor, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => column);
}

class $$PaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PaymentsTable,
    PaymentRow,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (PaymentRow, BaseReferences<_$AppDatabase, $PaymentsTable, PaymentRow>),
    PaymentRow,
    PrefetchHooks Function()> {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> paymentId = const Value.absent(),
            Value<String> clientOrderId = const Value.absent(),
            Value<String> method = const Value.absent(),
            Value<int> amountMinor = const Value.absent(),
            Value<int> receivedMinor = const Value.absent(),
            Value<DateTime> recordedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PaymentsCompanion(
            paymentId: paymentId,
            clientOrderId: clientOrderId,
            method: method,
            amountMinor: amountMinor,
            receivedMinor: receivedMinor,
            recordedAt: recordedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String paymentId,
            required String clientOrderId,
            required String method,
            required int amountMinor,
            required int receivedMinor,
            Value<DateTime> recordedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PaymentsCompanion.insert(
            paymentId: paymentId,
            clientOrderId: clientOrderId,
            method: method,
            amountMinor: amountMinor,
            receivedMinor: receivedMinor,
            recordedAt: recordedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$PaymentsTable, PaymentRow>(table),
                    BaseReferences<_$AppDatabase, $PaymentsTable, PaymentRow>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PaymentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PaymentsTable,
    PaymentRow,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (PaymentRow, BaseReferences<_$AppDatabase, $PaymentsTable, PaymentRow>),
    PaymentRow,
    PrefetchHooks Function()>;
typedef $$DeviceSessionsTableCreateCompanionBuilder = DeviceSessionsCompanion
    Function({
  required String deviceId,
  required String staffId,
  required String staffName,
  required String locationId,
  required DateTime grantedAt,
  required DateTime grantExpiresAt,
  Value<int> rowid,
});
typedef $$DeviceSessionsTableUpdateCompanionBuilder = DeviceSessionsCompanion
    Function({
  Value<String> deviceId,
  Value<String> staffId,
  Value<String> staffName,
  Value<String> locationId,
  Value<DateTime> grantedAt,
  Value<DateTime> grantExpiresAt,
  Value<int> rowid,
});

class $$DeviceSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $DeviceSessionsTable> {
  $$DeviceSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get staffId => $composableBuilder(
      column: $table.staffId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get staffName => $composableBuilder(
      column: $table.staffName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get grantedAt => $composableBuilder(
      column: $table.grantedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get grantExpiresAt => $composableBuilder(
      column: $table.grantExpiresAt,
      builder: (column) => ColumnFilters(column));
}

class $$DeviceSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $DeviceSessionsTable> {
  $$DeviceSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get staffId => $composableBuilder(
      column: $table.staffId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get staffName => $composableBuilder(
      column: $table.staffName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get grantedAt => $composableBuilder(
      column: $table.grantedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get grantExpiresAt => $composableBuilder(
      column: $table.grantExpiresAt,
      builder: (column) => ColumnOrderings(column));
}

class $$DeviceSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeviceSessionsTable> {
  $$DeviceSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get staffId =>
      $composableBuilder(column: $table.staffId, builder: (column) => column);

  GeneratedColumn<String> get staffName =>
      $composableBuilder(column: $table.staffName, builder: (column) => column);

  GeneratedColumn<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => column);

  GeneratedColumn<DateTime> get grantedAt =>
      $composableBuilder(column: $table.grantedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get grantExpiresAt => $composableBuilder(
      column: $table.grantExpiresAt, builder: (column) => column);
}

class $$DeviceSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DeviceSessionsTable,
    DeviceSessionRow,
    $$DeviceSessionsTableFilterComposer,
    $$DeviceSessionsTableOrderingComposer,
    $$DeviceSessionsTableAnnotationComposer,
    $$DeviceSessionsTableCreateCompanionBuilder,
    $$DeviceSessionsTableUpdateCompanionBuilder,
    (
      DeviceSessionRow,
      BaseReferences<_$AppDatabase, $DeviceSessionsTable, DeviceSessionRow>
    ),
    DeviceSessionRow,
    PrefetchHooks Function()> {
  $$DeviceSessionsTableTableManager(
      _$AppDatabase db, $DeviceSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeviceSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeviceSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeviceSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> deviceId = const Value.absent(),
            Value<String> staffId = const Value.absent(),
            Value<String> staffName = const Value.absent(),
            Value<String> locationId = const Value.absent(),
            Value<DateTime> grantedAt = const Value.absent(),
            Value<DateTime> grantExpiresAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DeviceSessionsCompanion(
            deviceId: deviceId,
            staffId: staffId,
            staffName: staffName,
            locationId: locationId,
            grantedAt: grantedAt,
            grantExpiresAt: grantExpiresAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String deviceId,
            required String staffId,
            required String staffName,
            required String locationId,
            required DateTime grantedAt,
            required DateTime grantExpiresAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              DeviceSessionsCompanion.insert(
            deviceId: deviceId,
            staffId: staffId,
            staffName: staffName,
            locationId: locationId,
            grantedAt: grantedAt,
            grantExpiresAt: grantExpiresAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$DeviceSessionsTable, DeviceSessionRow>(table),
                    BaseReferences<_$AppDatabase, $DeviceSessionsTable,
                        DeviceSessionRow>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DeviceSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DeviceSessionsTable,
    DeviceSessionRow,
    $$DeviceSessionsTableFilterComposer,
    $$DeviceSessionsTableOrderingComposer,
    $$DeviceSessionsTableAnnotationComposer,
    $$DeviceSessionsTableCreateCompanionBuilder,
    $$DeviceSessionsTableUpdateCompanionBuilder,
    (
      DeviceSessionRow,
      BaseReferences<_$AppDatabase, $DeviceSessionsTable, DeviceSessionRow>
    ),
    DeviceSessionRow,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$OrdersTableTableManager get orders =>
      $$OrdersTableTableManager(_db, _db.orders);
  $$OrderLinesTableTableManager get orderLines =>
      $$OrderLinesTableTableManager(_db, _db.orderLines);
  $$PendingUploadIntentsTableTableManager get pendingUploadIntents =>
      $$PendingUploadIntentsTableTableManager(_db, _db.pendingUploadIntents);
  $$KitchenTicketsTableTableManager get kitchenTickets =>
      $$KitchenTicketsTableTableManager(_db, _db.kitchenTickets);
  $$ShiftsTableTableManager get shifts =>
      $$ShiftsTableTableManager(_db, _db.shifts);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$DeviceSessionsTableTableManager get deviceSessions =>
      $$DeviceSessionsTableTableManager(_db, _db.deviceSessions);
}
