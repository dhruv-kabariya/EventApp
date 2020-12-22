part of 'eventbloc_bloc.dart';

@immutable
abstract class EventblocState extends Equatable {
  @override
  List<Object> get props => [];
}

class EventblocInitial extends EventblocState {}

class EventFetching extends EventblocState {}

class EventFetched extends EventblocState {
  final List<Event> events;

  EventFetched({@required this.events});
  @override
  List<Object> get props => [events];
}
