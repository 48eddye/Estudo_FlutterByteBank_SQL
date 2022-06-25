import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BytebenkApp());
}

class BytebenkApp extends StatelessWidget {
  const BytebenkApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.green[900],
              secondary: Colors.lightBlue[700],
            ),
      ),
      home: const Dashboard(),
    );
  }
}
