// ignore: unused_import

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';

// Project imports:
import 'package:drop_go_smartphone/features/map/model/item_model.dart';

part 'map_state.freezed.dart';

@freezed
class MapState with _$MapState {
  const factory MapState({
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
    required Position position,
    @Default(<ItemModel>[]) itemList,
  }) = _MapState;
}
