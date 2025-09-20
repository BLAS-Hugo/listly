import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_permissions.freezed.dart';
part 'list_permissions.g.dart';

@freezed
abstract class ListPermissions with _$ListPermissions {
  const factory ListPermissions({
    required bool anyoneCanEdit,
    required bool anyoneCanInvite,
    required bool anyoneCanDelete,
  }) = _ListPermissions;

  factory ListPermissions.fromJson(Map<String, dynamic> json) =>
      _$ListPermissionsFromJson(json);
}
