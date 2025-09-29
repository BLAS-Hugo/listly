import 'package:listly/shared/models/shopping_list.dart';

abstract class ShoppingListRepository {
  Future<ShoppingList?> getById(String id);
  Future<List<ShoppingList>> getAll();
  Future<void> create(ShoppingList shoppingList);
  Future<void> update(ShoppingList shoppingList);
  Future<void> delete(String id);

  Future<List<ShoppingList>> getUserLists(String userId);
  Future<void> addParticipant(String listId, String userId);
  Future<void> removeParticipant(String listId, String userId);
  Future<void> archiveList(String listId);

  Stream<List<ShoppingList>> watch();
  Stream<ShoppingList?> watchById(String id);
  Stream<List<ShoppingList>> watchUserLists(String userId);
}
