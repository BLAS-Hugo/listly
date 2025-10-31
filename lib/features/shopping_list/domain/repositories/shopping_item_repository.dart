import 'package:listly/shared/models/shopping_item.dart';

/// Repository interface for managing shopping items.
///
/// This abstraction defines the contract for shopping item data operations,
/// allowing different implementations (local, remote, or hybrid) without
/// affecting consumers.
///
/// Follows the Repository pattern from Clean Architecture, where the domain
/// layer defines interfaces and the data layer provides implementations.
abstract class ShoppingItemRepository {
  /// Retrieves a single shopping item by its unique identifier.
  ///
  /// Returns the [ShoppingItem] if found, null otherwise.
  /// Throws an exception if the operation fails.
  Future<ShoppingItem?> getById(String id);

  /// Retrieves all shopping items stored in the repository.
  ///
  /// Returns an empty list if no items exist.
  /// Throws an exception if the operation fails.
  ///
  /// Note: For large datasets, consider using [getItemsByListId] instead
  /// to fetch items for a specific list.
  Future<List<ShoppingItem>> getAll();

  /// Retrieves all shopping items that belong to a specific list.
  ///
  /// This is the primary method for fetching items to display in a list view.
  /// Items are typically sorted by [sortOrder] or [createdAt].
  ///
  /// Returns an empty list if the list has no items.
  /// Throws an exception if the operation fails.
  Future<List<ShoppingItem>> getItemsByListId(String listId);

  /// Creates a new shopping item.
  ///
  /// The item must have a unique [id] (typically a UUID).
  /// Throws an exception if an item with the same [id] already exists
  /// or if the operation fails.
  Future<void> create(ShoppingItem item);

  /// Updates an existing shopping item.
  ///
  /// The [updatedAt] timestamp should be set to the current time.
  /// Throws an exception if the item doesn't exist or if the operation fails.
  Future<void> update(ShoppingItem item);

  /// Deletes a shopping item by its unique identifier.
  ///
  /// This operation is idempotent - deleting a non-existent item should not throw.
  /// Throws an exception only if the operation fails due to other reasons.
  Future<void> delete(String id);

  /// Toggles the completion status of a shopping item.
  ///
  /// This is a convenience method that:
  /// 1. Fetches the current item
  /// 2. Toggles [isCompleted]
  /// 3. Sets [completedAt] to now if completing, or null if un-completing
  /// 4. Updates the item
  ///
  /// Throws an exception if the item doesn't exist or if the operation fails.
  Future<void> toggleCompleted(String id);

  /// Watches all shopping items for a specific list, emitting updates in real-time.
  ///
  /// This stream emits:
  /// - The initial list of items immediately upon subscription
  /// - Updated lists whenever items are added, modified, or removed
  ///
  /// The stream never completes unless explicitly closed.
  /// Throws an exception in the stream if a critical error occurs.
  Stream<List<ShoppingItem>> watchItemsByListId(String listId);

  /// Watches a single shopping item by ID, emitting updates in real-time.
  ///
  /// This stream emits:
  /// - The current item immediately upon subscription (or null if not found)
  /// - Updated item whenever it's modified
  /// - Null if the item is deleted
  ///
  /// The stream never completes unless explicitly closed.
  /// Throws an exception in the stream if a critical error occurs.
  Stream<ShoppingItem?> watchById(String id);
}
