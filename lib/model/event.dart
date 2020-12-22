import 'package:event/database/clubDB.dart';
import 'package:event/model/club.dart';
import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 3)
class Event extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String poster;
  @HiveField(3)
  DateTime date;
  @HiveField(4)
  String decsription;
  @HiveField(5)
  String spokePerson;
  @HiveField(6)
  String venue;
  @HiveField(7)
  String link;
  @HiveField(8)
  Club club;

  Event(
      {this.id,
      this.name,
      this.poster,
      this.club,
      this.date,
      this.decsription,
      this.link,
      this.spokePerson,
      this.venue});

  Event.make(Map<String, dynamic> event) {
    id = event["id"];
    name = event["name"];
    poster = event["poster"];
    decsription = event["Description"];
    date = event["timeDate"];
    spokePerson = event["SpokePerson"];
    venue = event["venue"];
    link = event["formLink"];
    club = event["club"];
  }

  Event.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    poster = json["poster"] == null ? null : json["poster"];
    decsription = json["Description"] == null ? "None" : json["Description"];
    date = DateTime.parse(json["timeDate"]);
    spokePerson = json["SpokePerson"] == null ? "None" : json["SpokePerson"];
    venue = json["venue"];
    link = json["formLink"] == null ? "None" : json["formLink"];
    club = ClubDB.getClub(json["club"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data["id"] = this.id;
    }
    data['name'] = this.name;
    data['formLink'] = this.link;
    data['timeDate'] = this.date.toUtc().toString();
    data['Description'] = this.decsription;
    if (poster != null) {
      data['poster'] = this.poster;
    }
    data['SpokePerson'] = this.spokePerson;
    data["venue"] = this.venue;
    data["club"] = this.club.toJson();
    return data;
  }
}
