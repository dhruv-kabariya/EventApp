part of 'authenticationbloc_bloc.dart';

@immutable
abstract class AuthenticationblocEvent extends Equatable {
  const AuthenticationblocEvent();
  @override
  List<Object> get props => [];
}

class CheckAuthentication extends AuthenticationblocEvent {}

class AuthenticationLogin extends AuthenticationblocEvent {
  final User user;
  const AuthenticationLogin(this.user);
  @override
  List<Object> get props => [user];
}

class AuthenticationLoginPage extends AuthenticationblocEvent {}

class AuthenticationSignUpPage extends AuthenticationblocEvent {}

class AuthenticationLogout extends AuthenticationblocEvent {}
