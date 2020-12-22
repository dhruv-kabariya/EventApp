part of 'loginbloc_bloc.dart';

@immutable
abstract class LoginblocEvent extends Equatable {
  const LoginblocEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChange extends LoginblocEvent {
  final String email;
  const LoginEmailChange({this.email});

  @override
  List<Object> get props => [email];
}

class LoginPasswordChange extends LoginblocEvent {
  final String password;
  const LoginPasswordChange({this.password});

  @override
  List<Object> get props => [password];
}

class LoginWithCredential extends LoginblocEvent {
  final String email;
  final String password;
  const LoginWithCredential({this.email, this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'LoginWithCredential with $email ';
  }
}
