import 'dart:math';

import 'package:flutter/material.dart';

GetGradientColor() {
  var colors = [
    // [Colors.red, Colors.purple],
    [Colors.blue, Color(0xff3267f6)],
    [Colors.yellow, Colors.deepOrange],
    // [Colors.red, Colors.purple]
  ];

  int random = Random().nextInt(colors.length -1);
  return colors[random];

}


//Formats the number with commas
//3445456 => 3,445,456
String FormatNumber(String number) {
  String formatted = "";
  int len = number.length;
  for (var i = 0; i < len; i++) {
    if ( ((len - i) % 3 == 0 )&& (i!=0) ) {
      formatted += ',';
    }
    formatted += number[i];
  }
  return formatted;
}