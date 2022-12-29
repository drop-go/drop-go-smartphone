// ignore: unused_import

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';

part 'position_state.freezed.dart';

@freezed
class PositionState with _$PositionState {
  const factory PositionState({
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
    required Position position,
  }) = _PositionState;
}
