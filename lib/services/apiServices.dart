import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssinfra/services/apiEndPoint.dart';

class ApiServices {
  Future getData({String? url}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = await prefs.getString("tokenValue");
    var res = await http.get(
      Uri.parse("${ApiEndPoint.endPoint}$url"),
      headers: {
        "Accept": "application/json",
        'Authorization': "Bearer $apiToken",
      },
    );
    return res.body;
  }

  Future postData({String? url, dynamic data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiToken = await prefs.getString("tokenValue");
    var res = await http.post(
      Uri.parse("${ApiEndPoint.endPoint}$url"),
      body: data,
      headers: {
        "Accept": "application/json",
        'Authorization': "Bearer $apiToken",
      },
    );
    return res.body;
  }
}
