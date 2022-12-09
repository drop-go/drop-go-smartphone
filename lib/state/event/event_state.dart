import 'package:drop_go_smartphone/model/event/event_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_state.freezed.dart';

@freezed
class EventState with _$EventState {
  const factory EventState({
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
    @Default(<EventModel>[]) List<EventModel> eventList,
  }) = _EventState;
}
