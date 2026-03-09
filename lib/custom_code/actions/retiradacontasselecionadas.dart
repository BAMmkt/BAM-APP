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

Future<List<dynamic>> retiradacontasselecionadas(
  List<dynamic>? contaspuxadas,
  List<dynamic>? contasselecionadas,
) async {
  // Check if the input lists are null or empty
  if (contaspuxadas == null || contasselecionadas == null) {
    return contaspuxadas ?? [];
  }

  // Extract the ids from contasselecionadas
  final selectedIds = contasselecionadas.map((item) => item['idconta']).toSet();

  // Filter contaspuxadas to remove items with related_id in selectedIds
  final filteredContaspuxadas = contaspuxadas.where((item) {
    return !selectedIds.contains(item['account_id']);
  }).toList();

  return filteredContaspuxadas;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
