import 'package:event/model/club.dart';
import 'package:event/services/apiCall.dart';
import 'package:hive/hive.dart';

import 'club.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String avtar;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final DateTime dob;
  @HiveField(6)
  final bool memberShip;
  @HiveField(7)
  Club club;
  @HiveField(8)
  String position;
  @HiveField(9)
  final String token;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.avtar,
      this.club,
      this.dob,
      this.email,
      this.position,
      this.memberShip,
      this.token,
      userClub,
      userPosition}) {
    this.club = userClub;
    this.position = userPosition;
  }

  static User fromJson(Map<String, dynamic> json) {
    final bool memberShip = json["club"];
    Club club;
    String position;
    if (memberShip == true) {
      club = Club.fromJson(json["membership"]["club"]);
      position = json["membership"]["position"];
    }

    return User(
        id: json['id'],
        token: json["token"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avtar: json["avtar"] == null ? null : json["avtar"],
        email: json["email"],
        dob: DateTime.now(),
        memberShip: memberShip,
        userClub: club,
        userPosition: position);
  }

  Map<String, String> toJson(
    int id,
    String first_name,
    String last_name,
    String email,
    String avtar,
  ) {
    Map<String, dynamic> data = Map<String, String>();
    data["id"] = id;
    data["first_name"] = first_name;
    data["last_name"] = last_name;
    data["email"] = email;
    data["avtar"] = avtar;

    return data;
  }
}
