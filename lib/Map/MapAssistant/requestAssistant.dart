import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestAssistant {
  static Future<dynamic> getRequest(Uri request) async {
    // var uri = Uri(host: url);
    http.Response response = await http.get(request);

    try {
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var decodeData = jsonDecode(jsonData);
        return decodeData;
      } else {
        return "Failed";
      }
    } catch (exp) {
      return "Failed";
    }
  }
}
