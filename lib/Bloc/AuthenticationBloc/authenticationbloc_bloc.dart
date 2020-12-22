import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event/database/userDB.dart';
import 'package:event/services/userService.dart';

import 'package:meta/meta.dart';

import '../../model/user.dart';

part 'authenticationbloc_event.dart';
part 'authenticationbloc_state.dart';

class AuthenticationblocBloc
    extends Bloc<AuthenticationblocEvent, AuthenticationblocState> {
  AuthenticationblocBloc() : super(AuthenticationblocInitial());

  UserDB db = UserDB();
  UserService service = UserService();

  @override
  Stream<AuthenticationblocState> mapEventToState(
    AuthenticationblocEvent event,
  ) async* {
    if (event is CheckAuthentication) {
      yield AuthenticationblocInitial();
      print(UserDB.chechLogin());
      if (UserDB.chechLogin()) {
        yield AuthenticationLogedIn(UserDB.getUser());
      } else {
        yield LoginState();
      }
    }
    if (event is AuthenticationLogin) {
      yield AuthenticationLogedIn(event.user);
    }
    if (event is AuthenticationLogout) {
      try {
        await UserDB.logoutUser();

        await service.logOut();
      } catch (e) {
        print(e.toString());
      }
      yield LoginState();
    }
    if (event is AuthenticationLoginPage) {
      yield LoginState();
    }
    if (event is AuthenticationSignUpPage) {
      yield SignUpState();
    }
  }
}
