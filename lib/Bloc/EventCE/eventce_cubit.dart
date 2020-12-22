import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event/model/event.dart';
import 'package:event/services/EventService.dart';
import 'package:meta/meta.dart';

part 'eventce_state.dart';

class EventceCubit extends Cubit<EventceState> {
  EventceCubit() : super(EventceInitial());

  EventService service = EventService();

  void create(Map<String, dynamic> data) async {
    emit(CreatingEvent());

    emit(CreatedEvent(event: await service.createEvent(data)));
  }

  void update(Map<String, dynamic> data) async {
    emit(UpdatingEvent());

    emit(UpdatedEvent(event: await service.editEvent(data)));
  }
}
