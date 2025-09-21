import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listly/shared/models/list_permissions.dart';
import 'package:uuid/uuid.dart';

part 'shopping_list.freezed.dart';
part 'shopping_list.g.dart';

@freezed
abstract class ShoppingList with _$ShoppingList {
  const factory ShoppingList({
    required String id,
    required String creatorUserId,
    @Default([]) List<String> participantIds,
    required String name,
    String? description,
    String? color,
    @Default([]) List<String> itemIds, // References to ShoppingItem IDs
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime lastActivityAt,
    @Default(false) bool isArchived,
    @Default(
      ListPermissions(
        anyoneCanEdit: true,
        anyoneCanInvite: false,
        anyoneCanDelete: false,
      ),
    )
    ListPermissions permissions,
  }) = _ShoppingList;

  factory ShoppingList.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListFromJson(json);

  factory ShoppingList.create({
    required String creatorUserId,
    required String name,
    String? description,
    String? color,
  }) {
    final now = DateTime.now();
    return ShoppingList(
      id: const Uuid().v4(),
      creatorUserId: creatorUserId,
      name: name,
      description: description,
      color: color ?? '#2196F3', // Default blue
      createdAt: now,
      updatedAt: now,
      lastActivityAt: now,
    );
  }
}
