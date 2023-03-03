import 'package:deficit/pages/input_page.dart';
import 'package:deficit/pages/login_page.dart';
import 'package:deficit/pages/logs_page.dart';
import 'package:flutter/material.dart';
import 'classes/constants.dart';

enum Gender {
  male,
  female,
}

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: kBmiPrimary,
        ),
        scaffoldBackgroundColor: kBmiPrimary,
      ),
      home: const LoginPage(),
    );
  }
}
