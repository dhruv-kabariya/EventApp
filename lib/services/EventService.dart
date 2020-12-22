import 'dart:convert';

import 'package:event/database/eventDB.dart';
import 'package:event/model/event.dart';
import 'package:event/services/apiCall.dart';

class EventService {
  CallApi callApi = CallApi();

  Future<List<Event>> getEvents() async {
    final String url = 'event/events/';

    var res = await callApi.callGet(url);
    var body = jsonDecode(res) as List;

    return body.map((element) {
      return Event.fromJson(element);
    }).toList();
  }

  Future<Event> createEvent(Map<String, dynamic> event) async {
    Event ev;
    final String urlceate = 'event/createevent/';

    String body = jsonEncode(event);

    String response = await callApi.callPost(urlceate, body);
    print(response);
    ev = Event.fromJson(jsonDecode(response));
    await EventDB.addEvent(ev);
    return ev;
  }

  Future<Event> editEvent(Map<String, dynamic> event) async {
    Event ev;
    final String urledit = 'event/updateevent/';
    var body = jsonEncode(event);
    String response = await callApi.callPost(urledit, body);

    print(response);
    ev = Event.fromJson(jsonDecode(response));
    print(ev.name);

    await EventDB.updateEvent(ev);

    return ev;
  }
}
