part of 'theme_cubit.dart';

@immutable
abstract class ThemeState extends Equatable {
  @override
  List<Object> get props => [];
}

class LightMode extends ThemeState {}

class DarkMode extends ThemeState {}
