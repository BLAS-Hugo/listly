import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_category.freezed.dart';
part 'list_category.g.dart';

@freezed
abstract class ListCategory with _$ListCategory {
  const factory ListCategory({
    required String id,
    required String name,
    required String icon, // Icon name or emoji
    required String color,
    @Default(0) int sortOrder,
    required DateTime createdAt,
  }) = _ListCategory;

  factory ListCategory.fromJson(Map<String, dynamic> json) =>
      _$ListCategoryFromJson(json);

  // Predefined categories
  static List<ListCategory> get defaultCategories => [
    ListCategory(
      id: 'fruits',
      name: 'Fruits',
      icon: '🍎',
      color: '#FF5722',
      createdAt: DateTime.now(),
    ),
    ListCategory(
      id: 'vegetables',
      name: 'Vegetables',
      icon: '🥕',
      color: '#4CAF50',
      createdAt: DateTime.now(),
    ),
    ListCategory(
      id: 'dairy',
      name: 'Dairy',
      icon: '🥛',
      color: '#2196F3',
      createdAt: DateTime.now(),
    ),
    ListCategory(
      id: 'meat',
      name: 'Meat',
      icon: '🥩',
      color: '#795548',
      createdAt: DateTime.now(),
    ),
    ListCategory(
      id: 'other',
      name: 'Other',
      icon: '📦',
      color: '#9E9E9E',
      createdAt: DateTime.now(),
    ),
  ];
}
