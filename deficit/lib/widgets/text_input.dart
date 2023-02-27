import 'package:flutter/material.dart';
import 'constants.dart';
class MyTextField extends StatefulWidget {
  MyTextField({super.key, required this.text, required this.icon, required this.obscured, required this.myController});
  final String text;
  final IconData icon;
  bool obscured;
  bool isObscured = true;
  final TextEditingController myController;
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    // widget.obscured = widget.obscured;
    if(widget.obscured)
    {
      return Container(
        margin: const EdgeInsets.all(15),
        child: TextField(
          controller: widget.myController,
          obscureText: widget.isObscured,
          obscuringCharacter: '*',
          style: const TextStyle(
            color: kSecondaryColor,
          ),
          decoration: InputDecoration(
            labelText: widget.text,
            labelStyle: const TextStyle(
              color: kSecondaryColor,
            ),
            filled: true,
            fillColor: kPrimaryColor,
            icon: Icon(widget.icon),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide.none,
            ),
            suffixIcon: widget.isObscured
                ? IconButton(
              icon: const Icon(Icons.visibility_off),
              onPressed: () {
                setState(() {
                  widget.isObscured = !widget.isObscured;
                });
              },
            )
                : IconButton(
              icon: const Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  widget.isObscured = !widget.isObscured;
                });
              },
            ),
          ),
        ),
      );
    }
    else
    {
      return Container(
        margin: const EdgeInsets.all(15),
        child: TextField(
          controller: widget.myController,
          style: const TextStyle(
            color: kSecondaryColor,
          ),
          decoration: InputDecoration(
            labelText: widget.text,
            labelStyle: const TextStyle(
              color: kSecondaryColor,
            ),
            filled: true,
            fillColor: kPrimaryColor,
            icon: Icon(widget.icon),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      );
    }

  }
}