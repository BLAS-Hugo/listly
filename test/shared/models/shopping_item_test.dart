import 'package:deep_pick/deep_pick.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listly/shared/models/shopping_item.dart';

import '../../helpers/test_data.dart';

void main() {
  group('ShoppingItem', () {
    group('constructor', () {
      test('creates instance with all parameters', () {
        final item = TestData.sampleShoppingItem;

        expect(item.id, equals('item_1'));
        expect(item.listId, equals('list_123'));
        expect(item.addedByUserId, equals('user_123'));
        expect(item.name, equals('Apples'));
        expect(item.description, equals('Red apples, organic'));
        expect(item.quantity, equals(6));
        expect(item.unit, equals('pieces'));
        expect(item.category, equals('fruits'));
        expect(item.isCompleted, isFalse);
        expect(item.completedAt, isNull);
        expect(item.completedByUserId, isNull);
        expect(item.sortOrder, equals(1));
      });

      test('creates completed item with completion data', () {
        final item = TestData.completedShoppingItem;

        expect(item.isCompleted, isTrue);
        expect(item.completedAt, isNotNull);
        expect(item.completedByUserId, equals('user_456'));
      });

      test('creates instance with minimal required parameters', () {
        final item = TestData.minimalShoppingItem;

        expect(item.id, equals('item_minimal'));
        expect(item.name, equals('Bread'));
        expect(item.quantity, equals(1));
        expect(item.description, isNull);
        expect(item.unit, isNull);
        expect(item.category, isNull);
        expect(item.isCompleted, isFalse);
      });
    });

    group('create factory', () {
      test('creates new shopping item with generated ID', () {
        final item = ShoppingItem.create(
          listId: 'list_123',
          addedByUserId: 'user_123',
          name: 'Test Item',
          description: 'Test description',
          quantity: 3,
          unit: 'kg',
          category: 'vegetables',
        );

        expect(item.id, isNotEmpty);
        expect(item.listId, equals('list_123'));
        expect(item.addedByUserId, equals('user_123'));
        expect(item.name, equals('Test Item'));
        expect(item.description, equals('Test description'));
        expect(item.quantity, equals(3));
        expect(item.unit, equals('kg'));
        expect(item.category, equals('vegetables'));
        expect(item.isCompleted, isFalse);
        expect(item.completedAt, isNull);
        expect(item.completedByUserId, isNull);
      });

      test('creates item with default quantity when none provided', () {
        final item = ShoppingItem.create(
          listId: 'list_123',
          addedByUserId: 'user_123',
          name: 'Default Quantity Item',
        );

        expect(item.quantity, equals(1));
      });

      test('creates item with custom quantity', () {
        final item = ShoppingItem.create(
          listId: 'list_123',
          addedByUserId: 'user_123',
          name: 'Custom Quantity Item',
          quantity: 5,
        );

        expect(item.quantity, equals(5));
      });

      test('sets timestamps and sort order correctly on creation', () {
        final before = DateTime.now();
        final item = ShoppingItem.create(
          listId: 'list_123',
          addedByUserId: 'user_123',
          name: 'Time Test',
        );
        final after = DateTime.now();

        expect(
          item.createdAt.isAfter(before.subtract(const Duration(seconds: 1))),
          isTrue,
        );
        expect(
          item.createdAt.isBefore(after.add(const Duration(seconds: 1))),
          isTrue,
        );
        expect(item.updatedAt, equals(item.createdAt));
        expect(item.sortOrder, equals(item.createdAt.millisecondsSinceEpoch));
      });
    });

    group('JSON serialization', () {
      test('converts to JSON correctly', () {
        final item = TestData.sampleShoppingItem;
        final json = item.toJson();

        expect(pick(json, 'id').asStringOrThrow(), equals('item_1'));
        expect(pick(json, 'list_id').asStringOrThrow(), equals('list_123'));
        expect(
          pick(json, 'added_by_user_id').asStringOrThrow(),
          equals('user_123'),
        );
        expect(pick(json, 'name').asStringOrThrow(), equals('Apples'));
        expect(
          pick(json, 'description').asStringOrNull(),
          equals('Red apples, organic'),
        );
        expect(pick(json, 'quantity').asIntOrThrow(), equals(6));
        expect(pick(json, 'unit').asStringOrNull(), equals('pieces'));
        expect(pick(json, 'category').asStringOrNull(), equals('fruits'));
        expect(pick(json, 'is_completed').asBoolOrFalse(), isFalse);
        expect(pick(json, 'completed_at').asStringOrNull(), isNull);
        expect(pick(json, 'completed_by_user_id').asStringOrNull(), isNull);
        expect(pick(json, 'sort_order').asIntOrThrow(), equals(1));
      });

      test('converts completed item to JSON correctly', () {
        final item = TestData.completedShoppingItem;
        final json = item.toJson();

        expect(pick(json, 'is_completed').asBoolOrFalse(), isTrue);
        expect(pick(json, 'completed_at').asStringOrNull(), isNotNull);
        expect(
          pick(json, 'completed_by_user_id').asStringOrNull(),
          equals('user_456'),
        );
      });

      test('creates from JSON correctly', () {
        final json = TestData.sampleShoppingItemJson;
        final item = ShoppingItem.fromJson(json);

        expect(item.id, equals('item_1'));
        expect(item.listId, equals('list_123'));
        expect(item.addedByUserId, equals('user_123'));
        expect(item.name, equals('Apples'));
        expect(item.description, equals('Red apples, organic'));
        expect(item.quantity, equals(6));
        expect(item.unit, equals('pieces'));
        expect(item.category, equals('fruits'));
        expect(item.isCompleted, isFalse);
        expect(item.sortOrder, equals(1));
      });

      test('round trip JSON serialization', () {
        final original = TestData.sampleShoppingItem;
        final json = original.toJson();
        final restored = ShoppingItem.fromJson(json);

        expect(restored, equals(original));
      });

      test('handles null optional fields in JSON', () {
        final json = {
          'id': 'item_null_test',
          'list_id': 'list_123',
          'added_by_user_id': 'user_123',
          'name': 'Null Test Item',
          'description': null,
          'quantity': 1,
          'unit': null,
          'category': null,
          'is_completed': false,
          'completed_at': null,
          'completed_by_user_id': null,
          'created_at': '2024-01-01T00:00:00.000',
          'updated_at': '2024-01-01T00:00:00.000',
          'sort_order': 0,
        };

        final item = ShoppingItem.fromJson(json);

        expect(item.description, isNull);
        expect(item.unit, isNull);
        expect(item.category, isNull);
        expect(item.completedAt, isNull);
        expect(item.completedByUserId, isNull);
      });
    });

    group('copyWith', () {
      test('creates copy with updated name', () {
        final original = TestData.sampleShoppingItem;
        final updated = original.copyWith(name: 'Updated Apples');

        expect(updated.name, equals('Updated Apples'));
        expect(updated.id, equals(original.id));
        expect(updated.listId, equals(original.listId));
      });

      test('creates copy with updated quantity', () {
        final original = TestData.sampleShoppingItem;
        final updated = original.copyWith(quantity: 12);

        expect(updated.quantity, equals(12));
        expect(updated.name, equals(original.name));
      });

      test('creates copy with completion data', () {
        final original = TestData.sampleShoppingItem;
        final completedAt = DateTime.now();
        final updated = original.copyWith(
          isCompleted: true,
          completedAt: completedAt,
          completedByUserId: 'user_456',
        );

        expect(updated.isCompleted, isTrue);
        expect(updated.completedAt, equals(completedAt));
        expect(updated.completedByUserId, equals('user_456'));
        expect(original.isCompleted, isFalse);
      });

      test('creates copy with updated description and category', () {
        final original = TestData.minimalShoppingItem;
        final updated = original.copyWith(
          description: 'Whole wheat bread',
          category: 'bakery',
          unit: 'loaf',
        );

        expect(updated.description, equals('Whole wheat bread'));
        expect(updated.category, equals('bakery'));
        expect(updated.unit, equals('loaf'));
        expect(original.description, isNull);
      });

      test('creates identical copy when no parameters provided', () {
        final original = TestData.sampleShoppingItem;
        final updated = original.copyWith();

        expect(updated, equals(original));
      });
    });

    group('equality', () {
      test('equal when all properties match', () {
        final item1 = TestData.sampleShoppingItem;
        final item2 = TestData.sampleShoppingItem;

        expect(item1, equals(item2));
        expect(item1.hashCode, equals(item2.hashCode));
      });

      test('not equal when IDs differ', () {
        final item1 = TestData.sampleShoppingItem;
        final item2 = item1.copyWith(id: 'different_id');

        expect(item1, isNot(equals(item2)));
      });

      test('not equal when names differ', () {
        final item1 = TestData.sampleShoppingItem;
        final item2 = item1.copyWith(name: 'Different Name');

        expect(item1, isNot(equals(item2)));
      });

      test('not equal when completion status differs', () {
        final item1 = TestData.sampleShoppingItem;
        final item2 = item1.copyWith(isCompleted: true);

        expect(item1, isNot(equals(item2)));
      });
    });

    group('toString', () {
      test('returns string representation', () {
        final item = TestData.sampleShoppingItem;
        final stringRepresentation = item.toString();

        expect(stringRepresentation, contains('ShoppingItem'));
        expect(stringRepresentation, contains(item.id));
        expect(stringRepresentation, contains(item.name));
      });
    });

    group('edge cases', () {
      test('handles zero quantity', () {
        final item = TestData.createShoppingItem(quantity: 0);

        expect(item.quantity, equals(0));
      });

      test('handles very large quantities', () {
        final item = TestData.createShoppingItem(quantity: 999999);

        expect(item.quantity, equals(999999));
      });

      test('handles special characters in names and descriptions', () {
        final item = TestData.createShoppingItem(
          name: 'Café au lait ☕ 2kg',
          description: 'Imported from "Café René" - très délicieux!',
          category: 'beverages & drinks',
        );

        expect(item.name, contains('☕'));
        expect(item.description, contains('"Café René"'));
        expect(item.category, contains('&'));
      });

      test('handles empty strings', () {
        final item = TestData.createShoppingItem(
          name: '',
          description: '',
          unit: '',
          category: '',
        );

        expect(item.name, equals(''));
        expect(item.description, equals(''));
        expect(item.unit, equals(''));
        expect(item.category, equals(''));
      });

      test('handles very long text fields', () {
        final longText = 'A' * 10000;
        final item = TestData.createShoppingItem(
          name: longText,
          description: longText,
          unit: longText,
          category: longText,
        );

        expect(item.name.length, equals(10000));
        expect(item.description!.length, equals(10000));
        expect(item.unit!.length, equals(10000));
        expect(item.category!.length, equals(10000));
      });

      test('handles completion workflow', () {
        final item = TestData.createShoppingItem();
        expect(item.isCompleted, isFalse);
        expect(item.completedAt, isNull);
        expect(item.completedByUserId, isNull);

        final completedAt = DateTime.now();
        final completedItem = item.copyWith(
          isCompleted: true,
          completedAt: completedAt,
          completedByUserId: 'user_completed',
        );

        expect(completedItem.isCompleted, isTrue);
        expect(completedItem.completedAt, equals(completedAt));
        expect(completedItem.completedByUserId, equals('user_completed'));

        // Uncomplete the item
        final uncompletedItem = completedItem.copyWith(
          isCompleted: false,
          completedAt: null,
          completedByUserId: null,
        );

        expect(uncompletedItem.isCompleted, isFalse);
        expect(uncompletedItem.completedAt, isNull);
        expect(uncompletedItem.completedByUserId, isNull);
      });

      test('handles date edge cases', () {
        final veryOldDate = DateTime(1900);
        final futureDate = DateTime(2100, 12, 31);

        final item = TestData.createShoppingItem(
          createdAt: veryOldDate,
          updatedAt: futureDate,
        );

        expect(item.createdAt, equals(veryOldDate));
        expect(item.updatedAt, equals(futureDate));
      });
    });
  });
}
