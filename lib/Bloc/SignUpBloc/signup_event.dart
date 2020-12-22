part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupEmailChange extends SignupEvent {
  final String email;
  const SignupEmailChange({this.email});

  @override
  List<Object> get props => [email];
}

class SignupPasswordChange extends SignupEvent {
  final String password;
  const SignupPasswordChange({this.password});

  @override
  List<Object> get props => [password];
}

class SignupWithCredential extends SignupEvent {
  final Map<String, dynamic> data;
  const SignupWithCredential({this.data});

  @override
  List<Object> get props => [data];

  @override
  String toString() {
    return 'SignupWithCredential with ${data["email"]} ';
  }
}
