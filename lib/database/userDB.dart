import 'package:event/model/club.dart';
import 'package:event/model/event.dart';
import 'package:event/model/user.dart';
import 'package:hive/hive.dart';

class UserDB {
  static bool chechLogin() {
    final Box user = Hive.box("user");

    if (user.get("login") == null) {
      return false;
    }

    return true;
  }

  static loginUser(User log, String token) async {
    final Box user = Hive.box("user");

    await user.put("login", log);
    await user.put("club", log.club);
    await user.put("token", token);
    return;
  }

  static Club getClub() {
    final Box club = Hive.box("user");
    return club.get("club") as Club;
  }

  static Future<bool> removeUser() async {
    final Box user = Hive.box("user");
    await user.delete("login");
    await user.delete("club");
    await user.delete("token");
    return true;
  }

  static User getUser() {
    final Box user = Hive.box("user");

    return user.get("login") as User;
  }

  static Future<void> logoutUser() async {
    final Box user = Hive.box("user");
    final Box events = Hive.box("Events");
    await user.deleteAll(["login", "token", "club"]);
    await events.deleteAll(events.keys);
  }

  static List<Event> getUserRegisteredEvents() {
    final Box events = Hive.box("Events");
  }

  static Future<List<Event>> addUserRegisteredEvents(
      List<Event> registred) async {
    final Box events = Hive.box("Events");
  }
}
