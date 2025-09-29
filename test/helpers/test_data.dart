// ignore_for_file: avoid_classes_with_only_static_members

import 'package:listly/shared/models/list_permissions.dart';
import 'package:listly/shared/models/shopping_item.dart';
import 'package:listly/shared/models/shopping_list.dart';
import 'package:listly/shared/models/user.dart';
import 'package:listly/shared/models/user_list_settings.dart';
import 'package:listly/shared/models/user_preferences.dart';

class TestData {
  // User Test Data
  static UserPreferences get sampleUserPreferences =>
      const UserPreferences(theme: 'dark');

  static User get sampleUser => User(
    id: 'user_123',
    name: 'Test User',
    firstName: 'Test',
    displayName: 'test_user',
    email: 'test@example.com',
    profileImageUrl: 'https://example.com/avatar.jpg',
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024, 1, 15),
    lastActiveAt: DateTime(2024, 1, 15, 10, 30),
    preferences: sampleUserPreferences,
  );

  static User get anotherUser => User(
    id: 'user_456',
    name: 'Another User',
    firstName: 'Another',
    displayName: 'another_user',
    email: 'another@example.com',
    createdAt: DateTime(2024, 1, 2),
    updatedAt: DateTime(2024, 1, 16),
  );

  // ListPermissions Test Data
  static ListPermissions get defaultPermissions => const ListPermissions(
    anyoneCanEdit: true,
    anyoneCanInvite: false,
    anyoneCanDelete: false,
  );

  static ListPermissions get restrictivePermissions => const ListPermissions(
    anyoneCanEdit: false,
    anyoneCanInvite: false,
    anyoneCanDelete: false,
  );

  static ListPermissions get openPermissions => const ListPermissions(
    anyoneCanEdit: true,
    anyoneCanInvite: true,
    anyoneCanDelete: true,
  );

  // ShoppingList Test Data
  static ShoppingList get sampleShoppingList => ShoppingList(
    id: 'list_123',
    creatorUserId: 'user_123',
    participantIds: const ['user_456', 'user_789'],
    name: 'Weekly Groceries',
    description: 'Weekly grocery shopping list',
    color: '#4CAF50',
    itemIds: const ['item_1', 'item_2', 'item_3'],
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024, 1, 10),
    lastActivityAt: DateTime(2024, 1, 10, 15, 30),
    permissions: defaultPermissions,
  );

  static ShoppingList get archivedShoppingList => ShoppingList(
    id: 'list_456',
    creatorUserId: 'user_123',
    name: 'Old List',
    description: 'An archived shopping list',
    color: '#9E9E9E',
    createdAt: DateTime(2023, 12),
    updatedAt: DateTime(2023, 12, 15),
    lastActivityAt: DateTime(2023, 12, 15),
    isArchived: true,
    permissions: restrictivePermissions,
  );

  static ShoppingList get emptyShoppingList => ShoppingList(
    id: 'list_empty',
    creatorUserId: 'user_123',
    name: 'Empty List',
    createdAt: DateTime(2024, 1, 5),
    updatedAt: DateTime(2024, 1, 5),
    lastActivityAt: DateTime(2024, 1, 5),
    permissions: defaultPermissions,
  );

  // ShoppingItem Test Data
  static ShoppingItem get sampleShoppingItem => ShoppingItem(
    id: 'item_1',
    listId: 'list_123',
    addedByUserId: 'user_123',
    name: 'Apples',
    description: 'Red apples, organic',
    quantity: 6,
    unit: 'pieces',
    category: 'fruits',
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
    sortOrder: 1,
  );

  static ShoppingItem get completedShoppingItem => ShoppingItem(
    id: 'item_2',
    listId: 'list_123',
    addedByUserId: 'user_123',
    name: 'Milk',
    description: 'Whole milk, 1 liter',
    quantity: 2,
    unit: 'liters',
    category: 'dairy',
    isCompleted: true,
    completedAt: DateTime(2024, 1, 8),
    completedByUserId: 'user_456',
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024, 1, 8),
    sortOrder: 2,
  );

  static ShoppingItem get minimalShoppingItem => ShoppingItem(
    id: 'item_minimal',
    listId: 'list_123',
    addedByUserId: 'user_123',
    name: 'Bread',
    createdAt: DateTime(2024, 1, 2),
    updatedAt: DateTime(2024, 1, 2),
    sortOrder: 3,
  );

  // UserListSettings Test Data
  static UserListSettings get sampleUserListSettings => UserListSettings(
    userId: 'user_123',
    listId: 'list_123',
    isPinned: true,
    lastViewedAt: DateTime(2024, 1, 15, 9, 30),
    sortOrder: 1,
    customName: 'My Groceries',
  );

  static UserListSettings get defaultUserListSettings => UserListSettings(
    userId: 'user_456',
    listId: 'list_123',
    lastViewedAt: DateTime(2024, 1, 10),
  );

  // JSON Test Data
  static Map<String, dynamic> get sampleShoppingListJson => {
    'id': 'list_123',
    'creator_user_id': 'user_123',
    'participant_ids': ['user_456', 'user_789'],
    'name': 'Weekly Groceries',
    'description': 'Weekly grocery shopping list',
    'color': '#4CAF50',
    'item_ids': ['item_1', 'item_2', 'item_3'],
    'created_at': '2024-01-01T00:00:00.000',
    'updated_at': '2024-01-10T00:00:00.000',
    'last_activity_at': '2024-01-10T15:30:00.000',
    'is_archived': false,
    'permissions': {
      'anyoneCanEdit': true,
      'anyoneCanInvite': false,
      'anyoneCanDelete': false,
    },
  };

  static Map<String, dynamic> get sampleUserJson => {
    'id': 'user_123',
    'name': 'Test User',
    'first_name': 'Test',
    'display_name': 'test_user',
    'email': 'test@example.com',
    'profile_image_url': 'https://example.com/avatar.jpg',
    'created_at': '2024-01-01T00:00:00.000',
    'updated_at': '2024-01-15T00:00:00.000',
    'last_active_at': '2024-01-15T10:30:00.000',
    'preferences': {
      'notifications_enabled': true,
      'email_notifications_enabled': false,
      'theme': 'dark',
      'language': 'en',
    },
  };

  static Map<String, dynamic> get sampleShoppingItemJson => {
    'id': 'item_1',
    'list_id': 'list_123',
    'added_by_user_id': 'user_123',
    'name': 'Apples',
    'description': 'Red apples, organic',
    'quantity': 6,
    'unit': 'pieces',
    'category': 'fruits',
    'is_completed': false,
    'completed_at': null,
    'completed_by_user_id': null,
    'created_at': '2024-01-01T00:00:00.000',
    'updated_at': '2024-01-01T00:00:00.000',
    'sort_order': 1,
  };

  // Lists for testing collections
  static List<ShoppingList> get sampleShoppingLists => [
    sampleShoppingList,
    archivedShoppingList,
    emptyShoppingList,
  ];

  static List<ShoppingItem> get sampleShoppingItems => [
    sampleShoppingItem,
    completedShoppingItem,
    minimalShoppingItem,
  ];

  static List<User> get sampleUsers => [sampleUser, anotherUser];

  // Utility methods for creating test data with overrides
  static ShoppingList createShoppingList({
    String? id,
    String? creatorUserId,
    List<String>? participantIds,
    String? name,
    String? description,
    String? color,
    List<String>? itemIds,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActivityAt,
    bool? isArchived,
    ListPermissions? permissions,
  }) {
    return ShoppingList(
      id: id ?? 'test_list_${DateTime.now().millisecondsSinceEpoch}',
      creatorUserId: creatorUserId ?? 'test_user',
      participantIds: participantIds ?? const [],
      name: name ?? 'Test List',
      description: description,
      color: color ?? '#2196F3',
      itemIds: itemIds ?? const [],
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      lastActivityAt: lastActivityAt ?? DateTime.now(),
      isArchived: isArchived ?? false,
      permissions: permissions ?? defaultPermissions,
    );
  }

  static ShoppingItem createShoppingItem({
    String? id,
    String? listId,
    String? addedByUserId,
    String? name,
    String? description,
    int? quantity,
    String? unit,
    String? category,
    bool? isCompleted,
    DateTime? completedAt,
    String? completedByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? sortOrder,
  }) {
    return ShoppingItem(
      id: id ?? 'test_item_${DateTime.now().millisecondsSinceEpoch}',
      listId: listId ?? 'test_list',
      addedByUserId: addedByUserId ?? 'test_user',
      name: name ?? 'Test Item',
      description: description,
      quantity: quantity ?? 1,
      unit: unit,
      category: category,
      isCompleted: isCompleted ?? false,
      completedAt: completedAt,
      completedByUserId: completedByUserId,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      sortOrder: sortOrder ?? 0,
    );
  }

  static User createUser({
    String? id,
    String? name,
    String? firstName,
    String? displayName,
    String? email,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActiveAt,
    UserPreferences? preferences,
  }) {
    return User(
      id: id ?? 'test_user_${DateTime.now().millisecondsSinceEpoch}',
      name: name ?? 'Test User',
      firstName: firstName ?? 'Test',
      displayName: displayName ?? 'test_user',
      email: email ?? 'test@example.com',
      profileImageUrl: profileImageUrl,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      lastActiveAt: lastActiveAt,
      preferences: preferences ?? const UserPreferences(),
    );
  }
}
