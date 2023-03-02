import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> post(String domain, String path, String body) async {
  var url = Uri.parse(domain + path);
  var response = await http.post(url, body: body);
  Map<String,dynamic> returnMap = {};
  returnMap['statusCode'] = response.statusCode;
  returnMap['body'] = response.body;
  return returnMap;
}

Future<Map<String, dynamic>> put(String domain, String path, String body) async {
  var url = Uri.parse(domain + path);
  var response = await http.put(url, body: body);
  Map<String,dynamic> returnMap = {};
  returnMap['statusCode'] = response.statusCode;
  returnMap['body'] = response.body;
  return returnMap;
}

Future<Map<String, dynamic>> delete(String domain, String path, String body) async {
  var url = Uri.parse(domain + path);
  var response = await http.delete(url, body: body);
  Map<String,dynamic> returnMap = {};
  returnMap['statusCode'] = response.statusCode;
  returnMap['body'] = response.body;
  return returnMap;
}

Future<Map<String, dynamic>> get(String domain, String path) async {
  var url = Uri.parse(domain + path);
  var response = await http.get(url);
  Map<String,dynamic> returnMap = {};
  returnMap['statusCode'] = response.statusCode;
  returnMap['body'] = response.body;
  return returnMap;
}