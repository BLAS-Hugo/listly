import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_preferences.freezed.dart';
part 'user_preferences.g.dart';

@freezed
abstract class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @JsonKey(name: 'notifications_enabled')
    @Default(true)
    bool notificationsEnabled,
    @JsonKey(name: 'email_notifications_enabled')
    @Default(false)
    bool emailNotificationsEnabled,
    @Default('system') String theme,
    @Default('en') String language,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}
