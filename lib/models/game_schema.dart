import 'package:isar/isar.dart';

part 'game_schema.g.dart';

enum ItemType { hat, glasses, shirt }

enum QuestTopic {
  menabung,
  kebutuhan_vs_keinginan,
  budgeting,
  investasi_risiko,
}

enum FinancialChoiceType { tabung, investasi }

@collection
class UserProfile {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String supabaseUserId;

  String name;
  bool isHatched;
  String? phoneNumber;
  String parentPassword;

  int xp;
  int coins;
  DateTime? lastDailyStreakClaim;
  int currentStreakDay;

  final equippedItems = IsarLink<EquippedItems>();

  @Backlink(to: "user")
  final inventory = IsarLinks<UserInventoryItem>();

  @Backlink(to: "user")
  final questHistory = IsarLinks<QuestHistory>();

  @Backlink(to: "user")
  final financialChoices = IsarLinks<FinancialChoice>();

  UserProfile({
    required this.supabaseUserId,
    required this.name,
    this.phoneNumber,
    required this.parentPassword,
    this.xp = 0,
    this.coins = 0,
    this.lastDailyStreakClaim,
    this.currentStreakDay = 0,
    this.isHatched = false,
  });
}

@collection
class ShopItem {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  int supabaseItemId;

  String name;

  @Enumerated(EnumType.name)
  ItemType type;

  String assetPath;
  int price;

  ShopItem({
    required this.supabaseItemId,
    required this.name,
    required this.type,
    required this.assetPath,
    required this.price,
  });
}

@collection
class UserInventoryItem {
  Id id = Isar.autoIncrement;

  final user = IsarLink<UserProfile>();
  final item = IsarLink<ShopItem>();

  DateTime purchasedAt;
  bool needsSync;

  UserInventoryItem({required this.purchasedAt, this.needsSync = false});
}

@collection
class EquippedItems {
  Id id = Isar.autoIncrement;

  final hat = IsarLink<ShopItem>();
  final glasses = IsarLink<ShopItem>();
  final shirt = IsarLink<ShopItem>();

  int? hatSupabaseId;
  int? glassesSupabaseId;
  int? shirtSupabaseId;

  EquippedItems({
    this.hatSupabaseId,
    this.glassesSupabaseId,
    this.shirtSupabaseId,
  });
}

@collection
class QuestHistory {
  Id id = Isar.autoIncrement;

  final user = IsarLink<UserProfile>();

  @Enumerated(EnumType.name)
  QuestTopic topic;

  bool isCorrect;
  DateTime answeredAt;
  bool needsSync;

  QuestHistory({
    required this.topic,
    required this.isCorrect,
    required this.answeredAt,
    this.needsSync = false,
  });
}

@collection
class FinancialChoice {
  Id id = Isar.autoIncrement;

  final user = IsarLink<UserProfile>();

  @Enumerated(EnumType.name)
  FinancialChoiceType choiceType;

  int coinChange;
  DateTime createdAt;
  bool needsSync;

  FinancialChoice({
    required this.choiceType,
    required this.coinChange,
    required this.createdAt,
    this.needsSync = false,
  });
}

@collection
class AppSettings {
  Id id = Isar.autoIncrement;

  bool musicOn;
  bool soundEffectsOn;

  AppSettings({this.musicOn = true, this.soundEffectsOn = true});
}
