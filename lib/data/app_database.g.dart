// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PersonsTable extends Persons with TableInfo<$PersonsTable, Person> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorIndexMeta = const VerificationMeta(
    'colorIndex',
  );
  @override
  late final GeneratedColumn<int> colorIndex = GeneratedColumn<int>(
    'color_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    archivedAt,
    id,
    name,
    colorIndex,
    sortOrder,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'persons';
  @override
  VerificationContext validateIntegrity(
    Insertable<Person> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color_index')) {
      context.handle(
        _colorIndexMeta,
        colorIndex.isAcceptableOrUnknown(data['color_index']!, _colorIndexMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Person map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Person(
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      colorIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_index'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PersonsTable createAlias(String alias) {
    return $PersonsTable(attachedDatabase, alias);
  }
}

class Person extends DataClass implements Insertable<Person> {
  final DateTime? archivedAt;
  final String id;
  final String name;

  /// Index in die Farbpalette der Oberfläche.
  final int colorIndex;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Person({
    this.archivedAt,
    required this.id,
    required this.name,
    required this.colorIndex,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['color_index'] = Variable<int>(colorIndex);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PersonsCompanion toCompanion(bool nullToAbsent) {
    return PersonsCompanion(
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      id: Value(id),
      name: Value(name),
      colorIndex: Value(colorIndex),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Person.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Person(
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      colorIndex: serializer.fromJson<int>(json['colorIndex']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'colorIndex': serializer.toJson<int>(colorIndex),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Person copyWith({
    Value<DateTime?> archivedAt = const Value.absent(),
    String? id,
    String? name,
    int? colorIndex,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Person(
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    colorIndex: colorIndex ?? this.colorIndex,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Person copyWithCompanion(PersonsCompanion data) {
    return Person(
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      colorIndex: data.colorIndex.present
          ? data.colorIndex.value
          : this.colorIndex,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Person(')
          ..write('archivedAt: $archivedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorIndex: $colorIndex, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    archivedAt,
    id,
    name,
    colorIndex,
    sortOrder,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Person &&
          other.archivedAt == this.archivedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.colorIndex == this.colorIndex &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PersonsCompanion extends UpdateCompanion<Person> {
  final Value<DateTime?> archivedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<int> colorIndex;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PersonsCompanion({
    this.archivedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.colorIndex = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PersonsCompanion.insert({
    this.archivedAt = const Value.absent(),
    required String id,
    required String name,
    this.colorIndex = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Person> custom({
    Expression<DateTime>? archivedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? colorIndex,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (archivedAt != null) 'archived_at': archivedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (colorIndex != null) 'color_index': colorIndex,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PersonsCompanion copyWith({
    Value<DateTime?>? archivedAt,
    Value<String>? id,
    Value<String>? name,
    Value<int>? colorIndex,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PersonsCompanion(
      archivedAt: archivedAt ?? this.archivedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      colorIndex: colorIndex ?? this.colorIndex,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colorIndex.present) {
      map['color_index'] = Variable<int>(colorIndex.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonsCompanion(')
          ..write('archivedAt: $archivedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorIndex: $colorIndex, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IncomesTable extends Incomes with TableInfo<$IncomesTable, Income> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _personIdMeta = const VerificationMeta(
    'personId',
  );
  @override
  late final GeneratedColumn<String> personId = GeneratedColumn<String>(
    'person_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES persons (id)',
    ),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _netCentsMeta = const VerificationMeta(
    'netCents',
  );
  @override
  late final GeneratedColumn<int> netCents = GeneratedColumn<int>(
    'net_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grossCentsMeta = const VerificationMeta(
    'grossCents',
  );
  @override
  late final GeneratedColumn<int> grossCents = GeneratedColumn<int>(
    'gross_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PayInterval, int> interval =
      GeneratedColumn<int>(
        'interval',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<PayInterval>($IncomesTable.$converterinterval);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    archivedAt,
    id,
    personId,
    label,
    netCents,
    grossCents,
    interval,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'incomes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Income> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(
        _personIdMeta,
        personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta),
      );
    } else if (isInserting) {
      context.missing(_personIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('net_cents')) {
      context.handle(
        _netCentsMeta,
        netCents.isAcceptableOrUnknown(data['net_cents']!, _netCentsMeta),
      );
    } else if (isInserting) {
      context.missing(_netCentsMeta);
    }
    if (data.containsKey('gross_cents')) {
      context.handle(
        _grossCentsMeta,
        grossCents.isAcceptableOrUnknown(data['gross_cents']!, _grossCentsMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Income map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Income(
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      personId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}person_id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      netCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}net_cents'],
      )!,
      grossCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gross_cents'],
      ),
      interval: $IncomesTable.$converterinterval.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}interval'],
        )!,
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $IncomesTable createAlias(String alias) {
    return $IncomesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PayInterval, int, int> $converterinterval =
      const EnumIndexConverter<PayInterval>(PayInterval.values);
}

class Income extends DataClass implements Insertable<Income> {
  final DateTime? archivedAt;
  final String id;
  final String personId;
  final String label;

  /// Netto je [interval] in Cent — Grundlage aller Rechnungen.
  final int netCents;

  /// Brutto je [interval] in Cent (optional, nur für die Abzugsquote).
  final int? grossCents;
  final PayInterval interval;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Income({
    this.archivedAt,
    required this.id,
    required this.personId,
    required this.label,
    required this.netCents,
    this.grossCents,
    required this.interval,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    map['id'] = Variable<String>(id);
    map['person_id'] = Variable<String>(personId);
    map['label'] = Variable<String>(label);
    map['net_cents'] = Variable<int>(netCents);
    if (!nullToAbsent || grossCents != null) {
      map['gross_cents'] = Variable<int>(grossCents);
    }
    {
      map['interval'] = Variable<int>(
        $IncomesTable.$converterinterval.toSql(interval),
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  IncomesCompanion toCompanion(bool nullToAbsent) {
    return IncomesCompanion(
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      id: Value(id),
      personId: Value(personId),
      label: Value(label),
      netCents: Value(netCents),
      grossCents: grossCents == null && nullToAbsent
          ? const Value.absent()
          : Value(grossCents),
      interval: Value(interval),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Income.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Income(
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
      id: serializer.fromJson<String>(json['id']),
      personId: serializer.fromJson<String>(json['personId']),
      label: serializer.fromJson<String>(json['label']),
      netCents: serializer.fromJson<int>(json['netCents']),
      grossCents: serializer.fromJson<int?>(json['grossCents']),
      interval: $IncomesTable.$converterinterval.fromJson(
        serializer.fromJson<int>(json['interval']),
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
      'id': serializer.toJson<String>(id),
      'personId': serializer.toJson<String>(personId),
      'label': serializer.toJson<String>(label),
      'netCents': serializer.toJson<int>(netCents),
      'grossCents': serializer.toJson<int?>(grossCents),
      'interval': serializer.toJson<int>(
        $IncomesTable.$converterinterval.toJson(interval),
      ),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Income copyWith({
    Value<DateTime?> archivedAt = const Value.absent(),
    String? id,
    String? personId,
    String? label,
    int? netCents,
    Value<int?> grossCents = const Value.absent(),
    PayInterval? interval,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Income(
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    id: id ?? this.id,
    personId: personId ?? this.personId,
    label: label ?? this.label,
    netCents: netCents ?? this.netCents,
    grossCents: grossCents.present ? grossCents.value : this.grossCents,
    interval: interval ?? this.interval,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Income copyWithCompanion(IncomesCompanion data) {
    return Income(
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      id: data.id.present ? data.id.value : this.id,
      personId: data.personId.present ? data.personId.value : this.personId,
      label: data.label.present ? data.label.value : this.label,
      netCents: data.netCents.present ? data.netCents.value : this.netCents,
      grossCents: data.grossCents.present
          ? data.grossCents.value
          : this.grossCents,
      interval: data.interval.present ? data.interval.value : this.interval,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Income(')
          ..write('archivedAt: $archivedAt, ')
          ..write('id: $id, ')
          ..write('personId: $personId, ')
          ..write('label: $label, ')
          ..write('netCents: $netCents, ')
          ..write('grossCents: $grossCents, ')
          ..write('interval: $interval, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    archivedAt,
    id,
    personId,
    label,
    netCents,
    grossCents,
    interval,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Income &&
          other.archivedAt == this.archivedAt &&
          other.id == this.id &&
          other.personId == this.personId &&
          other.label == this.label &&
          other.netCents == this.netCents &&
          other.grossCents == this.grossCents &&
          other.interval == this.interval &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class IncomesCompanion extends UpdateCompanion<Income> {
  final Value<DateTime?> archivedAt;
  final Value<String> id;
  final Value<String> personId;
  final Value<String> label;
  final Value<int> netCents;
  final Value<int?> grossCents;
  final Value<PayInterval> interval;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const IncomesCompanion({
    this.archivedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.personId = const Value.absent(),
    this.label = const Value.absent(),
    this.netCents = const Value.absent(),
    this.grossCents = const Value.absent(),
    this.interval = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IncomesCompanion.insert({
    this.archivedAt = const Value.absent(),
    required String id,
    required String personId,
    required String label,
    required int netCents,
    this.grossCents = const Value.absent(),
    this.interval = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       personId = Value(personId),
       label = Value(label),
       netCents = Value(netCents),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Income> custom({
    Expression<DateTime>? archivedAt,
    Expression<String>? id,
    Expression<String>? personId,
    Expression<String>? label,
    Expression<int>? netCents,
    Expression<int>? grossCents,
    Expression<int>? interval,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (archivedAt != null) 'archived_at': archivedAt,
      if (id != null) 'id': id,
      if (personId != null) 'person_id': personId,
      if (label != null) 'label': label,
      if (netCents != null) 'net_cents': netCents,
      if (grossCents != null) 'gross_cents': grossCents,
      if (interval != null) 'interval': interval,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IncomesCompanion copyWith({
    Value<DateTime?>? archivedAt,
    Value<String>? id,
    Value<String>? personId,
    Value<String>? label,
    Value<int>? netCents,
    Value<int?>? grossCents,
    Value<PayInterval>? interval,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return IncomesCompanion(
      archivedAt: archivedAt ?? this.archivedAt,
      id: id ?? this.id,
      personId: personId ?? this.personId,
      label: label ?? this.label,
      netCents: netCents ?? this.netCents,
      grossCents: grossCents ?? this.grossCents,
      interval: interval ?? this.interval,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<String>(personId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (netCents.present) {
      map['net_cents'] = Variable<int>(netCents.value);
    }
    if (grossCents.present) {
      map['gross_cents'] = Variable<int>(grossCents.value);
    }
    if (interval.present) {
      map['interval'] = Variable<int>(
        $IncomesTable.$converterinterval.toSql(interval.value),
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomesCompanion(')
          ..write('archivedAt: $archivedAt, ')
          ..write('id: $id, ')
          ..write('personId: $personId, ')
          ..write('label: $label, ')
          ..write('netCents: $netCents, ')
          ..write('grossCents: $grossCents, ')
          ..write('interval: $interval, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AccountKind, int> kind =
      GeneratedColumn<int>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<AccountKind>($AccountsTable.$converterkind);
  static const VerificationMeta _ownerPersonIdMeta = const VerificationMeta(
    'ownerPersonId',
  );
  @override
  late final GeneratedColumn<String> ownerPersonId = GeneratedColumn<String>(
    'owner_person_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES persons (id)',
    ),
  );
  static const VerificationMeta _isMainMeta = const VerificationMeta('isMain');
  @override
  late final GeneratedColumn<bool> isMain = GeneratedColumn<bool>(
    'is_main',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_main" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _interestRateMeta = const VerificationMeta(
    'interestRate',
  );
  @override
  late final GeneratedColumn<double> interestRate = GeneratedColumn<double>(
    'interest_rate',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _balanceCentsMeta = const VerificationMeta(
    'balanceCents',
  );
  @override
  late final GeneratedColumn<int> balanceCents = GeneratedColumn<int>(
    'balance_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    archivedAt,
    id,
    name,
    kind,
    ownerPersonId,
    isMain,
    interestRate,
    balanceCents,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Account> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('owner_person_id')) {
      context.handle(
        _ownerPersonIdMeta,
        ownerPersonId.isAcceptableOrUnknown(
          data['owner_person_id']!,
          _ownerPersonIdMeta,
        ),
      );
    }
    if (data.containsKey('is_main')) {
      context.handle(
        _isMainMeta,
        isMain.isAcceptableOrUnknown(data['is_main']!, _isMainMeta),
      );
    }
    if (data.containsKey('interest_rate')) {
      context.handle(
        _interestRateMeta,
        interestRate.isAcceptableOrUnknown(
          data['interest_rate']!,
          _interestRateMeta,
        ),
      );
    }
    if (data.containsKey('balance_cents')) {
      context.handle(
        _balanceCentsMeta,
        balanceCents.isAcceptableOrUnknown(
          data['balance_cents']!,
          _balanceCentsMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: $AccountsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}kind'],
        )!,
      ),
      ownerPersonId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_person_id'],
      ),
      isMain: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_main'],
      )!,
      interestRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}interest_rate'],
      ),
      balanceCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}balance_cents'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AccountKind, int, int> $converterkind =
      const EnumIndexConverter<AccountKind>(AccountKind.values);
}

class Account extends DataClass implements Insertable<Account> {
  final DateTime? archivedAt;
  final String id;
  final String name;
  final AccountKind kind;

  /// Inhaber; `null` = Gemeinschaftskonto.
  final String? ownerPersonId;

  /// Hauptkonto der Person: bekommt, was nach allen Posten übrig bleibt.
  final bool isMain;

  /// Zinssatz in % p. a. (Tagesgeld).
  final double? interestRate;

  /// Aktueller Kontostand in Cent (optional, für Notgroschen/Prognose).
  final int? balanceCents;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Account({
    this.archivedAt,
    required this.id,
    required this.name,
    required this.kind,
    this.ownerPersonId,
    required this.isMain,
    this.interestRate,
    this.balanceCents,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    {
      map['kind'] = Variable<int>($AccountsTable.$converterkind.toSql(kind));
    }
    if (!nullToAbsent || ownerPersonId != null) {
      map['owner_person_id'] = Variable<String>(ownerPersonId);
    }
    map['is_main'] = Variable<bool>(isMain);
    if (!nullToAbsent || interestRate != null) {
      map['interest_rate'] = Variable<double>(interestRate);
    }
    if (!nullToAbsent || balanceCents != null) {
      map['balance_cents'] = Variable<int>(balanceCents);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      id: Value(id),
      name: Value(name),
      kind: Value(kind),
      ownerPersonId: ownerPersonId == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerPersonId),
      isMain: Value(isMain),
      interestRate: interestRate == null && nullToAbsent
          ? const Value.absent()
          : Value(interestRate),
      balanceCents: balanceCents == null && nullToAbsent
          ? const Value.absent()
          : Value(balanceCents),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Account.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      kind: $AccountsTable.$converterkind.fromJson(
        serializer.fromJson<int>(json['kind']),
      ),
      ownerPersonId: serializer.fromJson<String?>(json['ownerPersonId']),
      isMain: serializer.fromJson<bool>(json['isMain']),
      interestRate: serializer.fromJson<double?>(json['interestRate']),
      balanceCents: serializer.fromJson<int?>(json['balanceCents']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<int>(
        $AccountsTable.$converterkind.toJson(kind),
      ),
      'ownerPersonId': serializer.toJson<String?>(ownerPersonId),
      'isMain': serializer.toJson<bool>(isMain),
      'interestRate': serializer.toJson<double?>(interestRate),
      'balanceCents': serializer.toJson<int?>(balanceCents),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Account copyWith({
    Value<DateTime?> archivedAt = const Value.absent(),
    String? id,
    String? name,
    AccountKind? kind,
    Value<String?> ownerPersonId = const Value.absent(),
    bool? isMain,
    Value<double?> interestRate = const Value.absent(),
    Value<int?> balanceCents = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Account(
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    ownerPersonId: ownerPersonId.present
        ? ownerPersonId.value
        : this.ownerPersonId,
    isMain: isMain ?? this.isMain,
    interestRate: interestRate.present ? interestRate.value : this.interestRate,
    balanceCents: balanceCents.present ? balanceCents.value : this.balanceCents,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Account copyWithCompanion(AccountsCompanion data) {
    return Account(
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      ownerPersonId: data.ownerPersonId.present
          ? data.ownerPersonId.value
          : this.ownerPersonId,
      isMain: data.isMain.present ? data.isMain.value : this.isMain,
      interestRate: data.interestRate.present
          ? data.interestRate.value
          : this.interestRate,
      balanceCents: data.balanceCents.present
          ? data.balanceCents.value
          : this.balanceCents,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('archivedAt: $archivedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('ownerPersonId: $ownerPersonId, ')
          ..write('isMain: $isMain, ')
          ..write('interestRate: $interestRate, ')
          ..write('balanceCents: $balanceCents, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    archivedAt,
    id,
    name,
    kind,
    ownerPersonId,
    isMain,
    interestRate,
    balanceCents,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.archivedAt == this.archivedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.ownerPersonId == this.ownerPersonId &&
          other.isMain == this.isMain &&
          other.interestRate == this.interestRate &&
          other.balanceCents == this.balanceCents &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<DateTime?> archivedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<AccountKind> kind;
  final Value<String?> ownerPersonId;
  final Value<bool> isMain;
  final Value<double?> interestRate;
  final Value<int?> balanceCents;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AccountsCompanion({
    this.archivedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.ownerPersonId = const Value.absent(),
    this.isMain = const Value.absent(),
    this.interestRate = const Value.absent(),
    this.balanceCents = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.archivedAt = const Value.absent(),
    required String id,
    required String name,
    required AccountKind kind,
    this.ownerPersonId = const Value.absent(),
    this.isMain = const Value.absent(),
    this.interestRate = const Value.absent(),
    this.balanceCents = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       kind = Value(kind),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Account> custom({
    Expression<DateTime>? archivedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? kind,
    Expression<String>? ownerPersonId,
    Expression<bool>? isMain,
    Expression<double>? interestRate,
    Expression<int>? balanceCents,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (archivedAt != null) 'archived_at': archivedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (ownerPersonId != null) 'owner_person_id': ownerPersonId,
      if (isMain != null) 'is_main': isMain,
      if (interestRate != null) 'interest_rate': interestRate,
      if (balanceCents != null) 'balance_cents': balanceCents,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith({
    Value<DateTime?>? archivedAt,
    Value<String>? id,
    Value<String>? name,
    Value<AccountKind>? kind,
    Value<String?>? ownerPersonId,
    Value<bool>? isMain,
    Value<double?>? interestRate,
    Value<int?>? balanceCents,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AccountsCompanion(
      archivedAt: archivedAt ?? this.archivedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      ownerPersonId: ownerPersonId ?? this.ownerPersonId,
      isMain: isMain ?? this.isMain,
      interestRate: interestRate ?? this.interestRate,
      balanceCents: balanceCents ?? this.balanceCents,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<int>(
        $AccountsTable.$converterkind.toSql(kind.value),
      );
    }
    if (ownerPersonId.present) {
      map['owner_person_id'] = Variable<String>(ownerPersonId.value);
    }
    if (isMain.present) {
      map['is_main'] = Variable<bool>(isMain.value);
    }
    if (interestRate.present) {
      map['interest_rate'] = Variable<double>(interestRate.value);
    }
    if (balanceCents.present) {
      map['balance_cents'] = Variable<int>(balanceCents.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('archivedAt: $archivedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('ownerPersonId: $ownerPersonId, ')
          ..write('isMain: $isMain, ')
          ..write('interestRate: $interestRate, ')
          ..write('balanceCents: $balanceCents, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _systemKeyMeta = const VerificationMeta(
    'systemKey',
  );
  @override
  late final GeneratedColumn<String> systemKey = GeneratedColumn<String>(
    'system_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('category'),
  );
  @override
  late final GeneratedColumnWithTypeConverter<BudgetBucket, int> bucket =
      GeneratedColumn<int>(
        'bucket',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<BudgetBucket>($CategoriesTable.$converterbucket);
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    archivedAt,
    id,
    name,
    systemKey,
    icon,
    bucket,
    sortOrder,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('system_key')) {
      context.handle(
        _systemKeyMeta,
        systemKey.isAcceptableOrUnknown(data['system_key']!, _systemKeyMeta),
      );
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      systemKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}system_key'],
      ),
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      bucket: $CategoriesTable.$converterbucket.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}bucket'],
        )!,
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BudgetBucket, int, int> $converterbucket =
      const EnumIndexConverter<BudgetBucket>(BudgetBucket.values);
}

class Category extends DataClass implements Insertable<Category> {
  final DateTime? archivedAt;
  final String id;
  final String name;

  /// Schlüssel der Standardkategorien (siehe `CategoryKey`); eigene = `null`.
  final String? systemKey;

  /// Symbol (Schlüssel aus `categoryIcons`).
  final String icon;
  final BudgetBucket bucket;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Category({
    this.archivedAt,
    required this.id,
    required this.name,
    this.systemKey,
    required this.icon,
    required this.bucket,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || systemKey != null) {
      map['system_key'] = Variable<String>(systemKey);
    }
    map['icon'] = Variable<String>(icon);
    {
      map['bucket'] = Variable<int>(
        $CategoriesTable.$converterbucket.toSql(bucket),
      );
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      id: Value(id),
      name: Value(name),
      systemKey: systemKey == null && nullToAbsent
          ? const Value.absent()
          : Value(systemKey),
      icon: Value(icon),
      bucket: Value(bucket),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      systemKey: serializer.fromJson<String?>(json['systemKey']),
      icon: serializer.fromJson<String>(json['icon']),
      bucket: $CategoriesTable.$converterbucket.fromJson(
        serializer.fromJson<int>(json['bucket']),
      ),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'systemKey': serializer.toJson<String?>(systemKey),
      'icon': serializer.toJson<String>(icon),
      'bucket': serializer.toJson<int>(
        $CategoriesTable.$converterbucket.toJson(bucket),
      ),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Category copyWith({
    Value<DateTime?> archivedAt = const Value.absent(),
    String? id,
    String? name,
    Value<String?> systemKey = const Value.absent(),
    String? icon,
    BudgetBucket? bucket,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Category(
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    systemKey: systemKey.present ? systemKey.value : this.systemKey,
    icon: icon ?? this.icon,
    bucket: bucket ?? this.bucket,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      systemKey: data.systemKey.present ? data.systemKey.value : this.systemKey,
      icon: data.icon.present ? data.icon.value : this.icon,
      bucket: data.bucket.present ? data.bucket.value : this.bucket,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('archivedAt: $archivedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('systemKey: $systemKey, ')
          ..write('icon: $icon, ')
          ..write('bucket: $bucket, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    archivedAt,
    id,
    name,
    systemKey,
    icon,
    bucket,
    sortOrder,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.archivedAt == this.archivedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.systemKey == this.systemKey &&
          other.icon == this.icon &&
          other.bucket == this.bucket &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<DateTime?> archivedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String?> systemKey;
  final Value<String> icon;
  final Value<BudgetBucket> bucket;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.archivedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.systemKey = const Value.absent(),
    this.icon = const Value.absent(),
    this.bucket = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.archivedAt = const Value.absent(),
    required String id,
    required String name,
    this.systemKey = const Value.absent(),
    this.icon = const Value.absent(),
    required BudgetBucket bucket,
    this.sortOrder = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       bucket = Value(bucket),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Category> custom({
    Expression<DateTime>? archivedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? systemKey,
    Expression<String>? icon,
    Expression<int>? bucket,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (archivedAt != null) 'archived_at': archivedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (systemKey != null) 'system_key': systemKey,
      if (icon != null) 'icon': icon,
      if (bucket != null) 'bucket': bucket,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<DateTime?>? archivedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String?>? systemKey,
    Value<String>? icon,
    Value<BudgetBucket>? bucket,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      archivedAt: archivedAt ?? this.archivedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      systemKey: systemKey ?? this.systemKey,
      icon: icon ?? this.icon,
      bucket: bucket ?? this.bucket,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (systemKey.present) {
      map['system_key'] = Variable<String>(systemKey.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (bucket.present) {
      map['bucket'] = Variable<int>(
        $CategoriesTable.$converterbucket.toSql(bucket.value),
      );
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('archivedAt: $archivedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('systemKey: $systemKey, ')
          ..write('icon: $icon, ')
          ..write('bucket: $bucket, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetItemsTable extends BudgetItems
    with TableInfo<$BudgetItemsTable, BudgetItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PayInterval, int> interval =
      GeneratedColumn<int>(
        'interval',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<PayInterval>($BudgetItemsTable.$converterinterval);
  static const VerificationMeta _payerPersonIdMeta = const VerificationMeta(
    'payerPersonId',
  );
  @override
  late final GeneratedColumn<String> payerPersonId = GeneratedColumn<String>(
    'payer_person_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES persons (id)',
    ),
  );
  static const VerificationMeta _beneficiaryPersonIdMeta =
      const VerificationMeta('beneficiaryPersonId');
  @override
  late final GeneratedColumn<String> beneficiaryPersonId =
      GeneratedColumn<String>(
        'beneficiary_person_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES persons (id)',
        ),
      );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<BudgetBucket?, int>
  bucketOverride = GeneratedColumn<int>(
    'bucket_override',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  ).withConverter<BudgetBucket?>($BudgetItemsTable.$converterbucketOverriden);
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
    'tag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contractNumberMeta = const VerificationMeta(
    'contractNumber',
  );
  @override
  late final GeneratedColumn<String> contractNumber = GeneratedColumn<String>(
    'contract_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueMonthMeta = const VerificationMeta(
    'dueMonth',
  );
  @override
  late final GeneratedColumn<int> dueMonth = GeneratedColumn<int>(
    'due_month',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _savingsPotentialCentsMeta =
      const VerificationMeta('savingsPotentialCents');
  @override
  late final GeneratedColumn<int> savingsPotentialCents = GeneratedColumn<int>(
    'savings_potential_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetCentsMeta = const VerificationMeta(
    'targetCents',
  );
  @override
  late final GeneratedColumn<int> targetCents = GeneratedColumn<int>(
    'target_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    archivedAt,
    id,
    categoryId,
    label,
    amountCents,
    interval,
    payerPersonId,
    beneficiaryPersonId,
    accountId,
    bucketOverride,
    tag,
    provider,
    contractNumber,
    phone,
    dueMonth,
    savingsPotentialCents,
    targetCents,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('payer_person_id')) {
      context.handle(
        _payerPersonIdMeta,
        payerPersonId.isAcceptableOrUnknown(
          data['payer_person_id']!,
          _payerPersonIdMeta,
        ),
      );
    }
    if (data.containsKey('beneficiary_person_id')) {
      context.handle(
        _beneficiaryPersonIdMeta,
        beneficiaryPersonId.isAcceptableOrUnknown(
          data['beneficiary_person_id']!,
          _beneficiaryPersonIdMeta,
        ),
      );
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('tag')) {
      context.handle(
        _tagMeta,
        tag.isAcceptableOrUnknown(data['tag']!, _tagMeta),
      );
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    }
    if (data.containsKey('contract_number')) {
      context.handle(
        _contractNumberMeta,
        contractNumber.isAcceptableOrUnknown(
          data['contract_number']!,
          _contractNumberMeta,
        ),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('due_month')) {
      context.handle(
        _dueMonthMeta,
        dueMonth.isAcceptableOrUnknown(data['due_month']!, _dueMonthMeta),
      );
    }
    if (data.containsKey('savings_potential_cents')) {
      context.handle(
        _savingsPotentialCentsMeta,
        savingsPotentialCents.isAcceptableOrUnknown(
          data['savings_potential_cents']!,
          _savingsPotentialCentsMeta,
        ),
      );
    }
    if (data.containsKey('target_cents')) {
      context.handle(
        _targetCentsMeta,
        targetCents.isAcceptableOrUnknown(
          data['target_cents']!,
          _targetCentsMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetItem(
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      interval: $BudgetItemsTable.$converterinterval.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}interval'],
        )!,
      ),
      payerPersonId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payer_person_id'],
      ),
      beneficiaryPersonId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}beneficiary_person_id'],
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      ),
      bucketOverride: $BudgetItemsTable.$converterbucketOverriden.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}bucket_override'],
        ),
      ),
      tag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag'],
      ),
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      ),
      contractNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contract_number'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      dueMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_month'],
      ),
      savingsPotentialCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}savings_potential_cents'],
      ),
      targetCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_cents'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BudgetItemsTable createAlias(String alias) {
    return $BudgetItemsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PayInterval, int, int> $converterinterval =
      const EnumIndexConverter<PayInterval>(PayInterval.values);
  static JsonTypeConverter2<BudgetBucket, int, int> $converterbucketOverride =
      const EnumIndexConverter<BudgetBucket>(BudgetBucket.values);
  static JsonTypeConverter2<BudgetBucket?, int?, int?>
  $converterbucketOverriden = JsonTypeConverter2.asNullable(
    $converterbucketOverride,
  );
}

class BudgetItem extends DataClass implements Insertable<BudgetItem> {
  final DateTime? archivedAt;
  final String id;
  final String categoryId;
  final String label;

  /// Betrag je [interval] in Cent.
  final int amountCents;
  final PayInterval interval;

  /// Wer zahlt; `null` = Gemeinschaftskonto.
  final String? payerPersonId;

  /// Für wen; `null` = für den ganzen Haushalt.
  final String? beneficiaryPersonId;

  /// Von welchem Konto abgebucht bzw. auf welches gespart wird.
  final String? accountId;

  /// Abweichender Topf (z. B. Genussmittel unter „Lebensmittel“ = Wunsch).
  final BudgetBucket? bucketOverride;

  /// Unterkategorie, z. B. „Streaming“, „Sport“.
  final String? tag;
  final String? provider;
  final String? contractNumber;
  final String? phone;

  /// Fälligkeitsmonat (1–12) bei nicht monatlichen Zahlungen.
  final int? dueMonth;

  /// Selbst eingeschätzte mögliche Ersparnis je Monat in Cent.
  final int? savingsPotentialCents;

  /// Sparziel in Cent (nur bei Sparposten sinnvoll).
  final int? targetCents;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BudgetItem({
    this.archivedAt,
    required this.id,
    required this.categoryId,
    required this.label,
    required this.amountCents,
    required this.interval,
    this.payerPersonId,
    this.beneficiaryPersonId,
    this.accountId,
    this.bucketOverride,
    this.tag,
    this.provider,
    this.contractNumber,
    this.phone,
    this.dueMonth,
    this.savingsPotentialCents,
    this.targetCents,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    map['id'] = Variable<String>(id);
    map['category_id'] = Variable<String>(categoryId);
    map['label'] = Variable<String>(label);
    map['amount_cents'] = Variable<int>(amountCents);
    {
      map['interval'] = Variable<int>(
        $BudgetItemsTable.$converterinterval.toSql(interval),
      );
    }
    if (!nullToAbsent || payerPersonId != null) {
      map['payer_person_id'] = Variable<String>(payerPersonId);
    }
    if (!nullToAbsent || beneficiaryPersonId != null) {
      map['beneficiary_person_id'] = Variable<String>(beneficiaryPersonId);
    }
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    if (!nullToAbsent || bucketOverride != null) {
      map['bucket_override'] = Variable<int>(
        $BudgetItemsTable.$converterbucketOverriden.toSql(bucketOverride),
      );
    }
    if (!nullToAbsent || tag != null) {
      map['tag'] = Variable<String>(tag);
    }
    if (!nullToAbsent || provider != null) {
      map['provider'] = Variable<String>(provider);
    }
    if (!nullToAbsent || contractNumber != null) {
      map['contract_number'] = Variable<String>(contractNumber);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || dueMonth != null) {
      map['due_month'] = Variable<int>(dueMonth);
    }
    if (!nullToAbsent || savingsPotentialCents != null) {
      map['savings_potential_cents'] = Variable<int>(savingsPotentialCents);
    }
    if (!nullToAbsent || targetCents != null) {
      map['target_cents'] = Variable<int>(targetCents);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BudgetItemsCompanion toCompanion(bool nullToAbsent) {
    return BudgetItemsCompanion(
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      id: Value(id),
      categoryId: Value(categoryId),
      label: Value(label),
      amountCents: Value(amountCents),
      interval: Value(interval),
      payerPersonId: payerPersonId == null && nullToAbsent
          ? const Value.absent()
          : Value(payerPersonId),
      beneficiaryPersonId: beneficiaryPersonId == null && nullToAbsent
          ? const Value.absent()
          : Value(beneficiaryPersonId),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      bucketOverride: bucketOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(bucketOverride),
      tag: tag == null && nullToAbsent ? const Value.absent() : Value(tag),
      provider: provider == null && nullToAbsent
          ? const Value.absent()
          : Value(provider),
      contractNumber: contractNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(contractNumber),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      dueMonth: dueMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(dueMonth),
      savingsPotentialCents: savingsPotentialCents == null && nullToAbsent
          ? const Value.absent()
          : Value(savingsPotentialCents),
      targetCents: targetCents == null && nullToAbsent
          ? const Value.absent()
          : Value(targetCents),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BudgetItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetItem(
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
      id: serializer.fromJson<String>(json['id']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      label: serializer.fromJson<String>(json['label']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      interval: $BudgetItemsTable.$converterinterval.fromJson(
        serializer.fromJson<int>(json['interval']),
      ),
      payerPersonId: serializer.fromJson<String?>(json['payerPersonId']),
      beneficiaryPersonId: serializer.fromJson<String?>(
        json['beneficiaryPersonId'],
      ),
      accountId: serializer.fromJson<String?>(json['accountId']),
      bucketOverride: $BudgetItemsTable.$converterbucketOverriden.fromJson(
        serializer.fromJson<int?>(json['bucketOverride']),
      ),
      tag: serializer.fromJson<String?>(json['tag']),
      provider: serializer.fromJson<String?>(json['provider']),
      contractNumber: serializer.fromJson<String?>(json['contractNumber']),
      phone: serializer.fromJson<String?>(json['phone']),
      dueMonth: serializer.fromJson<int?>(json['dueMonth']),
      savingsPotentialCents: serializer.fromJson<int?>(
        json['savingsPotentialCents'],
      ),
      targetCents: serializer.fromJson<int?>(json['targetCents']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
      'id': serializer.toJson<String>(id),
      'categoryId': serializer.toJson<String>(categoryId),
      'label': serializer.toJson<String>(label),
      'amountCents': serializer.toJson<int>(amountCents),
      'interval': serializer.toJson<int>(
        $BudgetItemsTable.$converterinterval.toJson(interval),
      ),
      'payerPersonId': serializer.toJson<String?>(payerPersonId),
      'beneficiaryPersonId': serializer.toJson<String?>(beneficiaryPersonId),
      'accountId': serializer.toJson<String?>(accountId),
      'bucketOverride': serializer.toJson<int?>(
        $BudgetItemsTable.$converterbucketOverriden.toJson(bucketOverride),
      ),
      'tag': serializer.toJson<String?>(tag),
      'provider': serializer.toJson<String?>(provider),
      'contractNumber': serializer.toJson<String?>(contractNumber),
      'phone': serializer.toJson<String?>(phone),
      'dueMonth': serializer.toJson<int?>(dueMonth),
      'savingsPotentialCents': serializer.toJson<int?>(savingsPotentialCents),
      'targetCents': serializer.toJson<int?>(targetCents),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BudgetItem copyWith({
    Value<DateTime?> archivedAt = const Value.absent(),
    String? id,
    String? categoryId,
    String? label,
    int? amountCents,
    PayInterval? interval,
    Value<String?> payerPersonId = const Value.absent(),
    Value<String?> beneficiaryPersonId = const Value.absent(),
    Value<String?> accountId = const Value.absent(),
    Value<BudgetBucket?> bucketOverride = const Value.absent(),
    Value<String?> tag = const Value.absent(),
    Value<String?> provider = const Value.absent(),
    Value<String?> contractNumber = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<int?> dueMonth = const Value.absent(),
    Value<int?> savingsPotentialCents = const Value.absent(),
    Value<int?> targetCents = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BudgetItem(
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    label: label ?? this.label,
    amountCents: amountCents ?? this.amountCents,
    interval: interval ?? this.interval,
    payerPersonId: payerPersonId.present
        ? payerPersonId.value
        : this.payerPersonId,
    beneficiaryPersonId: beneficiaryPersonId.present
        ? beneficiaryPersonId.value
        : this.beneficiaryPersonId,
    accountId: accountId.present ? accountId.value : this.accountId,
    bucketOverride: bucketOverride.present
        ? bucketOverride.value
        : this.bucketOverride,
    tag: tag.present ? tag.value : this.tag,
    provider: provider.present ? provider.value : this.provider,
    contractNumber: contractNumber.present
        ? contractNumber.value
        : this.contractNumber,
    phone: phone.present ? phone.value : this.phone,
    dueMonth: dueMonth.present ? dueMonth.value : this.dueMonth,
    savingsPotentialCents: savingsPotentialCents.present
        ? savingsPotentialCents.value
        : this.savingsPotentialCents,
    targetCents: targetCents.present ? targetCents.value : this.targetCents,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BudgetItem copyWithCompanion(BudgetItemsCompanion data) {
    return BudgetItem(
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      label: data.label.present ? data.label.value : this.label,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      interval: data.interval.present ? data.interval.value : this.interval,
      payerPersonId: data.payerPersonId.present
          ? data.payerPersonId.value
          : this.payerPersonId,
      beneficiaryPersonId: data.beneficiaryPersonId.present
          ? data.beneficiaryPersonId.value
          : this.beneficiaryPersonId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      bucketOverride: data.bucketOverride.present
          ? data.bucketOverride.value
          : this.bucketOverride,
      tag: data.tag.present ? data.tag.value : this.tag,
      provider: data.provider.present ? data.provider.value : this.provider,
      contractNumber: data.contractNumber.present
          ? data.contractNumber.value
          : this.contractNumber,
      phone: data.phone.present ? data.phone.value : this.phone,
      dueMonth: data.dueMonth.present ? data.dueMonth.value : this.dueMonth,
      savingsPotentialCents: data.savingsPotentialCents.present
          ? data.savingsPotentialCents.value
          : this.savingsPotentialCents,
      targetCents: data.targetCents.present
          ? data.targetCents.value
          : this.targetCents,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetItem(')
          ..write('archivedAt: $archivedAt, ')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('label: $label, ')
          ..write('amountCents: $amountCents, ')
          ..write('interval: $interval, ')
          ..write('payerPersonId: $payerPersonId, ')
          ..write('beneficiaryPersonId: $beneficiaryPersonId, ')
          ..write('accountId: $accountId, ')
          ..write('bucketOverride: $bucketOverride, ')
          ..write('tag: $tag, ')
          ..write('provider: $provider, ')
          ..write('contractNumber: $contractNumber, ')
          ..write('phone: $phone, ')
          ..write('dueMonth: $dueMonth, ')
          ..write('savingsPotentialCents: $savingsPotentialCents, ')
          ..write('targetCents: $targetCents, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    archivedAt,
    id,
    categoryId,
    label,
    amountCents,
    interval,
    payerPersonId,
    beneficiaryPersonId,
    accountId,
    bucketOverride,
    tag,
    provider,
    contractNumber,
    phone,
    dueMonth,
    savingsPotentialCents,
    targetCents,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetItem &&
          other.archivedAt == this.archivedAt &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.label == this.label &&
          other.amountCents == this.amountCents &&
          other.interval == this.interval &&
          other.payerPersonId == this.payerPersonId &&
          other.beneficiaryPersonId == this.beneficiaryPersonId &&
          other.accountId == this.accountId &&
          other.bucketOverride == this.bucketOverride &&
          other.tag == this.tag &&
          other.provider == this.provider &&
          other.contractNumber == this.contractNumber &&
          other.phone == this.phone &&
          other.dueMonth == this.dueMonth &&
          other.savingsPotentialCents == this.savingsPotentialCents &&
          other.targetCents == this.targetCents &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BudgetItemsCompanion extends UpdateCompanion<BudgetItem> {
  final Value<DateTime?> archivedAt;
  final Value<String> id;
  final Value<String> categoryId;
  final Value<String> label;
  final Value<int> amountCents;
  final Value<PayInterval> interval;
  final Value<String?> payerPersonId;
  final Value<String?> beneficiaryPersonId;
  final Value<String?> accountId;
  final Value<BudgetBucket?> bucketOverride;
  final Value<String?> tag;
  final Value<String?> provider;
  final Value<String?> contractNumber;
  final Value<String?> phone;
  final Value<int?> dueMonth;
  final Value<int?> savingsPotentialCents;
  final Value<int?> targetCents;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BudgetItemsCompanion({
    this.archivedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.label = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.interval = const Value.absent(),
    this.payerPersonId = const Value.absent(),
    this.beneficiaryPersonId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.bucketOverride = const Value.absent(),
    this.tag = const Value.absent(),
    this.provider = const Value.absent(),
    this.contractNumber = const Value.absent(),
    this.phone = const Value.absent(),
    this.dueMonth = const Value.absent(),
    this.savingsPotentialCents = const Value.absent(),
    this.targetCents = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetItemsCompanion.insert({
    this.archivedAt = const Value.absent(),
    required String id,
    required String categoryId,
    required String label,
    required int amountCents,
    this.interval = const Value.absent(),
    this.payerPersonId = const Value.absent(),
    this.beneficiaryPersonId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.bucketOverride = const Value.absent(),
    this.tag = const Value.absent(),
    this.provider = const Value.absent(),
    this.contractNumber = const Value.absent(),
    this.phone = const Value.absent(),
    this.dueMonth = const Value.absent(),
    this.savingsPotentialCents = const Value.absent(),
    this.targetCents = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       categoryId = Value(categoryId),
       label = Value(label),
       amountCents = Value(amountCents),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BudgetItem> custom({
    Expression<DateTime>? archivedAt,
    Expression<String>? id,
    Expression<String>? categoryId,
    Expression<String>? label,
    Expression<int>? amountCents,
    Expression<int>? interval,
    Expression<String>? payerPersonId,
    Expression<String>? beneficiaryPersonId,
    Expression<String>? accountId,
    Expression<int>? bucketOverride,
    Expression<String>? tag,
    Expression<String>? provider,
    Expression<String>? contractNumber,
    Expression<String>? phone,
    Expression<int>? dueMonth,
    Expression<int>? savingsPotentialCents,
    Expression<int>? targetCents,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (archivedAt != null) 'archived_at': archivedAt,
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (label != null) 'label': label,
      if (amountCents != null) 'amount_cents': amountCents,
      if (interval != null) 'interval': interval,
      if (payerPersonId != null) 'payer_person_id': payerPersonId,
      if (beneficiaryPersonId != null)
        'beneficiary_person_id': beneficiaryPersonId,
      if (accountId != null) 'account_id': accountId,
      if (bucketOverride != null) 'bucket_override': bucketOverride,
      if (tag != null) 'tag': tag,
      if (provider != null) 'provider': provider,
      if (contractNumber != null) 'contract_number': contractNumber,
      if (phone != null) 'phone': phone,
      if (dueMonth != null) 'due_month': dueMonth,
      if (savingsPotentialCents != null)
        'savings_potential_cents': savingsPotentialCents,
      if (targetCents != null) 'target_cents': targetCents,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetItemsCompanion copyWith({
    Value<DateTime?>? archivedAt,
    Value<String>? id,
    Value<String>? categoryId,
    Value<String>? label,
    Value<int>? amountCents,
    Value<PayInterval>? interval,
    Value<String?>? payerPersonId,
    Value<String?>? beneficiaryPersonId,
    Value<String?>? accountId,
    Value<BudgetBucket?>? bucketOverride,
    Value<String?>? tag,
    Value<String?>? provider,
    Value<String?>? contractNumber,
    Value<String?>? phone,
    Value<int?>? dueMonth,
    Value<int?>? savingsPotentialCents,
    Value<int?>? targetCents,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BudgetItemsCompanion(
      archivedAt: archivedAt ?? this.archivedAt,
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      label: label ?? this.label,
      amountCents: amountCents ?? this.amountCents,
      interval: interval ?? this.interval,
      payerPersonId: payerPersonId ?? this.payerPersonId,
      beneficiaryPersonId: beneficiaryPersonId ?? this.beneficiaryPersonId,
      accountId: accountId ?? this.accountId,
      bucketOverride: bucketOverride ?? this.bucketOverride,
      tag: tag ?? this.tag,
      provider: provider ?? this.provider,
      contractNumber: contractNumber ?? this.contractNumber,
      phone: phone ?? this.phone,
      dueMonth: dueMonth ?? this.dueMonth,
      savingsPotentialCents:
          savingsPotentialCents ?? this.savingsPotentialCents,
      targetCents: targetCents ?? this.targetCents,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (interval.present) {
      map['interval'] = Variable<int>(
        $BudgetItemsTable.$converterinterval.toSql(interval.value),
      );
    }
    if (payerPersonId.present) {
      map['payer_person_id'] = Variable<String>(payerPersonId.value);
    }
    if (beneficiaryPersonId.present) {
      map['beneficiary_person_id'] = Variable<String>(
        beneficiaryPersonId.value,
      );
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (bucketOverride.present) {
      map['bucket_override'] = Variable<int>(
        $BudgetItemsTable.$converterbucketOverriden.toSql(bucketOverride.value),
      );
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (contractNumber.present) {
      map['contract_number'] = Variable<String>(contractNumber.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (dueMonth.present) {
      map['due_month'] = Variable<int>(dueMonth.value);
    }
    if (savingsPotentialCents.present) {
      map['savings_potential_cents'] = Variable<int>(
        savingsPotentialCents.value,
      );
    }
    if (targetCents.present) {
      map['target_cents'] = Variable<int>(targetCents.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetItemsCompanion(')
          ..write('archivedAt: $archivedAt, ')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('label: $label, ')
          ..write('amountCents: $amountCents, ')
          ..write('interval: $interval, ')
          ..write('payerPersonId: $payerPersonId, ')
          ..write('beneficiaryPersonId: $beneficiaryPersonId, ')
          ..write('accountId: $accountId, ')
          ..write('bucketOverride: $bucketOverride, ')
          ..write('tag: $tag, ')
          ..write('provider: $provider, ')
          ..write('contractNumber: $contractNumber, ')
          ..write('phone: $phone, ')
          ..write('dueMonth: $dueMonth, ')
          ..write('savingsPotentialCents: $savingsPotentialCents, ')
          ..write('targetCents: $targetCents, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _onboardingCompletedMeta =
      const VerificationMeta('onboardingCompleted');
  @override
  late final GeneratedColumn<bool> onboardingCompleted = GeneratedColumn<bool>(
    'onboarding_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _appLockEnabledMeta = const VerificationMeta(
    'appLockEnabled',
  );
  @override
  late final GeneratedColumn<bool> appLockEnabled = GeneratedColumn<bool>(
    'app_lock_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("app_lock_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _ruleNeedsMeta = const VerificationMeta(
    'ruleNeeds',
  );
  @override
  late final GeneratedColumn<int> ruleNeeds = GeneratedColumn<int>(
    'rule_needs',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(50),
  );
  static const VerificationMeta _ruleWantsMeta = const VerificationMeta(
    'ruleWants',
  );
  @override
  late final GeneratedColumn<int> ruleWants = GeneratedColumn<int>(
    'rule_wants',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _ruleSavingsMeta = const VerificationMeta(
    'ruleSavings',
  );
  @override
  late final GeneratedColumn<int> ruleSavings = GeneratedColumn<int>(
    'rule_savings',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(20),
  );
  @override
  late final GeneratedColumnWithTypeConverter<SplitMode, int> splitMode =
      GeneratedColumn<int>(
        'split_mode',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<SplitMode>($AppSettingsTable.$convertersplitMode);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    onboardingCompleted,
    appLockEnabled,
    ruleNeeds,
    ruleWants,
    ruleSavings,
    splitMode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('onboarding_completed')) {
      context.handle(
        _onboardingCompletedMeta,
        onboardingCompleted.isAcceptableOrUnknown(
          data['onboarding_completed']!,
          _onboardingCompletedMeta,
        ),
      );
    }
    if (data.containsKey('app_lock_enabled')) {
      context.handle(
        _appLockEnabledMeta,
        appLockEnabled.isAcceptableOrUnknown(
          data['app_lock_enabled']!,
          _appLockEnabledMeta,
        ),
      );
    }
    if (data.containsKey('rule_needs')) {
      context.handle(
        _ruleNeedsMeta,
        ruleNeeds.isAcceptableOrUnknown(data['rule_needs']!, _ruleNeedsMeta),
      );
    }
    if (data.containsKey('rule_wants')) {
      context.handle(
        _ruleWantsMeta,
        ruleWants.isAcceptableOrUnknown(data['rule_wants']!, _ruleWantsMeta),
      );
    }
    if (data.containsKey('rule_savings')) {
      context.handle(
        _ruleSavingsMeta,
        ruleSavings.isAcceptableOrUnknown(
          data['rule_savings']!,
          _ruleSavingsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      onboardingCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_completed'],
      )!,
      appLockEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}app_lock_enabled'],
      )!,
      ruleNeeds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rule_needs'],
      )!,
      ruleWants: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rule_wants'],
      )!,
      ruleSavings: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rule_savings'],
      )!,
      splitMode: $AppSettingsTable.$convertersplitMode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}split_mode'],
        )!,
      ),
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SplitMode, int, int> $convertersplitMode =
      const EnumIndexConverter<SplitMode>(SplitMode.values);
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final bool onboardingCompleted;
  final bool appLockEnabled;

  /// Budgetregel in Prozent des Nettoeinkommens.
  final int ruleNeeds;
  final int ruleWants;
  final int ruleSavings;
  final SplitMode splitMode;
  const AppSetting({
    required this.id,
    required this.onboardingCompleted,
    required this.appLockEnabled,
    required this.ruleNeeds,
    required this.ruleWants,
    required this.ruleSavings,
    required this.splitMode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['onboarding_completed'] = Variable<bool>(onboardingCompleted);
    map['app_lock_enabled'] = Variable<bool>(appLockEnabled);
    map['rule_needs'] = Variable<int>(ruleNeeds);
    map['rule_wants'] = Variable<int>(ruleWants);
    map['rule_savings'] = Variable<int>(ruleSavings);
    {
      map['split_mode'] = Variable<int>(
        $AppSettingsTable.$convertersplitMode.toSql(splitMode),
      );
    }
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      onboardingCompleted: Value(onboardingCompleted),
      appLockEnabled: Value(appLockEnabled),
      ruleNeeds: Value(ruleNeeds),
      ruleWants: Value(ruleWants),
      ruleSavings: Value(ruleSavings),
      splitMode: Value(splitMode),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      onboardingCompleted: serializer.fromJson<bool>(
        json['onboardingCompleted'],
      ),
      appLockEnabled: serializer.fromJson<bool>(json['appLockEnabled']),
      ruleNeeds: serializer.fromJson<int>(json['ruleNeeds']),
      ruleWants: serializer.fromJson<int>(json['ruleWants']),
      ruleSavings: serializer.fromJson<int>(json['ruleSavings']),
      splitMode: $AppSettingsTable.$convertersplitMode.fromJson(
        serializer.fromJson<int>(json['splitMode']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'onboardingCompleted': serializer.toJson<bool>(onboardingCompleted),
      'appLockEnabled': serializer.toJson<bool>(appLockEnabled),
      'ruleNeeds': serializer.toJson<int>(ruleNeeds),
      'ruleWants': serializer.toJson<int>(ruleWants),
      'ruleSavings': serializer.toJson<int>(ruleSavings),
      'splitMode': serializer.toJson<int>(
        $AppSettingsTable.$convertersplitMode.toJson(splitMode),
      ),
    };
  }

  AppSetting copyWith({
    int? id,
    bool? onboardingCompleted,
    bool? appLockEnabled,
    int? ruleNeeds,
    int? ruleWants,
    int? ruleSavings,
    SplitMode? splitMode,
  }) => AppSetting(
    id: id ?? this.id,
    onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    appLockEnabled: appLockEnabled ?? this.appLockEnabled,
    ruleNeeds: ruleNeeds ?? this.ruleNeeds,
    ruleWants: ruleWants ?? this.ruleWants,
    ruleSavings: ruleSavings ?? this.ruleSavings,
    splitMode: splitMode ?? this.splitMode,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      onboardingCompleted: data.onboardingCompleted.present
          ? data.onboardingCompleted.value
          : this.onboardingCompleted,
      appLockEnabled: data.appLockEnabled.present
          ? data.appLockEnabled.value
          : this.appLockEnabled,
      ruleNeeds: data.ruleNeeds.present ? data.ruleNeeds.value : this.ruleNeeds,
      ruleWants: data.ruleWants.present ? data.ruleWants.value : this.ruleWants,
      ruleSavings: data.ruleSavings.present
          ? data.ruleSavings.value
          : this.ruleSavings,
      splitMode: data.splitMode.present ? data.splitMode.value : this.splitMode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('appLockEnabled: $appLockEnabled, ')
          ..write('ruleNeeds: $ruleNeeds, ')
          ..write('ruleWants: $ruleWants, ')
          ..write('ruleSavings: $ruleSavings, ')
          ..write('splitMode: $splitMode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    onboardingCompleted,
    appLockEnabled,
    ruleNeeds,
    ruleWants,
    ruleSavings,
    splitMode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.onboardingCompleted == this.onboardingCompleted &&
          other.appLockEnabled == this.appLockEnabled &&
          other.ruleNeeds == this.ruleNeeds &&
          other.ruleWants == this.ruleWants &&
          other.ruleSavings == this.ruleSavings &&
          other.splitMode == this.splitMode);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<bool> onboardingCompleted;
  final Value<bool> appLockEnabled;
  final Value<int> ruleNeeds;
  final Value<int> ruleWants;
  final Value<int> ruleSavings;
  final Value<SplitMode> splitMode;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.appLockEnabled = const Value.absent(),
    this.ruleNeeds = const Value.absent(),
    this.ruleWants = const Value.absent(),
    this.ruleSavings = const Value.absent(),
    this.splitMode = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.appLockEnabled = const Value.absent(),
    this.ruleNeeds = const Value.absent(),
    this.ruleWants = const Value.absent(),
    this.ruleSavings = const Value.absent(),
    this.splitMode = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<bool>? onboardingCompleted,
    Expression<bool>? appLockEnabled,
    Expression<int>? ruleNeeds,
    Expression<int>? ruleWants,
    Expression<int>? ruleSavings,
    Expression<int>? splitMode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (onboardingCompleted != null)
        'onboarding_completed': onboardingCompleted,
      if (appLockEnabled != null) 'app_lock_enabled': appLockEnabled,
      if (ruleNeeds != null) 'rule_needs': ruleNeeds,
      if (ruleWants != null) 'rule_wants': ruleWants,
      if (ruleSavings != null) 'rule_savings': ruleSavings,
      if (splitMode != null) 'split_mode': splitMode,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<bool>? onboardingCompleted,
    Value<bool>? appLockEnabled,
    Value<int>? ruleNeeds,
    Value<int>? ruleWants,
    Value<int>? ruleSavings,
    Value<SplitMode>? splitMode,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      appLockEnabled: appLockEnabled ?? this.appLockEnabled,
      ruleNeeds: ruleNeeds ?? this.ruleNeeds,
      ruleWants: ruleWants ?? this.ruleWants,
      ruleSavings: ruleSavings ?? this.ruleSavings,
      splitMode: splitMode ?? this.splitMode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (onboardingCompleted.present) {
      map['onboarding_completed'] = Variable<bool>(onboardingCompleted.value);
    }
    if (appLockEnabled.present) {
      map['app_lock_enabled'] = Variable<bool>(appLockEnabled.value);
    }
    if (ruleNeeds.present) {
      map['rule_needs'] = Variable<int>(ruleNeeds.value);
    }
    if (ruleWants.present) {
      map['rule_wants'] = Variable<int>(ruleWants.value);
    }
    if (ruleSavings.present) {
      map['rule_savings'] = Variable<int>(ruleSavings.value);
    }
    if (splitMode.present) {
      map['split_mode'] = Variable<int>(
        $AppSettingsTable.$convertersplitMode.toSql(splitMode.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('appLockEnabled: $appLockEnabled, ')
          ..write('ruleNeeds: $ruleNeeds, ')
          ..write('ruleWants: $ruleWants, ')
          ..write('ruleSavings: $ruleSavings, ')
          ..write('splitMode: $splitMode')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PersonsTable persons = $PersonsTable(this);
  late final $IncomesTable incomes = $IncomesTable(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $BudgetItemsTable budgetItems = $BudgetItemsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    persons,
    incomes,
    accounts,
    categories,
    budgetItems,
    appSettings,
  ];
}

typedef $$PersonsTableCreateCompanionBuilder = PersonsCompanion Function({
  Value<DateTime?> archivedAt,
  required String id,
  required String name,
  Value<int> colorIndex,
  Value<int> sortOrder,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$PersonsTableUpdateCompanionBuilder = PersonsCompanion Function({
  Value<DateTime?> archivedAt,
  Value<String> id,
  Value<String> name,
  Value<int> colorIndex,
  Value<int> sortOrder,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$PersonsTableReferences
    extends BaseReferences<_$AppDatabase, $PersonsTable, Person> {
  $$PersonsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$IncomesTable, List<Income>> _incomesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.incomes,
    aliasName: 'persons__id__incomes__person_id',
  );

  $$IncomesTableProcessedTableManager get incomesRefs {
    final manager = $$IncomesTableTableManager(
      $_db,
      $_db.incomes,
    ).filter((f) => f.personId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_incomesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AccountsTable, List<Account>> _accountsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.accounts,
    aliasName: 'persons__id__accounts__owner_person_id',
  );

  $$AccountsTableProcessedTableManager get accountsRefs {
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.ownerPersonId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_accountsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BudgetItemsTable, List<BudgetItem>>
  _paidItemsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.budgetItems,
    aliasName: 'persons__id__budget_items__payer_person_id',
  );

  $$BudgetItemsTableProcessedTableManager get paidItems {
    final manager = $$BudgetItemsTableTableManager(
      $_db,
      $_db.budgetItems,
    ).filter((f) => f.payerPersonId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paidItemsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BudgetItemsTable, List<BudgetItem>>
  _benefitItemsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.budgetItems,
    aliasName: 'persons__id__budget_items__beneficiary_person_id',
  );

  $$BudgetItemsTableProcessedTableManager get benefitItems {
    final manager = $$BudgetItemsTableTableManager($_db, $_db.budgetItems)
        .filter(
          (f) =>
              f.beneficiaryPersonId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_benefitItemsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PersonsTableFilterComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorIndex => $composableBuilder(
    column: $table.colorIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> incomesRefs(
    Expression<bool> Function($$IncomesTableFilterComposer f) f,
  ) {
    final $$IncomesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.incomes,
      getReferencedColumn: (t) => t.personId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IncomesTableFilterComposer(
            $db: $db,
            $table: $db.incomes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> accountsRefs(
    Expression<bool> Function($$AccountsTableFilterComposer f) f,
  ) {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.ownerPersonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paidItems(
    Expression<bool> Function($$BudgetItemsTableFilterComposer f) f,
  ) {
    final $$BudgetItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetItems,
      getReferencedColumn: (t) => t.payerPersonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetItemsTableFilterComposer(
            $db: $db,
            $table: $db.budgetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> benefitItems(
    Expression<bool> Function($$BudgetItemsTableFilterComposer f) f,
  ) {
    final $$BudgetItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetItems,
      getReferencedColumn: (t) => t.beneficiaryPersonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetItemsTableFilterComposer(
            $db: $db,
            $table: $db.budgetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PersonsTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorIndex => $composableBuilder(
    column: $table.colorIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PersonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get colorIndex => $composableBuilder(
    column: $table.colorIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> incomesRefs<T extends Object>(
    Expression<T> Function($$IncomesTableAnnotationComposer a) f,
  ) {
    final $$IncomesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.incomes,
      getReferencedColumn: (t) => t.personId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IncomesTableAnnotationComposer(
            $db: $db,
            $table: $db.incomes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> accountsRefs<T extends Object>(
    Expression<T> Function($$AccountsTableAnnotationComposer a) f,
  ) {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.ownerPersonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paidItems<T extends Object>(
    Expression<T> Function($$BudgetItemsTableAnnotationComposer a) f,
  ) {
    final $$BudgetItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetItems,
      getReferencedColumn: (t) => t.payerPersonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> benefitItems<T extends Object>(
    Expression<T> Function($$BudgetItemsTableAnnotationComposer a) f,
  ) {
    final $$BudgetItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetItems,
      getReferencedColumn: (t) => t.beneficiaryPersonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PersonsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersonsTable,
          Person,
          $$PersonsTableFilterComposer,
          $$PersonsTableOrderingComposer,
          $$PersonsTableAnnotationComposer,
          $$PersonsTableCreateCompanionBuilder,
          $$PersonsTableUpdateCompanionBuilder,
          (Person, $$PersonsTableReferences),
          Person,
          PrefetchHooks Function({
            bool incomesRefs,
            bool accountsRefs,
            bool paidItems,
            bool benefitItems,
          })
        > {
  $$PersonsTableTableManager(_$AppDatabase db, $PersonsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> colorIndex = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PersonsCompanion(
                archivedAt: archivedAt,
                id: id,
                name: name,
                colorIndex: colorIndex,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime?> archivedAt = const Value.absent(),
                required String id,
                required String name,
                Value<int> colorIndex = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PersonsCompanion.insert(
                archivedAt: archivedAt,
                id: id,
                name: name,
                colorIndex: colorIndex,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PersonsTable, Person>(table),
                  $$PersonsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                incomesRefs = false,
                accountsRefs = false,
                paidItems = false,
                benefitItems = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (incomesRefs) db.incomes,
                    if (accountsRefs) db.accounts,
                    if (paidItems) db.budgetItems,
                    if (benefitItems) db.budgetItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (incomesRefs)
                        await $_getPrefetchedData<
                          Person,
                          $PersonsTable,
                          Income
                        >(
                          currentTable: table,
                          referencedTable: $$PersonsTableReferences
                              ._incomesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PersonsTableReferences(
                                db,
                                table,
                                p0,
                              ).incomesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.personId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (accountsRefs)
                        await $_getPrefetchedData<
                          Person,
                          $PersonsTable,
                          Account
                        >(
                          currentTable: table,
                          referencedTable: $$PersonsTableReferences
                              ._accountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PersonsTableReferences(
                                db,
                                table,
                                p0,
                              ).accountsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ownerPersonId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paidItems)
                        await $_getPrefetchedData<
                          Person,
                          $PersonsTable,
                          BudgetItem
                        >(
                          currentTable: table,
                          referencedTable: $$PersonsTableReferences
                              ._paidItemsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PersonsTableReferences(db, table, p0).paidItems,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.payerPersonId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (benefitItems)
                        await $_getPrefetchedData<
                          Person,
                          $PersonsTable,
                          BudgetItem
                        >(
                          currentTable: table,
                          referencedTable: $$PersonsTableReferences
                              ._benefitItemsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PersonsTableReferences(
                                db,
                                table,
                                p0,
                              ).benefitItems,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.beneficiaryPersonId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PersonsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersonsTable,
      Person,
      $$PersonsTableFilterComposer,
      $$PersonsTableOrderingComposer,
      $$PersonsTableAnnotationComposer,
      $$PersonsTableCreateCompanionBuilder,
      $$PersonsTableUpdateCompanionBuilder,
      (Person, $$PersonsTableReferences),
      Person,
      PrefetchHooks Function({
        bool incomesRefs,
        bool accountsRefs,
        bool paidItems,
        bool benefitItems,
      })
    >;
typedef $$IncomesTableCreateCompanionBuilder = IncomesCompanion Function({
  Value<DateTime?> archivedAt,
  required String id,
  required String personId,
  required String label,
  required int netCents,
  Value<int?> grossCents,
  Value<PayInterval> interval,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$IncomesTableUpdateCompanionBuilder = IncomesCompanion Function({
  Value<DateTime?> archivedAt,
  Value<String> id,
  Value<String> personId,
  Value<String> label,
  Value<int> netCents,
  Value<int?> grossCents,
  Value<PayInterval> interval,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$IncomesTableReferences
    extends BaseReferences<_$AppDatabase, $IncomesTable, Income> {
  $$IncomesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PersonsTable _personIdTable(_$AppDatabase db) =>
      db.persons.createAlias('incomes__person_id__persons__id');

  $$PersonsTableProcessedTableManager get personId {
    final $_column = $_itemColumn<String>('person_id')!;

    final manager = $$PersonsTableTableManager(
      $_db,
      $_db.persons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$IncomesTableFilterComposer
    extends Composer<_$AppDatabase, $IncomesTable> {
  $$IncomesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get netCents => $composableBuilder(
    column: $table.netCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get grossCents => $composableBuilder(
    column: $table.grossCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PayInterval, PayInterval, int> get interval =>
      $composableBuilder(
        column: $table.interval,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PersonsTableFilterComposer get personId {
    final $$PersonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableFilterComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IncomesTableOrderingComposer
    extends Composer<_$AppDatabase, $IncomesTable> {
  $$IncomesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get netCents => $composableBuilder(
    column: $table.netCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get grossCents => $composableBuilder(
    column: $table.grossCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get interval => $composableBuilder(
    column: $table.interval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PersonsTableOrderingComposer get personId {
    final $$PersonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableOrderingComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IncomesTableAnnotationComposer
    extends Composer<_$AppDatabase, $IncomesTable> {
  $$IncomesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<int> get netCents =>
      $composableBuilder(column: $table.netCents, builder: (column) => column);

  GeneratedColumn<int> get grossCents => $composableBuilder(
    column: $table.grossCents,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<PayInterval, int> get interval =>
      $composableBuilder(column: $table.interval, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PersonsTableAnnotationComposer get personId {
    final $$PersonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableAnnotationComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IncomesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IncomesTable,
          Income,
          $$IncomesTableFilterComposer,
          $$IncomesTableOrderingComposer,
          $$IncomesTableAnnotationComposer,
          $$IncomesTableCreateCompanionBuilder,
          $$IncomesTableUpdateCompanionBuilder,
          (Income, $$IncomesTableReferences),
          Income,
          PrefetchHooks Function({bool personId})
        > {
  $$IncomesTableTableManager(_$AppDatabase db, $IncomesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IncomesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IncomesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IncomesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> personId = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<int> netCents = const Value.absent(),
                Value<int?> grossCents = const Value.absent(),
                Value<PayInterval> interval = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IncomesCompanion(
                archivedAt: archivedAt,
                id: id,
                personId: personId,
                label: label,
                netCents: netCents,
                grossCents: grossCents,
                interval: interval,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime?> archivedAt = const Value.absent(),
                required String id,
                required String personId,
                required String label,
                required int netCents,
                Value<int?> grossCents = const Value.absent(),
                Value<PayInterval> interval = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => IncomesCompanion.insert(
                archivedAt: archivedAt,
                id: id,
                personId: personId,
                label: label,
                netCents: netCents,
                grossCents: grossCents,
                interval: interval,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$IncomesTable, Income>(table),
                  $$IncomesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({personId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (personId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.personId,
                        referencedTable: $$IncomesTableReferences
                            ._personIdTable(db),
                        referencedColumn: $$IncomesTableReferences
                            ._personIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$IncomesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IncomesTable,
      Income,
      $$IncomesTableFilterComposer,
      $$IncomesTableOrderingComposer,
      $$IncomesTableAnnotationComposer,
      $$IncomesTableCreateCompanionBuilder,
      $$IncomesTableUpdateCompanionBuilder,
      (Income, $$IncomesTableReferences),
      Income,
      PrefetchHooks Function({bool personId})
    >;
typedef $$AccountsTableCreateCompanionBuilder = AccountsCompanion Function({
  Value<DateTime?> archivedAt,
  required String id,
  required String name,
  required AccountKind kind,
  Value<String?> ownerPersonId,
  Value<bool> isMain,
  Value<double?> interestRate,
  Value<int?> balanceCents,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$AccountsTableUpdateCompanionBuilder = AccountsCompanion Function({
  Value<DateTime?> archivedAt,
  Value<String> id,
  Value<String> name,
  Value<AccountKind> kind,
  Value<String?> ownerPersonId,
  Value<bool> isMain,
  Value<double?> interestRate,
  Value<int?> balanceCents,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$AccountsTableReferences
    extends BaseReferences<_$AppDatabase, $AccountsTable, Account> {
  $$AccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PersonsTable _ownerPersonIdTable(_$AppDatabase db) =>
      db.persons.createAlias('accounts__owner_person_id__persons__id');

  $$PersonsTableProcessedTableManager? get ownerPersonId {
    final $_column = $_itemColumn<String>('owner_person_id');
    if ($_column == null) return null;
    final manager = $$PersonsTableTableManager(
      $_db,
      $_db.persons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ownerPersonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BudgetItemsTable, List<BudgetItem>>
  _budgetItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.budgetItems,
    aliasName: 'accounts__id__budget_items__account_id',
  );

  $$BudgetItemsTableProcessedTableManager get budgetItemsRefs {
    final manager = $$BudgetItemsTableTableManager(
      $_db,
      $_db.budgetItems,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_budgetItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AccountKind, AccountKind, int> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get isMain => $composableBuilder(
    column: $table.isMain,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get interestRate => $composableBuilder(
    column: $table.interestRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get balanceCents => $composableBuilder(
    column: $table.balanceCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PersonsTableFilterComposer get ownerPersonId {
    final $$PersonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerPersonId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableFilterComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> budgetItemsRefs(
    Expression<bool> Function($$BudgetItemsTableFilterComposer f) f,
  ) {
    final $$BudgetItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetItems,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetItemsTableFilterComposer(
            $db: $db,
            $table: $db.budgetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMain => $composableBuilder(
    column: $table.isMain,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get interestRate => $composableBuilder(
    column: $table.interestRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get balanceCents => $composableBuilder(
    column: $table.balanceCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PersonsTableOrderingComposer get ownerPersonId {
    final $$PersonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerPersonId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableOrderingComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AccountKind, int> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<bool> get isMain =>
      $composableBuilder(column: $table.isMain, builder: (column) => column);

  GeneratedColumn<double> get interestRate => $composableBuilder(
    column: $table.interestRate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get balanceCents => $composableBuilder(
    column: $table.balanceCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PersonsTableAnnotationComposer get ownerPersonId {
    final $$PersonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerPersonId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableAnnotationComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> budgetItemsRefs<T extends Object>(
    Expression<T> Function($$BudgetItemsTableAnnotationComposer a) f,
  ) {
    final $$BudgetItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetItems,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountsTable,
          Account,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (Account, $$AccountsTableReferences),
          Account,
          PrefetchHooks Function({bool ownerPersonId, bool budgetItemsRefs})
        > {
  $$AccountsTableTableManager(_$AppDatabase db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<AccountKind> kind = const Value.absent(),
                Value<String?> ownerPersonId = const Value.absent(),
                Value<bool> isMain = const Value.absent(),
                Value<double?> interestRate = const Value.absent(),
                Value<int?> balanceCents = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion(
                archivedAt: archivedAt,
                id: id,
                name: name,
                kind: kind,
                ownerPersonId: ownerPersonId,
                isMain: isMain,
                interestRate: interestRate,
                balanceCents: balanceCents,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime?> archivedAt = const Value.absent(),
                required String id,
                required String name,
                required AccountKind kind,
                Value<String?> ownerPersonId = const Value.absent(),
                Value<bool> isMain = const Value.absent(),
                Value<double?> interestRate = const Value.absent(),
                Value<int?> balanceCents = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion.insert(
                archivedAt: archivedAt,
                id: id,
                name: name,
                kind: kind,
                ownerPersonId: ownerPersonId,
                isMain: isMain,
                interestRate: interestRate,
                balanceCents: balanceCents,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AccountsTable, Account>(table),
                  $$AccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({ownerPersonId = false, budgetItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (budgetItemsRefs) db.budgetItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (ownerPersonId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.ownerPersonId,
                            referencedTable: $$AccountsTableReferences
                                ._ownerPersonIdTable(db),
                            referencedColumn: $$AccountsTableReferences
                                ._ownerPersonIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (budgetItemsRefs)
                        await $_getPrefetchedData<
                          Account,
                          $AccountsTable,
                          BudgetItem
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._budgetItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).budgetItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountsTable,
      Account,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (Account, $$AccountsTableReferences),
      Account,
      PrefetchHooks Function({bool ownerPersonId, bool budgetItemsRefs})
    >;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  Value<DateTime?> archivedAt,
  required String id,
  required String name,
  Value<String?> systemKey,
  Value<String> icon,
  required BudgetBucket bucket,
  Value<int> sortOrder,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<DateTime?> archivedAt,
  Value<String> id,
  Value<String> name,
  Value<String?> systemKey,
  Value<String> icon,
  Value<BudgetBucket> bucket,
  Value<int> sortOrder,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BudgetItemsTable, List<BudgetItem>>
  _budgetItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.budgetItems,
    aliasName: 'categories__id__budget_items__category_id',
  );

  $$BudgetItemsTableProcessedTableManager get budgetItemsRefs {
    final manager = $$BudgetItemsTableTableManager(
      $_db,
      $_db.budgetItems,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_budgetItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get systemKey => $composableBuilder(
    column: $table.systemKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BudgetBucket, BudgetBucket, int> get bucket =>
      $composableBuilder(
        column: $table.bucket,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> budgetItemsRefs(
    Expression<bool> Function($$BudgetItemsTableFilterComposer f) f,
  ) {
    final $$BudgetItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetItems,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetItemsTableFilterComposer(
            $db: $db,
            $table: $db.budgetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get systemKey => $composableBuilder(
    column: $table.systemKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bucket => $composableBuilder(
    column: $table.bucket,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get systemKey =>
      $composableBuilder(column: $table.systemKey, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BudgetBucket, int> get bucket =>
      $composableBuilder(column: $table.bucket, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> budgetItemsRefs<T extends Object>(
    Expression<T> Function($$BudgetItemsTableAnnotationComposer a) f,
  ) {
    final $$BudgetItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetItems,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({bool budgetItemsRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> systemKey = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<BudgetBucket> bucket = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                archivedAt: archivedAt,
                id: id,
                name: name,
                systemKey: systemKey,
                icon: icon,
                bucket: bucket,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime?> archivedAt = const Value.absent(),
                required String id,
                required String name,
                Value<String?> systemKey = const Value.absent(),
                Value<String> icon = const Value.absent(),
                required BudgetBucket bucket,
                Value<int> sortOrder = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                archivedAt: archivedAt,
                id: id,
                name: name,
                systemKey: systemKey,
                icon: icon,
                bucket: bucket,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriesTable, Category>(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({budgetItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (budgetItemsRefs) db.budgetItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (budgetItemsRefs)
                    await $_getPrefetchedData<
                      Category,
                      $CategoriesTable,
                      BudgetItem
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._budgetItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).budgetItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({bool budgetItemsRefs})
    >;
typedef $$BudgetItemsTableCreateCompanionBuilder =
    BudgetItemsCompanion Function({
      Value<DateTime?> archivedAt,
      required String id,
      required String categoryId,
      required String label,
      required int amountCents,
      Value<PayInterval> interval,
      Value<String?> payerPersonId,
      Value<String?> beneficiaryPersonId,
      Value<String?> accountId,
      Value<BudgetBucket?> bucketOverride,
      Value<String?> tag,
      Value<String?> provider,
      Value<String?> contractNumber,
      Value<String?> phone,
      Value<int?> dueMonth,
      Value<int?> savingsPotentialCents,
      Value<int?> targetCents,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$BudgetItemsTableUpdateCompanionBuilder =
    BudgetItemsCompanion Function({
      Value<DateTime?> archivedAt,
      Value<String> id,
      Value<String> categoryId,
      Value<String> label,
      Value<int> amountCents,
      Value<PayInterval> interval,
      Value<String?> payerPersonId,
      Value<String?> beneficiaryPersonId,
      Value<String?> accountId,
      Value<BudgetBucket?> bucketOverride,
      Value<String?> tag,
      Value<String?> provider,
      Value<String?> contractNumber,
      Value<String?> phone,
      Value<int?> dueMonth,
      Value<int?> savingsPotentialCents,
      Value<int?> targetCents,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$BudgetItemsTableReferences
    extends BaseReferences<_$AppDatabase, $BudgetItemsTable, BudgetItem> {
  $$BudgetItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('budget_items__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PersonsTable _payerPersonIdTable(_$AppDatabase db) =>
      db.persons.createAlias('budget_items__payer_person_id__persons__id');

  $$PersonsTableProcessedTableManager? get payerPersonId {
    final $_column = $_itemColumn<String>('payer_person_id');
    if ($_column == null) return null;
    final manager = $$PersonsTableTableManager(
      $_db,
      $_db.persons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_payerPersonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PersonsTable _beneficiaryPersonIdTable(_$AppDatabase db) => db.persons
      .createAlias('budget_items__beneficiary_person_id__persons__id');

  $$PersonsTableProcessedTableManager? get beneficiaryPersonId {
    final $_column = $_itemColumn<String>('beneficiary_person_id');
    if ($_column == null) return null;
    final manager = $$PersonsTableTableManager(
      $_db,
      $_db.persons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_beneficiaryPersonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('budget_items__account_id__accounts__id');

  $$AccountsTableProcessedTableManager? get accountId {
    final $_column = $_itemColumn<String>('account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BudgetItemsTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetItemsTable> {
  $$BudgetItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PayInterval, PayInterval, int> get interval =>
      $composableBuilder(
        column: $table.interval,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<BudgetBucket?, BudgetBucket, int>
  get bucketOverride => $composableBuilder(
    column: $table.bucketOverride,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contractNumber => $composableBuilder(
    column: $table.contractNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueMonth => $composableBuilder(
    column: $table.dueMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get savingsPotentialCents => $composableBuilder(
    column: $table.savingsPotentialCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetCents => $composableBuilder(
    column: $table.targetCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableFilterComposer get payerPersonId {
    final $$PersonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payerPersonId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableFilterComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableFilterComposer get beneficiaryPersonId {
    final $$PersonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryPersonId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableFilterComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetItemsTable> {
  $$BudgetItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get interval => $composableBuilder(
    column: $table.interval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bucketOverride => $composableBuilder(
    column: $table.bucketOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contractNumber => $composableBuilder(
    column: $table.contractNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueMonth => $composableBuilder(
    column: $table.dueMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get savingsPotentialCents => $composableBuilder(
    column: $table.savingsPotentialCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetCents => $composableBuilder(
    column: $table.targetCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableOrderingComposer get payerPersonId {
    final $$PersonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payerPersonId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableOrderingComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableOrderingComposer get beneficiaryPersonId {
    final $$PersonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryPersonId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableOrderingComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetItemsTable> {
  $$BudgetItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<PayInterval, int> get interval =>
      $composableBuilder(column: $table.interval, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BudgetBucket?, int> get bucketOverride =>
      $composableBuilder(
        column: $table.bucketOverride,
        builder: (column) => column,
      );

  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<String> get contractNumber => $composableBuilder(
    column: $table.contractNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<int> get dueMonth =>
      $composableBuilder(column: $table.dueMonth, builder: (column) => column);

  GeneratedColumn<int> get savingsPotentialCents => $composableBuilder(
    column: $table.savingsPotentialCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetCents => $composableBuilder(
    column: $table.targetCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableAnnotationComposer get payerPersonId {
    final $$PersonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payerPersonId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableAnnotationComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableAnnotationComposer get beneficiaryPersonId {
    final $$PersonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.beneficiaryPersonId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableAnnotationComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BudgetItemsTable,
          BudgetItem,
          $$BudgetItemsTableFilterComposer,
          $$BudgetItemsTableOrderingComposer,
          $$BudgetItemsTableAnnotationComposer,
          $$BudgetItemsTableCreateCompanionBuilder,
          $$BudgetItemsTableUpdateCompanionBuilder,
          (BudgetItem, $$BudgetItemsTableReferences),
          BudgetItem,
          PrefetchHooks Function({
            bool categoryId,
            bool payerPersonId,
            bool beneficiaryPersonId,
            bool accountId,
          })
        > {
  $$BudgetItemsTableTableManager(_$AppDatabase db, $BudgetItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<PayInterval> interval = const Value.absent(),
                Value<String?> payerPersonId = const Value.absent(),
                Value<String?> beneficiaryPersonId = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<BudgetBucket?> bucketOverride = const Value.absent(),
                Value<String?> tag = const Value.absent(),
                Value<String?> provider = const Value.absent(),
                Value<String?> contractNumber = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<int?> dueMonth = const Value.absent(),
                Value<int?> savingsPotentialCents = const Value.absent(),
                Value<int?> targetCents = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetItemsCompanion(
                archivedAt: archivedAt,
                id: id,
                categoryId: categoryId,
                label: label,
                amountCents: amountCents,
                interval: interval,
                payerPersonId: payerPersonId,
                beneficiaryPersonId: beneficiaryPersonId,
                accountId: accountId,
                bucketOverride: bucketOverride,
                tag: tag,
                provider: provider,
                contractNumber: contractNumber,
                phone: phone,
                dueMonth: dueMonth,
                savingsPotentialCents: savingsPotentialCents,
                targetCents: targetCents,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime?> archivedAt = const Value.absent(),
                required String id,
                required String categoryId,
                required String label,
                required int amountCents,
                Value<PayInterval> interval = const Value.absent(),
                Value<String?> payerPersonId = const Value.absent(),
                Value<String?> beneficiaryPersonId = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<BudgetBucket?> bucketOverride = const Value.absent(),
                Value<String?> tag = const Value.absent(),
                Value<String?> provider = const Value.absent(),
                Value<String?> contractNumber = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<int?> dueMonth = const Value.absent(),
                Value<int?> savingsPotentialCents = const Value.absent(),
                Value<int?> targetCents = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BudgetItemsCompanion.insert(
                archivedAt: archivedAt,
                id: id,
                categoryId: categoryId,
                label: label,
                amountCents: amountCents,
                interval: interval,
                payerPersonId: payerPersonId,
                beneficiaryPersonId: beneficiaryPersonId,
                accountId: accountId,
                bucketOverride: bucketOverride,
                tag: tag,
                provider: provider,
                contractNumber: contractNumber,
                phone: phone,
                dueMonth: dueMonth,
                savingsPotentialCents: savingsPotentialCents,
                targetCents: targetCents,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BudgetItemsTable, BudgetItem>(table),
                  $$BudgetItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoryId = false,
                payerPersonId = false,
                beneficiaryPersonId = false,
                accountId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoryId,
                            referencedTable: $$BudgetItemsTableReferences
                                ._categoryIdTable(db),
                            referencedColumn: $$BudgetItemsTableReferences
                                ._categoryIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (payerPersonId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.payerPersonId,
                            referencedTable: $$BudgetItemsTableReferences
                                ._payerPersonIdTable(db),
                            referencedColumn: $$BudgetItemsTableReferences
                                ._payerPersonIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (beneficiaryPersonId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.beneficiaryPersonId,
                            referencedTable: $$BudgetItemsTableReferences
                                ._beneficiaryPersonIdTable(db),
                            referencedColumn: $$BudgetItemsTableReferences
                                ._beneficiaryPersonIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (accountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.accountId,
                            referencedTable: $$BudgetItemsTableReferences
                                ._accountIdTable(db),
                            referencedColumn: $$BudgetItemsTableReferences
                                ._accountIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$BudgetItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BudgetItemsTable,
      BudgetItem,
      $$BudgetItemsTableFilterComposer,
      $$BudgetItemsTableOrderingComposer,
      $$BudgetItemsTableAnnotationComposer,
      $$BudgetItemsTableCreateCompanionBuilder,
      $$BudgetItemsTableUpdateCompanionBuilder,
      (BudgetItem, $$BudgetItemsTableReferences),
      BudgetItem,
      PrefetchHooks Function({
        bool categoryId,
        bool payerPersonId,
        bool beneficiaryPersonId,
        bool accountId,
      })
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<bool> onboardingCompleted,
      Value<bool> appLockEnabled,
      Value<int> ruleNeeds,
      Value<int> ruleWants,
      Value<int> ruleSavings,
      Value<SplitMode> splitMode,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<bool> onboardingCompleted,
      Value<bool> appLockEnabled,
      Value<int> ruleNeeds,
      Value<int> ruleWants,
      Value<int> ruleSavings,
      Value<SplitMode> splitMode,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get appLockEnabled => $composableBuilder(
    column: $table.appLockEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ruleNeeds => $composableBuilder(
    column: $table.ruleNeeds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ruleWants => $composableBuilder(
    column: $table.ruleWants,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ruleSavings => $composableBuilder(
    column: $table.ruleSavings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SplitMode, SplitMode, int> get splitMode =>
      $composableBuilder(
        column: $table.splitMode,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get appLockEnabled => $composableBuilder(
    column: $table.appLockEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ruleNeeds => $composableBuilder(
    column: $table.ruleNeeds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ruleWants => $composableBuilder(
    column: $table.ruleWants,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ruleSavings => $composableBuilder(
    column: $table.ruleSavings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get splitMode => $composableBuilder(
    column: $table.splitMode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get appLockEnabled => $composableBuilder(
    column: $table.appLockEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ruleNeeds =>
      $composableBuilder(column: $table.ruleNeeds, builder: (column) => column);

  GeneratedColumn<int> get ruleWants =>
      $composableBuilder(column: $table.ruleWants, builder: (column) => column);

  GeneratedColumn<int> get ruleSavings => $composableBuilder(
    column: $table.ruleSavings,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SplitMode, int> get splitMode =>
      $composableBuilder(column: $table.splitMode, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<bool> appLockEnabled = const Value.absent(),
                Value<int> ruleNeeds = const Value.absent(),
                Value<int> ruleWants = const Value.absent(),
                Value<int> ruleSavings = const Value.absent(),
                Value<SplitMode> splitMode = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                onboardingCompleted: onboardingCompleted,
                appLockEnabled: appLockEnabled,
                ruleNeeds: ruleNeeds,
                ruleWants: ruleWants,
                ruleSavings: ruleSavings,
                splitMode: splitMode,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<bool> appLockEnabled = const Value.absent(),
                Value<int> ruleNeeds = const Value.absent(),
                Value<int> ruleWants = const Value.absent(),
                Value<int> ruleSavings = const Value.absent(),
                Value<SplitMode> splitMode = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                onboardingCompleted: onboardingCompleted,
                appLockEnabled: appLockEnabled,
                ruleNeeds: ruleNeeds,
                ruleWants: ruleWants,
                ruleSavings: ruleSavings,
                splitMode: splitMode,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSetting>(table),
                  BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PersonsTableTableManager get persons =>
      $$PersonsTableTableManager(_db, _db.persons);
  $$IncomesTableTableManager get incomes =>
      $$IncomesTableTableManager(_db, _db.incomes);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$BudgetItemsTableTableManager get budgetItems =>
      $$BudgetItemsTableTableManager(_db, _db.budgetItems);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
