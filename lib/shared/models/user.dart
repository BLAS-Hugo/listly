import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listly/shared/models/user_preferences.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String name,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'display_name') required String displayName,
    required String email,
    @JsonKey(name: 'profile_image_url') String? profileImageUrl,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'last_active_at') DateTime? lastActiveAt,
    @Default(UserPreferences()) UserPreferences preferences,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // Factory constructor for creating new users
  factory User.create({
    required String id,
    required String email,
    required String name,
    required String firstName,
    required String displayName,
    String? profileImageUrl,
    UserPreferences? preferences,
  }) {
    final now = DateTime.now();
    return User(
      id: id,
      email: email,
      name: name,
      firstName: firstName,
      displayName: displayName,
      profileImageUrl: profileImageUrl,
      createdAt: now,
      updatedAt: now,
      lastActiveAt: now,
      preferences: preferences ?? const UserPreferences(),
    );
  }

  // Factory for Firebase Auth integration
  factory User.fromFirebaseAuth(firebase_auth.User firebaseUser) {
    final nameParts = firebaseUser.displayName?.split(' ') ?? ['', ''];
    return User.create(
      id: firebaseUser.uid,
      email: firebaseUser.email!,
      firstName: nameParts.isNotEmpty ? nameParts.first : '',
      name: nameParts.length > 1 ? nameParts.last : '',
      displayName:
          firebaseUser.displayName ?? firebaseUser.email!.split('@').first,
      profileImageUrl: firebaseUser.photoURL,
    );
  }
}
