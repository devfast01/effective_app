import 'package:flutter/material.dart';

// TODO to show logs as green text
void printGreen(var text) {
  debugPrint('\x1B[32m$text\x1B[0m');
}
