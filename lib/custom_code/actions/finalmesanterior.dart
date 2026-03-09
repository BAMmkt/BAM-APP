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

Future<DateTime> finalmesanterior(DateTime? datainicio) async {
  if (datainicio == null) {
    throw ArgumentError("datainicio cannot be null");
  }

  // Calculate the last day of the previous month
  DateTime firstDayOfCurrentMonth =
      DateTime(datainicio.year, datainicio.month, 1);
  DateTime lastDayOfPreviousMonth =
      firstDayOfCurrentMonth.subtract(Duration(days: 1));

  return lastDayOfPreviousMonth;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
