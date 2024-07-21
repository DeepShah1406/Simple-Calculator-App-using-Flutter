import 'package:flutter/material.dart';

//import 'package:math_expressions/math_expressions.dart';
import 'calculator_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialApp m = MaterialApp(title: 'Calculator', debugShowCheckedModeBanner: false, theme: ThemeData.dark(), home: const CalculatorScreen());
    return m;
  }
}