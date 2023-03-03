import 'package:flutter/material.dart';
import '../classes/constants.dart';
import '../widgets/main_image.dart';

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
          title: const Text('LOGS'),
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
