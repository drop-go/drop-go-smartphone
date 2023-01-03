// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:animations/animations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

// Project imports:
import 'package:drop_go_smartphone/features/map/model/item_model.dart';
import 'package:drop_go_smartphone/features/map/presentation/notification_screen.dart';
import 'package:drop_go_smartphone/features/providers.dart';
import 'package:drop_go_smartphone/main.dart';

final trackingProvider = StateProvider(
  (ref) => MyLocationTrackingMode.None,
);

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key, required String id})
      : eventId = id,
        super(key: key);

  static Route<dynamic> route(String id) {
    return MaterialPageRoute(
      builder: (_) => MapScreen(id: id),
    );
  }

  final String eventId;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            MapViewPart(id: eventId),
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
            Positioned(
              right: 20,
              top: 90,
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
                      heroTag: "downloaded",
                      backgroundColor: Colors.white,
                      elevation: 0,
                      onPressed: action,
                      child: const Icon(
                        Icons.file_open,
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
            Positioned(
              right: 20,
              bottom: 75,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                child: Consumer(
                  builder: (context, ref, child) {
                    return FloatingActionButton(
                      heroTag: "tracking",
                      elevation: 0,
                      backgroundColor: const Color(0xFF4069FF),
                      onPressed: () => _toggleTracking(ref),
                      child: const Icon(
                        Icons.gps_fixed,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleTracking(WidgetRef ref) {
    if (ref.read(trackingProvider) == MyLocationTrackingMode.Tracking) {
      ref.read(trackingProvider.notifier).state = MyLocationTrackingMode.None;
    } else {
      ref.read(trackingProvider.notifier).state =
          MyLocationTrackingMode.Tracking;
    }
  }
}

class MapViewPart extends ConsumerWidget {
  MapViewPart({super.key, required String id}) : eventId = id;

  final String eventId;

  final Completer<MapboxMapController> _controller = Completer();
  final Map<String, ItemModel> symbolMap = {};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: _getCurrentPosition(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MapboxMap(
            styleString: 'mapbox://styles/gucchan28/clccy8m7q007314l3zqcoftdb',
            initialCameraPosition: CameraPosition(
              target: LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
              zoom: 15.5,
            ),
            onMapCreated: (MapboxMapController controller) {
              _controller.complete(controller);
              _controller.future.then((mapboxMap) {
                mapboxMap.onSymbolTapped.add(
                  (symbol) => _onSymbolTap(symbol, ref),
                );
              });
            },
            onStyleLoadedCallback: () => _addSymbol(ref),
            myLocationEnabled: true,
            myLocationTrackingMode: ref.watch(trackingProvider),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }

  Future<Position> _getCurrentPosition() async {
    final currentPosition =
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return currentPosition;
  }

  void _onSymbolTap(Symbol symbol, WidgetRef ref) async {
    final tappedSymbolItem = symbolMap[symbol.id]!;
    void Function()? onPressed = () async {
      EasyLoading.show(
        status: 'ダウンロード中',
        dismissOnTap: false,
      );
      await ref
          .read(mapViewModelProvider.notifier)
          .downloadItem(eventId, tappedSymbolItem.id);
      EasyLoading.showSuccess('完了しました');
      Future.delayed(const Duration(milliseconds: 2000), () {
        Navigator.of(navigatorKey.currentContext!).pop();
      });
    };

    final currentPotision = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final distance = Geolocator.distanceBetween(
      currentPotision.latitude,
      currentPotision.longitude,
      double.parse(tappedSymbolItem.latitude),
      double.parse(tappedSymbolItem.longitude),
    );

    if (tappedSymbolItem.radius * 2 < distance) {
      onPressed = null;
    }

    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(tappedSymbolItem.title),
        content: Text(tappedSymbolItem.description),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                '閉じる',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4069FF),
            ),
            child: const Text('ダウンロード'),
          ),
        ],
      ),
    );
  }

  Future<void> _addSymbol(WidgetRef ref) async {
    final List<ItemModel> itemList =
        await ref.read(mapViewModelProvider.notifier).getItems(eventId);
    List<SymbolOptions> symbolOptions = [];

    for (var item in itemList) {
      symbolOptions.add(
        SymbolOptions(
          geometry: LatLng(
            double.parse(item.latitude),
            double.parse(item.longitude),
          ),
          iconImage: 'mapbox-marker-icon-gray',
        ),
      );
    }

    _controller.future.then((mapboxMap) async {
      final symbols = await mapboxMap.addSymbols(symbolOptions);

      for (var i = 0; i < symbols.length; i++) {
        symbolMap[symbols[i].id] = itemList[i];
      }
    });
  }
}
