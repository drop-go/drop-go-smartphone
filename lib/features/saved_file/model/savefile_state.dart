// ignore: unused_import

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'savefile_state.freezed.dart';

@freezed
class SavefileState with _$SavefileState {
  const factory SavefileState({
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
    @Default([]) List<Map<String, Object>> fileList,
  }) = _SavefileState;
}
