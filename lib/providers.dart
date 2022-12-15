import 'package:drop_go_smartphone/state/event/event_state.dart';
import 'package:drop_go_smartphone/state/map/map_state.dart';
import 'package:drop_go_smartphone/state/map/position_state.dart';
import 'package:drop_go_smartphone/viewmodel/event/event_viewmodel.dart';
import 'package:drop_go_smartphone/viewmodel/map/item_viewmodel.dart';
import 'package:drop_go_smartphone/viewmodel/map/map_viewmodel.dart';
import 'package:drop_go_smartphone/viewmodel/map/position_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
