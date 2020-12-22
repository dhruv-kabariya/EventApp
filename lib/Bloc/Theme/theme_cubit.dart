import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(LightMode());

  void changeTheme() {
    if (state is LightMode) {
      emit(DarkMode());
    } else {
      emit(LightMode());
    }
  }
}
