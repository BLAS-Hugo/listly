import 'package:freezed_annotation/freezed_annotation.dart';

part 'recent_item.freezed.dart';
part 'recent_item.g.dart';

@freezed
abstract class RecentItem with _$RecentItem {
  const factory RecentItem({
    required String userId,
    required String name,
    String? category,
    String? unit,
    @Default(1) int usageCount,
    required DateTime lastUsedAt,
    required DateTime createdAt,
  }) = _RecentItem;

  const RecentItem._();

  factory RecentItem.fromJson(Map<String, dynamic> json) =>
      _$RecentItemFromJson(json);

  factory RecentItem.create({
    required String userId,
    required String name,
    String? category,
    String? unit,
  }) {
    final now = DateTime.now();
    return RecentItem(
      userId: userId,
      name: name,
      category: category,
      unit: unit,
      lastUsedAt: now,
      createdAt: now,
    );
  }

  // Composite key helper
  String compositeKey() => '${userId}_${name.toLowerCase()}';
}
