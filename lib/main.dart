
import 'package:flutter/material.dart';
import 'package:pdf_foramating/splash_screen.dart';


void main() {
  runApp(CreatePdfWidget());
}

/// Represents the PDF widget class.
class CreatePdfWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Sans',
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

