part of 'clubbloc_bloc.dart';

@immutable
abstract class ClubblocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchClubs extends ClubblocEvent {}
