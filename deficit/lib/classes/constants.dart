import 'dart:convert';

import 'package:flutter/material.dart';

import '../widgets/log_card.dart';
import 'http.dart';

String kDomain = "https://ddytbwzh1c.execute-api.us-east-1.amazonaws.com/pro/";

const kBottomContainerHeight = 80.0;
const kBmiPrimary = Color(0xFF0A0E21);
const kActiveCardColor = Color(0xFF1D1E33);
const kInactiveCardColor = Color(0xFF111328);
const kBackgroundColor = Color(0xFFD6D6B1);
const kPrimaryColor = Color(0xFF7C9875);
const kSecondaryColor = Color(0xFF0A2342);
const kTertiaryColor = Color(0xFF96BE8C);
const kSuggestiveText = Colors.white;

const kDateTextStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.w900,
);
const kCardTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);
const kLabelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF8D8E98),
);
const kContainerText = TextStyle(
  fontSize: 20.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);
const kLogText = TextStyle(
  fontSize: 20.0,
  color: kPrimaryColor,
  fontWeight: FontWeight.bold,
);
const kTitleTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 40,
  letterSpacing: 2.0,
);
const kResultTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 22.0,
  letterSpacing: 2.0,
  color: kSecondaryColor,
);
const kBMITextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 100.0,
);
const kBodyTextStyle = TextStyle(
  fontSize: 22.0,
);

Widget kColumnSpace(double space){
  return SizedBox(
  height: space,
  );
}
Widget kRowSpace(double space){
  return SizedBox(
    width: space,
  );
}

Future<Map<String,dynamic>> kDeleteLog(String email, String pass, String date)async{
  Map<String,dynamic> log = {};
  log['email'] = email;
  log['password'] = pass;
  log['date'] = date;
  Map<String,dynamic> request = {};
  request['body'] = log;
  var response = await delete(kDomain, 'log', json.encode(request));
  return response;
}

Future<Map<String,dynamic>> kAddLog(int calories, int carbs, int protein, int fat, String date, String email, String pass)async{
  Map<String, dynamic> log = {};
  log['calories'] = calories;
  log['carb'] = carbs;
  log['protein'] = protein;
  log['fat'] = fat;
  log['date'] = date;

  Map<String, dynamic> requestBody = {};
  requestBody['email'] = email;
  requestBody['password'] = pass;
  requestBody['log'] = log;

  var request = <String, dynamic>{};
  request['body'] = requestBody;
  var response = await post(kDomain, 'log', json.encode(request));
  return response;
}

Future<List<Widget>> kLogRead(String email, String password) async {
  Map<String, dynamic> log = {};
  Map<String, dynamic> requestBody = {};
  log = {};
  log['email'] = email;
  log['password'] = password;
  requestBody = {};
  requestBody['body'] = log;
  var response =
      await post(kDomain, "logs", json.encode(requestBody));
  var body = json.decode(response['body']);
  log = (body['message'][0]);
  List<dynamic> b = body['message'];
  List<Map<String, dynamic>> userLogs =
  <Map<String, dynamic>>[];
  for (var c in b) {
    userLogs.add(c);
  }
  List<Widget> widgets = futureLogs(userLogs);
  return widgets;
}