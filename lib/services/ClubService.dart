import 'dart:convert';

import 'package:event/model/club.dart';
import 'package:event/services/apiCall.dart';
import 'package:flutter/material.dart';

class ClubServices with ChangeNotifier {
  CallApi callApi = CallApi();
  static final String url = 'user/clubList/';

  getClubList() async {
    var res = await callApi.callGet(url);
    var body = jsonDecode(res) as List;

    return body.map((e) => Club.fromJson(e)).toList();
  }
}
