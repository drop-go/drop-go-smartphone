import 'dart:async';

import 'package:drop_go_smartphone/model/item/item_model.dart';
import 'package:drop_go_smartphone/repository/item_repository.dart';
import 'package:drop_go_smartphone/repository/position_repository.dart';
import 'package:drop_go_smartphone/state/map/map_state.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MapViewModel extends StateNotifier<MapState> {
  MapViewModel(this.read)
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
        ) {
    _init();
  }

  // @override
  // void dispose() {
  //   _getPositionSubscription.cancel();
  //   super.dispose();
  // }

  final read;
  //late StreamSubscription _getPositionSubscription;

  void _init() {
    state = state.copyWith(isLoading: true);
    _getCurrentLocation();
    state = state.copyWith(isLoading: false);
  }

  Future<List<ItemModel>> getItems(String id) async {
    final itemRepository = read(itemRepositoryProvider);
    final List<ItemModel> itemList = await itemRepository.fetchItems(id);
    print('id: $id');
    print('${itemList[0].latitude}.${itemList[0].longitude}');
    return itemList;
    // try {
    //   print(itemList);

    //   if (!mounted) {
    //     return;
    //   }
    //   state = state.copyWith(itemList: itemList);
    // } on Exception catch (e) {
    //   if (!mounted) {
    //     return;
    //   }
    //   state = state.copyWith(errorMessage: e.toString());
    // }
  }

  Future<void> _getCurrentLocation() async {
    final positionRepository = read(positionRepositoryProvider);

    try {
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
    //_getPositionStream();
  }

  // void _getPositionStream() {
  //   const LocationSettings locationSettings = LocationSettings(
  //     accuracy: LocationAccuracy.high,
  //   );

  //   _getPositionSubscription =
  //       Geolocator.getPositionStream(locationSettings: locationSettings)
  //           .listen((Position? position) {
  //     if (position != null && mounted) {
  //       state = state.copyWith(position: position);
  //     }
  //   });
  // }
}
