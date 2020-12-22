import 'dart:async';

import 'package:event/database/userDB.dart';
import 'package:event/model/user.dart';
import 'package:event/utils/validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event/Bloc/AuthenticationBloc/authenticationbloc_bloc.dart';
import 'package:event/services/userService.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({this.bloc, this.service}) : super(SignupState.initial());

  final UserService service;
  final AuthenticationblocBloc bloc;

  @override
  Stream<Transition<SignupEvent, SignupState>> transformEvents(
      Stream<SignupEvent> events, transitionFn) {
    final nonDebounceStream = events.where((event) =>
        (event is! SignupEmailChange) || (event is! SignupPasswordChange));

    final deBounceStream = events.where((event) =>
        (event is SignupPasswordChange && event is SignupEmailChange));

    return super.transformEvents(
        nonDebounceStream.mergeWith([deBounceStream]).debounceTime(
            Duration(milliseconds: 100)),
        transitionFn);
  }

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignupEmailChange) {
      yield* _mapSignupEmailChangeToState(event);
    } else if (event is SignupPasswordChange) {
      yield* _mapSignupPasswordChange(event);
    } else if (event is SignupWithCredential) {
      yield* _mapSignupWithCredentialToState(event);
    }
  }

  Stream<SignupState> _mapSignupEmailChangeToState(
      SignupEmailChange event) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(event.email));
  }

  Stream<SignupState> _mapSignupPasswordChange(
      SignupPasswordChange event) async* {
    yield state.update(
        isEmailValid: Validators.isValidPassword(event.password));
  }

  Stream<SignupState> _mapSignupWithCredentialToState(
      SignupWithCredential event) async* {
    yield SignupState.loading();

    try {
      var userRaw = await service.signUp(event.data);
      User user = User.fromJson(userRaw);
      UserDB.loginUser(user, user.token);
      bloc.add(AuthenticationLogin(user));
    } catch (e) {
      print(e.toString());
      yield SignupState.fail();
    }
  }
}
