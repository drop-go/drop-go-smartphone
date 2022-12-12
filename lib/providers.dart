import 'package:drop_go_smartphone/state/event/event_state.dart';
import 'package:drop_go_smartphone/state/map/position_state.dart';
import 'package:drop_go_smartphone/viewmodel/event/event_viewmodel.dart';
import 'package:drop_go_smartphone/viewmodel/map/position_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final eventViewModelProvider =
    StateNotifierProvider.autoDispose<EventViewModel, EventState>(
  (ref) => EventViewModel(ref.read),
);

final positionViewModelProvider =
    StateNotifierProvider.autoDispose<PositionViewModel, PositionState>(
  (ref) => PositionViewModel(ref.read),
);
