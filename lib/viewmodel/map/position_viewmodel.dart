import 'dart:async';

import 'package:drop_go_smartphone/repository/position_repository.dart';
import 'package:drop_go_smartphone/state/map/position_state.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PositionViewModel extends StateNotifier<PositionState> {
  PositionViewModel(this.read)
      : super(
          PositionState(
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
        ) {
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _getPositionSubscription.cancel();
    super.dispose();
  }

  final read;
  late StreamSubscription _getPositionSubscription;

  Future<void> _getCurrentLocation() async {
    final positionRepository = read(positionRepositoryProvider);

    try {
      if (!mounted) {
        return;
      }
      state = state.copyWith(isLoading: true);
      final Position currentPosition = await positionRepository.fetchLocation();

      if (!mounted) {
        return;
      }
      state = state.copyWith(position: currentPosition);
    } on Exception catch (e) {
      if (!mounted) {
        return;
      }
      state = state.copyWith(errorMessage: e.toString());
    }
    if (!mounted) {
      return;
    }
    state = state.copyWith(isLoading: false);

    _getPositionStream();
  }

  void _getPositionStream() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
    );

    _getPositionSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      if (position != null && mounted) {
        state = state.copyWith(position: position);
      }
    });
  }
}
