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

// from lista filtrada return a csv archive with all the values of the list structuring it like this: one column for  nome, one for contato.email, one for contato.telefone, one for valor_negociacao, one for status, one for data_entrada, one for data_da_ultima_movimentacao, one for data_de_fechamento and one colum for each dados_extas item, where dados_extas.titulo is the nem of the column and dados_extras.value is the value
import 'dart:convert';
import 'dart:typed_data';

Future<FFUploadedFile?> csvdownload(
    List<CrmLeadsTesteRecord>? listafiltrada) async {
  if (listafiltrada == null || listafiltrada.isEmpty) {
    return null;
  }

  try {
    // Get all unique dados_extras titles for dynamic columns
    Set<String> dadosExtrasColumns = {};
    for (var record in listafiltrada) {
      if (record.dadosExtras != null) {
        for (var extra in record.dadosExtras!) {
          if (extra.titulo != null && extra.titulo!.isNotEmpty) {
            dadosExtrasColumns.add(extra.titulo!);
          }
        }
      }
    }

    // Create CSV header
    List<String> headers = [
      'nome',
      'contato.email',
      'contato.telefone',
      'valor_negociacao',
      'status',
      'data_entrada',
      'data_da_ultima_movimentacao',
      'data_de_fechamento'
    ];

    // Add dados_extras columns
    headers.addAll(dadosExtrasColumns.toList()..sort());

    // Start building CSV content
    List<List<String>> csvData = [];
    csvData.add(headers);

    // Process each record
    for (var record in listafiltrada) {
      List<String> row = [];

      // Add basic fields
      row.add(_escapeCsvField(record.nome ?? ''));
      row.add(_escapeCsvField(record.contato?.email ?? ''));
      row.add(_escapeCsvField(record.contato?.telefone ?? ''));
      row.add(_escapeCsvField(record.valorNegociacao?.toString() ?? ''));
      row.add(_escapeCsvField(record.status ?? ''));
      row.add(_escapeCsvField(record.dataEntrada?.toString() ?? ''));
      row.add(
          _escapeCsvField(record.dataDaUltimaMovimentacao?.toString() ?? ''));
      row.add(_escapeCsvField(record.dataDeFechamento?.toString() ?? ''));

      // Add dados_extras values
      Map<String, String> extrasMap = {};
      if (record.dadosExtras != null) {
        for (var extra in record.dadosExtras!) {
          if (extra.titulo != null && extra.titulo!.isNotEmpty) {
            extrasMap[extra.titulo!] = extra.valor ?? '';
          }
        }
      }

      // Add valores for each dados_extras column in order
      for (String columnName in dadosExtrasColumns.toList()..sort()) {
        row.add(_escapeCsvField(extrasMap[columnName] ?? ''));
      }

      csvData.add(row);
    }

    // Convert to CSV string
    String csvContent = csvData.map((row) => row.join(',')).join('\n');

    // Convert to bytes
    Uint8List bytes = utf8.encode(csvContent);

    // Create FFUploadedFile
    return FFUploadedFile(
      name: 'crm_leads_${DateTime.now().millisecondsSinceEpoch}.csv',
      bytes: bytes,
    );
  } catch (e) {
    print('Error generating CSV: $e');
    return null;
  }
}

String _escapeCsvField(String field) {
  // Escape quotes and wrap in quotes if necessary
  if (field.contains(',') || field.contains('"') || field.contains('\n')) {
    return '"${field.replaceAll('"', '""')}"';
  }
  return field;
}
