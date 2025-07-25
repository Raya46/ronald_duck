import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ronald_duck/models/game_schema.dart';

class IsarService {
  late Future<Isar> db;

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
          UserProfileSchema,
          ShopItemSchema,
          UserInventoryItemSchema,
          EquippedItemsSchema,
          QuestHistorySchema,
          FinancialChoiceSchema,
          AppSettingsSchema,
        ],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> saveUserProfile(UserProfile profile) async {
    final isar = await db;
    await isar.writeTxn(() => isar.userProfiles.put(profile));
  }

  Future<UserProfile?> getUserProfile(String supabaseUserId) async {
    final isar = await db;
    return await isar.userProfiles
        .where()
        .supabaseUserIdEqualTo(supabaseUserId)
        .findFirst();
  }

  Future<void> saveShopItems(List<ShopItem> items) async {
    final isar = await db;
    await isar.writeTxn(() => isar.shopItems.putAllBySupabaseItemId(items));
  }

  Future<List<ShopItem>> getShopItems() async {
    final isar = await db;
    return await isar.shopItems.where().findAll();
  }

  Future<ShopItem?> getShopItemBySupabaseId(int? supabaseId) async {
    if (supabaseId == null) return null;
    final isar = await db;
    return await isar.shopItems
        .where()
        .supabaseItemIdEqualTo(supabaseId)
        .findFirst();
  }

  Future<void> purchaseItem(UserProfile user, ShopItem item) async {
    final isar = await db;
    final newInventoryItem = UserInventoryItem(
      purchasedAt: DateTime.now(),
      needsSync: true,
    );

    await isar.writeTxn(() async {
      await isar.userInventoryItems.put(newInventoryItem);
      newInventoryItem.user.value = user;
      newInventoryItem.item.value = item;
      await newInventoryItem.user.save();
      await newInventoryItem.item.save();
    });
  }

  Future<void> syncUserInventory(
    UserProfile user,
    Set<int> supabaseInventoryIds,
  ) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await user.inventory.load();
      await isar.userInventoryItems.deleteAll(
        user.inventory.map((e) => e.id).toList(),
      );
      user.inventory.clear();

      for (final itemId in supabaseInventoryIds) {
        final shopItem = await isar.shopItems.getBySupabaseItemId(itemId);
        if (shopItem != null) {
          final newInventoryItem = UserInventoryItem(
            purchasedAt: DateTime.now(),
          );
          await isar.userInventoryItems.put(newInventoryItem);
          newInventoryItem.item.value = shopItem;
          await newInventoryItem.item.save();
          user.inventory.add(newInventoryItem);
        }
      }
      await user.inventory.save();
    });
  }

  Future<void> equipItem(UserProfile user, ShopItem itemToEquip) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await user.equippedItems.load();
      EquippedItems currentEquipped =
          user.equippedItems.value ?? EquippedItems();

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
      await isar.equippedItems.put(currentEquipped);
      user.equippedItems.value = currentEquipped;
      await user.equippedItems.save();
    });
  }

  Future<void> updateEquippedItems(
    UserProfile user,
    EquippedItems equippedItems,
  ) async {
    final isar = await db;

    await isar.writeTxn(() async {
      await equippedItems.hat.save();
      await equippedItems.glasses.save();
      await equippedItems.shirt.save();

      await isar.equippedItems.put(equippedItems);

      user.equippedItems.value = equippedItems;

      await user.equippedItems.save();
    });
  }

  Future<EquippedItems?> getOrCreateEquippedItems(
    UserProfile user, {
    int? hatId,
    int? glassesId,
    int? shirtId,
  }) async {
    final isar = await db;
    await user.equippedItems.load();
    EquippedItems? equippedItems = user.equippedItems.value;

    if (equippedItems == null) {
      equippedItems = EquippedItems();
      await isar.writeTxn(() async {
        await isar.equippedItems.put(equippedItems!);
        user.equippedItems.value = equippedItems;
        await user.equippedItems.save();
      });
    }

    bool needsUpdate = false;

    if (hatId != equippedItems.hatSupabaseId) {
      equippedItems.hat.value = await getShopItemBySupabaseId(hatId);
      equippedItems.hatSupabaseId = hatId;
      needsUpdate = true;
    }

    if (glassesId != equippedItems.glassesSupabaseId) {
      equippedItems.glasses.value = await getShopItemBySupabaseId(glassesId);
      equippedItems.glassesSupabaseId = glassesId;
      needsUpdate = true;
    }

    if (shirtId != equippedItems.shirtSupabaseId) {
      equippedItems.shirt.value = await getShopItemBySupabaseId(shirtId);
      equippedItems.shirtSupabaseId = shirtId;
      needsUpdate = true;
    }

    if (needsUpdate) {
      await isar.writeTxn(() async {
        await isar.equippedItems.put(equippedItems!);
        await equippedItems.hat.save();
        await equippedItems.glasses.save();
        await equippedItems.shirt.save();
      });
    }

    return equippedItems;
  }

  Future<void> addQuestHistory(
    UserProfile user,
    QuestTopic topic,
    bool isCorrect,
  ) async {
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

  Future<void> addFinancialChoice(
    UserProfile user,
    FinancialChoiceType choice,
    int coinChange,
  ) async {
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

  Future<AppSettings> getAppSettings() async {
    final isar = await db;
    final settings = await isar.appSettings.where().findFirst();
    return settings ?? AppSettings();
  }

  Future<void> saveAppSettings(AppSettings settings) async {
    final isar = await db;
    await isar.writeTxn(() => isar.appSettings.put(settings));
  }
}
