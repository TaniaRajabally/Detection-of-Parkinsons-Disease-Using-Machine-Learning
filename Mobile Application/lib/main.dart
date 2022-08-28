import 'package:drawx/login.dart';
import 'package:flutter/material.dart';


void main() => runApp(handwrittenNumberRecognizerApp());

class handwrittenNumberRecognizerApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Recognizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
