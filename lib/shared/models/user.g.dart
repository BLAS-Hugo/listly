// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  name: json['name'] as String,
  firstName: json['first_name'] as String,
  displayName: json['display_name'] as String,
  email: json['email'] as String,
  profileImageUrl: json['profile_image_url'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  lastActiveAt: json['last_active_at'] == null
      ? null
      : DateTime.parse(json['last_active_at'] as String),
  preferences: json['preferences'] == null
      ? const UserPreferences()
      : UserPreferences.fromJson(json['preferences'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'first_name': instance.firstName,
  'display_name': instance.displayName,
  'email': instance.email,
  'profile_image_url': instance.profileImageUrl,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'last_active_at': instance.lastActiveAt?.toIso8601String(),
  'preferences': instance.preferences,
};
