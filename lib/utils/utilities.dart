import 'dart:math';

import 'package:flutter/material.dart';

GetGradientColor() {
  var colors = [
    [Colors.red, Colors.purple],
    [Colors.blue, Colors.green],
    [Colors.yellow, Colors.deepOrange],
    [Colors.red, Colors.purple]
  ];

  int random = Random().nextInt(colors.length -1);
  return colors[random];

}
