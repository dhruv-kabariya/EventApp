import 'dart:convert';

import 'package:event/model/otherUser.dart';
import 'package:event/services/apiCall.dart';

class GetRegisterdUser {
  CallApi callApi = CallApi();

  getRegistedList(int evnetId) async {
    final String url = 'event/registerList/';

    String sentUrl = url + evnetId.toString() + "/";

    var res = await callApi.callGet(sentUrl);
    List<dynamic> users = jsonDecode(res);

    return users.map((element) {
      return OtherUser.fromJson(element);
    }).toList();
  }

  Future<OtherUser> registered(int eventId, int userId) async {
    final url = "event/eventregister/";
    Map<String, dynamic> body = {"event": eventId, "user_id": userId};
    var res = await callApi.callPost(url, jsonEncode(body));
    var resBody = jsonDecode(res);
    return OtherUser.fromJson(resBody);
  }
}
