import 'package:flutter/material.dart';

import 'game_page.dart';

void main() => runApp(const ShapeMatchApp());

class ShapeMatchApp extends StatelessWidget {
  const ShapeMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shape Matching',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const GamePage(),
    );
  }
}
