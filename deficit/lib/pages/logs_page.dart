import 'dart:convert';

import 'package:deficit/widgets/reusable_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../classes/http.dart';
import '../classes/constants.dart';
import '../widgets/main_image.dart';
import '../widgets/reusable_log_card.dart';
import '../widgets/text_input.dart';
import 'input_page.dart';

class LogPage extends StatefulWidget {
  const LogPage({Key? key, required this.email, required this.pass, required this.logs}) : super(key: key);
  final String email;
  final String pass;
  final List<Widget> logs;
  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text('LOGIN'),
          titleSpacing: 2.0,
          centerTitle: true,
        ),
        backgroundColor: kBackgroundColor,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                MainImage('assets/logo_complete.png', 15.0, 200.0, 200.0),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.logs,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
