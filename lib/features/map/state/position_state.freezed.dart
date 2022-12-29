// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'position_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PositionState {
  bool get isLoading => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  Position get position => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PositionStateCopyWith<PositionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PositionStateCopyWith<$Res> {
  factory $PositionStateCopyWith(
          PositionState value, $Res Function(PositionState) then) =
      _$PositionStateCopyWithImpl<$Res, PositionState>;
  @useResult
  $Res call({bool isLoading, String errorMessage, Position position});
}

/// @nodoc
class _$PositionStateCopyWithImpl<$Res, $Val extends PositionState>
    implements $PositionStateCopyWith<$Res> {
  _$PositionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = null,
    Object? position = null,
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
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PositionStateCopyWith<$Res>
    implements $PositionStateCopyWith<$Res> {
  factory _$$_PositionStateCopyWith(
          _$_PositionState value, $Res Function(_$_PositionState) then) =
      __$$_PositionStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String errorMessage, Position position});
}

/// @nodoc
class __$$_PositionStateCopyWithImpl<$Res>
    extends _$PositionStateCopyWithImpl<$Res, _$_PositionState>
    implements _$$_PositionStateCopyWith<$Res> {
  __$$_PositionStateCopyWithImpl(
      _$_PositionState _value, $Res Function(_$_PositionState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = null,
    Object? position = null,
  }) {
    return _then(_$_PositionState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
    ));
  }
}

/// @nodoc

class _$_PositionState with DiagnosticableTreeMixin implements _PositionState {
  const _$_PositionState(
      {this.isLoading = false, this.errorMessage = '', required this.position});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  final Position position;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PositionState(isLoading: $isLoading, errorMessage: $errorMessage, position: $position)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PositionState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('errorMessage', errorMessage))
      ..add(DiagnosticsProperty('position', position));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PositionState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, errorMessage, position);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PositionStateCopyWith<_$_PositionState> get copyWith =>
      __$$_PositionStateCopyWithImpl<_$_PositionState>(this, _$identity);
}

abstract class _PositionState implements PositionState {
  const factory _PositionState(
      {final bool isLoading,
      final String errorMessage,
      required final Position position}) = _$_PositionState;

  @override
  bool get isLoading;
  @override
  String get errorMessage;
  @override
  Position get position;
  @override
  @JsonKey(ignore: true)
  _$$_PositionStateCopyWith<_$_PositionState> get copyWith =>
      throw _privateConstructorUsedError;
}
