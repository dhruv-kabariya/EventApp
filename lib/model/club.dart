import 'package:event/services/apiCall.dart';
import 'package:hive/hive.dart';

part 'club.g.dart';

@HiveType(typeId: 2)
class Club {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;
  @HiveField(2)
  String poster;
  @HiveField(3)
  String description;

  Club({this.id, this.name, this.description, this.poster});

  Club.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    poster = json["logo"];
    description = json["description"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["poster"] = this.poster;
    data["description"] = this.description;

    return data;
  }
}
