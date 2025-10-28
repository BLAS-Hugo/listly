import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listly/core/database/sembast/sembast_service.dart';
import 'package:listly/features/shopping_list/domain/repositories/shopping_item_repository.dart';
import 'package:listly/shared/models/shopping_item.dart';
import 'package:sembast/sembast.dart';

final localShoppingItemRepositoryProvider = Provider(
  (ref) => LocalShoppingItemRepository(
    sembastService: ref.watch(sembastServiceProvider),
  ),
);

/// Local implementation of [ShoppingItemRepository] using Sembast.
///
/// Stores shopping items in the 'shopping_items' Sembast store.
/// All operations are synchronous with local database - no network calls.
class LocalShoppingItemRepository implements ShoppingItemRepository {
  final SembastService _sembastService;
  static const String _storeName = 'shopping_items';

  const LocalShoppingItemRepository({required SembastService sembastService})
      : _sembastService = sembastService;

  @override
  Future<ShoppingItem?> getById(String id) async {
    try {
      final data = await _sembastService.read(_storeName, id);
      return data != null ? ShoppingItem.fromJson(data) : null;
    } catch (e) {
      throw Exception('Failed to get shopping item by id: $e');
    }
  }

  @override
  Future<List<ShoppingItem>> getAll() async {
    try {
      final dataList = await _sembastService.readAll(_storeName);
      return dataList.map((data) => ShoppingItem.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Failed to get all shopping items: $e');
    }
  }

  @override
  Future<List<ShoppingItem>> getItemsByListId(String listId) async {
    try {
      final finder = Finder(
        filter: Filter.equals('listId', listId),
        sortOrders: [SortOrder('sortOrder', true)],
      );

      final dataList = await _sembastService.query(_storeName, finder: finder);
      return dataList.map((data) => ShoppingItem.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Failed to get shopping items for list: $e');
    }
  }

  @override
  Future<void> create(ShoppingItem item) async {
    try {
      await _sembastService.create(
        _storeName,
        item.id,
        item.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to create shopping item: $e');
    }
  }

  @override
  Future<void> update(ShoppingItem item) async {
    try {
      final updatedItem = item.copyWith(updatedAt: DateTime.now());
      await _sembastService.update(
        _storeName,
        item.id,
        updatedItem.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to update shopping item: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _sembastService.delete(_storeName, id);
    } catch (e) {
      throw Exception('Failed to delete shopping item: $e');
    }
  }

  @override
  Future<void> toggleCompleted(String id) async {
    try {
      final currentItem = await getById(id);
      if (currentItem == null) {
        throw Exception('Shopping item not found');
      }

      final now = DateTime.now();
      final updatedItem = currentItem.copyWith(
        isCompleted: !currentItem.isCompleted,
        completedAt: !currentItem.isCompleted ? now : null,
        completedByUserId: !currentItem.isCompleted 
            ? currentItem.addedByUserId // Use the user who added it as fallback
            : null,
        updatedAt: now,
      );

      await _sembastService.update(
        _storeName,
        id,
        updatedItem.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to toggle shopping item completion: $e');
    }
  }

  @override
  Stream<List<ShoppingItem>> watch() {
    try {
      final finder = Finder(sortOrders: [SortOrder('sortOrder', true)]);
      return _sembastService
          .watchQuery(_storeName, finder: finder)
          .map(
            (dataList) =>
                dataList.map((data) => ShoppingItem.fromJson(data)).toList(),
          );
    } catch (e) {
      throw Exception('Failed to watch shopping items: $e');
    }
  }

  @override
  Stream<ShoppingItem?> watchById(String id) {
    try {
      return _sembastService
          .watchOne(_storeName, id)
          .map((data) => data != null ? ShoppingItem.fromJson(data) : null);
    } catch (e) {
      throw Exception('Failed to watch shopping item by id: $e');
    }
  }

  @override
  Stream<List<ShoppingItem>> watchItemsByListId(String listId) {
    try {
      final finder = Finder(
        filter: Filter.equals('listId', listId),
        sortOrders: [SortOrder('sortOrder', true)],
      );

      return _sembastService
          .watchQuery(_storeName, finder: finder)
          .map(
            (dataList) =>
                dataList.map((data) => ShoppingItem.fromJson(data)).toList(),
          );
    } catch (e) {
      throw Exception('Failed to watch shopping items for list: $e');
    }
  }
}

