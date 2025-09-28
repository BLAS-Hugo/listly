import 'package:flutter_test/flutter_test.dart';
import 'package:listly/shared/models/list_permissions.dart';

void main() {
  group('ListPermissions', () {
    group('constructor', () {
      test('creates instance with required parameters', () {
        const permissions = ListPermissions(
          anyoneCanEdit: true,
          anyoneCanInvite: false,
          anyoneCanDelete: false,
        );

        expect(permissions.anyoneCanEdit, isTrue);
        expect(permissions.anyoneCanInvite, isFalse);
        expect(permissions.anyoneCanDelete, isFalse);
      });

      test('creates instance with all permissions enabled', () {
        const permissions = ListPermissions(
          anyoneCanEdit: true,
          anyoneCanInvite: true,
          anyoneCanDelete: true,
        );

        expect(permissions.anyoneCanEdit, isTrue);
        expect(permissions.anyoneCanInvite, isTrue);
        expect(permissions.anyoneCanDelete, isTrue);
      });

      test('creates instance with all permissions disabled', () {
        const permissions = ListPermissions(
          anyoneCanEdit: false,
          anyoneCanInvite: false,
          anyoneCanDelete: false,
        );

        expect(permissions.anyoneCanEdit, isFalse);
        expect(permissions.anyoneCanInvite, isFalse);
        expect(permissions.anyoneCanDelete, isFalse);
      });
    });

    group('JSON serialization', () {
      test('converts to JSON correctly', () {
        const permissions = ListPermissions(
          anyoneCanEdit: true,
          anyoneCanInvite: false,
          anyoneCanDelete: true,
        );

        final json = permissions.toJson();

        expect(
          json,
          equals({
            'anyoneCanEdit': true,
            'anyoneCanInvite': false,
            'anyoneCanDelete': true,
          }),
        );
      });

      test('creates from JSON correctly', () {
        final json = {
          'anyoneCanEdit': false,
          'anyoneCanInvite': true,
          'anyoneCanDelete': false,
        };

        final permissions = ListPermissions.fromJson(json);

        expect(permissions.anyoneCanEdit, isFalse);
        expect(permissions.anyoneCanInvite, isTrue);
        expect(permissions.anyoneCanDelete, isFalse);
      });

      test('round trip JSON serialization', () {
        const originalPermissions = ListPermissions(
          anyoneCanEdit: true,
          anyoneCanInvite: true,
          anyoneCanDelete: false,
        );

        final json = originalPermissions.toJson();
        final restoredPermissions = ListPermissions.fromJson(json);

        expect(restoredPermissions, equals(originalPermissions));
      });
    });

    group('equality', () {
      test('equal when all properties match', () {
        const permissions1 = ListPermissions(
          anyoneCanEdit: true,
          anyoneCanInvite: false,
          anyoneCanDelete: true,
        );

        const permissions2 = ListPermissions(
          anyoneCanEdit: true,
          anyoneCanInvite: false,
          anyoneCanDelete: true,
        );

        expect(permissions1, equals(permissions2));
        expect(permissions1.hashCode, equals(permissions2.hashCode));
      });

      test('not equal when properties differ', () {
        const permissions1 = ListPermissions(
          anyoneCanEdit: true,
          anyoneCanInvite: false,
          anyoneCanDelete: true,
        );

        const permissions2 = ListPermissions(
          anyoneCanEdit: false,
          anyoneCanInvite: false,
          anyoneCanDelete: true,
        );

        expect(permissions1, isNot(equals(permissions2)));
      });
    });

    group('copyWith', () {
      test('creates copy with updated anyoneCanEdit', () {
        const original = ListPermissions(
          anyoneCanEdit: false,
          anyoneCanInvite: true,
          anyoneCanDelete: false,
        );

        final updated = original.copyWith(anyoneCanEdit: true);

        expect(updated.anyoneCanEdit, isTrue);
        expect(updated.anyoneCanInvite, isTrue);
        expect(updated.anyoneCanDelete, isFalse);
      });

      test('creates copy with updated anyoneCanInvite', () {
        const original = ListPermissions(
          anyoneCanEdit: true,
          anyoneCanInvite: false,
          anyoneCanDelete: true,
        );

        final updated = original.copyWith(anyoneCanInvite: true);

        expect(updated.anyoneCanEdit, isTrue);
        expect(updated.anyoneCanInvite, isTrue);
        expect(updated.anyoneCanDelete, isTrue);
      });

      test('creates copy with updated anyoneCanDelete', () {
        const original = ListPermissions(
          anyoneCanEdit: true,
          anyoneCanInvite: true,
          anyoneCanDelete: false,
        );

        final updated = original.copyWith(anyoneCanDelete: true);

        expect(updated.anyoneCanEdit, isTrue);
        expect(updated.anyoneCanInvite, isTrue);
        expect(updated.anyoneCanDelete, isTrue);
      });

      test('creates copy with multiple updates', () {
        const original = ListPermissions(
          anyoneCanEdit: false,
          anyoneCanInvite: false,
          anyoneCanDelete: false,
        );

        final updated = original.copyWith(
          anyoneCanEdit: true,
          anyoneCanDelete: true,
        );

        expect(updated.anyoneCanEdit, isTrue);
        expect(updated.anyoneCanInvite, isFalse);
        expect(updated.anyoneCanDelete, isTrue);
      });

      test('creates identical copy when no parameters provided', () {
        const original = ListPermissions(
          anyoneCanEdit: true,
          anyoneCanInvite: false,
          anyoneCanDelete: true,
        );

        final updated = original.copyWith();

        expect(updated, equals(original));
      });
    });

    group('toString', () {
      test('returns string representation', () {
        const permissions = ListPermissions(
          anyoneCanEdit: true,
          anyoneCanInvite: false,
          anyoneCanDelete: true,
        );

        final stringRepresentation = permissions.toString();

        expect(stringRepresentation, contains('ListPermissions'));
        expect(stringRepresentation, contains('anyoneCanEdit'));
        expect(stringRepresentation, contains('anyoneCanInvite'));
        expect(stringRepresentation, contains('anyoneCanDelete'));
      });
    });
  });
}
