import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'homebloc_event.dart';
part 'homebloc_state.dart';

class HomeblocBloc extends Bloc<HomeblocEvent, HomeblocState> {
  HomeblocBloc() : super(HomeblocInitial());

  @override
  Stream<HomeblocState> mapEventToState(
    HomeblocEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
