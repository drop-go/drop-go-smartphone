import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:drop_go_smartphone/model/event/event_model.dart';

final eventRepositoryProvider = Provider.autoDispose<EventRepository>(
  (ref) => EventRepositoryImpl(),
);

abstract class EventRepository {
  Future<List<EventModel>> fetchAll();
  Future<EventModel> fetchEvent();
}

class EventRepositoryImpl implements EventRepository {
  final String baseUrl = 'https://public.drop-go-api.xyz';

  @override
  Future<List<EventModel>> fetchAll() async {
    List<EventModel> events = [];
    final url = Uri.parse("$baseUrl/event");

    final res = await http.get(url);

    if (res.statusCode != 200) {
      return events;
    }

    final List eventMap = jsonDecode(utf8.decode(res.bodyBytes));
    for (var event in eventMap) {
      events.add(EventModel.fromJson(event));
    }

    return events;
  }

  @override
  Future<EventModel> fetchEvent() {
    // TODO: implement fetchEvent
    throw UnimplementedError();
  }
}
