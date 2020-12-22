part of 'eventbloc_bloc.dart';

@immutable
abstract class EventblocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchEvents extends EventblocEvent {}

class FetchMoreEvents extends EventblocEvent {}
