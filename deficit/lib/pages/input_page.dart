import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../classes/http.dart';
import '../widgets/bottom_button.dart';
import '../classes/calculator_brain.dart';
import '../widgets/card_child_icon.dart';
import '../classes/constants.dart';
import '../main.dart';
import 'results_page.dart';
import '../widgets/reusable_card.dart';
import '../widgets/round_icon_button.dart';
import '../classes/rsa_encryption.dart' as rsa;

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
          title: const Text('MACRO COUNTER'),
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

                  Map<String,dynamic> requestBody = {};
                  requestBody['email'] = widget.email;
                  requestBody['password'] = widget.pass;
                  requestBody['log'] = log;

                  var request = <String,dynamic> {};
                  request['body'] = requestBody;
                  print(json.encode(request));
                  var response = await post(kDomain, 'log', json.encode(request));
                  print(response['statusCode']);
                  print(response['body']);
                  // CalculatorBrain brain = CalculatorBrain(0,0);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ResultsPage(bmiResults: brain.calculateBmi(), bmiText: brain.getResult(), bmiInterpretation: brain.getInterp(),)));
                },
                buttonTitle: 'Add Log',
              ),
            ],
          ),
        ));
  }
}