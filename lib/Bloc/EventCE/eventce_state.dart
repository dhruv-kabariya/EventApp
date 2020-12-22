part of 'eventce_cubit.dart';

@immutable
abstract class EventceState extends Equatable {
  @override
  List<Object> get props => [];
}

class EventceInitial extends EventceState {}

class UpdatingEvent extends EventceState {}

class UpdatedEvent extends EventceState {
  final Event event;

  UpdatedEvent({this.event});
}

class CreatingEvent extends EventceState {}

class CreatedEvent extends EventceState {
  final Event event;

  CreatedEvent({this.event});
}
