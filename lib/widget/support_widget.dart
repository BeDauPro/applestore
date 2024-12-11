import 'dart:ui';
import 'package:flutter/material.dart';

class AppWidget{
  static TextStyle boldTextFieldStyle(){
    return TextStyle(
      color: Colors.black,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    );
  }
  static TextStyle lightTextFieldStyle(){
    return TextStyle(
      color: Colors.black54,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }
  static TextStyle semiboldTextFieldStyle(){
    return TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }
  static TextStyle blueTextFieldStyle(){
    return TextStyle(
      color: Colors.blueAccent,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }
}