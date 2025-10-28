import 'package:listly/shared/models/shopping_list.dart';
import 'package:listly/shared/repositories/base_repository.dart';

/// Abstract repository for managing [ShoppingList] entities.
///
/// This interface defines the contract for data operations related to shopping lists,
/// supporting CRUD, collaboration features, and real-time data streams.
abstract class ShoppingListRepository implements BaseRepository<ShoppingList, String> {
  /// Retrieves a single [ShoppingList] by its unique [id].
  ///
  /// Returns the [ShoppingList] if found, otherwise `null`.
  /// Throws [RepositoryException] on data access errors.
  @override
  Future<ShoppingList?> getById(String id);

  /// Retrieves all [ShoppingList] entities.
  ///
  /// Returns a list of all [ShoppingList]s.
  /// Throws [RepositoryException] on data access errors.
  @override
  Future<List<ShoppingList>> getAll();

  /// Creates a new [ShoppingList].
  ///
  /// The [shoppingList] must have a unique ID.
  /// Throws [RepositoryException] if creation fails (e.g., ID conflict).
  @override
  Future<void> create(ShoppingList shoppingList);

  /// Updates an existing [ShoppingList].
  ///
  /// The [shoppingList] must have an ID corresponding to an existing list.
  /// Throws [RepositoryException] if update fails (e.g., list not found).
  @override
  Future<void> update(ShoppingList shoppingList);

  /// Deletes a [ShoppingList] by its unique [id].
  ///
  /// Throws [RepositoryException] if deletion fails (e.g., list not found).
  @override
  Future<void> delete(String id);

  /// Retrieves all [ShoppingList] entities associated with a specific [userId].
  ///
  /// Returns lists where the user is either the creator or a participant.
  /// Results are sorted by last activity (most recent first).
  /// Throws [RepositoryException] on data access errors.
  Future<List<ShoppingList>> getUserLists(String userId);

  /// Adds a participant to a shopping list.
  ///
  /// The [userId] will be added to the list's participants if not already present.
  /// Updates the list's `lastActivityAt` timestamp.
  /// Throws [RepositoryException] if the list is not found or operation fails.
  Future<void> addParticipant(String listId, String userId);

  /// Removes a participant from a shopping list.
  ///
  /// The [userId] will be removed from the list's participants.
  /// Updates the list's `lastActivityAt` timestamp.
  /// Throws [RepositoryException] if the list is not found or operation fails.
  Future<void> removeParticipant(String listId, String userId);

  /// Archives a shopping list by its [listId].
  ///
  /// Sets the list's `isArchived` flag to `true`.
  /// Updates the list's `lastActivityAt` timestamp.
  /// Throws [RepositoryException] if the list is not found or operation fails.
  Future<void> archiveList(String listId);

  /// Provides a real-time stream of all [ShoppingList] entities.
  ///
  /// Emits a new list whenever any shopping list changes.
  /// Results are sorted by last activity (most recent first).
  /// Throws [RepositoryException] on data access errors.
  @override
  Stream<List<ShoppingList>> watch();

  /// Provides a real-time stream of a single [ShoppingList] by its [id].
  ///
  /// Emits a new list whenever it changes, or `null` if deleted.
  /// Throws [RepositoryException] on data access errors.
  @override
  Stream<ShoppingList?> watchById(String id);

  /// Provides a real-time stream of all [ShoppingList] entities for a specific [userId].
  ///
  /// Emits lists where the user is either the creator or a participant.
  /// Results are sorted by last activity (most recent first).
  /// Throws [RepositoryException] on data access errors.
  Stream<List<ShoppingList>> watchUserLists(String userId);
}
