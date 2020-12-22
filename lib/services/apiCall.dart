import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class CallApi {
  static String basicApiUrl =
      "http://backend-test1.us-west-2.elasticbeanstalk.com/api/";
  static String basicUrl =
      "http://backend-test1.us-west-2.elasticbeanstalk.com/";

  getHeader() {
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final Box user = Hive.box("user");
    String token = user.get("token");
    if (token != null) {
      header["Authorization"] = "Token $token";
    }

    return header;
  }

  callGet(String reqUrl) async {
    String url = basicApiUrl + reqUrl;
    http.Response reponse = await http.get(url, headers: getHeader());

    try {
      if (reponse.statusCode >= 200 && reponse.statusCode < 400) {
        return reponse.body;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> callPost(String reqUrl, dynamic body) async {
    String url = basicApiUrl + reqUrl;
    http.Response response = await http.post(
      url,
      headers: getHeader(),
      body: body,
    );

    if (response.statusCode >= 200 && response.statusCode < 400) {
      return response.body;
    }
  }
}
