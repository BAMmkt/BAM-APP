// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<DateTime> iniciomesanterior(DateTime? datainicio) async {
  if (datainicio == null) {
    throw ArgumentError("datainicio cannot be null");
  }

  // Handle edge case for January
  DateTime firstDayOfPreviousMonth;
  if (datainicio.month == 1) {
    firstDayOfPreviousMonth = DateTime(datainicio.year - 1, 12, 1);
  } else {
    firstDayOfPreviousMonth =
        DateTime(datainicio.year, datainicio.month - 1, 1);
  }

  return firstDayOfPreviousMonth;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
