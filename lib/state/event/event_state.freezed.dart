// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EventState {
  bool get isLoading => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  List<EventModel> get eventList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EventStateCopyWith<EventState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventStateCopyWith<$Res> {
  factory $EventStateCopyWith(
          EventState value, $Res Function(EventState) then) =
      _$EventStateCopyWithImpl<$Res, EventState>;
  @useResult
  $Res call({bool isLoading, String errorMessage, List<EventModel> eventList});
}

/// @nodoc
class _$EventStateCopyWithImpl<$Res, $Val extends EventState>
    implements $EventStateCopyWith<$Res> {
  _$EventStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = null,
    Object? eventList = null,
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
      eventList: null == eventList
          ? _value.eventList
          : eventList // ignore: cast_nullable_to_non_nullable
              as List<EventModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EventStateCopyWith<$Res>
    implements $EventStateCopyWith<$Res> {
  factory _$$_EventStateCopyWith(
          _$_EventState value, $Res Function(_$_EventState) then) =
      __$$_EventStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String errorMessage, List<EventModel> eventList});
}

/// @nodoc
class __$$_EventStateCopyWithImpl<$Res>
    extends _$EventStateCopyWithImpl<$Res, _$_EventState>
    implements _$$_EventStateCopyWith<$Res> {
  __$$_EventStateCopyWithImpl(
      _$_EventState _value, $Res Function(_$_EventState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = null,
    Object? eventList = null,
  }) {
    return _then(_$_EventState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      eventList: null == eventList
          ? _value._eventList
          : eventList // ignore: cast_nullable_to_non_nullable
              as List<EventModel>,
    ));
  }
}

/// @nodoc

class _$_EventState implements _EventState {
  const _$_EventState(
      {this.isLoading = false,
      this.errorMessage = '',
      final List<EventModel> eventList = const <EventModel>[]})
      : _eventList = eventList;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String errorMessage;
  final List<EventModel> _eventList;
  @override
  @JsonKey()
  List<EventModel> get eventList {
    if (_eventList is EqualUnmodifiableListView) return _eventList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_eventList);
  }

  @override
  String toString() {
    return 'EventState(isLoading: $isLoading, errorMessage: $errorMessage, eventList: $eventList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality()
                .equals(other._eventList, _eventList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, errorMessage,
      const DeepCollectionEquality().hash(_eventList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventStateCopyWith<_$_EventState> get copyWith =>
      __$$_EventStateCopyWithImpl<_$_EventState>(this, _$identity);
}

abstract class _EventState implements EventState {
  const factory _EventState(
      {final bool isLoading,
      final String errorMessage,
      final List<EventModel> eventList}) = _$_EventState;

  @override
  bool get isLoading;
  @override
  String get errorMessage;
  @override
  List<EventModel> get eventList;
  @override
  @JsonKey(ignore: true)
  _$$_EventStateCopyWith<_$_EventState> get copyWith =>
      throw _privateConstructorUsedError;
}
