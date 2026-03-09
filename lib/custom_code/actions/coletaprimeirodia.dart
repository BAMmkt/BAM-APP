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

Future<DateTime?> coletaprimeirodia(
  List<dynamic> dados,
) async {
  // filter the json list by $.username field = cliente  inside each item from the list and from that result parse the $.date field from string to date time value, then get the most recente date and return the last day of said month

  List<DateTime> dates = [];

  // Filter the json list by $.username field = cliente
  List<dynamic> filteredData = dados;

  // Parse the $.date field from string to date time value
  filteredData.forEach((item) {
    try {
      DateTime date = DateTime.parse(item['date']);
      dates.add(date);
    } catch (e) {
      // Ignore invalid date strings
    }
  });

  // Check if there are valid dates
  if (dates.isEmpty) {
    return null; // Return null if no valid dates are found
  }

  // Get the most recent date
  DateTime mostRecentDate = dates
      .reduce((value, element) => value.isAfter(element) ? value : element);

  // Return the last day of the month of the most recent date
  DateTime firstDayOfMonth =
      DateTime(mostRecentDate.year, mostRecentDate.month, 1);

  return firstDayOfMonth;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
