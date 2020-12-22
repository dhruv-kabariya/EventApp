import 'dart:convert';

import 'package:event/services/apiCall.dart';

class TakeAttendance {
  CallApi callApi = CallApi();
  static final String url = 'event/userattend/';

  takeAttendace(int userId, int eventId) async {
    Map<String, dynamic> body = {
      "user": userId,
      "event": eventId,
      "attend": true
    };

    var res = await callApi.callPost(url, jsonEncode(body));
    var resBody = jsonDecode(res);
    print(resBody);
  }
}
