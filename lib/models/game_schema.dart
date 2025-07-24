import 'package:isar/isar.dart';

part 'game_schema.g.dart';

// =============================================
// ENUMS (mencerminkan tipe data di Supabase)

enum ItemType { hat, glasses, shirt }

enum QuestTopic {
  menabung,
  kebutuhan_vs_keinginan,
  budgeting,
  investasi_risiko,
}

enum FinancialChoiceType { tabung, investasi }

// =============================================
// 1. USER PROFILE & PROGRESS
// Gabungan dari tabel 'profiles' dan 'user_progress' di Supabase.
// =============================================
@collection
class UserProfile {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String supabaseUserId; // Kunci untuk sinkronisasi

  String name;
  bool isHatched;
  String? phoneNumber;
  String parentPassword; // Harus di-hash sebelum disimpan

  // Data dari user_progress
  int xp;
  int coins;
  DateTime? lastDailyStreakClaim;
  int currentStreakDay;

  // Relasi ke data lain
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
    this.isHatched = false
  });
}

// =============================================
// 2. SHOP & INVENTORY
// =============================================

@collection
class ShopItem {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  int supabaseItemId; // ID dari tabel shop_items di Supabase

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
  bool needsSync; // True jika item dibeli saat offline

  UserInventoryItem({required this.purchasedAt, this.needsSync = false});
}

@collection
class EquippedItems {
  Id id = Isar.autoIncrement;

  final hat = IsarLink<ShopItem>();
  final glasses = IsarLink<ShopItem>();
  final shirt = IsarLink<ShopItem>();
}

// =============================================
// 3. QUEST & FINANCIAL CHOICES HISTORY
// =============================================

@collection
class QuestHistory {
  Id id = Isar.autoIncrement;

  final user = IsarLink<UserProfile>();

  @Enumerated(EnumType.name)
  QuestTopic topic;

  bool isCorrect;
  DateTime answeredAt;
  bool needsSync; // True jika kuis dijawab saat offline

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
  bool needsSync; // True jika pilihan dibuat saat offline

  FinancialChoice({
    required this.choiceType,
    required this.coinChange,
    required this.createdAt,
    this.needsSync = false,
  });
}

// =============================================
// 4. APP SETTINGS (Lokal)
// =============================================
@collection
class AppSettings {
  Id id = Isar.autoIncrement;

  bool musicOn;
  bool soundEffectsOn;

  AppSettings({this.musicOn = true, this.soundEffectsOn = true});
}
