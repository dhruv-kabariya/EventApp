part of 'clubbloc_bloc.dart';

@immutable
abstract class ClubblocState {}

class ClubblocInitial extends ClubblocState {}

class GettingClubs extends ClubblocState {}

class ClubFetched extends ClubblocState {}
