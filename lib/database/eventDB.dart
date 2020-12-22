import 'package:event/model/event.dart';
import 'package:hive/hive.dart';

class EventDB {
  static List<Event> getEventList() {
    final Box events = Hive.box("Events");

    return events.values.map((e) => e as Event).toList();
  }

  static List<Event> getClubEvent(int clubId) {
    final Box events = Hive.box("Events");

    return events.values
        .map((e) => e as Event)
        .toList()
        .where((e) => e.club.id == clubId)
        .toList();
  }

  static Event getEvent(int id) {
    final Box events = Hive.box("Events");

    return events.get(id) as Event;
  }

  Future<void> addAllEvent(List<Event> eventList) async {
    final Box events = Hive.box("Events");

    for (int i = 0; i < eventList.length; i++) {
      await events.put(eventList[i].id, eventList[i]);
    }
  }

  static Future<int> addEvent(Event event) async {
    final Box events = Hive.box("Events");
    print(event.id);
    await events.put(event.id, event);
    return event.id;
  }

  static Future<int> updateEvent(Event event) async {
    final Box events = Hive.box("Events");
    await events.put(event.id, event);

    return event.id;
  }

  Future<void> updateCach(List<Event> listEvent) async {
    final Box events = Hive.box("Events");

    await events.deleteAll(events.keys);
    for (int i = 0; i < listEvent.length; i++) {
      await events.put(listEvent[i].id, listEvent[i]);
    }
    return;
  }
}
