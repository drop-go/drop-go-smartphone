import 'dart:async';

import 'package:drop_go_smartphone/view/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => const MapScreen(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            MapView(),
            Positioned(
              left: 20,
              top: 20,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                child: FloatingActionButton(
                  heroTag: "back",
                  backgroundColor: Colors.white,
                  elevation: 0,
                  onPressed: () => {
                    Navigator.of(context).pop(),
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 20,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                child: FloatingActionButton(
                  heroTag: "notification",
                  backgroundColor: Colors.white,
                  elevation: 0,
                  onPressed: () => _showCupertinoModalBottomSheet(context),
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showCupertinoModalBottomSheet(BuildContext context) {
  showCupertinoModalBottomSheet(
    topRadius: const Radius.circular(45),
    context: context,
    builder: (BuildContext context) => const NotificationScreen(),
  );
}

class MapView extends HookWidget {
  MapView({super.key});

  final Completer<GoogleMapController> _mapController = Completer();
  final Position _initialPosition = Position(
    latitude: 35.199719,
    longitude: 136.1953773,
    timestamp: DateTime.now(),
    altitude: 0,
    accuracy: 0,
    heading: 0,
    floor: null,
    speed: 0,
    speedAccuracy: 0,
  );

  @override
  Widget build(BuildContext context) {
    final initialMarkers = {
      _initialPosition.timestamp.toString(): Marker(
        markerId: MarkerId(_initialPosition.timestamp.toString()),
        position: LatLng(_initialPosition.latitude, _initialPosition.longitude),
      ),
    };
    final position = useState<Position>(_initialPosition);
    final markers = useState<Map<String, Marker>>(initialMarkers);

    _setCurrentLocation(position, markers);
    _animateCamera(position);

    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(_initialPosition.latitude, _initialPosition.longitude),
          zoom: 16.4746,
        ),
        onMapCreated: _mapController.complete,
        markers: markers.value.values.toSet(),
      ),
    );
  }

  Future<void> _setCurrentLocation(ValueNotifier<Position> position,
      ValueNotifier<Map<String, Marker>> markers) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    final currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    const decimalPoint = 3;
    if ((position.value.latitude).toStringAsFixed(decimalPoint) !=
            (currentPosition.latitude).toStringAsFixed(decimalPoint) &&
        (position.value.longitude).toStringAsFixed(decimalPoint) !=
            (currentPosition.longitude).toStringAsFixed(decimalPoint)) {
      // 現在地座標にMarkerを立てる
      final marker = Marker(
        markerId: MarkerId(currentPosition.timestamp.toString()),
        position: LatLng(currentPosition.latitude, currentPosition.longitude),
      );
      markers.value.clear();
      markers.value[currentPosition.timestamp.toString()] = marker;
      // 現在地座標のstateを更新する
      position.value = currentPosition;
    }
  }

  Future<void> _animateCamera(ValueNotifier<Position> position) async {
    final mapController = await _mapController.future;
    // 現在地座標が取得できたらカメラを現在地に移動する
    await mapController.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(position.value.latitude, position.value.longitude),
      ),
    );
  }
}
