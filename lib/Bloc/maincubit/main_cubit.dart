import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(HomeSelected(index: 0));

  StreamController<int> controller = StreamController<int>.broadcast();
  Stream<int> get selected => controller.stream.asBroadcastStream();

  final List<MainState> paths = [
    HomeSelected(index: 0),
    ClubSelected(index: 1),
    HistorySelected(index: 2),
  ];

  void changePage(int index) {
    controller.add(index);
    emit(paths[index]);
  }
}
