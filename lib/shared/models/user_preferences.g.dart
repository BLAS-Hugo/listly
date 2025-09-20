// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) =>
    _UserPreferences(
      notificationsEnabled: json['notifications_enabled'] as bool? ?? true,
      emailNotificationsEnabled:
          json['email_notifications_enabled'] as bool? ?? false,
      theme: json['theme'] as String? ?? 'system',
      language: json['language'] as String? ?? 'en',
    );

Map<String, dynamic> _$UserPreferencesToJson(_UserPreferences instance) =>
    <String, dynamic>{
      'notifications_enabled': instance.notificationsEnabled,
      'email_notifications_enabled': instance.emailNotificationsEnabled,
      'theme': instance.theme,
      'language': instance.language,
    };
