import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event/database/eventDB.dart';
import 'package:event/model/event.dart';
import 'package:event/services/EventService.dart';

import 'package:meta/meta.dart';

part 'eventbloc_event.dart';
part 'eventbloc_state.dart';

class EventblocBloc extends Bloc<EventblocEvent, EventblocState> {
  EventblocBloc() : super(EventblocInitial());

  EventService service = EventService();
  EventDB db = EventDB();

  @override
  Stream<EventblocState> mapEventToState(
    EventblocEvent event,
  ) async* {
    if (event is FetchEvents) {
      yield* _mapFetchEventToState();
    }
  }

  Stream<EventblocState> _mapFetchEventToState() async* {
    yield EventFetching();

    List<Event> eventList = await service.getEvents();

    await db.addAllEvent(eventList);
    yield EventFetched(events: eventList);
  }
}
