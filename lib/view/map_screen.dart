import 'dart:async';

import 'package:animations/animations.dart';
import 'package:drop_go_smartphone/providers.dart';
import 'package:drop_go_smartphone/view/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => const MapScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                child: OpenContainer(
                  closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  closedElevation: 0,
                  transitionType: ContainerTransitionType.fadeThrough,
                  transitionDuration: const Duration(milliseconds: 500),
                  closedBuilder: (context, action) {
                    return FloatingActionButton(
                      heroTag: "notification",
                      backgroundColor: Colors.white,
                      elevation: 0,
                      onPressed: action,
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.black,
                      ),
                    );
                  },
                  openBuilder: (context, action) {
                    return const NotificationScreen();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapView extends ConsumerWidget {
  MapView({super.key});

  final Completer<GoogleMapController> _mapController = Completer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(positionViewModelProvider);

    final initialMarkers = {
      state.position.timestamp.toString(): Marker(
        markerId: MarkerId(state.position.timestamp.toString()),
        position: LatLng(state.position.latitude, state.position.longitude),
      ),
    };
    final position = state.position;
    final markers = initialMarkers;

    _animateCamera(position);

    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(state.position.latitude, state.position.longitude),
          zoom: 16.4746,
        ),
        onMapCreated: _mapController.complete,
        // markers: markers.values.toSet(),
        myLocationEnabled: true,
      ),
    );
  }

  Future<void> _animateCamera(Position position) async {
    final mapController = await _mapController.future;
    // 現在地座標が取得できたらカメラを現在地に移動する
    await mapController.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(position.latitude, position.longitude),
      ),
    );
  }
}
