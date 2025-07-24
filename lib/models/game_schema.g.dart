// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_schema.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserProfileCollection on Isar {
  IsarCollection<UserProfile> get userProfiles => this.collection();
}

const UserProfileSchema = CollectionSchema(
  name: r'UserProfile',
  id: 4738427352541298891,
  properties: {
    r'coins': PropertySchema(
      id: 0,
      name: r'coins',
      type: IsarType.long,
    ),
    r'currentStreakDay': PropertySchema(
      id: 1,
      name: r'currentStreakDay',
      type: IsarType.long,
    ),
    r'isHatched': PropertySchema(
      id: 2,
      name: r'isHatched',
      type: IsarType.bool,
    ),
    r'lastDailyStreakClaim': PropertySchema(
      id: 3,
      name: r'lastDailyStreakClaim',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'parentPassword': PropertySchema(
      id: 5,
      name: r'parentPassword',
      type: IsarType.string,
    ),
    r'phoneNumber': PropertySchema(
      id: 6,
      name: r'phoneNumber',
      type: IsarType.string,
    ),
    r'supabaseUserId': PropertySchema(
      id: 7,
      name: r'supabaseUserId',
      type: IsarType.string,
    ),
    r'xp': PropertySchema(
      id: 8,
      name: r'xp',
      type: IsarType.long,
    )
  },
  estimateSize: _userProfileEstimateSize,
  serialize: _userProfileSerialize,
  deserialize: _userProfileDeserialize,
  deserializeProp: _userProfileDeserializeProp,
  idName: r'id',
  indexes: {
    r'supabaseUserId': IndexSchema(
      id: -536050839130063521,
      name: r'supabaseUserId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'supabaseUserId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'equippedItems': LinkSchema(
      id: -8939642119656276220,
      name: r'equippedItems',
      target: r'EquippedItems',
      single: true,
    ),
    r'inventory': LinkSchema(
      id: 8788119378756177763,
      name: r'inventory',
      target: r'UserInventoryItem',
      single: false,
      linkName: r'user',
    ),
    r'questHistory': LinkSchema(
      id: 1931461073591385368,
      name: r'questHistory',
      target: r'QuestHistory',
      single: false,
      linkName: r'user',
    ),
    r'financialChoices': LinkSchema(
      id: 418395970726406333,
      name: r'financialChoices',
      target: r'FinancialChoice',
      single: false,
      linkName: r'user',
    )
  },
  embeddedSchemas: {},
  getId: _userProfileGetId,
  getLinks: _userProfileGetLinks,
  attach: _userProfileAttach,
  version: '3.1.8',
);

int _userProfileEstimateSize(
  UserProfile object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.parentPassword.length * 3;
  {
    final value = object.phoneNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.supabaseUserId.length * 3;
  return bytesCount;
}

void _userProfileSerialize(
  UserProfile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.coins);
  writer.writeLong(offsets[1], object.currentStreakDay);
  writer.writeBool(offsets[2], object.isHatched);
  writer.writeDateTime(offsets[3], object.lastDailyStreakClaim);
  writer.writeString(offsets[4], object.name);
  writer.writeString(offsets[5], object.parentPassword);
  writer.writeString(offsets[6], object.phoneNumber);
  writer.writeString(offsets[7], object.supabaseUserId);
  writer.writeLong(offsets[8], object.xp);
}

UserProfile _userProfileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserProfile(
    coins: reader.readLongOrNull(offsets[0]) ?? 0,
    currentStreakDay: reader.readLongOrNull(offsets[1]) ?? 0,
    isHatched: reader.readBoolOrNull(offsets[2]) ?? false,
    lastDailyStreakClaim: reader.readDateTimeOrNull(offsets[3]),
    name: reader.readString(offsets[4]),
    parentPassword: reader.readString(offsets[5]),
    phoneNumber: reader.readStringOrNull(offsets[6]),
    supabaseUserId: reader.readString(offsets[7]),
    xp: reader.readLongOrNull(offsets[8]) ?? 0,
  );
  object.id = id;
  return object;
}

P _userProfileDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userProfileGetId(UserProfile object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userProfileGetLinks(UserProfile object) {
  return [
    object.equippedItems,
    object.inventory,
    object.questHistory,
    object.financialChoices
  ];
}

void _userProfileAttach(
    IsarCollection<dynamic> col, Id id, UserProfile object) {
  object.id = id;
  object.equippedItems
      .attach(col, col.isar.collection<EquippedItems>(), r'equippedItems', id);
  object.inventory
      .attach(col, col.isar.collection<UserInventoryItem>(), r'inventory', id);
  object.questHistory
      .attach(col, col.isar.collection<QuestHistory>(), r'questHistory', id);
  object.financialChoices.attach(
      col, col.isar.collection<FinancialChoice>(), r'financialChoices', id);
}

extension UserProfileByIndex on IsarCollection<UserProfile> {
  Future<UserProfile?> getBySupabaseUserId(String supabaseUserId) {
    return getByIndex(r'supabaseUserId', [supabaseUserId]);
  }

  UserProfile? getBySupabaseUserIdSync(String supabaseUserId) {
    return getByIndexSync(r'supabaseUserId', [supabaseUserId]);
  }

  Future<bool> deleteBySupabaseUserId(String supabaseUserId) {
    return deleteByIndex(r'supabaseUserId', [supabaseUserId]);
  }

  bool deleteBySupabaseUserIdSync(String supabaseUserId) {
    return deleteByIndexSync(r'supabaseUserId', [supabaseUserId]);
  }

  Future<List<UserProfile?>> getAllBySupabaseUserId(
      List<String> supabaseUserIdValues) {
    final values = supabaseUserIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'supabaseUserId', values);
  }

  List<UserProfile?> getAllBySupabaseUserIdSync(
      List<String> supabaseUserIdValues) {
    final values = supabaseUserIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'supabaseUserId', values);
  }

  Future<int> deleteAllBySupabaseUserId(List<String> supabaseUserIdValues) {
    final values = supabaseUserIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'supabaseUserId', values);
  }

  int deleteAllBySupabaseUserIdSync(List<String> supabaseUserIdValues) {
    final values = supabaseUserIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'supabaseUserId', values);
  }

  Future<Id> putBySupabaseUserId(UserProfile object) {
    return putByIndex(r'supabaseUserId', object);
  }

  Id putBySupabaseUserIdSync(UserProfile object, {bool saveLinks = true}) {
    return putByIndexSync(r'supabaseUserId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySupabaseUserId(List<UserProfile> objects) {
    return putAllByIndex(r'supabaseUserId', objects);
  }

  List<Id> putAllBySupabaseUserIdSync(List<UserProfile> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'supabaseUserId', objects, saveLinks: saveLinks);
  }
}

extension UserProfileQueryWhereSort
    on QueryBuilder<UserProfile, UserProfile, QWhere> {
  QueryBuilder<UserProfile, UserProfile, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserProfileQueryWhere
    on QueryBuilder<UserProfile, UserProfile, QWhereClause> {
  QueryBuilder<UserProfile, UserProfile, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterWhereClause>
      supabaseUserIdEqualTo(String supabaseUserId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'supabaseUserId',
        value: [supabaseUserId],
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterWhereClause>
      supabaseUserIdNotEqualTo(String supabaseUserId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseUserId',
              lower: [],
              upper: [supabaseUserId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseUserId',
              lower: [supabaseUserId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseUserId',
              lower: [supabaseUserId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseUserId',
              lower: [],
              upper: [supabaseUserId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension UserProfileQueryFilter
    on QueryBuilder<UserProfile, UserProfile, QFilterCondition> {
  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> coinsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coins',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      coinsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'coins',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> coinsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'coins',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> coinsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'coins',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      currentStreakDayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentStreakDay',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      currentStreakDayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentStreakDay',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      currentStreakDayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentStreakDay',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      currentStreakDayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentStreakDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      isHatchedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isHatched',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      lastDailyStreakClaimIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastDailyStreakClaim',
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      lastDailyStreakClaimIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastDailyStreakClaim',
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      lastDailyStreakClaimEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastDailyStreakClaim',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      lastDailyStreakClaimGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastDailyStreakClaim',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      lastDailyStreakClaimLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastDailyStreakClaim',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      lastDailyStreakClaimBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastDailyStreakClaim',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      parentPasswordEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      parentPasswordGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      parentPasswordLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      parentPasswordBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentPassword',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      parentPasswordStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parentPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      parentPasswordEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parentPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      parentPasswordContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      parentPasswordMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentPassword',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      parentPasswordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentPassword',
        value: '',
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      parentPasswordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentPassword',
        value: '',
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      phoneNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'phoneNumber',
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      phoneNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'phoneNumber',
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      phoneNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      phoneNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      phoneNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      phoneNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phoneNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      phoneNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      phoneNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      phoneNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      phoneNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phoneNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      phoneNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      phoneNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      supabaseUserIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supabaseUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      supabaseUserIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'supabaseUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      supabaseUserIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'supabaseUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      supabaseUserIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'supabaseUserId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      supabaseUserIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'supabaseUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      supabaseUserIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'supabaseUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      supabaseUserIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'supabaseUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      supabaseUserIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'supabaseUserId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      supabaseUserIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supabaseUserId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      supabaseUserIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'supabaseUserId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> xpEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'xp',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> xpGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'xp',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> xpLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'xp',
        value: value,
      ));
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> xpBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'xp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserProfileQueryObject
    on QueryBuilder<UserProfile, UserProfile, QFilterCondition> {}

extension UserProfileQueryLinks
    on QueryBuilder<UserProfile, UserProfile, QFilterCondition> {
  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> equippedItems(
      FilterQuery<EquippedItems> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'equippedItems');
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      equippedItemsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'equippedItems', 0, true, 0, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> inventory(
      FilterQuery<UserInventoryItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'inventory');
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      inventoryLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'inventory', length, true, length, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      inventoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'inventory', 0, true, 0, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      inventoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'inventory', 0, false, 999999, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      inventoryLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'inventory', 0, true, length, include);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      inventoryLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'inventory', length, include, 999999, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      inventoryLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'inventory', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition> questHistory(
      FilterQuery<QuestHistory> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'questHistory');
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      questHistoryLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questHistory', length, true, length, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      questHistoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questHistory', 0, true, 0, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      questHistoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questHistory', 0, false, 999999, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      questHistoryLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questHistory', 0, true, length, include);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      questHistoryLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'questHistory', length, include, 999999, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      questHistoryLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'questHistory', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      financialChoices(FilterQuery<FinancialChoice> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'financialChoices');
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      financialChoicesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'financialChoices', length, true, length, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      financialChoicesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'financialChoices', 0, true, 0, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      financialChoicesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'financialChoices', 0, false, 999999, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      financialChoicesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'financialChoices', 0, true, length, include);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      financialChoicesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'financialChoices', length, include, 999999, true);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterFilterCondition>
      financialChoicesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'financialChoices', lower, includeLower, upper, includeUpper);
    });
  }
}

extension UserProfileQuerySortBy
    on QueryBuilder<UserProfile, UserProfile, QSortBy> {
  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByCoins() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coins', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByCoinsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coins', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
      sortByCurrentStreakDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreakDay', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
      sortByCurrentStreakDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreakDay', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByIsHatched() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHatched', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByIsHatchedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHatched', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
      sortByLastDailyStreakClaim() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDailyStreakClaim', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
      sortByLastDailyStreakClaimDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDailyStreakClaim', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByParentPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentPassword', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
      sortByParentPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentPassword', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortBySupabaseUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseUserId', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
      sortBySupabaseUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseUserId', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByXp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xp', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> sortByXpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xp', Sort.desc);
    });
  }
}

extension UserProfileQuerySortThenBy
    on QueryBuilder<UserProfile, UserProfile, QSortThenBy> {
  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByCoins() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coins', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByCoinsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coins', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
      thenByCurrentStreakDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreakDay', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
      thenByCurrentStreakDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreakDay', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByIsHatched() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHatched', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByIsHatchedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isHatched', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
      thenByLastDailyStreakClaim() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDailyStreakClaim', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
      thenByLastDailyStreakClaimDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDailyStreakClaim', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByParentPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentPassword', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
      thenByParentPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentPassword', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenBySupabaseUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseUserId', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy>
      thenBySupabaseUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseUserId', Sort.desc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByXp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xp', Sort.asc);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QAfterSortBy> thenByXpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xp', Sort.desc);
    });
  }
}

extension UserProfileQueryWhereDistinct
    on QueryBuilder<UserProfile, UserProfile, QDistinct> {
  QueryBuilder<UserProfile, UserProfile, QDistinct> distinctByCoins() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coins');
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct>
      distinctByCurrentStreakDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentStreakDay');
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct> distinctByIsHatched() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isHatched');
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct>
      distinctByLastDailyStreakClaim() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastDailyStreakClaim');
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct> distinctByParentPassword(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentPassword',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct> distinctByPhoneNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phoneNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct> distinctBySupabaseUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supabaseUserId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserProfile, UserProfile, QDistinct> distinctByXp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'xp');
    });
  }
}

extension UserProfileQueryProperty
    on QueryBuilder<UserProfile, UserProfile, QQueryProperty> {
  QueryBuilder<UserProfile, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserProfile, int, QQueryOperations> coinsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coins');
    });
  }

  QueryBuilder<UserProfile, int, QQueryOperations> currentStreakDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentStreakDay');
    });
  }

  QueryBuilder<UserProfile, bool, QQueryOperations> isHatchedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isHatched');
    });
  }

  QueryBuilder<UserProfile, DateTime?, QQueryOperations>
      lastDailyStreakClaimProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastDailyStreakClaim');
    });
  }

  QueryBuilder<UserProfile, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<UserProfile, String, QQueryOperations> parentPasswordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentPassword');
    });
  }

  QueryBuilder<UserProfile, String?, QQueryOperations> phoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phoneNumber');
    });
  }

  QueryBuilder<UserProfile, String, QQueryOperations> supabaseUserIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supabaseUserId');
    });
  }

  QueryBuilder<UserProfile, int, QQueryOperations> xpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'xp');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetShopItemCollection on Isar {
  IsarCollection<ShopItem> get shopItems => this.collection();
}

const ShopItemSchema = CollectionSchema(
  name: r'ShopItem',
  id: 2038923739036996480,
  properties: {
    r'assetPath': PropertySchema(
      id: 0,
      name: r'assetPath',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'price': PropertySchema(
      id: 2,
      name: r'price',
      type: IsarType.long,
    ),
    r'supabaseItemId': PropertySchema(
      id: 3,
      name: r'supabaseItemId',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 4,
      name: r'type',
      type: IsarType.string,
      enumMap: _ShopItemtypeEnumValueMap,
    )
  },
  estimateSize: _shopItemEstimateSize,
  serialize: _shopItemSerialize,
  deserialize: _shopItemDeserialize,
  deserializeProp: _shopItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'supabaseItemId': IndexSchema(
      id: -296404430468700532,
      name: r'supabaseItemId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'supabaseItemId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _shopItemGetId,
  getLinks: _shopItemGetLinks,
  attach: _shopItemAttach,
  version: '3.1.8',
);

int _shopItemEstimateSize(
  ShopItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.assetPath.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.type.name.length * 3;
  return bytesCount;
}

void _shopItemSerialize(
  ShopItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.assetPath);
  writer.writeString(offsets[1], object.name);
  writer.writeLong(offsets[2], object.price);
  writer.writeLong(offsets[3], object.supabaseItemId);
  writer.writeString(offsets[4], object.type.name);
}

ShopItem _shopItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ShopItem(
    assetPath: reader.readString(offsets[0]),
    name: reader.readString(offsets[1]),
    price: reader.readLong(offsets[2]),
    supabaseItemId: reader.readLong(offsets[3]),
    type: _ShopItemtypeValueEnumMap[reader.readStringOrNull(offsets[4])] ??
        ItemType.hat,
  );
  object.id = id;
  return object;
}

P _shopItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (_ShopItemtypeValueEnumMap[reader.readStringOrNull(offset)] ??
          ItemType.hat) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ShopItemtypeEnumValueMap = {
  r'hat': r'hat',
  r'glasses': r'glasses',
  r'shirt': r'shirt',
};
const _ShopItemtypeValueEnumMap = {
  r'hat': ItemType.hat,
  r'glasses': ItemType.glasses,
  r'shirt': ItemType.shirt,
};

Id _shopItemGetId(ShopItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _shopItemGetLinks(ShopItem object) {
  return [];
}

void _shopItemAttach(IsarCollection<dynamic> col, Id id, ShopItem object) {
  object.id = id;
}

extension ShopItemByIndex on IsarCollection<ShopItem> {
  Future<ShopItem?> getBySupabaseItemId(int supabaseItemId) {
    return getByIndex(r'supabaseItemId', [supabaseItemId]);
  }

  ShopItem? getBySupabaseItemIdSync(int supabaseItemId) {
    return getByIndexSync(r'supabaseItemId', [supabaseItemId]);
  }

  Future<bool> deleteBySupabaseItemId(int supabaseItemId) {
    return deleteByIndex(r'supabaseItemId', [supabaseItemId]);
  }

  bool deleteBySupabaseItemIdSync(int supabaseItemId) {
    return deleteByIndexSync(r'supabaseItemId', [supabaseItemId]);
  }

  Future<List<ShopItem?>> getAllBySupabaseItemId(
      List<int> supabaseItemIdValues) {
    final values = supabaseItemIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'supabaseItemId', values);
  }

  List<ShopItem?> getAllBySupabaseItemIdSync(List<int> supabaseItemIdValues) {
    final values = supabaseItemIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'supabaseItemId', values);
  }

  Future<int> deleteAllBySupabaseItemId(List<int> supabaseItemIdValues) {
    final values = supabaseItemIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'supabaseItemId', values);
  }

  int deleteAllBySupabaseItemIdSync(List<int> supabaseItemIdValues) {
    final values = supabaseItemIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'supabaseItemId', values);
  }

  Future<Id> putBySupabaseItemId(ShopItem object) {
    return putByIndex(r'supabaseItemId', object);
  }

  Id putBySupabaseItemIdSync(ShopItem object, {bool saveLinks = true}) {
    return putByIndexSync(r'supabaseItemId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySupabaseItemId(List<ShopItem> objects) {
    return putAllByIndex(r'supabaseItemId', objects);
  }

  List<Id> putAllBySupabaseItemIdSync(List<ShopItem> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'supabaseItemId', objects, saveLinks: saveLinks);
  }
}

extension ShopItemQueryWhereSort on QueryBuilder<ShopItem, ShopItem, QWhere> {
  QueryBuilder<ShopItem, ShopItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterWhere> anySupabaseItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'supabaseItemId'),
      );
    });
  }
}

extension ShopItemQueryWhere on QueryBuilder<ShopItem, ShopItem, QWhereClause> {
  QueryBuilder<ShopItem, ShopItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterWhereClause> supabaseItemIdEqualTo(
      int supabaseItemId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'supabaseItemId',
        value: [supabaseItemId],
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterWhereClause> supabaseItemIdNotEqualTo(
      int supabaseItemId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseItemId',
              lower: [],
              upper: [supabaseItemId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseItemId',
              lower: [supabaseItemId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseItemId',
              lower: [supabaseItemId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseItemId',
              lower: [],
              upper: [supabaseItemId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterWhereClause> supabaseItemIdGreaterThan(
    int supabaseItemId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'supabaseItemId',
        lower: [supabaseItemId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterWhereClause> supabaseItemIdLessThan(
    int supabaseItemId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'supabaseItemId',
        lower: [],
        upper: [supabaseItemId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterWhereClause> supabaseItemIdBetween(
    int lowerSupabaseItemId,
    int upperSupabaseItemId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'supabaseItemId',
        lower: [lowerSupabaseItemId],
        includeLower: includeLower,
        upper: [upperSupabaseItemId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ShopItemQueryFilter
    on QueryBuilder<ShopItem, ShopItem, QFilterCondition> {
  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> assetPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> assetPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> assetPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> assetPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assetPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> assetPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'assetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> assetPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'assetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> assetPathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'assetPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> assetPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'assetPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> assetPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assetPath',
        value: '',
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition>
      assetPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'assetPath',
        value: '',
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> priceEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> priceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> priceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> priceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> supabaseItemIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supabaseItemId',
        value: value,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition>
      supabaseItemIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'supabaseItemId',
        value: value,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition>
      supabaseItemIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'supabaseItemId',
        value: value,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> supabaseItemIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'supabaseItemId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> typeEqualTo(
    ItemType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> typeGreaterThan(
    ItemType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> typeLessThan(
    ItemType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> typeBetween(
    ItemType lower,
    ItemType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension ShopItemQueryObject
    on QueryBuilder<ShopItem, ShopItem, QFilterCondition> {}

extension ShopItemQueryLinks
    on QueryBuilder<ShopItem, ShopItem, QFilterCondition> {}

extension ShopItemQuerySortBy on QueryBuilder<ShopItem, ShopItem, QSortBy> {
  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> sortByAssetPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetPath', Sort.asc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> sortByAssetPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetPath', Sort.desc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> sortBySupabaseItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseItemId', Sort.asc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> sortBySupabaseItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseItemId', Sort.desc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ShopItemQuerySortThenBy
    on QueryBuilder<ShopItem, ShopItem, QSortThenBy> {
  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> thenByAssetPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetPath', Sort.asc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> thenByAssetPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetPath', Sort.desc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> thenBySupabaseItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseItemId', Sort.asc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> thenBySupabaseItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseItemId', Sort.desc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ShopItemQueryWhereDistinct
    on QueryBuilder<ShopItem, ShopItem, QDistinct> {
  QueryBuilder<ShopItem, ShopItem, QDistinct> distinctByAssetPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assetPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ShopItem, ShopItem, QDistinct> distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }

  QueryBuilder<ShopItem, ShopItem, QDistinct> distinctBySupabaseItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supabaseItemId');
    });
  }

  QueryBuilder<ShopItem, ShopItem, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension ShopItemQueryProperty
    on QueryBuilder<ShopItem, ShopItem, QQueryProperty> {
  QueryBuilder<ShopItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ShopItem, String, QQueryOperations> assetPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assetPath');
    });
  }

  QueryBuilder<ShopItem, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ShopItem, int, QQueryOperations> priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }

  QueryBuilder<ShopItem, int, QQueryOperations> supabaseItemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supabaseItemId');
    });
  }

  QueryBuilder<ShopItem, ItemType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserInventoryItemCollection on Isar {
  IsarCollection<UserInventoryItem> get userInventoryItems => this.collection();
}

const UserInventoryItemSchema = CollectionSchema(
  name: r'UserInventoryItem',
  id: 9145075763089776505,
  properties: {
    r'needsSync': PropertySchema(
      id: 0,
      name: r'needsSync',
      type: IsarType.bool,
    ),
    r'purchasedAt': PropertySchema(
      id: 1,
      name: r'purchasedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _userInventoryItemEstimateSize,
  serialize: _userInventoryItemSerialize,
  deserialize: _userInventoryItemDeserialize,
  deserializeProp: _userInventoryItemDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'user': LinkSchema(
      id: 1796715909990909869,
      name: r'user',
      target: r'UserProfile',
      single: true,
    ),
    r'item': LinkSchema(
      id: 2195675184630504370,
      name: r'item',
      target: r'ShopItem',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _userInventoryItemGetId,
  getLinks: _userInventoryItemGetLinks,
  attach: _userInventoryItemAttach,
  version: '3.1.8',
);

int _userInventoryItemEstimateSize(
  UserInventoryItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _userInventoryItemSerialize(
  UserInventoryItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.needsSync);
  writer.writeDateTime(offsets[1], object.purchasedAt);
}

UserInventoryItem _userInventoryItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserInventoryItem(
    needsSync: reader.readBoolOrNull(offsets[0]) ?? false,
    purchasedAt: reader.readDateTime(offsets[1]),
  );
  object.id = id;
  return object;
}

P _userInventoryItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userInventoryItemGetId(UserInventoryItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userInventoryItemGetLinks(
    UserInventoryItem object) {
  return [object.user, object.item];
}

void _userInventoryItemAttach(
    IsarCollection<dynamic> col, Id id, UserInventoryItem object) {
  object.id = id;
  object.user.attach(col, col.isar.collection<UserProfile>(), r'user', id);
  object.item.attach(col, col.isar.collection<ShopItem>(), r'item', id);
}

extension UserInventoryItemQueryWhereSort
    on QueryBuilder<UserInventoryItem, UserInventoryItem, QWhere> {
  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserInventoryItemQueryWhere
    on QueryBuilder<UserInventoryItem, UserInventoryItem, QWhereClause> {
  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserInventoryItemQueryFilter
    on QueryBuilder<UserInventoryItem, UserInventoryItem, QFilterCondition> {
  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterFilterCondition>
      needsSyncEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'needsSync',
        value: value,
      ));
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterFilterCondition>
      purchasedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'purchasedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterFilterCondition>
      purchasedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'purchasedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterFilterCondition>
      purchasedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'purchasedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterFilterCondition>
      purchasedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'purchasedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserInventoryItemQueryObject
    on QueryBuilder<UserInventoryItem, UserInventoryItem, QFilterCondition> {}

extension UserInventoryItemQueryLinks
    on QueryBuilder<UserInventoryItem, UserInventoryItem, QFilterCondition> {
  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterFilterCondition>
      user(FilterQuery<UserProfile> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'user');
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterFilterCondition>
      userIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'user', 0, true, 0, true);
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterFilterCondition>
      item(FilterQuery<ShopItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'item');
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterFilterCondition>
      itemIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'item', 0, true, 0, true);
    });
  }
}

extension UserInventoryItemQuerySortBy
    on QueryBuilder<UserInventoryItem, UserInventoryItem, QSortBy> {
  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterSortBy>
      sortByNeedsSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsSync', Sort.asc);
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterSortBy>
      sortByNeedsSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsSync', Sort.desc);
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterSortBy>
      sortByPurchasedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchasedAt', Sort.asc);
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterSortBy>
      sortByPurchasedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchasedAt', Sort.desc);
    });
  }
}

extension UserInventoryItemQuerySortThenBy
    on QueryBuilder<UserInventoryItem, UserInventoryItem, QSortThenBy> {
  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterSortBy>
      thenByNeedsSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsSync', Sort.asc);
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterSortBy>
      thenByNeedsSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsSync', Sort.desc);
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterSortBy>
      thenByPurchasedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchasedAt', Sort.asc);
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QAfterSortBy>
      thenByPurchasedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchasedAt', Sort.desc);
    });
  }
}

extension UserInventoryItemQueryWhereDistinct
    on QueryBuilder<UserInventoryItem, UserInventoryItem, QDistinct> {
  QueryBuilder<UserInventoryItem, UserInventoryItem, QDistinct>
      distinctByNeedsSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'needsSync');
    });
  }

  QueryBuilder<UserInventoryItem, UserInventoryItem, QDistinct>
      distinctByPurchasedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'purchasedAt');
    });
  }
}

extension UserInventoryItemQueryProperty
    on QueryBuilder<UserInventoryItem, UserInventoryItem, QQueryProperty> {
  QueryBuilder<UserInventoryItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserInventoryItem, bool, QQueryOperations> needsSyncProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'needsSync');
    });
  }

  QueryBuilder<UserInventoryItem, DateTime, QQueryOperations>
      purchasedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'purchasedAt');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEquippedItemsCollection on Isar {
  IsarCollection<EquippedItems> get equippedItems => this.collection();
}

const EquippedItemsSchema = CollectionSchema(
  name: r'EquippedItems',
  id: 4632034000497503271,
  properties: {},
  estimateSize: _equippedItemsEstimateSize,
  serialize: _equippedItemsSerialize,
  deserialize: _equippedItemsDeserialize,
  deserializeProp: _equippedItemsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'hat': LinkSchema(
      id: 8502660278569532380,
      name: r'hat',
      target: r'ShopItem',
      single: true,
    ),
    r'glasses': LinkSchema(
      id: -8468255392765419290,
      name: r'glasses',
      target: r'ShopItem',
      single: true,
    ),
    r'shirt': LinkSchema(
      id: -3809732922445224791,
      name: r'shirt',
      target: r'ShopItem',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _equippedItemsGetId,
  getLinks: _equippedItemsGetLinks,
  attach: _equippedItemsAttach,
  version: '3.1.8',
);

int _equippedItemsEstimateSize(
  EquippedItems object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _equippedItemsSerialize(
  EquippedItems object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {}
EquippedItems _equippedItemsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EquippedItems();
  object.id = id;
  return object;
}

P _equippedItemsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _equippedItemsGetId(EquippedItems object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _equippedItemsGetLinks(EquippedItems object) {
  return [object.hat, object.glasses, object.shirt];
}

void _equippedItemsAttach(
    IsarCollection<dynamic> col, Id id, EquippedItems object) {
  object.id = id;
  object.hat.attach(col, col.isar.collection<ShopItem>(), r'hat', id);
  object.glasses.attach(col, col.isar.collection<ShopItem>(), r'glasses', id);
  object.shirt.attach(col, col.isar.collection<ShopItem>(), r'shirt', id);
}

extension EquippedItemsQueryWhereSort
    on QueryBuilder<EquippedItems, EquippedItems, QWhere> {
  QueryBuilder<EquippedItems, EquippedItems, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EquippedItemsQueryWhere
    on QueryBuilder<EquippedItems, EquippedItems, QWhereClause> {
  QueryBuilder<EquippedItems, EquippedItems, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EquippedItems, EquippedItems, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<EquippedItems, EquippedItems, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EquippedItems, EquippedItems, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EquippedItems, EquippedItems, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EquippedItemsQueryFilter
    on QueryBuilder<EquippedItems, EquippedItems, QFilterCondition> {
  QueryBuilder<EquippedItems, EquippedItems, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EquippedItems, EquippedItems, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EquippedItems, EquippedItems, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EquippedItems, EquippedItems, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EquippedItemsQueryObject
    on QueryBuilder<EquippedItems, EquippedItems, QFilterCondition> {}

extension EquippedItemsQueryLinks
    on QueryBuilder<EquippedItems, EquippedItems, QFilterCondition> {
  QueryBuilder<EquippedItems, EquippedItems, QAfterFilterCondition> hat(
      FilterQuery<ShopItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'hat');
    });
  }

  QueryBuilder<EquippedItems, EquippedItems, QAfterFilterCondition>
      hatIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'hat', 0, true, 0, true);
    });
  }

  QueryBuilder<EquippedItems, EquippedItems, QAfterFilterCondition> glasses(
      FilterQuery<ShopItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'glasses');
    });
  }

  QueryBuilder<EquippedItems, EquippedItems, QAfterFilterCondition>
      glassesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'glasses', 0, true, 0, true);
    });
  }

  QueryBuilder<EquippedItems, EquippedItems, QAfterFilterCondition> shirt(
      FilterQuery<ShopItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'shirt');
    });
  }

  QueryBuilder<EquippedItems, EquippedItems, QAfterFilterCondition>
      shirtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'shirt', 0, true, 0, true);
    });
  }
}

extension EquippedItemsQuerySortBy
    on QueryBuilder<EquippedItems, EquippedItems, QSortBy> {}

extension EquippedItemsQuerySortThenBy
    on QueryBuilder<EquippedItems, EquippedItems, QSortThenBy> {
  QueryBuilder<EquippedItems, EquippedItems, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EquippedItems, EquippedItems, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension EquippedItemsQueryWhereDistinct
    on QueryBuilder<EquippedItems, EquippedItems, QDistinct> {}

extension EquippedItemsQueryProperty
    on QueryBuilder<EquippedItems, EquippedItems, QQueryProperty> {
  QueryBuilder<EquippedItems, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuestHistoryCollection on Isar {
  IsarCollection<QuestHistory> get questHistorys => this.collection();
}

const QuestHistorySchema = CollectionSchema(
  name: r'QuestHistory',
  id: -5923464879967362583,
  properties: {
    r'answeredAt': PropertySchema(
      id: 0,
      name: r'answeredAt',
      type: IsarType.dateTime,
    ),
    r'isCorrect': PropertySchema(
      id: 1,
      name: r'isCorrect',
      type: IsarType.bool,
    ),
    r'needsSync': PropertySchema(
      id: 2,
      name: r'needsSync',
      type: IsarType.bool,
    ),
    r'topic': PropertySchema(
      id: 3,
      name: r'topic',
      type: IsarType.string,
      enumMap: _QuestHistorytopicEnumValueMap,
    )
  },
  estimateSize: _questHistoryEstimateSize,
  serialize: _questHistorySerialize,
  deserialize: _questHistoryDeserialize,
  deserializeProp: _questHistoryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'user': LinkSchema(
      id: -4362635977477712445,
      name: r'user',
      target: r'UserProfile',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _questHistoryGetId,
  getLinks: _questHistoryGetLinks,
  attach: _questHistoryAttach,
  version: '3.1.8',
);

int _questHistoryEstimateSize(
  QuestHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.topic.name.length * 3;
  return bytesCount;
}

void _questHistorySerialize(
  QuestHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.answeredAt);
  writer.writeBool(offsets[1], object.isCorrect);
  writer.writeBool(offsets[2], object.needsSync);
  writer.writeString(offsets[3], object.topic.name);
}

QuestHistory _questHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuestHistory(
    answeredAt: reader.readDateTime(offsets[0]),
    isCorrect: reader.readBool(offsets[1]),
    needsSync: reader.readBoolOrNull(offsets[2]) ?? false,
    topic:
        _QuestHistorytopicValueEnumMap[reader.readStringOrNull(offsets[3])] ??
            QuestTopic.menabung,
  );
  object.id = id;
  return object;
}

P _questHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 3:
      return (_QuestHistorytopicValueEnumMap[reader.readStringOrNull(offset)] ??
          QuestTopic.menabung) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _QuestHistorytopicEnumValueMap = {
  r'menabung': r'menabung',
  r'kebutuhan_vs_keinginan': r'kebutuhan_vs_keinginan',
  r'budgeting': r'budgeting',
  r'investasi_risiko': r'investasi_risiko',
};
const _QuestHistorytopicValueEnumMap = {
  r'menabung': QuestTopic.menabung,
  r'kebutuhan_vs_keinginan': QuestTopic.kebutuhan_vs_keinginan,
  r'budgeting': QuestTopic.budgeting,
  r'investasi_risiko': QuestTopic.investasi_risiko,
};

Id _questHistoryGetId(QuestHistory object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _questHistoryGetLinks(QuestHistory object) {
  return [object.user];
}

void _questHistoryAttach(
    IsarCollection<dynamic> col, Id id, QuestHistory object) {
  object.id = id;
  object.user.attach(col, col.isar.collection<UserProfile>(), r'user', id);
}

extension QuestHistoryQueryWhereSort
    on QueryBuilder<QuestHistory, QuestHistory, QWhere> {
  QueryBuilder<QuestHistory, QuestHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension QuestHistoryQueryWhere
    on QueryBuilder<QuestHistory, QuestHistory, QWhereClause> {
  QueryBuilder<QuestHistory, QuestHistory, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuestHistoryQueryFilter
    on QueryBuilder<QuestHistory, QuestHistory, QFilterCondition> {
  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition>
      answeredAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'answeredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition>
      answeredAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'answeredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition>
      answeredAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'answeredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition>
      answeredAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'answeredAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition>
      isCorrectEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCorrect',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition>
      needsSyncEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'needsSync',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition> topicEqualTo(
    QuestTopic value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition>
      topicGreaterThan(
    QuestTopic value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'topic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition> topicLessThan(
    QuestTopic value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'topic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition> topicBetween(
    QuestTopic lower,
    QuestTopic upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'topic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition>
      topicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'topic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition> topicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'topic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition> topicContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'topic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition> topicMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'topic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition>
      topicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topic',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition>
      topicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'topic',
        value: '',
      ));
    });
  }
}

extension QuestHistoryQueryObject
    on QueryBuilder<QuestHistory, QuestHistory, QFilterCondition> {}

extension QuestHistoryQueryLinks
    on QueryBuilder<QuestHistory, QuestHistory, QFilterCondition> {
  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition> user(
      FilterQuery<UserProfile> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'user');
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterFilterCondition> userIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'user', 0, true, 0, true);
    });
  }
}

extension QuestHistoryQuerySortBy
    on QueryBuilder<QuestHistory, QuestHistory, QSortBy> {
  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy> sortByAnsweredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answeredAt', Sort.asc);
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy>
      sortByAnsweredAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answeredAt', Sort.desc);
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy> sortByIsCorrect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCorrect', Sort.asc);
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy> sortByIsCorrectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCorrect', Sort.desc);
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy> sortByNeedsSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsSync', Sort.asc);
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy> sortByNeedsSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsSync', Sort.desc);
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy> sortByTopic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topic', Sort.asc);
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy> sortByTopicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topic', Sort.desc);
    });
  }
}

extension QuestHistoryQuerySortThenBy
    on QueryBuilder<QuestHistory, QuestHistory, QSortThenBy> {
  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy> thenByAnsweredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answeredAt', Sort.asc);
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy>
      thenByAnsweredAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answeredAt', Sort.desc);
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy> thenByIsCorrect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCorrect', Sort.asc);
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy> thenByIsCorrectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCorrect', Sort.desc);
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy> thenByNeedsSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsSync', Sort.asc);
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy> thenByNeedsSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsSync', Sort.desc);
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy> thenByTopic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topic', Sort.asc);
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QAfterSortBy> thenByTopicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'topic', Sort.desc);
    });
  }
}

extension QuestHistoryQueryWhereDistinct
    on QueryBuilder<QuestHistory, QuestHistory, QDistinct> {
  QueryBuilder<QuestHistory, QuestHistory, QDistinct> distinctByAnsweredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'answeredAt');
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QDistinct> distinctByIsCorrect() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCorrect');
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QDistinct> distinctByNeedsSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'needsSync');
    });
  }

  QueryBuilder<QuestHistory, QuestHistory, QDistinct> distinctByTopic(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'topic', caseSensitive: caseSensitive);
    });
  }
}

extension QuestHistoryQueryProperty
    on QueryBuilder<QuestHistory, QuestHistory, QQueryProperty> {
  QueryBuilder<QuestHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuestHistory, DateTime, QQueryOperations> answeredAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'answeredAt');
    });
  }

  QueryBuilder<QuestHistory, bool, QQueryOperations> isCorrectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCorrect');
    });
  }

  QueryBuilder<QuestHistory, bool, QQueryOperations> needsSyncProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'needsSync');
    });
  }

  QueryBuilder<QuestHistory, QuestTopic, QQueryOperations> topicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'topic');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFinancialChoiceCollection on Isar {
  IsarCollection<FinancialChoice> get financialChoices => this.collection();
}

const FinancialChoiceSchema = CollectionSchema(
  name: r'FinancialChoice',
  id: 425585796346843055,
  properties: {
    r'choiceType': PropertySchema(
      id: 0,
      name: r'choiceType',
      type: IsarType.string,
      enumMap: _FinancialChoicechoiceTypeEnumValueMap,
    ),
    r'coinChange': PropertySchema(
      id: 1,
      name: r'coinChange',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'needsSync': PropertySchema(
      id: 3,
      name: r'needsSync',
      type: IsarType.bool,
    )
  },
  estimateSize: _financialChoiceEstimateSize,
  serialize: _financialChoiceSerialize,
  deserialize: _financialChoiceDeserialize,
  deserializeProp: _financialChoiceDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'user': LinkSchema(
      id: 620704081089886614,
      name: r'user',
      target: r'UserProfile',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _financialChoiceGetId,
  getLinks: _financialChoiceGetLinks,
  attach: _financialChoiceAttach,
  version: '3.1.8',
);

int _financialChoiceEstimateSize(
  FinancialChoice object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.choiceType.name.length * 3;
  return bytesCount;
}

void _financialChoiceSerialize(
  FinancialChoice object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.choiceType.name);
  writer.writeLong(offsets[1], object.coinChange);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeBool(offsets[3], object.needsSync);
}

FinancialChoice _financialChoiceDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FinancialChoice(
    choiceType: _FinancialChoicechoiceTypeValueEnumMap[
            reader.readStringOrNull(offsets[0])] ??
        FinancialChoiceType.tabung,
    coinChange: reader.readLong(offsets[1]),
    createdAt: reader.readDateTime(offsets[2]),
    needsSync: reader.readBoolOrNull(offsets[3]) ?? false,
  );
  object.id = id;
  return object;
}

P _financialChoiceDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_FinancialChoicechoiceTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          FinancialChoiceType.tabung) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FinancialChoicechoiceTypeEnumValueMap = {
  r'tabung': r'tabung',
  r'investasi': r'investasi',
};
const _FinancialChoicechoiceTypeValueEnumMap = {
  r'tabung': FinancialChoiceType.tabung,
  r'investasi': FinancialChoiceType.investasi,
};

Id _financialChoiceGetId(FinancialChoice object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _financialChoiceGetLinks(FinancialChoice object) {
  return [object.user];
}

void _financialChoiceAttach(
    IsarCollection<dynamic> col, Id id, FinancialChoice object) {
  object.id = id;
  object.user.attach(col, col.isar.collection<UserProfile>(), r'user', id);
}

extension FinancialChoiceQueryWhereSort
    on QueryBuilder<FinancialChoice, FinancialChoice, QWhere> {
  QueryBuilder<FinancialChoice, FinancialChoice, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FinancialChoiceQueryWhere
    on QueryBuilder<FinancialChoice, FinancialChoice, QWhereClause> {
  QueryBuilder<FinancialChoice, FinancialChoice, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FinancialChoiceQueryFilter
    on QueryBuilder<FinancialChoice, FinancialChoice, QFilterCondition> {
  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      choiceTypeEqualTo(
    FinancialChoiceType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'choiceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      choiceTypeGreaterThan(
    FinancialChoiceType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'choiceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      choiceTypeLessThan(
    FinancialChoiceType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'choiceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      choiceTypeBetween(
    FinancialChoiceType lower,
    FinancialChoiceType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'choiceType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      choiceTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'choiceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      choiceTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'choiceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      choiceTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'choiceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      choiceTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'choiceType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      choiceTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'choiceType',
        value: '',
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      choiceTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'choiceType',
        value: '',
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      coinChangeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coinChange',
        value: value,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      coinChangeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'coinChange',
        value: value,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      coinChangeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'coinChange',
        value: value,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      coinChangeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'coinChange',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      needsSyncEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'needsSync',
        value: value,
      ));
    });
  }
}

extension FinancialChoiceQueryObject
    on QueryBuilder<FinancialChoice, FinancialChoice, QFilterCondition> {}

extension FinancialChoiceQueryLinks
    on QueryBuilder<FinancialChoice, FinancialChoice, QFilterCondition> {
  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition> user(
      FilterQuery<UserProfile> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'user');
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterFilterCondition>
      userIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'user', 0, true, 0, true);
    });
  }
}

extension FinancialChoiceQuerySortBy
    on QueryBuilder<FinancialChoice, FinancialChoice, QSortBy> {
  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy>
      sortByChoiceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'choiceType', Sort.asc);
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy>
      sortByChoiceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'choiceType', Sort.desc);
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy>
      sortByCoinChange() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coinChange', Sort.asc);
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy>
      sortByCoinChangeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coinChange', Sort.desc);
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy>
      sortByNeedsSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsSync', Sort.asc);
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy>
      sortByNeedsSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsSync', Sort.desc);
    });
  }
}

extension FinancialChoiceQuerySortThenBy
    on QueryBuilder<FinancialChoice, FinancialChoice, QSortThenBy> {
  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy>
      thenByChoiceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'choiceType', Sort.asc);
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy>
      thenByChoiceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'choiceType', Sort.desc);
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy>
      thenByCoinChange() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coinChange', Sort.asc);
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy>
      thenByCoinChangeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coinChange', Sort.desc);
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy>
      thenByNeedsSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsSync', Sort.asc);
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QAfterSortBy>
      thenByNeedsSyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsSync', Sort.desc);
    });
  }
}

extension FinancialChoiceQueryWhereDistinct
    on QueryBuilder<FinancialChoice, FinancialChoice, QDistinct> {
  QueryBuilder<FinancialChoice, FinancialChoice, QDistinct>
      distinctByChoiceType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'choiceType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QDistinct>
      distinctByCoinChange() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coinChange');
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoice, QDistinct>
      distinctByNeedsSync() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'needsSync');
    });
  }
}

extension FinancialChoiceQueryProperty
    on QueryBuilder<FinancialChoice, FinancialChoice, QQueryProperty> {
  QueryBuilder<FinancialChoice, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FinancialChoice, FinancialChoiceType, QQueryOperations>
      choiceTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'choiceType');
    });
  }

  QueryBuilder<FinancialChoice, int, QQueryOperations> coinChangeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coinChange');
    });
  }

  QueryBuilder<FinancialChoice, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<FinancialChoice, bool, QQueryOperations> needsSyncProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'needsSync');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppSettingsCollection on Isar {
  IsarCollection<AppSettings> get appSettings => this.collection();
}

const AppSettingsSchema = CollectionSchema(
  name: r'AppSettings',
  id: -5633561779022347008,
  properties: {
    r'musicOn': PropertySchema(
      id: 0,
      name: r'musicOn',
      type: IsarType.bool,
    ),
    r'soundEffectsOn': PropertySchema(
      id: 1,
      name: r'soundEffectsOn',
      type: IsarType.bool,
    )
  },
  estimateSize: _appSettingsEstimateSize,
  serialize: _appSettingsSerialize,
  deserialize: _appSettingsDeserialize,
  deserializeProp: _appSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _appSettingsGetId,
  getLinks: _appSettingsGetLinks,
  attach: _appSettingsAttach,
  version: '3.1.8',
);

int _appSettingsEstimateSize(
  AppSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _appSettingsSerialize(
  AppSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.musicOn);
  writer.writeBool(offsets[1], object.soundEffectsOn);
}

AppSettings _appSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppSettings(
    musicOn: reader.readBoolOrNull(offsets[0]) ?? true,
    soundEffectsOn: reader.readBoolOrNull(offsets[1]) ?? true,
  );
  object.id = id;
  return object;
}

P _appSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _appSettingsGetId(AppSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appSettingsGetLinks(AppSettings object) {
  return [];
}

void _appSettingsAttach(
    IsarCollection<dynamic> col, Id id, AppSettings object) {
  object.id = id;
}

extension AppSettingsQueryWhereSort
    on QueryBuilder<AppSettings, AppSettings, QWhere> {
  QueryBuilder<AppSettings, AppSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppSettingsQueryWhere
    on QueryBuilder<AppSettings, AppSettings, QWhereClause> {
  QueryBuilder<AppSettings, AppSettings, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AppSettingsQueryFilter
    on QueryBuilder<AppSettings, AppSettings, QFilterCondition> {
  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition> musicOnEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'musicOn',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterFilterCondition>
      soundEffectsOnEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soundEffectsOn',
        value: value,
      ));
    });
  }
}

extension AppSettingsQueryObject
    on QueryBuilder<AppSettings, AppSettings, QFilterCondition> {}

extension AppSettingsQueryLinks
    on QueryBuilder<AppSettings, AppSettings, QFilterCondition> {}

extension AppSettingsQuerySortBy
    on QueryBuilder<AppSettings, AppSettings, QSortBy> {
  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByMusicOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'musicOn', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortByMusicOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'musicOn', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> sortBySoundEffectsOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEffectsOn', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      sortBySoundEffectsOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEffectsOn', Sort.desc);
    });
  }
}

extension AppSettingsQuerySortThenBy
    on QueryBuilder<AppSettings, AppSettings, QSortThenBy> {
  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByMusicOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'musicOn', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenByMusicOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'musicOn', Sort.desc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy> thenBySoundEffectsOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEffectsOn', Sort.asc);
    });
  }

  QueryBuilder<AppSettings, AppSettings, QAfterSortBy>
      thenBySoundEffectsOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEffectsOn', Sort.desc);
    });
  }
}

extension AppSettingsQueryWhereDistinct
    on QueryBuilder<AppSettings, AppSettings, QDistinct> {
  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctByMusicOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'musicOn');
    });
  }

  QueryBuilder<AppSettings, AppSettings, QDistinct> distinctBySoundEffectsOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soundEffectsOn');
    });
  }
}

extension AppSettingsQueryProperty
    on QueryBuilder<AppSettings, AppSettings, QQueryProperty> {
  QueryBuilder<AppSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppSettings, bool, QQueryOperations> musicOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'musicOn');
    });
  }

  QueryBuilder<AppSettings, bool, QQueryOperations> soundEffectsOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soundEffectsOn');
    });
  }
}
