import 'package:deficit/pages/input_page.dart';
import 'package:flutter/material.dart';
import 'widgets/constants.dart';

enum Gender {
  male,
  female,
}

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: kBmiPrimary,
        ),
        scaffoldBackgroundColor: kBmiPrimary,
      ),
      home: InputPage(),
    );
  }
}
