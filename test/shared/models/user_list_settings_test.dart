import 'package:deep_pick/deep_pick.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listly/shared/models/user_list_settings.dart';

import '../../helpers/test_data.dart';

void main() {
  group('UserListSettings', () {
    group('constructor', () {
      test('creates instance with all parameters', () {
        final settings = TestData.sampleUserListSettings;

        expect(settings.userId, equals('user_123'));
        expect(settings.listId, equals('list_123'));
        expect(settings.isPinned, isTrue);
        expect(settings.lastViewedAt, isNotNull);
        expect(settings.sortOrder, equals(1));
        expect(settings.notificationsEnabled, isTrue);
        expect(settings.customName, equals('My Groceries'));
      });

      test('creates instance with default values', () {
        final settings = TestData.defaultUserListSettings;

        expect(settings.userId, equals('user_456'));
        expect(settings.listId, equals('list_123'));
        expect(settings.isPinned, isFalse);
        expect(settings.sortOrder, equals(0));
        expect(settings.notificationsEnabled, isTrue);
        expect(settings.customName, isNull);
      });
    });

    group('create factory', () {
      test('creates new settings with default values', () {
        final before = DateTime.now();
        final settings = UserListSettings.create(
          userId: 'user_123',
          listId: 'list_456',
        );
        final after = DateTime.now();

        expect(settings.userId, equals('user_123'));
        expect(settings.listId, equals('list_456'));
        expect(settings.isPinned, isFalse);
        expect(settings.customName, isNull);
        expect(settings.lastViewedAt, isNotNull);
        expect(
          settings.lastViewedAt!.isAfter(
            before.subtract(const Duration(seconds: 1)),
          ),
          isTrue,
        );
        expect(
          settings.lastViewedAt!.isBefore(
            after.add(const Duration(seconds: 1)),
          ),
          isTrue,
        );
      });

      test('creates new settings with custom values', () {
        final settings = UserListSettings.create(
          userId: 'user_123',
          listId: 'list_456',
          isPinned: true,
          customName: 'Custom List Name',
        );

        expect(settings.isPinned, isTrue);
        expect(settings.customName, equals('Custom List Name'));
      });
    });

    group('compositeKey', () {
      test('returns correct composite key', () {
        final settings = TestData.sampleUserListSettings;

        final key = settings.compositeKey();

        expect(key, equals('user_123_list_123'));
      });

      test('returns composite key for different user and list', () {
        const settings = UserListSettings(
          userId: 'different_user',
          listId: 'different_list',
        );

        final key = settings.compositeKey();

        expect(key, equals('different_user_different_list'));
      });

      test('handles special characters in IDs', () {
        const settings = UserListSettings(
          userId: 'user-with_special.chars',
          listId: 'list@with#special\$chars',
        );

        final key = settings.compositeKey();

        expect(key, equals('user-with_special.chars_list@with#special\$chars'));
      });
    });

    group('JSON serialization', () {
      test('converts to JSON correctly', () {
        final settings = TestData.sampleUserListSettings;
        final json = settings.toJson();

        expect(pick(json, 'userId').asStringOrThrow(), equals('user_123'));
        expect(pick(json, 'listId').asStringOrThrow(), equals('list_123'));
        expect(pick(json, 'isPinned').asBoolOrFalse(), isTrue);
        expect(pick(json, 'lastViewedAt').asStringOrNull(), isNotNull);
        expect(pick(json, 'sortOrder').asIntOrThrow(), equals(1));
        expect(pick(json, 'notificationsEnabled').asBoolOrTrue(), isTrue);
        expect(
          pick(json, 'customName').asStringOrNull(),
          equals('My Groceries'),
        );
      });

      test('converts to JSON with null optional fields', () {
        final settings = TestData.defaultUserListSettings;
        final json = settings.toJson();

        expect(pick(json, 'customName').asStringOrNull(), isNull);
        expect(pick(json, 'isPinned').asBoolOrFalse(), isFalse);
        expect(pick(json, 'sortOrder').asIntOrThrow(), equals(0));
      });

      test('creates from JSON correctly', () {
        final json = {
          'userId': 'user_json',
          'listId': 'list_json',
          'isPinned': true,
          'lastViewedAt': '2024-01-15T09:30:00.000',
          'sortOrder': 5,
          'notificationsEnabled': false,
          'customName': 'JSON Test List',
        };

        final settings = UserListSettings.fromJson(json);

        expect(settings.userId, equals('user_json'));
        expect(settings.listId, equals('list_json'));
        expect(settings.isPinned, isTrue);
        expect(settings.lastViewedAt, isNotNull);
        expect(settings.sortOrder, equals(5));
        expect(settings.notificationsEnabled, isFalse);
        expect(settings.customName, equals('JSON Test List'));
      });

      test('round trip JSON serialization', () {
        final original = TestData.sampleUserListSettings;
        final json = original.toJson();
        final restored = UserListSettings.fromJson(json);

        expect(restored, equals(original));
      });

      test('handles null lastViewedAt in JSON', () {
        final json = {
          'userId': 'user_123',
          'listId': 'list_123',
          'isPinned': false,
          'lastViewedAt': null,
          'sortOrder': 0,
          'notificationsEnabled': true,
          'customName': null,
        };

        final settings = UserListSettings.fromJson(json);

        expect(settings.lastViewedAt, isNull);
        expect(settings.customName, isNull);
      });
    });

    group('copyWith', () {
      test('creates copy with updated isPinned', () {
        final original = TestData.defaultUserListSettings;
        final updated = original.copyWith(isPinned: true);

        expect(updated.isPinned, isTrue);
        expect(updated.userId, equals(original.userId));
        expect(updated.listId, equals(original.listId));
        expect(original.isPinned, isFalse);
      });

      test('creates copy with updated customName', () {
        final original = TestData.defaultUserListSettings;
        final updated = original.copyWith(customName: 'New Custom Name');

        expect(updated.customName, equals('New Custom Name'));
        expect(updated.userId, equals(original.userId));
        expect(original.customName, isNull);
      });

      test('creates copy with updated lastViewedAt', () {
        final original = TestData.sampleUserListSettings;
        final newViewedAt = DateTime.now();
        final updated = original.copyWith(lastViewedAt: newViewedAt);

        expect(updated.lastViewedAt, equals(newViewedAt));
        expect(updated.lastViewedAt, isNot(equals(original.lastViewedAt)));
      });

      test('creates copy with updated sortOrder', () {
        final original = TestData.sampleUserListSettings;
        final updated = original.copyWith(sortOrder: 10);

        expect(updated.sortOrder, equals(10));
        expect(original.sortOrder, equals(1));
      });

      test('creates copy with updated notificationsEnabled', () {
        final original = TestData.sampleUserListSettings;
        final updated = original.copyWith(notificationsEnabled: false);

        expect(updated.notificationsEnabled, isFalse);
        expect(original.notificationsEnabled, isTrue);
      });

      test('creates identical copy when no parameters provided', () {
        final original = TestData.sampleUserListSettings;
        final updated = original.copyWith();

        expect(updated, equals(original));
      });

      test('can clear customName by setting to null', () {
        final original = TestData.sampleUserListSettings;
        final updated = original.copyWith(customName: null);

        expect(updated.customName, isNull);
        expect(original.customName, equals('My Groceries'));
      });
    });

    group('equality', () {
      test('equal when all properties match', () {
        final settings1 = TestData.sampleUserListSettings;
        final settings2 = TestData.sampleUserListSettings;

        expect(settings1, equals(settings2));
        expect(settings1.hashCode, equals(settings2.hashCode));
      });

      test('not equal when userIds differ', () {
        final settings1 = TestData.sampleUserListSettings;
        final settings2 = settings1.copyWith(userId: 'different_user');

        expect(settings1, isNot(equals(settings2)));
      });

      test('not equal when listIds differ', () {
        final settings1 = TestData.sampleUserListSettings;
        final settings2 = settings1.copyWith(listId: 'different_list');

        expect(settings1, isNot(equals(settings2)));
      });

      test('not equal when isPinned differs', () {
        final settings1 = TestData.sampleUserListSettings;
        final settings2 = settings1.copyWith(isPinned: false);

        expect(settings1, isNot(equals(settings2)));
      });
    });

    group('toString', () {
      test('returns string representation', () {
        final settings = TestData.sampleUserListSettings;
        final stringRepresentation = settings.toString();

        expect(stringRepresentation, contains('UserListSettings'));
        expect(stringRepresentation, contains(settings.userId));
        expect(stringRepresentation, contains(settings.listId));
      });
    });

    group('edge cases', () {
      test('handles empty string IDs', () {
        const settings = UserListSettings(userId: '', listId: '');

        expect(settings.userId, equals(''));
        expect(settings.listId, equals(''));
        expect(settings.compositeKey(), equals('_'));
      });

      test('handles very long custom names', () {
        final longName = 'A' * 10000;
        final settings = TestData.sampleUserListSettings.copyWith(
          customName: longName,
        );

        expect(settings.customName!.length, equals(10000));
      });

      test('handles special characters in custom name', () {
        final settings = TestData.sampleUserListSettings.copyWith(
          customName: 'List with émojis 🛒 and "quotes" & special chars',
        );

        expect(settings.customName, contains('émojis'));
        expect(settings.customName, contains('🛒'));
        expect(settings.customName, contains('"quotes"'));
      });

      test('handles extreme sort order values', () {
        final settings1 = TestData.sampleUserListSettings.copyWith(
          sortOrder: -999999,
        );
        final settings2 = TestData.sampleUserListSettings.copyWith(
          sortOrder: 999999,
        );

        expect(settings1.sortOrder, equals(-999999));
        expect(settings2.sortOrder, equals(999999));
      });

      test('handles edge case timestamps', () {
        final veryOldDate = DateTime(1900);
        final futureDate = DateTime(2100, 12, 31);

        final settings = TestData.sampleUserListSettings.copyWith(
          lastViewedAt: veryOldDate,
        );

        expect(settings.lastViewedAt, equals(veryOldDate));

        final futureSettings = settings.copyWith(lastViewedAt: futureDate);
        expect(futureSettings.lastViewedAt, equals(futureDate));
      });

      test('handles workflow: pin -> unpin -> rename', () {
        final original = TestData.defaultUserListSettings;

        // Pin the list
        final pinned = original.copyWith(isPinned: true);
        expect(pinned.isPinned, isTrue);

        // Unpin and rename
        final unpinnedRenamed = pinned.copyWith(
          isPinned: false,
          customName: 'Renamed List',
        );
        expect(unpinnedRenamed.isPinned, isFalse);
        expect(unpinnedRenamed.customName, equals('Renamed List'));

        // Clear custom name
        final cleared = unpinnedRenamed.copyWith(customName: null);
        expect(cleared.customName, isNull);
        expect(cleared.isPinned, isFalse);
      });
    });
  });
}
