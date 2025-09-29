import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:listly/shared/models/user_preferences.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  @JsonSerializable(
    explicitToJson: true,
    fieldRename: FieldRename.snake,
  )
  const factory User({
    required String id,
    required String name,
    required String firstName,
    required String displayName,
    required String email,
    String? profileImageUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? lastActiveAt,
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
      displayName: (firebaseUser.displayName?.isNotEmpty == true)
          ? firebaseUser.displayName!
          : firebaseUser.email!.split('@').first,
      profileImageUrl: firebaseUser.photoURL,
    );
  }
}
