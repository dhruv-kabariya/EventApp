import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event/database/userDB.dart';
import 'package:event/model/otherUser.dart';
import 'package:event/services/RegisterService.dart';

import 'package:meta/meta.dart';

part 'otheruser_state.dart';

class OtheruserCubit extends Cubit<OtheruserState> {
  OtheruserCubit() : super(OtheruserInitial());

  GetRegisterdUser servise = GetRegisterdUser();

  Future<void> getOtherUser(int id) async {
    emit(FetchingOtherUser());

    emit(FetchedOtherUser(users: await servise.getRegistedList(id)));
  }

  Future<void> register({int id, List<OtherUser> userList}) async {
    final List<OtherUser> users = userList;

    emit(RegisteringUser());
    users.add(await servise.registered(id, UserDB.getUser().id));

    emit(FetchedOtherUser(users: users));
  }
}
