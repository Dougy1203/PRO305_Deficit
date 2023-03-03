import 'dart:convert';
import 'package:deficit/pages/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../classes/http.dart';
import '../classes/constants.dart';
import '../widgets/text_input.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("SIGN UP"),
        titleSpacing: 2.0,
        centerTitle: true,
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            MyTextField(
              text: "First Name",
              icon: Icons.abc,
              obscured: false,
              myController: fNameController,
            ),
            MyTextField(
                text: "Last Name",
                icon: Icons.abc,
                obscured: false,
                myController: lNameController),
            MyTextField(
                text: "Email",
                icon: Icons.email,
                obscured: false,
                myController: emailController),
            MyTextField(
                text: "Password",
                icon: Icons.password,
                obscured: true,
                myController: passController),
            MyTextField(
                text: "Confirm Password",
                icon: Icons.password,
                obscured: true,
                myController: confirmPassController),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                    child: Container(
                      width: 90.0,
                      height: 30.0,
                      color: kPrimaryColor,
                      child: const Center(child: Text('Sign Up')),
                    ),
                    onPressed: () async {
                      if (passController.text == confirmPassController.text) {
                        var map = <String, dynamic>{};
                        map['firstname'] = fNameController.text;
                        map['lastname'] = lNameController.text;
                        map['email'] = emailController.text;
                        map['password'] = passController.text;

                        var request = <String, dynamic> {};
                        request['body'] = map;
                        if(kDebugMode) {
                          print(request);
                        }

                        final response = await post(kDomain, 'user', json.encode(request));
                        if (kDebugMode) {
                          print(response['statusCode']);
                          print(response['body']);
                        }
                        if(response['statusCode'] == 200){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        }
                      } else {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Password's Don't Match"),
                            content: const Text(
                                'Please Enter Matching Passwords to Proceed'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
