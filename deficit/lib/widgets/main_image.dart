import 'package:flutter/material.dart';

import '../pages/login_page.dart';

class MainImage extends StatelessWidget {
  const MainImage(this.imageURL, this.margin, this.width, this.height, {super.key});
  final String imageURL;
  final double margin;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Container(
        margin: EdgeInsets.only(top: margin),
        width: width,
        height: height,
        child: Image(
          image: AssetImage(imageURL),
        ),
      ),
      onPressed:(){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) =>LoginPage()));
      }
    );
  }
}