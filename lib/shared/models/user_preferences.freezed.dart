// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserPreferences {

@JsonKey(name: 'notifications_enabled') bool get notificationsEnabled;@JsonKey(name: 'email_notifications_enabled') bool get emailNotificationsEnabled; String get theme; String get language;
/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPreferencesCopyWith<UserPreferences> get copyWith => _$UserPreferencesCopyWithImpl<UserPreferences>(this as UserPreferences, _$identity);

  /// Serializes this UserPreferences to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPreferences&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.emailNotificationsEnabled, emailNotificationsEnabled) || other.emailNotificationsEnabled == emailNotificationsEnabled)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.language, language) || other.language == language));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationsEnabled,emailNotificationsEnabled,theme,language);

@override
String toString() {
  return 'UserPreferences(notificationsEnabled: $notificationsEnabled, emailNotificationsEnabled: $emailNotificationsEnabled, theme: $theme, language: $language)';
}


}

/// @nodoc
abstract mixin class $UserPreferencesCopyWith<$Res>  {
  factory $UserPreferencesCopyWith(UserPreferences value, $Res Function(UserPreferences) _then) = _$UserPreferencesCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'notifications_enabled') bool notificationsEnabled,@JsonKey(name: 'email_notifications_enabled') bool emailNotificationsEnabled, String theme, String language
});




}
/// @nodoc
class _$UserPreferencesCopyWithImpl<$Res>
    implements $UserPreferencesCopyWith<$Res> {
  _$UserPreferencesCopyWithImpl(this._self, this._then);

  final UserPreferences _self;
  final $Res Function(UserPreferences) _then;

/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationsEnabled = null,Object? emailNotificationsEnabled = null,Object? theme = null,Object? language = null,}) {
  return _then(_self.copyWith(
notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,emailNotificationsEnabled: null == emailNotificationsEnabled ? _self.emailNotificationsEnabled : emailNotificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPreferences].
extension UserPreferencesPatterns on UserPreferences {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPreferences value)  $default,){
final _that = this;
switch (_that) {
case _UserPreferences():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'notifications_enabled')  bool notificationsEnabled, @JsonKey(name: 'email_notifications_enabled')  bool emailNotificationsEnabled,  String theme,  String language)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
return $default(_that.notificationsEnabled,_that.emailNotificationsEnabled,_that.theme,_that.language);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'notifications_enabled')  bool notificationsEnabled, @JsonKey(name: 'email_notifications_enabled')  bool emailNotificationsEnabled,  String theme,  String language)  $default,) {final _that = this;
switch (_that) {
case _UserPreferences():
return $default(_that.notificationsEnabled,_that.emailNotificationsEnabled,_that.theme,_that.language);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'notifications_enabled')  bool notificationsEnabled, @JsonKey(name: 'email_notifications_enabled')  bool emailNotificationsEnabled,  String theme,  String language)?  $default,) {final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
return $default(_that.notificationsEnabled,_that.emailNotificationsEnabled,_that.theme,_that.language);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserPreferences implements UserPreferences {
  const _UserPreferences({@JsonKey(name: 'notifications_enabled') this.notificationsEnabled = true, @JsonKey(name: 'email_notifications_enabled') this.emailNotificationsEnabled = false, this.theme = 'system', this.language = 'en'});
  factory _UserPreferences.fromJson(Map<String, dynamic> json) => _$UserPreferencesFromJson(json);

@override@JsonKey(name: 'notifications_enabled') final  bool notificationsEnabled;
@override@JsonKey(name: 'email_notifications_enabled') final  bool emailNotificationsEnabled;
@override@JsonKey() final  String theme;
@override@JsonKey() final  String language;

/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPreferencesCopyWith<_UserPreferences> get copyWith => __$UserPreferencesCopyWithImpl<_UserPreferences>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserPreferencesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPreferences&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.emailNotificationsEnabled, emailNotificationsEnabled) || other.emailNotificationsEnabled == emailNotificationsEnabled)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.language, language) || other.language == language));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationsEnabled,emailNotificationsEnabled,theme,language);

@override
String toString() {
  return 'UserPreferences(notificationsEnabled: $notificationsEnabled, emailNotificationsEnabled: $emailNotificationsEnabled, theme: $theme, language: $language)';
}


}

/// @nodoc
abstract mixin class _$UserPreferencesCopyWith<$Res> implements $UserPreferencesCopyWith<$Res> {
  factory _$UserPreferencesCopyWith(_UserPreferences value, $Res Function(_UserPreferences) _then) = __$UserPreferencesCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'notifications_enabled') bool notificationsEnabled,@JsonKey(name: 'email_notifications_enabled') bool emailNotificationsEnabled, String theme, String language
});




}
/// @nodoc
class __$UserPreferencesCopyWithImpl<$Res>
    implements _$UserPreferencesCopyWith<$Res> {
  __$UserPreferencesCopyWithImpl(this._self, this._then);

  final _UserPreferences _self;
  final $Res Function(_UserPreferences) _then;

/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationsEnabled = null,Object? emailNotificationsEnabled = null,Object? theme = null,Object? language = null,}) {
  return _then(_UserPreferences(
notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,emailNotificationsEnabled: null == emailNotificationsEnabled ? _self.emailNotificationsEnabled : emailNotificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
