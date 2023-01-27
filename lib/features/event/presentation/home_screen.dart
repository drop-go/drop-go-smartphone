// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:animations/animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:drop_go_smartphone/common_widgets/common_loading.dart';
import 'package:drop_go_smartphone/features/event/model/event_model.dart';
import 'package:drop_go_smartphone/features/map/presentation/map_screen.dart';
import 'package:drop_go_smartphone/features/providers.dart';
import 'package:drop_go_smartphone/features/saved_file/presentation/savefile_list_screen.dart';
import 'package:drop_go_smartphone/main.dart';
import 'package:drop_go_smartphone/utils/unix_time_formatter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eventViewModelProvider);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        floatingActionButton: OpenContainer(
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          closedElevation: 0,
          transitionType: ContainerTransitionType.fadeThrough,
          transitionDuration: const Duration(milliseconds: 500),
          closedBuilder: (context, action) {
            return FloatingActionButton.extended(
              backgroundColor: const Color(0xFF4069FF),
              onPressed: action,
              icon: const Icon(Icons.file_copy),
              label: const Text('保存したアイテム'),
            );
          },
          openBuilder: (context, action) {
            return const SavefileListScreen();
          },
        ),
        body: SafeArea(
          bottom: false,
          child: Center(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Container(
                            height: 1,
                            width: 15,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 7),
                          const Text(
                            'おすすめのイベント',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 247,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.eventList.length,
                          itemBuilder: (context, index) {
                            if (index < 3) {
                              return EventPanelHoriz(
                                num: index,
                                list: state.eventList,
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Container(
                            height: 1,
                            width: 15,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 7),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: const Text(
                              'すべてのイベント',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.eventList.length,
                        itemBuilder: (context, index) {
                          if (index == 0 || index == 1 || index == 2) {
                            return Container();
                          } else {
                            return EventPanel(
                              num: index,
                              list: state.eventList,
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
                CommonLoading(visible: state.isLoading),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventPanelHoriz extends StatelessWidget {
  const EventPanelHoriz(
      {super.key, required int num, required List<EventModel> list})
      : eventList = list,
        index = num;

  final int index;
  final List<EventModel> eventList;

  @override
  Widget build(BuildContext context) {
    final startDate = unixToDate(eventList[index].startDate);
    final endDate = unixToDate(eventList[index].endDate);

    var imageUrl = eventList[index].imageUrl;
    if (imageUrl == '') {
      imageUrl =
          'https://thumb.ac-illust.com/53/53a1735dbeb06d68b83eb2ca7ee30642_t.jpeg';
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 12,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () async {
              final pref = await SharedPreferences.getInstance();
              await pref.setString('selectedEventId', eventList[index].id);

              Navigator.of(navigatorKey.currentContext!).push(
                MapScreen.route(eventList[index].id),
              );
            },
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          eventList[index].address,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          eventList[index].title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 6,
                        ),
                        child: Text(
                          eventList[index].description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          '$startDate ~ $endDate',
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventPanel extends StatelessWidget {
  const EventPanel(
      {super.key, required int num, required List<EventModel> list})
      : eventList = list,
        index = num;

  final int index;
  final List<EventModel> eventList;

  @override
  Widget build(BuildContext context) {
    final startDate = unixToDate(eventList[index].startDate);
    final endDate = unixToDate(eventList[index].endDate);

    var imageUrl = eventList[index].imageUrl;
    if (imageUrl == '') {
      imageUrl =
          'https://thumb.ac-illust.com/53/53a1735dbeb06d68b83eb2ca7ee30642_t.jpeg';
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 12,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () async {
              final pref = await SharedPreferences.getInstance();
              await pref.setString('selectedEventId', eventList[index].id);

              Navigator.of(navigatorKey.currentContext!).push(
                MapScreen.route(eventList[index].id),
              );
            },
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 135,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          eventList[index].address,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          eventList[index].title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child: Text(
                          eventList[index].description,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          '$startDate ~ $endDate',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
