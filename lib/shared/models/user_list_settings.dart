import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_list_settings.freezed.dart';
part 'user_list_settings.g.dart';

@freezed
abstract class UserListSettings with _$UserListSettings {
  const factory UserListSettings({
    required String userId,
    required String listId,
    @Default(false) bool isPinned,
    DateTime? lastViewedAt,
    @Default(0) int sortOrder,
    @Default(true) bool notificationsEnabled,
    String? customName,
  }) = _UserListSettings;

  const UserListSettings._();

  factory UserListSettings.fromJson(Map<String, dynamic> json) =>
      _$UserListSettingsFromJson(json);

  factory UserListSettings.create({
    required String userId,
    required String listId,
    bool isPinned = false,
    String? customName,
  }) {
    return UserListSettings(
      userId: userId,
      listId: listId,
      isPinned: isPinned,
      customName: customName,
      lastViewedAt: DateTime.now(),
    );
  }

  // Composite key helper
  String compositeKey() => '${userId}_$listId';
}
