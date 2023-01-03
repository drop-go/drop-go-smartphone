// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:drop_go_smartphone/common_widgets/common_loading.dart';
import 'package:drop_go_smartphone/constants/constants.dart' as constants;
import 'package:drop_go_smartphone/features/event/model/event_model.dart';
import 'package:drop_go_smartphone/features/map/presentation/map_screen.dart';
import 'package:drop_go_smartphone/features/providers.dart';
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
        body: SafeArea(
          bottom: false,
          child: Center(
            child: Stack(
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        constants.eventInfo,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.eventList.length,
                        itemBuilder: (context, index) => EventPanel(
                          num: index,
                          list: state.eventList,
                        ),
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

    return Padding(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: () => {
          Navigator.of(context).push(
            MapScreen.route(eventList[index].id),
          ),
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(1, 1),
              ),
            ],
          ),
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
                      padding: const EdgeInsets.symmetric(vertical: 8),
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
    );
  }
}
