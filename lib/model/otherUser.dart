import 'package:event/services/apiCall.dart';

class OtherUser {
  String avtar;
  String first_name;
  String last_name;
  int id;

  OtherUser();

  OtherUser.fromJson(Map<String, dynamic> json) {
    id = json["name"]["id"];
    avtar = json["name"]["avtar"] == null ? null : json["name"]["avtar"];
    first_name = json["name"]["first_name"];
    last_name = json["name"]["last_name"];
  }
}
