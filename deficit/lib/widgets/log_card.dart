import 'package:deficit/classes/constants.dart';
import 'package:flutter/material.dart';

Widget logs(dynamic log){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(log['protein'], style: kLogText,),
      Text(log['fat'], style: kLogText,),
      Text(log['carb'], style: kLogText,),
      Text(log['calories'], style: kLogText,),
    ],
  );
}