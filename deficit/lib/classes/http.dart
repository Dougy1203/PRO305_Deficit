import 'dart:convert';

import 'package:deficit/widgets/log_card.dart';
import 'package:deficit/widgets/reusable_log_card.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../classes/constants.dart';

Future<Map<String, dynamic>> post(String domain, String path, String body) async {
  var url = Uri.parse(domain + path);
  var response = await http.post(url, body: body);
  var res = jsonDecode(response.body);
  Map<String,dynamic> returnMap = {};
  returnMap['statusCode'] = res['statusCode'];
  returnMap['body'] = res['body'];
  return returnMap;
}

Future<Map<String, dynamic>> put(String domain, String path, String body) async {
  var url = Uri.parse(domain + path);
  var response = await http.put(url, body: body);
  var res = jsonDecode(response.body);
  Map<String,dynamic> returnMap = {};
  returnMap['statusCode'] = res['statusCode'];
  returnMap['body'] = res['body'];
  return returnMap;
}

Future<Map<String, dynamic>> delete(String domain, String path, String body) async {
  var url = Uri.parse(domain + path);
  var response = await http.delete(url, body: body);
  var res = jsonDecode(response.body);
  Map<String,dynamic> returnMap = {};
  returnMap['statusCode'] = res['statusCode'];
  returnMap['body'] = res['body'];
  return returnMap;
}

Future<Map<String, dynamic>> get(String domain, String path) async {
  var url = Uri.parse(domain + path);
  var response = await http.get(url);
  var res = jsonDecode(response.body);
  Map<String,dynamic> returnMap = {};
  returnMap['statusCode'] = res['statusCode'];
  returnMap['body'] = res['body'];
  return returnMap;
}


Future<List<Widget>> futureLogs(String email, String password) async {
  List<Widget> widgets = [];
  try {
    Map<String,dynamic> request = {};
    request['email'] = email;
    request['password'] = password;
    Map<String,dynamic> requestBody = {};
    requestBody['body'] = request;
    dynamic response = await post(kDomain, 'logs', json.encode(requestBody));
    response.forEach((element)=>{
      widgets.add(ReusableLogCard(color: kPrimaryColor, cardChild: logs(element), onPress: (){}))
    });
    // widget.files.forEach((k, v) => widgets.add(PDFNetwork(title: k, uri: v)));
    // for (String s in widget.modules) {
    //   if (s.isNotEmpty) {
    //     widgets.add(Module(modName: s));
    //   }
    // }
    return widgets;
  } catch (e) {
    return widgets;
  }
}