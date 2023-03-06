import 'package:deficit/classes/constants.dart';
import 'package:flutter/material.dart';

Widget logs(Map<String,dynamic> log){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(log['protein'].toString(), style: kLogText,),
      Text(log['fat'].toString(), style: kLogText,),
      Text(log['carb'].toString(), style: kLogText,),
      Text(log['calories'].toString(), style: kLogText,),
    ],
  );
}