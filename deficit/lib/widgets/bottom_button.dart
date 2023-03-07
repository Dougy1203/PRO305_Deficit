import 'package:flutter/material.dart';
import '../classes/constants.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({super.key, required this.onTap, required this.buttonTitle});
  final VoidCallback onTap;
  final String buttonTitle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: kTertiaryColor,
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        height: kBottomContainerHeight,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              buttonTitle,
              style: kContainerText,
            ),
          ],
        ),
      ),
    );
  }
}
