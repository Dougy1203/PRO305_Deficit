import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../classes/http.dart';
import '../widgets/constants.dart';
import '../widgets/main_image.dart';
import '../widgets/text_input.dart';
import 'input_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final corporateController = TextEditingController();
  final userController = TextEditingController();
  final passController = TextEditingController();
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const MainImage('assets/logo_complete.png', 15.0, 200.0, 200.0),
              MyTextField(
                text: 'Email',
                icon: Icons.person,
                obscured: false,
                myController: userController,
              ),
              MyTextField(
                text: 'Password',
                icon: Icons.password,
                obscured: true,
                myController: passController,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      child: Wrap(children: [
                        Container(
                          width: 90.0,
                          height: 30.0,
                          color: kPrimaryColor,
                          child: const Center(child: Text('Sign In')),
                        ),
                      ]),
                      onPressed: () async {
                        var map = <String, dynamic>{};
                        map['email'] = userController.text;
                        map['password'] = passController.text;
                        var request = <String, dynamic> {};
                        request['body'] = map;
                        if(kDebugMode) {
                          print(userController.text);
                          print(passController.text);
                          print(request);
                        }
                        final response = await post(kDomain, 'login', json.encode(request));
                        if (kDebugMode) {
                          print(response['statusCode']);
                          print(response['body']);
                        }
                        if(response['statusCode'] == 200){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InputPage(email: userController.text, pass: passController.text),
                            ),
                          );
                        }
                      }),
                  MaterialButton(

                    child: Wrap(children: [
                      Container(
                        width: 90.0,
                        height: 30.0,
                        color: kPrimaryColor,
                        child: const Center(child: Text('Sign Up')),
                      ),
                    ]),
                    onPressed: ()
                    {
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const SignUp()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
