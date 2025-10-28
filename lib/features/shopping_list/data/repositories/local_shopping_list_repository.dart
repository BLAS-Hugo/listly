import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listly/core/database/sembast/sembast_service.dart';
import 'package:listly/features/shopping_list/domain/repositories/shopping_list_repository.dart';
import 'package:listly/shared/models/shopping_list.dart';
import 'package:sembast/sembast.dart';

/// Riverpod provider for [LocalShoppingListRepository].
///
/// Provides a singleton instance of the repository with Sembast service injected.
final localShoppingListRepositoryProvider = Provider(
  (ref) => LocalShoppingListRepository(
    sembastService: ref.watch(sembastServiceProvider),
  ),
);

/// Local implementation of [ShoppingListRepository] using Sembast.
///
/// Stores shopping lists in the 'lists' Sembast store.
/// All operations are synchronous with local database - no network calls.
/// Supports CRUD operations, collaboration features, and real-time data streams.
class LocalShoppingListRepository implements ShoppingListRepository {
  final SembastService _sembastService;
  static const String _storeName = 'lists';

  const LocalShoppingListRepository({required SembastService sembastService})
    : _sembastService = sembastService;

  @override
  Future<ShoppingList?> getById(String id) async {
    try {
      final data = await _sembastService.read(_storeName, id);
      return data != null ? ShoppingList.fromJson(data) : null;
    } catch (e) {
      throw Exception('Failed to get shopping list by id: $e');
    }
  }

  @override
  Future<List<ShoppingList>> getAll() async {
    try {
      final dataList = await _sembastService.readAll(_storeName);
      return dataList.map((data) => ShoppingList.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Failed to get all shopping lists: $e');
    }
  }

  @override
  Future<void> create(ShoppingList shoppingList) async {
    try {
      await _sembastService.create(
        _storeName,
        shoppingList.id,
        shoppingList.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to create shopping list: $e');
    }
  }

  @override
  Future<void> update(ShoppingList shoppingList) async {
    try {
      final updatedList = shoppingList.copyWith(updatedAt: DateTime.now());
      await _sembastService.update(
        _storeName,
        shoppingList.id,
        updatedList.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to update shopping list: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _sembastService.delete(_storeName, id);
    } catch (e) {
      throw Exception('Failed to delete shopping list: $e');
    }
  }

  @override
  Future<List<ShoppingList>> getUserLists(String userId) async {
    try {
      final finder = Finder(
        filter: Filter.or([
          Filter.equals('creatorUserId', userId),
          Filter.inList('participantIds', [userId]),
        ]),
        sortOrders: [SortOrder('lastActivityAt', false)],
      );

      final dataList = await _sembastService.query(_storeName, finder: finder);
      return dataList.map((data) => ShoppingList.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Failed to get user shopping lists: $e');
    }
  }

  @override
  Future<void> addParticipant(String listId, String userId) async {
    try {
      final currentList = await getById(listId);
      if (currentList == null) {
        throw Exception('Shopping list not found');
      }

      if (currentList.participantIds.contains(userId)) {
        return; // User is already a participant
      }

      final updatedList = currentList.copyWith(
        participantIds: [...currentList.participantIds, userId],
        updatedAt: DateTime.now(),
        lastActivityAt: DateTime.now(),
      );

      await update(updatedList);
    } catch (e) {
      throw Exception('Failed to add participant: $e');
    }
  }

  @override
  Future<void> removeParticipant(String listId, String userId) async {
    try {
      final currentList = await getById(listId);
      if (currentList == null) {
        throw Exception('Shopping list not found');
      }

      final updatedParticipants = currentList.participantIds
          .where((id) => id != userId)
          .toList();

      final updatedList = currentList.copyWith(
        participantIds: updatedParticipants,
        updatedAt: DateTime.now(),
        lastActivityAt: DateTime.now(),
      );

      await update(updatedList);
    } catch (e) {
      throw Exception('Failed to remove participant: $e');
    }
  }

  @override
  Future<void> archiveList(String listId) async {
    try {
      final currentList = await getById(listId);
      if (currentList == null) {
        throw Exception('Shopping list not found');
      }

      final updatedList = currentList.copyWith(
        isArchived: true,
        updatedAt: DateTime.now(),
        lastActivityAt: DateTime.now(),
      );

      await update(updatedList);
    } catch (e) {
      throw Exception('Failed to archive shopping list: $e');
    }
  }

  @override
  Stream<List<ShoppingList>> watch() {
    try {
      final finder = Finder(sortOrders: [SortOrder('lastActivityAt', false)]);

      return _sembastService
          .watchQuery(_storeName, finder: finder)
          .map(
            (dataList) =>
                dataList.map((data) => ShoppingList.fromJson(data)).toList(),
          );
    } catch (e) {
      throw Exception('Failed to watch shopping lists: $e');
    }
  }

  @override
  Stream<ShoppingList?> watchById(String id) {
    try {
      return _sembastService
          .watchOne(_storeName, id)
          .map((data) => data != null ? ShoppingList.fromJson(data) : null);
    } catch (e) {
      throw Exception('Failed to watch shopping list by id: $e');
    }
  }

  @override
  Stream<List<ShoppingList>> watchUserLists(String userId) {
    try {
      final finder = Finder(
        filter: Filter.or([
          Filter.equals('creatorUserId', userId),
          Filter.inList('participantIds', [userId]),
        ]),
        sortOrders: [SortOrder('lastActivityAt', false)],
      );

      return _sembastService
          .watchQuery(_storeName, finder: finder)
          .map(
            (dataList) =>
                dataList.map((data) => ShoppingList.fromJson(data)).toList(),
          );
    } catch (e) {
      throw Exception('Failed to watch user shopping lists: $e');
    }
  }
}
