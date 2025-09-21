import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'shopping_item.freezed.dart';
part 'shopping_item.g.dart';

@freezed
abstract class ShoppingItem with _$ShoppingItem {
  const factory ShoppingItem({
    required String id,
    required String listId,
    required String addedByUserId,
    required String name,
    String? description,
    @Default(1) int quantity,
    String? unit, // "kg", "pieces", "liters"
    String? category, // "fruits", "vegetables", "dairy"
    @Default(false) bool isCompleted,
    DateTime? completedAt,
    String? completedByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int sortOrder, // For custom ordering
  }) = _ShoppingItem;

  factory ShoppingItem.fromJson(Map<String, dynamic> json) =>
      _$ShoppingItemFromJson(json);

  factory ShoppingItem.create({
    required String listId,
    required String addedByUserId,
    required String name,
    String? description,
    int quantity = 1,
    String? unit,
    String? category,
  }) {
    final now = DateTime.now();
    return ShoppingItem(
      id: const Uuid().v4(),
      listId: listId,
      addedByUserId: addedByUserId,
      name: name,
      description: description,
      quantity: quantity,
      unit: unit,
      category: category,
      createdAt: now,
      updatedAt: now,
      sortOrder: now.millisecondsSinceEpoch, // Simple ordering
    );
  }
}
