// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'savefile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SavefileState {
  bool get isLoading => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  List<Map<String, Object>> get fileList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SavefileStateCopyWith<SavefileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavefileStateCopyWith<$Res> {
  factory $SavefileStateCopyWith(
          SavefileState value, $Res Function(SavefileState) then) =
      _$SavefileStateCopyWithImpl<$Res, SavefileState>;
  @useResult
  $Res call(
      {bool isLoading,
      String errorMessage,
      List<Map<String, Object>> fileList});
}

/// @nodoc
class _$SavefileStateCopyWithImpl<$Res, $Val extends SavefileState>
    implements $SavefileStateCopyWith<$Res> {
  _$SavefileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = null,
    Object? fileList = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      fileList: null == fileList
          ? _value.fileList
          : fileList // ignore: cast_nullable_to_non_nullable
              as List<Map<String, Object>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SavefileStateCopyWith<$Res>
    implements $SavefileStateCopyWith<$Res> {
  factory _$$_SavefileStateCopyWith(
          _$_SavefileState value, $Res Function(_$_SavefileState) then) =
      __$$_SavefileStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String errorMessage,
      List<Map<String, Object>> fileList});
}

/// @nodoc
class __$$_SavefileStateCopyWithImpl<$Res>
    extends _$SavefileStateCopyWithImpl<$Res, _$_SavefileState>
    implements _$$_SavefileStateCopyWith<$Res> {
  __$$_SavefileStateCopyWithImpl(
      _$_SavefileState _value, $Res Function(_$_SavefileState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = null,
    Object? fileList = null,
  }) {
    return _then(_$_SavefileState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      fileList: null == fileList
          ? _value._fileList
          : fileList // ignore: cast_nullable_to_non_nullable
              as List<Map<String, Object>>,
    ));
  }
}

/// @nodoc

class _$_SavefileState with DiagnosticableTreeMixin implements _SavefileState {
  const _$_SavefileState(
      {this.isLoading = false,
      this.errorMessage = '',
      final List<Map<String, Object>> fileList = const []})
      : _fileList = fileList;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String errorMessage;
  final List<Map<String, Object>> _fileList;
  @override
  @JsonKey()
  List<Map<String, Object>> get fileList {
    if (_fileList is EqualUnmodifiableListView) return _fileList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fileList);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SavefileState(isLoading: $isLoading, errorMessage: $errorMessage, fileList: $fileList)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SavefileState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('errorMessage', errorMessage))
      ..add(DiagnosticsProperty('fileList', fileList));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SavefileState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other._fileList, _fileList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, errorMessage,
      const DeepCollectionEquality().hash(_fileList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SavefileStateCopyWith<_$_SavefileState> get copyWith =>
      __$$_SavefileStateCopyWithImpl<_$_SavefileState>(this, _$identity);
}

abstract class _SavefileState implements SavefileState {
  const factory _SavefileState(
      {final bool isLoading,
      final String errorMessage,
      final List<Map<String, Object>> fileList}) = _$_SavefileState;

  @override
  bool get isLoading;
  @override
  String get errorMessage;
  @override
  List<Map<String, Object>> get fileList;
  @override
  @JsonKey(ignore: true)
  _$$_SavefileStateCopyWith<_$_SavefileState> get copyWith =>
      throw _privateConstructorUsedError;
}
