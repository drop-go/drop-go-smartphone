import 'package:drop_go_smartphone/state/map/map_state.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemViewModel extends StateNotifier<MapState> {
  ItemViewModel(this.read)
      : super(
          MapState(
            position: Position(
              latitude: 35.199719,
              longitude: 136.1953773,
              timestamp: DateTime.now(),
              altitude: 0,
              accuracy: 0,
              heading: 0,
              floor: null,
              speed: 0,
              speedAccuracy: 0,
            ),
          ),
        );

  final read;
}
