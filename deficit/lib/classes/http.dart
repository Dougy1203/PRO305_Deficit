import 'package:http/http.dart' as http;

Future<int> statusCode(String domain, String path, Map<String, String> body) async {
  var url = Uri.https(domain, path);
  var response = await http.post(url, body: body);
  return response.statusCode;
}

Future<String> response(String domain, String path, Map<String, String> body) async {
  var url = Uri.https(domain, path);
  var response = await http.post(url, body: body);
  return response.body;
}