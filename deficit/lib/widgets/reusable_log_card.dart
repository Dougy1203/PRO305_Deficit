import 'package:flutter/material.dart';

class ReusableLogCard extends StatelessWidget {
  const ReusableLogCard({super.key, required this.color, required this.cardChild, required this.onPress});
  final Color color;
  final Widget cardChild;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 150,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: cardChild,
      ),
    );
  }
}