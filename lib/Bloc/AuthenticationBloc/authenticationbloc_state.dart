part of 'authenticationbloc_bloc.dart';

@immutable
abstract class AuthenticationblocState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationblocInitial extends AuthenticationblocState {}

class AuthenticationFail extends AuthenticationblocState {}

class AuthenticationLogedIn extends AuthenticationblocState {
  final User user;
  AuthenticationLogedIn(this.user);

  @override
  List<Object> get props => [user];
}

class LoginState extends AuthenticationFail {}

class SignUpState extends AuthenticationFail {}
