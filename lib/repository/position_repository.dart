import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final positionRepositoryProvider = Provider.autoDispose<PositionRepository>(
  (ref) => PositionRepositoryImpl(),
);

abstract class PositionRepository {
  Future<Position> fetchLocation();
}

class PositionRepositoryImpl implements PositionRepository {
  @override
  Future<Position> fetchLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    final position =
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return position;
  }
}
