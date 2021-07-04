import 'dart:math';

import 'package:flutter/material.dart';

Random random = new Random();

List<Color> colors = [
  Colors.red, 
  Colors.green, 
  Colors.yellow,
  Colors.brown,
  Colors.purple,
  Colors.pink
];

Color getRandomColor() {
  return colors[random.nextInt(colors.length)];
}
