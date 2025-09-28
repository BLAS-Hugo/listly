import 'package:deep_pick/deep_pick.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:listly/shared/models/user.dart';
import 'package:listly/shared/models/user_preferences.dart';

import '../../helpers/test_data.dart';

// Mock Firebase User for testing
class MockFirebaseUser implements firebase_auth.User {
  @override
  final String uid;
  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final String? photoURL;

  MockFirebaseUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
  });

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('User', () {
    group('constructor', () {
      test('creates instance with required parameters', () {
        final user = TestData.sampleUser;

        expect(user.id, equals('user_123'));
        expect(user.name, equals('Test User'));
        expect(user.firstName, equals('Test'));
        expect(user.displayName, equals('test_user'));
        expect(user.email, equals('test@example.com'));
        expect(user.profileImageUrl, equals('https://example.com/avatar.jpg'));
        expect(user.preferences, equals(TestData.sampleUserPreferences));
      });

      test('creates instance with default preferences', () {
        final user = TestData.anotherUser;

        expect(user.preferences, equals(const UserPreferences()));
      });
    });

    group('create factory', () {
      test('creates new user with generated timestamps', () {
        final before = DateTime.now();
        final user = User.create(
          id: 'user_123',
          email: 'test@example.com',
          name: 'Test',
          firstName: 'Test',
          displayName: 'test_user',
        );
        final after = DateTime.now();

        expect(user.id, equals('user_123'));
        expect(user.email, equals('test@example.com'));
        expect(
          user.createdAt.isAfter(before.subtract(const Duration(seconds: 1))),
          isTrue,
        );
        expect(
          user.createdAt.isBefore(after.add(const Duration(seconds: 1))),
          isTrue,
        );
        expect(user.updatedAt, equals(user.createdAt));
        expect(user.lastActiveAt, equals(user.createdAt));
      });

      test('creates user with custom preferences', () {
        const customPreferences = UserPreferences(
          notificationsEnabled: false,
          theme: 'dark',
        );

        final user = User.create(
          id: 'user_123',
          email: 'test@example.com',
          name: 'Test',
          firstName: 'Test',
          displayName: 'test_user',
          preferences: customPreferences,
        );

        expect(user.preferences, equals(customPreferences));
      });

      test('creates user with default preferences when none provided', () {
        final user = User.create(
          id: 'user_123',
          email: 'test@example.com',
          name: 'Test',
          firstName: 'Test',
          displayName: 'test_user',
        );

        expect(user.preferences, equals(const UserPreferences()));
      });
    });

    group('fromFirebaseAuth factory', () {
      test('creates user from Firebase Auth user with full name', () {
        final firebaseUser = MockFirebaseUser(
          uid: 'firebase_123',
          email: 'firebase@example.com',
          displayName: 'John Doe',
          photoURL: 'https://example.com/photo.jpg',
        );

        final user = User.fromFirebaseAuth(firebaseUser);

        expect(user.id, equals('firebase_123'));
        expect(user.email, equals('firebase@example.com'));
        expect(user.firstName, equals('John'));
        expect(user.name, equals('Doe'));
        expect(user.displayName, equals('John Doe'));
        expect(user.profileImageUrl, equals('https://example.com/photo.jpg'));
      });

      test('creates user from Firebase Auth user with single name', () {
        final firebaseUser = MockFirebaseUser(
          uid: 'firebase_123',
          email: 'single@example.com',
          displayName: 'SingleName',
        );

        final user = User.fromFirebaseAuth(firebaseUser);

        expect(user.firstName, equals('SingleName'));
        expect(user.name, equals(''));
        expect(user.displayName, equals('SingleName'));
      });

      test('creates user from Firebase Auth user without display name', () {
        final firebaseUser = MockFirebaseUser(
          uid: 'firebase_123',
          email: 'nodisplay@example.com',
        );

        final user = User.fromFirebaseAuth(firebaseUser);

        expect(user.firstName, equals(''));
        expect(user.name, equals(''));
        expect(user.displayName, equals('nodisplay'));
      });

      test('handles empty display name', () {
        final firebaseUser = MockFirebaseUser(
          uid: 'firebase_123',
          email: 'empty@example.com',
          displayName: '',
        );

        final user = User.fromFirebaseAuth(firebaseUser);

        expect(user.displayName, equals('empty'));
      });
    });

    group('JSON serialization', () {
      test('converts to JSON correctly', () {
        final user = TestData.sampleUser;
        final json = user.toJson();

        expect(pick(json, 'id').asStringOrThrow(), equals('user_123'));
        expect(pick(json, 'name').asStringOrThrow(), equals('Test User'));
        expect(pick(json, 'first_name').asStringOrThrow(), equals('Test'));
        expect(pick(json, 'display_name').asStringOrThrow(), equals('test_user'));
        expect(pick(json, 'email').asStringOrThrow(), equals('test@example.com'));
        expect(
          pick(json, 'profile_image_url').asStringOrThrow(),
          equals('https://example.com/avatar.jpg'),
        );
        expect(pick(json, 'preferences').asMapOrNull(), isNotNull);
        expect(pick(json, 'preferences', 'theme').asStringOrThrow(), equals('dark'));
      });

      test('creates from JSON correctly', () {
        final json = TestData.sampleUserJson;
        final user = User.fromJson(json);

        expect(user.id, equals('user_123'));
        expect(user.name, equals('Test User'));
        expect(user.firstName, equals('Test'));
        expect(user.displayName, equals('test_user'));
        expect(user.email, equals('test@example.com'));
        expect(user.profileImageUrl, equals('https://example.com/avatar.jpg'));
        expect(user.preferences.theme, equals('dark'));
      });

      test('round trip JSON serialization', () {
        final original = TestData.sampleUser;
        final json = original.toJson();
        final restored = User.fromJson(json);

        expect(restored.id, equals(original.id));
        expect(restored.name, equals(original.name));
        expect(restored.firstName, equals(original.firstName));
        expect(restored.displayName, equals(original.displayName));
        expect(restored.email, equals(original.email));
        expect(restored.profileImageUrl, equals(original.profileImageUrl));
        expect(restored.preferences, equals(original.preferences));
      });

      test('handles null optional fields in JSON', () {
        final json = {
          'id': 'user_null_test',
          'name': 'Null Test User',
          'first_name': 'Null',
          'display_name': 'null_test',
          'email': 'null@example.com',
          'profile_image_url': null,
          'created_at': '2024-01-01T00:00:00.000',
          'updated_at': '2024-01-01T00:00:00.000',
          'last_active_at': null,
          'preferences': {
            'notifications_enabled': true,
            'email_notifications_enabled': false,
            'theme': 'system',
            'language': 'en',
          },
        };

        final user = User.fromJson(json);

        expect(user.profileImageUrl, isNull);
        expect(user.lastActiveAt, isNull);
        expect(user.preferences.theme, equals('system'));
      });
    });

    group('copyWith', () {
      test('creates copy with updated name', () {
        final original = TestData.sampleUser;
        final updated = original.copyWith(name: 'Updated User');

        expect(updated.name, equals('Updated User'));
        expect(updated.id, equals(original.id));
        expect(updated.email, equals(original.email));
      });

      test('creates copy with updated preferences', () {
        final original = TestData.sampleUser;
        const newPreferences = UserPreferences(
          notificationsEnabled: false,
          theme: 'light',
        );
        final updated = original.copyWith(preferences: newPreferences);

        expect(updated.preferences, equals(newPreferences));
        expect(updated.preferences, isNot(equals(original.preferences)));
      });

      test('creates copy with updated timestamps', () {
        final original = TestData.sampleUser;
        final newLastActive = DateTime.now();
        final updated = original.copyWith(lastActiveAt: newLastActive);

        expect(updated.lastActiveAt, equals(newLastActive));
        expect(updated.createdAt, equals(original.createdAt));
      });

      test('creates identical copy when no parameters provided', () {
        final original = TestData.sampleUser;
        final updated = original.copyWith();

        expect(updated, equals(original));
      });
    });

    group('equality', () {
      test('equal when all properties match', () {
        final user1 = TestData.sampleUser;
        final user2 = TestData.sampleUser;

        expect(user1, equals(user2));
        expect(user1.hashCode, equals(user2.hashCode));
      });

      test('not equal when IDs differ', () {
        final user1 = TestData.sampleUser;
        final user2 = user1.copyWith(id: 'different_id');

        expect(user1, isNot(equals(user2)));
      });

      test('not equal when emails differ', () {
        final user1 = TestData.sampleUser;
        final user2 = user1.copyWith(email: 'different@example.com');

        expect(user1, isNot(equals(user2)));
      });
    });

    group('toString', () {
      test('returns string representation', () {
        final user = TestData.sampleUser;
        final stringRepresentation = user.toString();

        expect(stringRepresentation, contains('User'));
        expect(stringRepresentation, contains(user.id));
        expect(stringRepresentation, contains(user.email));
      });
    });

    group('edge cases', () {
      test('handles very long names', () {
        final longName = 'A' * 1000;
        final user = TestData.createUser(
          name: longName,
          firstName: longName,
          displayName: longName,
        );

        expect(user.name.length, equals(1000));
        expect(user.firstName.length, equals(1000));
        expect(user.displayName.length, equals(1000));
      });

      test('handles special characters in names', () {
        final user = TestData.createUser(
          name: 'Åke Öberg',
          firstName: 'José María',
          displayName: 'user_with-special.chars@domain',
        );

        expect(user.name, equals('Åke Öberg'));
        expect(user.firstName, equals('José María'));
        expect(user.displayName, equals('user_with-special.chars@domain'));
      });

      test('handles international email addresses', () {
        final user = TestData.createUser(email: 'тест@пример.рф');

        expect(user.email, equals('тест@пример.рф'));
      });

      test('handles firebase user with complex display name', () {
        final firebaseUser = MockFirebaseUser(
          uid: 'firebase_123',
          email: 'complex@example.com',
          displayName: 'Dr. José María de la Cruz Jr.',
        );

        final user = User.fromFirebaseAuth(firebaseUser);

        expect(user.firstName, equals('Dr.'));
        expect(user.name, equals('Jr.'));
        expect(user.displayName, equals('Dr. José María de la Cruz Jr.'));
      });
    });
  });
}
