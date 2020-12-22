import 'dart:async';

import 'package:event/Bloc/AuthenticationBloc/authenticationbloc_bloc.dart';
import 'package:event/database/userDB.dart';
import 'package:event/model/user.dart';

import 'package:event/services/userService.dart';

import 'package:event/utils/validator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'loginbloc_event.dart';
part 'loginbloc_state.dart';

class LoginblocBloc extends Bloc<LoginblocEvent, LoginblocState> {
  LoginblocBloc({@required this.loginService, @required this.bloc})
      : super(LoginblocState.initial());

  final UserService loginService;
  final AuthenticationblocBloc bloc;

  @override
  Stream<Transition<LoginblocEvent, LoginblocState>> transformEvents(
      Stream<LoginblocEvent> events, transitionFn) {
    final nonDebounceStream = events.where((event) =>
        (event is! LoginEmailChange) || (event is! LoginPasswordChange));

    final deBounceStream = events.where(
        (event) => (event is LoginPasswordChange && event is LoginEmailChange));

    return super.transformEvents(
        nonDebounceStream.mergeWith([deBounceStream]).debounceTime(
            Duration(milliseconds: 100)),
        transitionFn);
  }

  @override
  Stream<LoginblocState> mapEventToState(
    LoginblocEvent event,
  ) async* {
    if (event is LoginEmailChange) {
      yield* _mapLoginEmailChangeToState(event);
    } else if (event is LoginPasswordChange) {
      yield* _mapLoginPasswordChamgeToState(event);
    } else if (event is LoginWithCredential) {
      yield* _mapLoginWithCredentialToState(event);
    }
  }

  Stream<LoginblocState> _mapLoginEmailChangeToState(
      LoginEmailChange event) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(event.email));
  }

  Stream<LoginblocState> _mapLoginPasswordChamgeToState(
      LoginPasswordChange event) async* {
    yield state.update(
        isPasswordValid: Validators.isValidPassword(event.password));
  }

  Stream<LoginblocState> _mapLoginWithCredentialToState(
      LoginWithCredential event) async* {
    yield LoginblocState.loading();
    try {
      var user = await loginService.login(event.email, event.password);
      User use = User.fromJson(user);
      UserDB.loginUser(use, use.token);
      bloc.add(AuthenticationLogin(use));
    } catch (e) {
      print("error" + e.toString());

      yield LoginblocState.fail();
    }
  }
}
