// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:drop_go_smartphone/features/event/model/event_state.dart';
import 'package:drop_go_smartphone/features/event/repository/event_repository.dart';

class EventViewModel extends StateNotifier<EventState> {
  EventViewModel(this.read) : super(const EventState()) {
    _init();
  }

  final read;

  Future<void> _init() async {
    _getEvents();
  }

  Future<void> _getEvents() async {
    final eventRepository = read(eventRepositoryProvider);
    try {
      if (!mounted) {
        return;
      }
      state = state.copyWith(isLoading: true);
      final eventList = await eventRepository.fetchAll();

      if (!mounted) {
        return;
      }
      state = state.copyWith(eventList: eventList);
    } on Exception catch (e) {
      if (!mounted) {
        return;
      }
      state = state.copyWith(errorMessage: e.toString());
    }
    if (!mounted) {
      return;
    }
    state = state.copyWith(isLoading: false);
  }
}
