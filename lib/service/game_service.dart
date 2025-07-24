// File: lib/services/isar_service.dart

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ronald_duck/models/game_schema.dart';

class IsarService {
  late Future<Isar> db;

  // Singleton pattern untuk memastikan hanya ada satu instance dari service ini
  static final IsarService _instance = IsarService._internal();
  factory IsarService() => _instance;
  IsarService._internal() {
    db = _openDB();
  }

  Future<Isar> _openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [
          // Daftarkan semua skema Anda di sini
          UserProfileSchema,
          ShopItemSchema,
          UserInventoryItemSchema,
          EquippedItemsSchema,
          QuestHistorySchema,
          FinancialChoiceSchema,
          AppSettingsSchema,
        ],
        directory: dir.path,
        inspector: true, // Berguna untuk debugging
      );
    }
    return Future.value(Isar.getInstance());
  }

  // --- UserProfile Operations ---

  Future<void> saveUserProfile(UserProfile profile) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.userProfiles.put(profile);
    });
  }

  Future<UserProfile?> getUserProfile(String supabaseUserId) async {
    final isar = await db;
    return await isar.userProfiles.where().supabaseUserIdEqualTo(supabaseUserId).findFirst();
  }

  // --- ShopItem Operations ---

  Future<void> saveShopItems(List<ShopItem> items) async {
    final isar = await db;
    await isar.writeTxn(() async {
      // Menggunakan putAllBy untuk efisiensi dan menghindari duplikat berdasarkan supabaseItemId
      await isar.shopItems.putAllBySupabaseItemId(items);
    });
  }

  Future<List<ShopItem>> getShopItems() async {
    final isar = await db;
    return await isar.shopItems.where().findAll();
  }

  Future<ShopItem?> getShopItemBySupabaseId(int supabaseId) async {
    final isar = await db;
    return await isar.shopItems.where().supabaseItemIdEqualTo(supabaseId).findFirst();
  }

  // --- Inventory & Equipped Items Operations ---

  Future<void> purchaseItem(UserProfile user, ShopItem item) async {
    final isar = await db;
    final newInventoryItem = UserInventoryItem(
      purchasedAt: DateTime.now(),
      needsSync: true, // Tandai untuk sinkronisasi
    );

    await isar.writeTxn(() async {
      // Simpan item inventaris baru terlebih dahulu
      await isar.userInventoryItems.put(newInventoryItem);
      
      // Hubungkan item dengan pengguna dan item toko
      newInventoryItem.user.value = user;
      newInventoryItem.item.value = item;
      
      // Simpan perubahan pada link.
      // Metode .save() mengembalikan Future<void>, artinya tidak ada nilai yang dikembalikan.
      // Cukup 'await' untuk memastikan operasi selesai sebelum melanjutkan.
      await newInventoryItem.user.save();
      await newInventoryItem.item.save();
    });
  }

  Future<void> equipItem(UserProfile user, ShopItem itemToEquip) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await user.equippedItems.load();
      EquippedItems? currentEquipped = user.equippedItems.value;
      currentEquipped ??= EquippedItems();

      switch (itemToEquip.type) {
        case ItemType.hat:
          currentEquipped.hat.value = itemToEquip;
          break;
        case ItemType.glasses:
          currentEquipped.glasses.value = itemToEquip;
          break;
        case ItemType.shirt:
          currentEquipped.shirt.value = itemToEquip;
          break;
      }
      // Simpan perubahan pada objek EquippedItems
      await isar.equippedItems.put(currentEquipped);

      // Hubungkan objek EquippedItems yang baru ke profil pengguna
      user.equippedItems.value = currentEquipped;
      await user.equippedItems.save();
    });
  }

  // --- History Operations ---

  Future<void> addQuestHistory(UserProfile user, QuestTopic topic, bool isCorrect) async {
    final isar = await db;
    final history = QuestHistory(
      topic: topic,
      isCorrect: isCorrect,
      answeredAt: DateTime.now(),
      needsSync: true,
    );

    await isar.writeTxn(() async {
      await isar.questHistorys.put(history);
      history.user.value = user;
      await history.user.save();
    });
  }

  Future<void> addFinancialChoice(UserProfile user, FinancialChoiceType choice, int coinChange) async {
    final isar = await db;
    final financialChoice = FinancialChoice(
      choiceType: choice,
      coinChange: coinChange,
      createdAt: DateTime.now(),
      needsSync: true,
    );

    await isar.writeTxn(() async {
      await isar.financialChoices.put(financialChoice);
      financialChoice.user.value = user;
      await financialChoice.user.save();
    });
  }

  // --- AppSettings Operations ---

  Future<AppSettings> getAppSettings() async {
    final isar = await db;
    // Biasanya hanya akan ada satu entri pengaturan
    final settings = await isar.appSettings.where().findFirst();
    return settings ?? AppSettings(); // Kembalikan default jika tidak ada
  }

  Future<void> saveAppSettings(AppSettings settings) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.appSettings.put(settings);
    });
  }
}
