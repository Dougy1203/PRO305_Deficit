import 'dart:convert';
import 'package:flutter/material.dart';
import '../classes/http.dart';
import '../classes/rsa_encryption.dart';
import '../widgets/bottom_button.dart';
import '../classes/constants.dart';
import '../widgets/main_image.dart';
import '../widgets/reusable_card.dart';
import 'logs_page.dart';

class InputPage extends StatefulWidget {
  InputPage({super.key, required this.email, required this.pass});
  String email;
  String pass;

  @override
  InputPageState createState() => InputPageState();
}

class InputPageState extends State<InputPage> {
  int calories = 200;
  int protein = 20;
  int carbs = 20;
  int fat = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: MainImage('assets/logo_complete.png', 15.0, 200.0, 200.0),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ReusableCard(
                color: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('PROTEIN', style: kLabelTextStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          protein.toString(),
                          style: kCardTextStyle,
                        ),
                        const Text(
                          'g',
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 25.0),
                        activeTrackColor: Colors.white,
                        thumbColor: kTertiaryColor,
                        overlayColor: const Color(0x29EB1555),
                      ),
                      child: Slider(
                        value: protein.toDouble(),
                        inactiveColor: const Color(0xFF8D8E98),
                        onChanged: (double newValue) {
                          setState(() {
                            protein = newValue.round();
                          });
                        },
                        min: 0.0,
                        max: 120,
                      ),
                    ),
                  ],
                ), onPress: () {  },
              ),
              ReusableCard(
                color: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('CARBS', style: kLabelTextStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          carbs.toString(),
                          style: kCardTextStyle,
                        ),
                        const Text(
                          'g',
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 25.0),
                        activeTrackColor: Colors.white,
                        thumbColor: kTertiaryColor,
                        overlayColor: const Color(0x29EB1555),
                      ),
                      child: Slider(
                        value: carbs.toDouble(),
                        inactiveColor: const Color(0xFF8D8E98),
                        onChanged: (double newValue) {
                          setState(() {
                            carbs = newValue.round();
                          });
                        },
                        min: 0.0,
                        max: 120,
                      ),
                    ),
                  ],
                ), onPress: () {  },
              ),
              ReusableCard(
                color: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('FAT', style: kLabelTextStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          fat.toString(),
                          style: kCardTextStyle,
                        ),
                        const Text(
                          'g',
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 25.0),
                        activeTrackColor: Colors.white,
                        thumbColor: kTertiaryColor,
                        overlayColor: const Color(0x29EB1555),
                      ),
                      child: Slider(
                        value: fat.toDouble(),
                        inactiveColor: const Color(0xFF8D8E98),
                        onChanged: (double newValue) {
                          setState(() {
                            fat = newValue.round();
                          });
                        },
                        min: 0.0,
                        max: 120,
                      ),
                    ),
                  ],
                ), onPress: () {  },
              ),
              ReusableCard(
                color: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('CALORIES', style: kLabelTextStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          calories.toString(),
                          style: kCardTextStyle,
                        ),
                        const Text(
                          '',
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 25.0),
                        activeTrackColor: Colors.white,
                        thumbColor: kTertiaryColor,
                        overlayColor: const Color(0x29EB1555),
                      ),
                      child: Slider(
                        value: calories.toDouble(),
                        inactiveColor: const Color(0xFF8D8E98),
                        onChanged: (double newValue) {
                          setState(() {
                            calories = newValue.round();
                          });
                        },
                        min: 0.0,
                        max: 2000,
                      ),
                    ),
                  ],
                ), onPress: () {  },
              ),
              BottomButton(
                onTap: () async {
                  Map<String,dynamic> log = {};
                  log['calories'] = calories;
                  log['carb'] = carbs;
                  log['protein'] = protein;
                  log['fat'] = fat;
                  log['date'] = "2/20/24";

                      Map<String,dynamic> requestBody = {};
                      requestBody['email'] = widget.email;
                      requestBody['password'] = widget.pass;
                      requestBody['log'] = log;

                      var request = <String,dynamic> {};
                      request['body'] = requestBody;
                      print(json.encode(request));
                      var response = await put(kDomain, 'log', json.encode(request));
                      print(response['statusCode']);
                      print(response['body']);


                      log = {};
                      log['email'] = widget.email;
                      log['password'] = widget.pass;
                      requestBody = {};
                      requestBody['body'] = log;
                      response = await post(kDomain, "logs", json.encode(requestBody));
                      print(requestBody);
                      print(response);
                      var body = json.decode(response['body']);
                      print(body['message']);
                    },
                    buttonTitle: 'Add Log',
                  ),
                  BottomButton(
                    onTap: () async {
                      Map<String,dynamic> log = {};
                      Map<String,dynamic> requestBody = {};
                      log = {};
                      String email = widget.email;
                      String pass = widget.pass;
                      log['email'] = email;
                      log['password'] = pass;
                      requestBody = {};
                      requestBody['body'] = log;
                      var response = await post(kDomain, "logs", json.encode(requestBody));
                      print(response);
                      var body = json.decode(response['body']);
                      log = (body['message'][0]);
                      List<dynamic> b = body['message'];

                      List<Map<String,dynamic>> userLogs = <Map<String,dynamic>>[];
                      for(var c in b){
                        userLogs.add(c);
                      }
                      List<Widget> widgets = futureLogs(userLogs);
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LogPage(email: widget.email, pass: widget.pass, logs: widgets)));
                    },
                    buttonTitle: 'View Logs',
                  ),
                ],
              ),
            ),
        );
  }
}