import 'dart:convert';

import 'package:event/services/apiCall.dart';

class UserService {
  CallApi apiCall = CallApi();

  login(String email, String password) async {
    Map<String, String> body = {"email": email, "password": password};
    final String url = "user/login/";

    var reqBody = jsonEncode(body);
    Map<String, dynamic> resBody =
        jsonDecode(await apiCall.callPost(url, reqBody));
    print(resBody);
    return resBody;
  }

  loginWithGoogle() {}

  resetPassword() async {
    final String url = 'resetpassword/';

    apiCall.callGet(url);
  }

  signUp(body) async {
    String url = "user/signup/";
    print(body);
    var reqBody = jsonEncode(body);
    Map<String, dynamic> resBody =
        jsonDecode(await apiCall.callPost(url, reqBody));
    return resBody;
  }

  signupwithGoogle() {}

  logOut() async {
    final String url = 'user/logout/';

    apiCall.callGet(url).then((_) {});
    return;
  }
}
