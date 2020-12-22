part of 'main_cubit.dart';

@immutable
abstract class MainState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeSelected extends MainState {
  final int index;

  HomeSelected({this.index});
  @override
  List<Object> get props => [index];
}

class ClubSelected extends MainState {
  final int index;

  ClubSelected({this.index});
  @override
  List<Object> get props => [index];
}

class HistorySelected extends MainState {
  final int index;

  HistorySelected({this.index});
  @override
  List<Object> get props => [index];
}
