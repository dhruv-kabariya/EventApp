part of 'otheruser_cubit.dart';

@immutable
abstract class OtheruserState extends Equatable {
  @override
  List<Object> get props => [];
}

class OtheruserInitial extends OtheruserState {}

class FetchingOtherUser extends OtheruserState {}

class FetchedOtherUser extends OtheruserState {
  final List<OtherUser> users;
  bool containe = false;

  FetchedOtherUser({this.users}) {
    for (int j = 0; j < users.length; j++) {
      if (users[j].id == UserDB.getUser().id) {
        containe = true;
      }
    }
  }
  @override
  List<Object> get props => [users];
}

class RegisteringUser extends OtheruserState {}

class RegistrationFail extends OtheruserState {}
