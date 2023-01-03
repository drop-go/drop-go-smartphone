// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:drop_go_smartphone/features/event/model/event_state.dart';
import 'package:drop_go_smartphone/features/event/viewmodel/event_viewmodel.dart';
import 'package:drop_go_smartphone/features/map/state/map_state.dart';
import 'package:drop_go_smartphone/features/map/state/position_state.dart';
import 'package:drop_go_smartphone/features/map/viewmodel/item_viewmodel.dart';
import 'package:drop_go_smartphone/features/map/viewmodel/map_viewmodel.dart';
import 'package:drop_go_smartphone/features/map/viewmodel/position_viewmodel.dart';
import 'package:drop_go_smartphone/features/saved_file/state/savefile_state.dart';
import 'package:drop_go_smartphone/features/saved_file/viewmodel/savefile_view_model.dart';

final eventIdProvider = StateProvider<String>((ref) => '');

final eventViewModelProvider =
    StateNotifierProvider.autoDispose<EventViewModel, EventState>(
  (ref) => EventViewModel(ref.read),
);

final positionViewModelProvider =
    StateNotifierProvider.autoDispose<PositionViewModel, PositionState>(
  (ref) => PositionViewModel(ref.read),
);

final mapViewModelProvider =
    StateNotifierProvider.autoDispose<MapViewModel, MapState>(
  (ref) => MapViewModel(ref.read),
);

final itemViewModelProvider =
    StateNotifierProvider.autoDispose<ItemViewModel, MapState>(
  (ref) => ItemViewModel(ref.read),
);

final savefileViewModelProvider =
    StateNotifierProvider.autoDispose<SavefileViewModel, SavefileState>(
  (ref) => SavefileViewModel(ref.read),
);
