import 'dart:async';

import 'package:animations/animations.dart';
import 'package:drop_go_smartphone/model/item/item_model.dart';
import 'package:drop_go_smartphone/providers.dart';
import 'package:drop_go_smartphone/view/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
            MapView(id: eventId),
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
  MapView({super.key, required String id}) : eventId = id;

  final String eventId;
  final Completer<GoogleMapController> _mapController = Completer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(mapViewModelProvider);

    List<Marker> markerList = [];
    final position = state.position;

    _animateCamera(position);

    return Scaffold(
      body: FutureBuilder(
        future: ref.read(mapViewModelProvider.notifier).getItems(eventId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 非同期処理未完了 = 通信中
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasData) {
            markerList = _createMarkers(snapshot.data!, context);
          }

          return GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: false,
            initialCameraPosition: const CameraPosition(
              target: LatLng(34.700037, 135.493057),
              zoom: 16.4746,
            ),
            onMapCreated: (GoogleMapController controller) {
              if (_mapController.isCompleted) {
                _mapController.complete(controller);
              }
            },
            // markers: markers.values.toSet(),
            myLocationEnabled: true,
            markers: markerList.toSet(),
          );
        },
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

  List<Marker> _createMarkers(List<ItemModel> itemList, BuildContext context) {
    List<Marker> markerList = [];
    for (var item in itemList) {
      final marker = Marker(
        markerId: MarkerId(item.id),
        position: LatLng(
          double.parse(item.latitude),
          double.parse(item.longitude),
        ),
        onTap: () => showDialog(
          context: context,
          builder: (context) => MarkerDialog(itemModel: item),
        ),
      );
      markerList.add(marker);
    }
    return markerList;
  }
}

class MarkerDialog extends StatefulWidget {
  const MarkerDialog({super.key, required ItemModel itemModel})
      : item = itemModel;
  final ItemModel item;

  @override
  State<MarkerDialog> createState() => _MarkerDialogState(item);
}

class _MarkerDialogState extends State<MarkerDialog> {
  _MarkerDialogState(this.item);
  bool _flag = false;
  final ItemModel item;

  void _handleDownload() {
    setState(() {
      _flag = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_flag) {
      return const AlertDialog(
        title: Text('ダウンロード完了'),
        content: SizedBox(
          height: 90,
          child: Text('ダウンロードが完了しました！'),
        ),
      );
    } else {
      return AlertDialog(
        title: Text(item.title),
        content: Text(item.description),
        actions: [
          ElevatedButton(
              onPressed: () => _handleDownload(), child: const Text('ダウンロード')),
        ],
      );
    }
  }
}
