import 'package:deficit/classes/constants.dart';
import 'package:flutter/material.dart';

Widget logs(Map<String,dynamic> log){
  return SingleChildScrollView(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Date: ", style: kResultTextStyle),
            Text(log['date'].toString(), style: kResultTextStyle),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Protein', style: kResultTextStyle,),
                Text(log['protein'].toString(), style: kLogText,),
              ],
            ),
            kRowSpace(15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Fat', style: kResultTextStyle,),
                Text(log['fat'].toString(), style: kLogText,),
              ],
            ),
            kRowSpace(15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Carbs', style: kResultTextStyle,),
                Text(log['carb'].toString(), style: kLogText,),
              ],
            ),
            kRowSpace(15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Calories', style: kResultTextStyle,),
                Text(log['calories'].toString(), style: kLogText,),
              ],
            ),
          ],
        ),
        kColumnSpace(20),
      ],
    ),
  );
}