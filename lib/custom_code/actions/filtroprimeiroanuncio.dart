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

Future<dynamic> filtroprimeiroanuncio(List<dynamic>? dados) async {
  if (dados == null || dados.isEmpty) {
    return null;
  }

  dynamic mostRecentItem;
  DateTime? mostRecentDate;

  for (var item in dados) {
    if (item is Map<String, dynamic> && item.containsKey('date')) {
      DateTime? currentDate;

      // Try to parse the date from various formats
      try {
        var dateValue = item['date'];

        if (dateValue is String) {
          // Try parsing ISO format first
          currentDate = DateTime.tryParse(dateValue);

          // If that fails, try other common formats
          if (currentDate == null) {
            // Try parsing timestamp string
            var timestamp = int.tryParse(dateValue);
            if (timestamp != null) {
              currentDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
            }
          }
        } else if (dateValue is int) {
          // Assume it's a timestamp
          currentDate = DateTime.fromMillisecondsSinceEpoch(dateValue);
        } else if (dateValue is DateTime) {
          currentDate = dateValue;
        }

        // Compare dates and keep the most recent
        if (currentDate != null) {
          if (mostRecentDate == null || currentDate.isAfter(mostRecentDate)) {
            mostRecentDate = currentDate;
            mostRecentItem = item;
          }
        }
      } catch (e) {
        // Skip items with invalid date formats
        continue;
      }
    }
  }

  return mostRecentItem;
}
