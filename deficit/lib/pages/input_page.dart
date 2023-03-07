import 'dart:convert';
import 'package:flutter/material.dart';
import '../classes/http.dart';
import '../classes/rsa_encryption.dart';
import '../widgets/bottom_button.dart';
import '../classes/constants.dart';
import '../widgets/main_image.dart';
import '../widgets/reusable_card.dart';
import '../widgets/reusable_log_card.dart';
import '../widgets/text_input.dart';
import 'logs_page.dart';

class InputPage extends StatefulWidget {
  InputPage({super.key, required this.email, required this.pass, required this.date});
  String email;
  String pass;
  String date;
  @override
  InputPageState createState() => InputPageState();
}

class InputPageState extends State<InputPage> {
  int calories = 200;
  int protein = 20;
  int carbs = 20;
  int fat = 20;
  final dateController = TextEditingController();
  double dateHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    // date = "${now.month}/${now.day}/${now.year}";
    dateController.text = widget.date;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Input Log'),
        titleSpacing: 2.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MainImage('assets/logo_complete.png', 15.0, 200.0, 200.0),
            ReusableLogCard(
                color: kSecondaryColor,
                cardChild: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Date: ", style: kDateTextStyle),
                      ],
                    ),
                    MyTextField(
                      icon: Icons.date_range,
                      obscured: false,
                      text: 'Enter Date:',
                      myController: dateController,
                    ),
                  ],
                ),
                onPress: () {
                }),
            ReusableCard(
              color: kSecondaryColor,
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
                          widget.date = dateController.text;
                          protein = newValue.round();
                        });
                      },
                      min: 0.0,
                      max: 120,
                    ),
                  ),
                ],
              ),
              onPress: () {},
            ),
            ReusableCard(
              color: kSecondaryColor,
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
                          widget.date = dateController.text;
                          carbs = newValue.round();
                        });
                      },
                      min: 0.0,
                      max: 120,
                    ),
                  ),
                ],
              ),
              onPress: () {},
            ),
            ReusableCard(
              color: kSecondaryColor,
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
                          widget.date = dateController.text;
                          fat = newValue.round();
                        });
                      },
                      min: 0.0,
                      max: 120,
                    ),
                  ),
                ],
              ),
              onPress: () {},
            ),
            ReusableCard(
              color: kSecondaryColor,
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
                          widget.date = dateController.text;
                          calories = newValue.round();
                        });
                      },
                      min: 0.0,
                      max: 2000,
                    ),
                  ),
                ],
              ),
              onPress: () {},
            ),
            BottomButton(
              onTap: () async {
                Map<String, dynamic> log = {};
                log['calories'] = calories;
                log['carb'] = carbs;
                log['protein'] = protein;
                log['fat'] = fat;
                log['date'] = dateController.text;

                Map<String, dynamic> requestBody = {};
                requestBody['email'] = widget.email;
                requestBody['password'] = widget.pass;
                requestBody['log'] = log;

                var request = <String, dynamic>{};
                request['body'] = requestBody;
                var response = await put(kDomain, 'log', json.encode(request));
              },
              buttonTitle: 'Add Log',
            ),
            BottomButton(
              onTap: () async {
                Map<String, dynamic> log = {};
                Map<String, dynamic> requestBody = {};
                log = {};
                String email = widget.email;
                String pass = widget.pass;
                log['email'] = email;
                log['password'] = pass;
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LogPage(
                            email: widget.email,
                            pass: widget.pass,
                            logs: widgets)));
              },
              buttonTitle: 'View Logs',
            ),
          ],
        ),
      ),
    );
  }
}
