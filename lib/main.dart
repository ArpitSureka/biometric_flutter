import 'package:flutter/material.dart';
import 'package:biometric/pages/homePage.dart';
import 'package:biometric/pages/addImage.dart';
import 'package:biometric/pages/showImage.dart';
import 'package:biometric/pages/ListFiles.dart';
import 'package:biometric/pages/compareImage.dart';

void main() {
  runApp(MaterialApp(
    title: 'Biometric recognition',
    initialRoute: '/',
    routes: {
      '/': (context) => HomePage(),
      '/addImage': (context) => AddImage(),
      '/listFiles': (context) => ListFiles(),
      '/compare': (context) => CompareImage(),
    },
  ));
}
