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

class $RestaurantTablesTable extends RestaurantTables
    with TableInfo<$RestaurantTablesTable, RestaurantTableRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RestaurantTablesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _seatsMeta = const VerificationMeta('seats');
  @override
  late final GeneratedColumn<int> seats = GeneratedColumn<int>(
      'seats', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _zoneMeta = const VerificationMeta('zone');
  @override
  late final GeneratedColumn<String> zone = GeneratedColumn<String>(
      'zone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _guestCountMeta =
      const VerificationMeta('guestCount');
  @override
  late final GeneratedColumn<int> guestCount = GeneratedColumn<int>(
      'guest_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _elapsedMinutesMeta =
      const VerificationMeta('elapsedMinutes');
  @override
  late final GeneratedColumn<int> elapsedMinutes = GeneratedColumn<int>(
      'elapsed_minutes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _orderTotalMinorMeta =
      const VerificationMeta('orderTotalMinor');
  @override
  late final GeneratedColumn<int> orderTotalMinor = GeneratedColumn<int>(
      'order_total_minor', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _reservedByNameMeta =
      const VerificationMeta('reservedByName');
  @override
  late final GeneratedColumn<String> reservedByName = GeneratedColumn<String>(
      'reserved_by_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reservedAtMeta =
      const VerificationMeta('reservedAt');
  @override
  late final GeneratedColumn<DateTime> reservedAt = GeneratedColumn<DateTime>(
      'reserved_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
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
        id,
        label,
        seats,
        zone,
        status,
        guestCount,
        elapsedMinutes,
        orderTotalMinor,
        reservedByName,
        reservedAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'restaurant_tables';
  @override
  VerificationContext validateIntegrity(Insertable<RestaurantTableRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('seats')) {
      context.handle(
          _seatsMeta, seats.isAcceptableOrUnknown(data['seats']!, _seatsMeta));
    } else if (isInserting) {
      context.missing(_seatsMeta);
    }
    if (data.containsKey('zone')) {
      context.handle(
          _zoneMeta, zone.isAcceptableOrUnknown(data['zone']!, _zoneMeta));
    } else if (isInserting) {
      context.missing(_zoneMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('guest_count')) {
      context.handle(
          _guestCountMeta,
          guestCount.isAcceptableOrUnknown(
              data['guest_count']!, _guestCountMeta));
    }
    if (data.containsKey('elapsed_minutes')) {
      context.handle(
          _elapsedMinutesMeta,
          elapsedMinutes.isAcceptableOrUnknown(
              data['elapsed_minutes']!, _elapsedMinutesMeta));
    }
    if (data.containsKey('order_total_minor')) {
      context.handle(
          _orderTotalMinorMeta,
          orderTotalMinor.isAcceptableOrUnknown(
              data['order_total_minor']!, _orderTotalMinorMeta));
    }
    if (data.containsKey('reserved_by_name')) {
      context.handle(
          _reservedByNameMeta,
          reservedByName.isAcceptableOrUnknown(
              data['reserved_by_name']!, _reservedByNameMeta));
    }
    if (data.containsKey('reserved_at')) {
      context.handle(
          _reservedAtMeta,
          reservedAt.isAcceptableOrUnknown(
              data['reserved_at']!, _reservedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RestaurantTableRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RestaurantTableRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      seats: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}seats'])!,
      zone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}zone'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      guestCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}guest_count']),
      elapsedMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}elapsed_minutes']),
      orderTotalMinor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_total_minor']),
      reservedByName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}reserved_by_name']),
      reservedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}reserved_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $RestaurantTablesTable createAlias(String alias) {
    return $RestaurantTablesTable(attachedDatabase, alias);
  }
}

class RestaurantTableRow extends DataClass
    implements Insertable<RestaurantTableRow> {
  final String id;
  final String label;
  final int seats;
  final String zone;
  final String status;
  final int? guestCount;
  final int? elapsedMinutes;
  final int? orderTotalMinor;
  final String? reservedByName;
  final DateTime? reservedAt;
  final DateTime createdAt;
  const RestaurantTableRow(
      {required this.id,
      required this.label,
      required this.seats,
      required this.zone,
      required this.status,
      this.guestCount,
      this.elapsedMinutes,
      this.orderTotalMinor,
      this.reservedByName,
      this.reservedAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['label'] = Variable<String>(label);
    map['seats'] = Variable<int>(seats);
    map['zone'] = Variable<String>(zone);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || guestCount != null) {
      map['guest_count'] = Variable<int>(guestCount);
    }
    if (!nullToAbsent || elapsedMinutes != null) {
      map['elapsed_minutes'] = Variable<int>(elapsedMinutes);
    }
    if (!nullToAbsent || orderTotalMinor != null) {
      map['order_total_minor'] = Variable<int>(orderTotalMinor);
    }
    if (!nullToAbsent || reservedByName != null) {
      map['reserved_by_name'] = Variable<String>(reservedByName);
    }
    if (!nullToAbsent || reservedAt != null) {
      map['reserved_at'] = Variable<DateTime>(reservedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RestaurantTablesCompanion toCompanion(bool nullToAbsent) {
    return RestaurantTablesCompanion(
      id: Value(id),
      label: Value(label),
      seats: Value(seats),
      zone: Value(zone),
      status: Value(status),
      guestCount: guestCount == null && nullToAbsent
          ? const Value.absent()
          : Value(guestCount),
      elapsedMinutes: elapsedMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(elapsedMinutes),
      orderTotalMinor: orderTotalMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(orderTotalMinor),
      reservedByName: reservedByName == null && nullToAbsent
          ? const Value.absent()
          : Value(reservedByName),
      reservedAt: reservedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(reservedAt),
      createdAt: Value(createdAt),
    );
  }

  factory RestaurantTableRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RestaurantTableRow(
      id: serializer.fromJson<String>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      seats: serializer.fromJson<int>(json['seats']),
      zone: serializer.fromJson<String>(json['zone']),
      status: serializer.fromJson<String>(json['status']),
      guestCount: serializer.fromJson<int?>(json['guestCount']),
      elapsedMinutes: serializer.fromJson<int?>(json['elapsedMinutes']),
      orderTotalMinor: serializer.fromJson<int?>(json['orderTotalMinor']),
      reservedByName: serializer.fromJson<String?>(json['reservedByName']),
      reservedAt: serializer.fromJson<DateTime?>(json['reservedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'label': serializer.toJson<String>(label),
      'seats': serializer.toJson<int>(seats),
      'zone': serializer.toJson<String>(zone),
      'status': serializer.toJson<String>(status),
      'guestCount': serializer.toJson<int?>(guestCount),
      'elapsedMinutes': serializer.toJson<int?>(elapsedMinutes),
      'orderTotalMinor': serializer.toJson<int?>(orderTotalMinor),
      'reservedByName': serializer.toJson<String?>(reservedByName),
      'reservedAt': serializer.toJson<DateTime?>(reservedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RestaurantTableRow copyWith(
          {String? id,
          String? label,
          int? seats,
          String? zone,
          String? status,
          Value<int?> guestCount = const Value.absent(),
          Value<int?> elapsedMinutes = const Value.absent(),
          Value<int?> orderTotalMinor = const Value.absent(),
          Value<String?> reservedByName = const Value.absent(),
          Value<DateTime?> reservedAt = const Value.absent(),
          DateTime? createdAt}) =>
      RestaurantTableRow(
        id: id ?? this.id,
        label: label ?? this.label,
        seats: seats ?? this.seats,
        zone: zone ?? this.zone,
        status: status ?? this.status,
        guestCount: guestCount.present ? guestCount.value : this.guestCount,
        elapsedMinutes:
            elapsedMinutes.present ? elapsedMinutes.value : this.elapsedMinutes,
        orderTotalMinor: orderTotalMinor.present
            ? orderTotalMinor.value
            : this.orderTotalMinor,
        reservedByName:
            reservedByName.present ? reservedByName.value : this.reservedByName,
        reservedAt: reservedAt.present ? reservedAt.value : this.reservedAt,
        createdAt: createdAt ?? this.createdAt,
      );
  RestaurantTableRow copyWithCompanion(RestaurantTablesCompanion data) {
    return RestaurantTableRow(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      seats: data.seats.present ? data.seats.value : this.seats,
      zone: data.zone.present ? data.zone.value : this.zone,
      status: data.status.present ? data.status.value : this.status,
      guestCount:
          data.guestCount.present ? data.guestCount.value : this.guestCount,
      elapsedMinutes: data.elapsedMinutes.present
          ? data.elapsedMinutes.value
          : this.elapsedMinutes,
      orderTotalMinor: data.orderTotalMinor.present
          ? data.orderTotalMinor.value
          : this.orderTotalMinor,
      reservedByName: data.reservedByName.present
          ? data.reservedByName.value
          : this.reservedByName,
      reservedAt:
          data.reservedAt.present ? data.reservedAt.value : this.reservedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RestaurantTableRow(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('seats: $seats, ')
          ..write('zone: $zone, ')
          ..write('status: $status, ')
          ..write('guestCount: $guestCount, ')
          ..write('elapsedMinutes: $elapsedMinutes, ')
          ..write('orderTotalMinor: $orderTotalMinor, ')
          ..write('reservedByName: $reservedByName, ')
          ..write('reservedAt: $reservedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, label, seats, zone, status, guestCount,
      elapsedMinutes, orderTotalMinor, reservedByName, reservedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RestaurantTableRow &&
          other.id == this.id &&
          other.label == this.label &&
          other.seats == this.seats &&
          other.zone == this.zone &&
          other.status == this.status &&
          other.guestCount == this.guestCount &&
          other.elapsedMinutes == this.elapsedMinutes &&
          other.orderTotalMinor == this.orderTotalMinor &&
          other.reservedByName == this.reservedByName &&
          other.reservedAt == this.reservedAt &&
          other.createdAt == this.createdAt);
}

class RestaurantTablesCompanion extends UpdateCompanion<RestaurantTableRow> {
  final Value<String> id;
  final Value<String> label;
  final Value<int> seats;
  final Value<String> zone;
  final Value<String> status;
  final Value<int?> guestCount;
  final Value<int?> elapsedMinutes;
  final Value<int?> orderTotalMinor;
  final Value<String?> reservedByName;
  final Value<DateTime?> reservedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RestaurantTablesCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.seats = const Value.absent(),
    this.zone = const Value.absent(),
    this.status = const Value.absent(),
    this.guestCount = const Value.absent(),
    this.elapsedMinutes = const Value.absent(),
    this.orderTotalMinor = const Value.absent(),
    this.reservedByName = const Value.absent(),
    this.reservedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RestaurantTablesCompanion.insert({
    required String id,
    required String label,
    required int seats,
    required String zone,
    required String status,
    this.guestCount = const Value.absent(),
    this.elapsedMinutes = const Value.absent(),
    this.orderTotalMinor = const Value.absent(),
    this.reservedByName = const Value.absent(),
    this.reservedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        label = Value(label),
        seats = Value(seats),
        zone = Value(zone),
        status = Value(status);
  static Insertable<RestaurantTableRow> custom({
    Expression<String>? id,
    Expression<String>? label,
    Expression<int>? seats,
    Expression<String>? zone,
    Expression<String>? status,
    Expression<int>? guestCount,
    Expression<int>? elapsedMinutes,
    Expression<int>? orderTotalMinor,
    Expression<String>? reservedByName,
    Expression<DateTime>? reservedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (seats != null) 'seats': seats,
      if (zone != null) 'zone': zone,
      if (status != null) 'status': status,
      if (guestCount != null) 'guest_count': guestCount,
      if (elapsedMinutes != null) 'elapsed_minutes': elapsedMinutes,
      if (orderTotalMinor != null) 'order_total_minor': orderTotalMinor,
      if (reservedByName != null) 'reserved_by_name': reservedByName,
      if (reservedAt != null) 'reserved_at': reservedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RestaurantTablesCompanion copyWith(
      {Value<String>? id,
      Value<String>? label,
      Value<int>? seats,
      Value<String>? zone,
      Value<String>? status,
      Value<int?>? guestCount,
      Value<int?>? elapsedMinutes,
      Value<int?>? orderTotalMinor,
      Value<String?>? reservedByName,
      Value<DateTime?>? reservedAt,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return RestaurantTablesCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      seats: seats ?? this.seats,
      zone: zone ?? this.zone,
      status: status ?? this.status,
      guestCount: guestCount ?? this.guestCount,
      elapsedMinutes: elapsedMinutes ?? this.elapsedMinutes,
      orderTotalMinor: orderTotalMinor ?? this.orderTotalMinor,
      reservedByName: reservedByName ?? this.reservedByName,
      reservedAt: reservedAt ?? this.reservedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (seats.present) {
      map['seats'] = Variable<int>(seats.value);
    }
    if (zone.present) {
      map['zone'] = Variable<String>(zone.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (guestCount.present) {
      map['guest_count'] = Variable<int>(guestCount.value);
    }
    if (elapsedMinutes.present) {
      map['elapsed_minutes'] = Variable<int>(elapsedMinutes.value);
    }
    if (orderTotalMinor.present) {
      map['order_total_minor'] = Variable<int>(orderTotalMinor.value);
    }
    if (reservedByName.present) {
      map['reserved_by_name'] = Variable<String>(reservedByName.value);
    }
    if (reservedAt.present) {
      map['reserved_at'] = Variable<DateTime>(reservedAt.value);
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
    return (StringBuffer('RestaurantTablesCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('seats: $seats, ')
          ..write('zone: $zone, ')
          ..write('status: $status, ')
          ..write('guestCount: $guestCount, ')
          ..write('elapsedMinutes: $elapsedMinutes, ')
          ..write('orderTotalMinor: $orderTotalMinor, ')
          ..write('reservedByName: $reservedByName, ')
          ..write('reservedAt: $reservedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AllOrdersTableTable extends AllOrdersTable
    with TableInfo<$AllOrdersTableTable, AllOrderEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AllOrdersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
      'order_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tableOrCustomerMeta =
      const VerificationMeta('tableOrCustomer');
  @override
  late final GeneratedColumn<String> tableOrCustomer = GeneratedColumn<String>(
      'table_or_customer', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itemsLabelMeta =
      const VerificationMeta('itemsLabel');
  @override
  late final GeneratedColumn<String> itemsLabel = GeneratedColumn<String>(
      'items_label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMinorMeta =
      const VerificationMeta('amountMinor');
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
      'amount_minor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  List<GeneratedColumn> get $columns => [
        orderId,
        type,
        source,
        tableOrCustomer,
        itemsLabel,
        amountMinor,
        status,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'all_orders_table';
  @override
  VerificationContext validateIntegrity(Insertable<AllOrderEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('table_or_customer')) {
      context.handle(
          _tableOrCustomerMeta,
          tableOrCustomer.isAcceptableOrUnknown(
              data['table_or_customer']!, _tableOrCustomerMeta));
    } else if (isInserting) {
      context.missing(_tableOrCustomerMeta);
    }
    if (data.containsKey('items_label')) {
      context.handle(
          _itemsLabelMeta,
          itemsLabel.isAcceptableOrUnknown(
              data['items_label']!, _itemsLabelMeta));
    } else if (isInserting) {
      context.missing(_itemsLabelMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
          _amountMinorMeta,
          amountMinor.isAcceptableOrUnknown(
              data['amount_minor']!, _amountMinorMeta));
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
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
  Set<GeneratedColumn> get $primaryKey => {orderId};
  @override
  AllOrderEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AllOrderEntity(
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      tableOrCustomer: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}table_or_customer'])!,
      itemsLabel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}items_label'])!,
      amountMinor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_minor'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AllOrdersTableTable createAlias(String alias) {
    return $AllOrdersTableTable(attachedDatabase, alias);
  }
}

class AllOrderEntity extends DataClass implements Insertable<AllOrderEntity> {
  final String orderId;
  final String type;
  final String source;
  final String tableOrCustomer;
  final String itemsLabel;
  final int amountMinor;
  final String status;
  final DateTime createdAt;
  const AllOrderEntity(
      {required this.orderId,
      required this.type,
      required this.source,
      required this.tableOrCustomer,
      required this.itemsLabel,
      required this.amountMinor,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['order_id'] = Variable<String>(orderId);
    map['type'] = Variable<String>(type);
    map['source'] = Variable<String>(source);
    map['table_or_customer'] = Variable<String>(tableOrCustomer);
    map['items_label'] = Variable<String>(itemsLabel);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AllOrdersTableCompanion toCompanion(bool nullToAbsent) {
    return AllOrdersTableCompanion(
      orderId: Value(orderId),
      type: Value(type),
      source: Value(source),
      tableOrCustomer: Value(tableOrCustomer),
      itemsLabel: Value(itemsLabel),
      amountMinor: Value(amountMinor),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory AllOrderEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AllOrderEntity(
      orderId: serializer.fromJson<String>(json['orderId']),
      type: serializer.fromJson<String>(json['type']),
      source: serializer.fromJson<String>(json['source']),
      tableOrCustomer: serializer.fromJson<String>(json['tableOrCustomer']),
      itemsLabel: serializer.fromJson<String>(json['itemsLabel']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'orderId': serializer.toJson<String>(orderId),
      'type': serializer.toJson<String>(type),
      'source': serializer.toJson<String>(source),
      'tableOrCustomer': serializer.toJson<String>(tableOrCustomer),
      'itemsLabel': serializer.toJson<String>(itemsLabel),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AllOrderEntity copyWith(
          {String? orderId,
          String? type,
          String? source,
          String? tableOrCustomer,
          String? itemsLabel,
          int? amountMinor,
          String? status,
          DateTime? createdAt}) =>
      AllOrderEntity(
        orderId: orderId ?? this.orderId,
        type: type ?? this.type,
        source: source ?? this.source,
        tableOrCustomer: tableOrCustomer ?? this.tableOrCustomer,
        itemsLabel: itemsLabel ?? this.itemsLabel,
        amountMinor: amountMinor ?? this.amountMinor,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  AllOrderEntity copyWithCompanion(AllOrdersTableCompanion data) {
    return AllOrderEntity(
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      type: data.type.present ? data.type.value : this.type,
      source: data.source.present ? data.source.value : this.source,
      tableOrCustomer: data.tableOrCustomer.present
          ? data.tableOrCustomer.value
          : this.tableOrCustomer,
      itemsLabel:
          data.itemsLabel.present ? data.itemsLabel.value : this.itemsLabel,
      amountMinor:
          data.amountMinor.present ? data.amountMinor.value : this.amountMinor,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AllOrderEntity(')
          ..write('orderId: $orderId, ')
          ..write('type: $type, ')
          ..write('source: $source, ')
          ..write('tableOrCustomer: $tableOrCustomer, ')
          ..write('itemsLabel: $itemsLabel, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(orderId, type, source, tableOrCustomer,
      itemsLabel, amountMinor, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AllOrderEntity &&
          other.orderId == this.orderId &&
          other.type == this.type &&
          other.source == this.source &&
          other.tableOrCustomer == this.tableOrCustomer &&
          other.itemsLabel == this.itemsLabel &&
          other.amountMinor == this.amountMinor &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class AllOrdersTableCompanion extends UpdateCompanion<AllOrderEntity> {
  final Value<String> orderId;
  final Value<String> type;
  final Value<String> source;
  final Value<String> tableOrCustomer;
  final Value<String> itemsLabel;
  final Value<int> amountMinor;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AllOrdersTableCompanion({
    this.orderId = const Value.absent(),
    this.type = const Value.absent(),
    this.source = const Value.absent(),
    this.tableOrCustomer = const Value.absent(),
    this.itemsLabel = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AllOrdersTableCompanion.insert({
    required String orderId,
    required String type,
    required String source,
    required String tableOrCustomer,
    required String itemsLabel,
    required int amountMinor,
    required String status,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : orderId = Value(orderId),
        type = Value(type),
        source = Value(source),
        tableOrCustomer = Value(tableOrCustomer),
        itemsLabel = Value(itemsLabel),
        amountMinor = Value(amountMinor),
        status = Value(status);
  static Insertable<AllOrderEntity> custom({
    Expression<String>? orderId,
    Expression<String>? type,
    Expression<String>? source,
    Expression<String>? tableOrCustomer,
    Expression<String>? itemsLabel,
    Expression<int>? amountMinor,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (orderId != null) 'order_id': orderId,
      if (type != null) 'type': type,
      if (source != null) 'source': source,
      if (tableOrCustomer != null) 'table_or_customer': tableOrCustomer,
      if (itemsLabel != null) 'items_label': itemsLabel,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AllOrdersTableCompanion copyWith(
      {Value<String>? orderId,
      Value<String>? type,
      Value<String>? source,
      Value<String>? tableOrCustomer,
      Value<String>? itemsLabel,
      Value<int>? amountMinor,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return AllOrdersTableCompanion(
      orderId: orderId ?? this.orderId,
      type: type ?? this.type,
      source: source ?? this.source,
      tableOrCustomer: tableOrCustomer ?? this.tableOrCustomer,
      itemsLabel: itemsLabel ?? this.itemsLabel,
      amountMinor: amountMinor ?? this.amountMinor,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (tableOrCustomer.present) {
      map['table_or_customer'] = Variable<String>(tableOrCustomer.value);
    }
    if (itemsLabel.present) {
      map['items_label'] = Variable<String>(itemsLabel.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
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
    return (StringBuffer('AllOrdersTableCompanion(')
          ..write('orderId: $orderId, ')
          ..write('type: $type, ')
          ..write('source: $source, ')
          ..write('tableOrCustomer: $tableOrCustomer, ')
          ..write('itemsLabel: $itemsLabel, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MenuCategoriesTableTable extends MenuCategoriesTable
    with TableInfo<$MenuCategoriesTableTable, MenuCategoryEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenuCategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
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
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menu_categories_table';
  @override
  VerificationContext validateIntegrity(Insertable<MenuCategoryEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MenuCategoryEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenuCategoryEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MenuCategoriesTableTable createAlias(String alias) {
    return $MenuCategoriesTableTable(attachedDatabase, alias);
  }
}

class MenuCategoryEntity extends DataClass
    implements Insertable<MenuCategoryEntity> {
  final String id;
  final String name;
  final DateTime createdAt;
  const MenuCategoryEntity(
      {required this.id, required this.name, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MenuCategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return MenuCategoriesTableCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory MenuCategoryEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenuCategoryEntity(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MenuCategoryEntity copyWith(
          {String? id, String? name, DateTime? createdAt}) =>
      MenuCategoryEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );
  MenuCategoryEntity copyWithCompanion(MenuCategoriesTableCompanion data) {
    return MenuCategoryEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenuCategoryEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenuCategoryEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class MenuCategoriesTableCompanion extends UpdateCompanion<MenuCategoryEntity> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MenuCategoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MenuCategoriesTableCompanion.insert({
    required String id,
    required String name,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<MenuCategoryEntity> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MenuCategoriesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return MenuCategoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
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
    return (StringBuffer('MenuCategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MenuItemsTableTable extends MenuItemsTable
    with TableInfo<$MenuItemsTableTable, MenuItemEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenuItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMinorMeta =
      const VerificationMeta('priceMinor');
  @override
  late final GeneratedColumn<int> priceMinor = GeneratedColumn<int>(
      'price_minor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isVegMeta = const VerificationMeta('isVeg');
  @override
  late final GeneratedColumn<bool> isVeg = GeneratedColumn<bool>(
      'is_veg', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_veg" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isBestsellerMeta =
      const VerificationMeta('isBestseller');
  @override
  late final GeneratedColumn<bool> isBestseller = GeneratedColumn<bool>(
      'is_bestseller', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_bestseller" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _availableMeta =
      const VerificationMeta('available');
  @override
  late final GeneratedColumn<bool> available = GeneratedColumn<bool>(
      'available', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("available" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _unavailableReasonMeta =
      const VerificationMeta('unavailableReason');
  @override
  late final GeneratedColumn<String> unavailableReason =
      GeneratedColumn<String>('unavailable_reason', aliasedName, true,
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
        id,
        categoryId,
        name,
        priceMinor,
        isVeg,
        isBestseller,
        available,
        unavailableReason,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menu_items_table';
  @override
  VerificationContext validateIntegrity(Insertable<MenuItemEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price_minor')) {
      context.handle(
          _priceMinorMeta,
          priceMinor.isAcceptableOrUnknown(
              data['price_minor']!, _priceMinorMeta));
    } else if (isInserting) {
      context.missing(_priceMinorMeta);
    }
    if (data.containsKey('is_veg')) {
      context.handle(
          _isVegMeta, isVeg.isAcceptableOrUnknown(data['is_veg']!, _isVegMeta));
    }
    if (data.containsKey('is_bestseller')) {
      context.handle(
          _isBestsellerMeta,
          isBestseller.isAcceptableOrUnknown(
              data['is_bestseller']!, _isBestsellerMeta));
    }
    if (data.containsKey('available')) {
      context.handle(_availableMeta,
          available.isAcceptableOrUnknown(data['available']!, _availableMeta));
    }
    if (data.containsKey('unavailable_reason')) {
      context.handle(
          _unavailableReasonMeta,
          unavailableReason.isAcceptableOrUnknown(
              data['unavailable_reason']!, _unavailableReasonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MenuItemEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenuItemEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      priceMinor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price_minor'])!,
      isVeg: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_veg'])!,
      isBestseller: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_bestseller'])!,
      available: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}available'])!,
      unavailableReason: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}unavailable_reason']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MenuItemsTableTable createAlias(String alias) {
    return $MenuItemsTableTable(attachedDatabase, alias);
  }
}

class MenuItemEntity extends DataClass implements Insertable<MenuItemEntity> {
  final String id;
  final String categoryId;
  final String name;
  final int priceMinor;
  final bool isVeg;
  final bool isBestseller;
  final bool available;
  final String? unavailableReason;
  final DateTime createdAt;
  const MenuItemEntity(
      {required this.id,
      required this.categoryId,
      required this.name,
      required this.priceMinor,
      required this.isVeg,
      required this.isBestseller,
      required this.available,
      this.unavailableReason,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category_id'] = Variable<String>(categoryId);
    map['name'] = Variable<String>(name);
    map['price_minor'] = Variable<int>(priceMinor);
    map['is_veg'] = Variable<bool>(isVeg);
    map['is_bestseller'] = Variable<bool>(isBestseller);
    map['available'] = Variable<bool>(available);
    if (!nullToAbsent || unavailableReason != null) {
      map['unavailable_reason'] = Variable<String>(unavailableReason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MenuItemsTableCompanion toCompanion(bool nullToAbsent) {
    return MenuItemsTableCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      name: Value(name),
      priceMinor: Value(priceMinor),
      isVeg: Value(isVeg),
      isBestseller: Value(isBestseller),
      available: Value(available),
      unavailableReason: unavailableReason == null && nullToAbsent
          ? const Value.absent()
          : Value(unavailableReason),
      createdAt: Value(createdAt),
    );
  }

  factory MenuItemEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenuItemEntity(
      id: serializer.fromJson<String>(json['id']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      name: serializer.fromJson<String>(json['name']),
      priceMinor: serializer.fromJson<int>(json['priceMinor']),
      isVeg: serializer.fromJson<bool>(json['isVeg']),
      isBestseller: serializer.fromJson<bool>(json['isBestseller']),
      available: serializer.fromJson<bool>(json['available']),
      unavailableReason:
          serializer.fromJson<String?>(json['unavailableReason']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'categoryId': serializer.toJson<String>(categoryId),
      'name': serializer.toJson<String>(name),
      'priceMinor': serializer.toJson<int>(priceMinor),
      'isVeg': serializer.toJson<bool>(isVeg),
      'isBestseller': serializer.toJson<bool>(isBestseller),
      'available': serializer.toJson<bool>(available),
      'unavailableReason': serializer.toJson<String?>(unavailableReason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MenuItemEntity copyWith(
          {String? id,
          String? categoryId,
          String? name,
          int? priceMinor,
          bool? isVeg,
          bool? isBestseller,
          bool? available,
          Value<String?> unavailableReason = const Value.absent(),
          DateTime? createdAt}) =>
      MenuItemEntity(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        priceMinor: priceMinor ?? this.priceMinor,
        isVeg: isVeg ?? this.isVeg,
        isBestseller: isBestseller ?? this.isBestseller,
        available: available ?? this.available,
        unavailableReason: unavailableReason.present
            ? unavailableReason.value
            : this.unavailableReason,
        createdAt: createdAt ?? this.createdAt,
      );
  MenuItemEntity copyWithCompanion(MenuItemsTableCompanion data) {
    return MenuItemEntity(
      id: data.id.present ? data.id.value : this.id,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      name: data.name.present ? data.name.value : this.name,
      priceMinor:
          data.priceMinor.present ? data.priceMinor.value : this.priceMinor,
      isVeg: data.isVeg.present ? data.isVeg.value : this.isVeg,
      isBestseller: data.isBestseller.present
          ? data.isBestseller.value
          : this.isBestseller,
      available: data.available.present ? data.available.value : this.available,
      unavailableReason: data.unavailableReason.present
          ? data.unavailableReason.value
          : this.unavailableReason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenuItemEntity(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('priceMinor: $priceMinor, ')
          ..write('isVeg: $isVeg, ')
          ..write('isBestseller: $isBestseller, ')
          ..write('available: $available, ')
          ..write('unavailableReason: $unavailableReason, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, categoryId, name, priceMinor, isVeg,
      isBestseller, available, unavailableReason, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenuItemEntity &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.name == this.name &&
          other.priceMinor == this.priceMinor &&
          other.isVeg == this.isVeg &&
          other.isBestseller == this.isBestseller &&
          other.available == this.available &&
          other.unavailableReason == this.unavailableReason &&
          other.createdAt == this.createdAt);
}

class MenuItemsTableCompanion extends UpdateCompanion<MenuItemEntity> {
  final Value<String> id;
  final Value<String> categoryId;
  final Value<String> name;
  final Value<int> priceMinor;
  final Value<bool> isVeg;
  final Value<bool> isBestseller;
  final Value<bool> available;
  final Value<String?> unavailableReason;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MenuItemsTableCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.priceMinor = const Value.absent(),
    this.isVeg = const Value.absent(),
    this.isBestseller = const Value.absent(),
    this.available = const Value.absent(),
    this.unavailableReason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MenuItemsTableCompanion.insert({
    required String id,
    required String categoryId,
    required String name,
    required int priceMinor,
    this.isVeg = const Value.absent(),
    this.isBestseller = const Value.absent(),
    this.available = const Value.absent(),
    this.unavailableReason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        categoryId = Value(categoryId),
        name = Value(name),
        priceMinor = Value(priceMinor);
  static Insertable<MenuItemEntity> custom({
    Expression<String>? id,
    Expression<String>? categoryId,
    Expression<String>? name,
    Expression<int>? priceMinor,
    Expression<bool>? isVeg,
    Expression<bool>? isBestseller,
    Expression<bool>? available,
    Expression<String>? unavailableReason,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (priceMinor != null) 'price_minor': priceMinor,
      if (isVeg != null) 'is_veg': isVeg,
      if (isBestseller != null) 'is_bestseller': isBestseller,
      if (available != null) 'available': available,
      if (unavailableReason != null) 'unavailable_reason': unavailableReason,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MenuItemsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? categoryId,
      Value<String>? name,
      Value<int>? priceMinor,
      Value<bool>? isVeg,
      Value<bool>? isBestseller,
      Value<bool>? available,
      Value<String?>? unavailableReason,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return MenuItemsTableCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      priceMinor: priceMinor ?? this.priceMinor,
      isVeg: isVeg ?? this.isVeg,
      isBestseller: isBestseller ?? this.isBestseller,
      available: available ?? this.available,
      unavailableReason: unavailableReason ?? this.unavailableReason,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (priceMinor.present) {
      map['price_minor'] = Variable<int>(priceMinor.value);
    }
    if (isVeg.present) {
      map['is_veg'] = Variable<bool>(isVeg.value);
    }
    if (isBestseller.present) {
      map['is_bestseller'] = Variable<bool>(isBestseller.value);
    }
    if (available.present) {
      map['available'] = Variable<bool>(available.value);
    }
    if (unavailableReason.present) {
      map['unavailable_reason'] = Variable<String>(unavailableReason.value);
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
    return (StringBuffer('MenuItemsTableCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('priceMinor: $priceMinor, ')
          ..write('isVeg: $isVeg, ')
          ..write('isBestseller: $isBestseller, ')
          ..write('available: $available, ')
          ..write('unavailableReason: $unavailableReason, ')
          ..write('createdAt: $createdAt, ')
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
  late final $RestaurantTablesTable restaurantTables =
      $RestaurantTablesTable(this);
  late final $AllOrdersTableTable allOrdersTable = $AllOrdersTableTable(this);
  late final $MenuCategoriesTableTable menuCategoriesTable =
      $MenuCategoriesTableTable(this);
  late final $MenuItemsTableTable menuItemsTable = $MenuItemsTableTable(this);
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
        deviceSessions,
        restaurantTables,
        allOrdersTable,
        menuCategoriesTable,
        menuItemsTable
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
typedef $$RestaurantTablesTableCreateCompanionBuilder
    = RestaurantTablesCompanion Function({
  required String id,
  required String label,
  required int seats,
  required String zone,
  required String status,
  Value<int?> guestCount,
  Value<int?> elapsedMinutes,
  Value<int?> orderTotalMinor,
  Value<String?> reservedByName,
  Value<DateTime?> reservedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$RestaurantTablesTableUpdateCompanionBuilder
    = RestaurantTablesCompanion Function({
  Value<String> id,
  Value<String> label,
  Value<int> seats,
  Value<String> zone,
  Value<String> status,
  Value<int?> guestCount,
  Value<int?> elapsedMinutes,
  Value<int?> orderTotalMinor,
  Value<String?> reservedByName,
  Value<DateTime?> reservedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$RestaurantTablesTableFilterComposer
    extends Composer<_$AppDatabase, $RestaurantTablesTable> {
  $$RestaurantTablesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get seats => $composableBuilder(
      column: $table.seats, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get zone => $composableBuilder(
      column: $table.zone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get guestCount => $composableBuilder(
      column: $table.guestCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get elapsedMinutes => $composableBuilder(
      column: $table.elapsedMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderTotalMinor => $composableBuilder(
      column: $table.orderTotalMinor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reservedByName => $composableBuilder(
      column: $table.reservedByName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get reservedAt => $composableBuilder(
      column: $table.reservedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$RestaurantTablesTableOrderingComposer
    extends Composer<_$AppDatabase, $RestaurantTablesTable> {
  $$RestaurantTablesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get seats => $composableBuilder(
      column: $table.seats, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get zone => $composableBuilder(
      column: $table.zone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get guestCount => $composableBuilder(
      column: $table.guestCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get elapsedMinutes => $composableBuilder(
      column: $table.elapsedMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderTotalMinor => $composableBuilder(
      column: $table.orderTotalMinor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reservedByName => $composableBuilder(
      column: $table.reservedByName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get reservedAt => $composableBuilder(
      column: $table.reservedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$RestaurantTablesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RestaurantTablesTable> {
  $$RestaurantTablesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<int> get seats =>
      $composableBuilder(column: $table.seats, builder: (column) => column);

  GeneratedColumn<String> get zone =>
      $composableBuilder(column: $table.zone, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get guestCount => $composableBuilder(
      column: $table.guestCount, builder: (column) => column);

  GeneratedColumn<int> get elapsedMinutes => $composableBuilder(
      column: $table.elapsedMinutes, builder: (column) => column);

  GeneratedColumn<int> get orderTotalMinor => $composableBuilder(
      column: $table.orderTotalMinor, builder: (column) => column);

  GeneratedColumn<String> get reservedByName => $composableBuilder(
      column: $table.reservedByName, builder: (column) => column);

  GeneratedColumn<DateTime> get reservedAt => $composableBuilder(
      column: $table.reservedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$RestaurantTablesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RestaurantTablesTable,
    RestaurantTableRow,
    $$RestaurantTablesTableFilterComposer,
    $$RestaurantTablesTableOrderingComposer,
    $$RestaurantTablesTableAnnotationComposer,
    $$RestaurantTablesTableCreateCompanionBuilder,
    $$RestaurantTablesTableUpdateCompanionBuilder,
    (
      RestaurantTableRow,
      BaseReferences<_$AppDatabase, $RestaurantTablesTable, RestaurantTableRow>
    ),
    RestaurantTableRow,
    PrefetchHooks Function()> {
  $$RestaurantTablesTableTableManager(
      _$AppDatabase db, $RestaurantTablesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RestaurantTablesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RestaurantTablesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RestaurantTablesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<int> seats = const Value.absent(),
            Value<String> zone = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> guestCount = const Value.absent(),
            Value<int?> elapsedMinutes = const Value.absent(),
            Value<int?> orderTotalMinor = const Value.absent(),
            Value<String?> reservedByName = const Value.absent(),
            Value<DateTime?> reservedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RestaurantTablesCompanion(
            id: id,
            label: label,
            seats: seats,
            zone: zone,
            status: status,
            guestCount: guestCount,
            elapsedMinutes: elapsedMinutes,
            orderTotalMinor: orderTotalMinor,
            reservedByName: reservedByName,
            reservedAt: reservedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String label,
            required int seats,
            required String zone,
            required String status,
            Value<int?> guestCount = const Value.absent(),
            Value<int?> elapsedMinutes = const Value.absent(),
            Value<int?> orderTotalMinor = const Value.absent(),
            Value<String?> reservedByName = const Value.absent(),
            Value<DateTime?> reservedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RestaurantTablesCompanion.insert(
            id: id,
            label: label,
            seats: seats,
            zone: zone,
            status: status,
            guestCount: guestCount,
            elapsedMinutes: elapsedMinutes,
            orderTotalMinor: orderTotalMinor,
            reservedByName: reservedByName,
            reservedAt: reservedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$RestaurantTablesTable, RestaurantTableRow>(
                        table),
                    BaseReferences<_$AppDatabase, $RestaurantTablesTable,
                        RestaurantTableRow>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RestaurantTablesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RestaurantTablesTable,
    RestaurantTableRow,
    $$RestaurantTablesTableFilterComposer,
    $$RestaurantTablesTableOrderingComposer,
    $$RestaurantTablesTableAnnotationComposer,
    $$RestaurantTablesTableCreateCompanionBuilder,
    $$RestaurantTablesTableUpdateCompanionBuilder,
    (
      RestaurantTableRow,
      BaseReferences<_$AppDatabase, $RestaurantTablesTable, RestaurantTableRow>
    ),
    RestaurantTableRow,
    PrefetchHooks Function()>;
typedef $$AllOrdersTableTableCreateCompanionBuilder = AllOrdersTableCompanion
    Function({
  required String orderId,
  required String type,
  required String source,
  required String tableOrCustomer,
  required String itemsLabel,
  required int amountMinor,
  required String status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$AllOrdersTableTableUpdateCompanionBuilder = AllOrdersTableCompanion
    Function({
  Value<String> orderId,
  Value<String> type,
  Value<String> source,
  Value<String> tableOrCustomer,
  Value<String> itemsLabel,
  Value<int> amountMinor,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$AllOrdersTableTableFilterComposer
    extends Composer<_$AppDatabase, $AllOrdersTableTable> {
  $$AllOrdersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get orderId => $composableBuilder(
      column: $table.orderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tableOrCustomer => $composableBuilder(
      column: $table.tableOrCustomer,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemsLabel => $composableBuilder(
      column: $table.itemsLabel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountMinor => $composableBuilder(
      column: $table.amountMinor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$AllOrdersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AllOrdersTableTable> {
  $$AllOrdersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get orderId => $composableBuilder(
      column: $table.orderId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tableOrCustomer => $composableBuilder(
      column: $table.tableOrCustomer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemsLabel => $composableBuilder(
      column: $table.itemsLabel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountMinor => $composableBuilder(
      column: $table.amountMinor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$AllOrdersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AllOrdersTableTable> {
  $$AllOrdersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get tableOrCustomer => $composableBuilder(
      column: $table.tableOrCustomer, builder: (column) => column);

  GeneratedColumn<String> get itemsLabel => $composableBuilder(
      column: $table.itemsLabel, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
      column: $table.amountMinor, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AllOrdersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AllOrdersTableTable,
    AllOrderEntity,
    $$AllOrdersTableTableFilterComposer,
    $$AllOrdersTableTableOrderingComposer,
    $$AllOrdersTableTableAnnotationComposer,
    $$AllOrdersTableTableCreateCompanionBuilder,
    $$AllOrdersTableTableUpdateCompanionBuilder,
    (
      AllOrderEntity,
      BaseReferences<_$AppDatabase, $AllOrdersTableTable, AllOrderEntity>
    ),
    AllOrderEntity,
    PrefetchHooks Function()> {
  $$AllOrdersTableTableTableManager(
      _$AppDatabase db, $AllOrdersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AllOrdersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AllOrdersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AllOrdersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> orderId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String> tableOrCustomer = const Value.absent(),
            Value<String> itemsLabel = const Value.absent(),
            Value<int> amountMinor = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AllOrdersTableCompanion(
            orderId: orderId,
            type: type,
            source: source,
            tableOrCustomer: tableOrCustomer,
            itemsLabel: itemsLabel,
            amountMinor: amountMinor,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String orderId,
            required String type,
            required String source,
            required String tableOrCustomer,
            required String itemsLabel,
            required int amountMinor,
            required String status,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AllOrdersTableCompanion.insert(
            orderId: orderId,
            type: type,
            source: source,
            tableOrCustomer: tableOrCustomer,
            itemsLabel: itemsLabel,
            amountMinor: amountMinor,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$AllOrdersTableTable, AllOrderEntity>(table),
                    BaseReferences<_$AppDatabase, $AllOrdersTableTable,
                        AllOrderEntity>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AllOrdersTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AllOrdersTableTable,
    AllOrderEntity,
    $$AllOrdersTableTableFilterComposer,
    $$AllOrdersTableTableOrderingComposer,
    $$AllOrdersTableTableAnnotationComposer,
    $$AllOrdersTableTableCreateCompanionBuilder,
    $$AllOrdersTableTableUpdateCompanionBuilder,
    (
      AllOrderEntity,
      BaseReferences<_$AppDatabase, $AllOrdersTableTable, AllOrderEntity>
    ),
    AllOrderEntity,
    PrefetchHooks Function()>;
typedef $$MenuCategoriesTableTableCreateCompanionBuilder
    = MenuCategoriesTableCompanion Function({
  required String id,
  required String name,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$MenuCategoriesTableTableUpdateCompanionBuilder
    = MenuCategoriesTableCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$MenuCategoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $MenuCategoriesTableTable> {
  $$MenuCategoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$MenuCategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MenuCategoriesTableTable> {
  $$MenuCategoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$MenuCategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenuCategoriesTableTable> {
  $$MenuCategoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MenuCategoriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MenuCategoriesTableTable,
    MenuCategoryEntity,
    $$MenuCategoriesTableTableFilterComposer,
    $$MenuCategoriesTableTableOrderingComposer,
    $$MenuCategoriesTableTableAnnotationComposer,
    $$MenuCategoriesTableTableCreateCompanionBuilder,
    $$MenuCategoriesTableTableUpdateCompanionBuilder,
    (
      MenuCategoryEntity,
      BaseReferences<_$AppDatabase, $MenuCategoriesTableTable,
          MenuCategoryEntity>
    ),
    MenuCategoryEntity,
    PrefetchHooks Function()> {
  $$MenuCategoriesTableTableTableManager(
      _$AppDatabase db, $MenuCategoriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenuCategoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenuCategoriesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenuCategoriesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MenuCategoriesTableCompanion(
            id: id,
            name: name,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MenuCategoriesTableCompanion.insert(
            id: id,
            name: name,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$MenuCategoriesTableTable, MenuCategoryEntity>(
                        table),
                    BaseReferences<_$AppDatabase, $MenuCategoriesTableTable,
                        MenuCategoryEntity>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MenuCategoriesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MenuCategoriesTableTable,
    MenuCategoryEntity,
    $$MenuCategoriesTableTableFilterComposer,
    $$MenuCategoriesTableTableOrderingComposer,
    $$MenuCategoriesTableTableAnnotationComposer,
    $$MenuCategoriesTableTableCreateCompanionBuilder,
    $$MenuCategoriesTableTableUpdateCompanionBuilder,
    (
      MenuCategoryEntity,
      BaseReferences<_$AppDatabase, $MenuCategoriesTableTable,
          MenuCategoryEntity>
    ),
    MenuCategoryEntity,
    PrefetchHooks Function()>;
typedef $$MenuItemsTableTableCreateCompanionBuilder = MenuItemsTableCompanion
    Function({
  required String id,
  required String categoryId,
  required String name,
  required int priceMinor,
  Value<bool> isVeg,
  Value<bool> isBestseller,
  Value<bool> available,
  Value<String?> unavailableReason,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$MenuItemsTableTableUpdateCompanionBuilder = MenuItemsTableCompanion
    Function({
  Value<String> id,
  Value<String> categoryId,
  Value<String> name,
  Value<int> priceMinor,
  Value<bool> isVeg,
  Value<bool> isBestseller,
  Value<bool> available,
  Value<String?> unavailableReason,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$MenuItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $MenuItemsTableTable> {
  $$MenuItemsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priceMinor => $composableBuilder(
      column: $table.priceMinor, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isVeg => $composableBuilder(
      column: $table.isVeg, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isBestseller => $composableBuilder(
      column: $table.isBestseller, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get available => $composableBuilder(
      column: $table.available, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unavailableReason => $composableBuilder(
      column: $table.unavailableReason,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$MenuItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MenuItemsTableTable> {
  $$MenuItemsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priceMinor => $composableBuilder(
      column: $table.priceMinor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isVeg => $composableBuilder(
      column: $table.isVeg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isBestseller => $composableBuilder(
      column: $table.isBestseller,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get available => $composableBuilder(
      column: $table.available, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unavailableReason => $composableBuilder(
      column: $table.unavailableReason,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$MenuItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenuItemsTableTable> {
  $$MenuItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get priceMinor => $composableBuilder(
      column: $table.priceMinor, builder: (column) => column);

  GeneratedColumn<bool> get isVeg =>
      $composableBuilder(column: $table.isVeg, builder: (column) => column);

  GeneratedColumn<bool> get isBestseller => $composableBuilder(
      column: $table.isBestseller, builder: (column) => column);

  GeneratedColumn<bool> get available =>
      $composableBuilder(column: $table.available, builder: (column) => column);

  GeneratedColumn<String> get unavailableReason => $composableBuilder(
      column: $table.unavailableReason, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MenuItemsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MenuItemsTableTable,
    MenuItemEntity,
    $$MenuItemsTableTableFilterComposer,
    $$MenuItemsTableTableOrderingComposer,
    $$MenuItemsTableTableAnnotationComposer,
    $$MenuItemsTableTableCreateCompanionBuilder,
    $$MenuItemsTableTableUpdateCompanionBuilder,
    (
      MenuItemEntity,
      BaseReferences<_$AppDatabase, $MenuItemsTableTable, MenuItemEntity>
    ),
    MenuItemEntity,
    PrefetchHooks Function()> {
  $$MenuItemsTableTableTableManager(
      _$AppDatabase db, $MenuItemsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenuItemsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenuItemsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenuItemsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> categoryId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> priceMinor = const Value.absent(),
            Value<bool> isVeg = const Value.absent(),
            Value<bool> isBestseller = const Value.absent(),
            Value<bool> available = const Value.absent(),
            Value<String?> unavailableReason = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MenuItemsTableCompanion(
            id: id,
            categoryId: categoryId,
            name: name,
            priceMinor: priceMinor,
            isVeg: isVeg,
            isBestseller: isBestseller,
            available: available,
            unavailableReason: unavailableReason,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String categoryId,
            required String name,
            required int priceMinor,
            Value<bool> isVeg = const Value.absent(),
            Value<bool> isBestseller = const Value.absent(),
            Value<bool> available = const Value.absent(),
            Value<String?> unavailableReason = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MenuItemsTableCompanion.insert(
            id: id,
            categoryId: categoryId,
            name: name,
            priceMinor: priceMinor,
            isVeg: isVeg,
            isBestseller: isBestseller,
            available: available,
            unavailableReason: unavailableReason,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$MenuItemsTableTable, MenuItemEntity>(table),
                    BaseReferences<_$AppDatabase, $MenuItemsTableTable,
                        MenuItemEntity>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MenuItemsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MenuItemsTableTable,
    MenuItemEntity,
    $$MenuItemsTableTableFilterComposer,
    $$MenuItemsTableTableOrderingComposer,
    $$MenuItemsTableTableAnnotationComposer,
    $$MenuItemsTableTableCreateCompanionBuilder,
    $$MenuItemsTableTableUpdateCompanionBuilder,
    (
      MenuItemEntity,
      BaseReferences<_$AppDatabase, $MenuItemsTableTable, MenuItemEntity>
    ),
    MenuItemEntity,
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
  $$RestaurantTablesTableTableManager get restaurantTables =>
      $$RestaurantTablesTableTableManager(_db, _db.restaurantTables);
  $$AllOrdersTableTableTableManager get allOrdersTable =>
      $$AllOrdersTableTableTableManager(_db, _db.allOrdersTable);
  $$MenuCategoriesTableTableTableManager get menuCategoriesTable =>
      $$MenuCategoriesTableTableTableManager(_db, _db.menuCategoriesTable);
  $$MenuItemsTableTableTableManager get menuItemsTable =>
      $$MenuItemsTableTableTableManager(_db, _db.menuItemsTable);
}
