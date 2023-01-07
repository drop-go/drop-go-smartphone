// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

// Package imports:
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:drop_go_smartphone/features/map/model/item_model.dart';
import 'package:drop_go_smartphone/features/map/repository/item_repository.dart';
import 'package:drop_go_smartphone/features/map/repository/position_repository.dart';
import 'package:drop_go_smartphone/features/map/state/map_state.dart';

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
    return itemList;
  }

  Future<void> downloadItem(String eventId, String itemId) async {
    final itemRepository = read(itemRepositoryProvider);
    final ItemModel file = await itemRepository.fetchFile(eventId, itemId);
    final Uint8List bytes = base64Decode(file.file.dataURI.split(',')[1]);
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final File saveFile =
        File("$dir/${file.file.fileName}.${file.file.extension}");
    await saveFile.writeAsBytes(bytes);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(file.file.fileName, file.title);
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
