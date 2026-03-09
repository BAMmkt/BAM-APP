import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

DateTime? reduzirdatainicio(DateTime? datainicio) {
  // Return the first day of the previous month of datainicio
  if (datainicio != null) {
    // Handle case where month is January to wrap to previous year
    int previousMonth = datainicio.month == 1 ? 12 : datainicio.month - 1;
    int previousYear =
        datainicio.month == 1 ? datainicio.year - 1 : datainicio.year;

    return DateTime(previousYear, previousMonth, 1);
  }
  return null;
}

DateTime? reduzirdatafinal(DateTime? datafinal) {
  // Return the last day of the previous month of datainicio
  if (datafinal != null) {
    // Calculate the first day of the current month
    DateTime firstDayOfCurrentMonth =
        DateTime(datafinal.year, datafinal.month, 1);
    // Subtract one day to get the last day of the previous month
    DateTime lastDayOfPreviousMonth =
        firstDayOfCurrentMonth.subtract(Duration(days: 1));
    return lastDayOfPreviousMonth;
  }
  return null;
}

DateTime? aumentardatainicio(DateTime? datainicio) {
  // Get datainicio value and make it the first day of the next month
  if (datainicio != null) {
    // Handle case where month is December to wrap to next year
    int nextMonth = datainicio.month == 12 ? 1 : datainicio.month + 1;
    int nextYear =
        datainicio.month == 12 ? datainicio.year + 1 : datainicio.year;

    return DateTime(nextYear, nextMonth, 1);
  }
  return null;
}

bool? bolavancopost(
  List<dynamic> insightsmensais,
  DateTime datafinal,
) {
  for (var item in insightsmensais) {
    // Obtém o valor da propriedade 'month'
    String monthStr = item['post_timestamp'];

    // Converte a string para DateTime
    // Certifique-se de que o formato da string seja compatível com o DateTime.parse
    DateTime monthDate = DateTime.parse(monthStr);

    // Se a data convertida for posterior à dataFinal, retorna true
    if (monthDate.isAfter(datafinal)) {
      return true;
    }
  }
  // Se nenhum item atender à condição, retorna false
  return false;
}

DateTime? aumentardatafinal(DateTime? datafinal) {
  // Get datafinal value and return the last day of the next month
  if (datafinal == null) {
    return null;
  }

  // Calculate the first day of the next month
  int nextMonth = datafinal.month == 12 ? 1 : datafinal.month + 1;
  int nextYear = datafinal.month == 12 ? datafinal.year + 1 : datafinal.year;

  // Get the first day of the month after the next month, then subtract one day to get the last day of the next month
  final lastDayOfNextMonth = DateTime(nextYear, nextMonth + 1, 0);

  return lastDayOfNextMonth;
}

bool bolrecuopost(
  List<dynamic> insightsmensais,
  DateTime datainicio,
) {
  for (var item in insightsmensais) {
    // Obtém o valor da propriedade 'month'
    String monthStr = item['post_timestamp'];

    // Converte a string para DateTime
    // Certifique-se de que o formato da string seja compatível com o DateTime.parse
    DateTime monthDate = DateTime.parse(monthStr);

    // Se a data convertida for posterior à dataFinal, retorna true
    if (monthDate.isBefore(datainicio)) {
      return true;
    }
  }
  // Se nenhum item atender à condição, retorna false
  return false;
}

bool? bolavanco(
  List<dynamic> insightsmensais,
  DateTime datafinal,
) {
  for (var item in insightsmensais) {
    // Obtém o valor da propriedade 'month'
    String monthStr = item['date'];

    // Converte a string para DateTime
    // Certifique-se de que o formato da string seja compatível com o DateTime.parse
    DateTime monthDate = DateTime.parse(monthStr);

    // Se a data convertida for posterior à dataFinal, retorna true
    if (monthDate.isAfter(datafinal)) {
      return true;
    }
  }
  // Se nenhum item atender à condição, retorna false
  return false;
}

List<int>? distretariamulher(
  DateTime? datainicio,
  DateTime? datafinal,
  List<dynamic>? insightsdemograficos,
) {
  // Check if the input parameters are valid
  if (datainicio == null ||
      datafinal == null ||
      insightsdemograficos == null ||
      insightsdemograficos.isEmpty) {
    return null; // Return null if any parameter is invalid
  }

  // Find the first item where the date is between datainicio and datafinal
  var firstItem = insightsdemograficos.firstWhere(
    (item) {
      DateTime itemDate = DateTime.parse(item[
          'collected_date']); // Assuming 'collected_date' is the key for the date
      // A condição abaixo verifica se a data está no intervalo, incluindo os limites (datainicio e datafinal)
      return (itemDate.isAtSameMomentAs(datainicio) ||
              itemDate.isAfter(datainicio)) &&
          (itemDate.isAtSameMomentAs(datafinal) ||
              itemDate.isBefore(datafinal));
    },
    orElse: () => null, // Return null if no item is found
  );

  // If no item is found, return null
  if (firstItem == null) {
    return null;
  }

  // Sum the values from the specified columns
  int age13_17f = firstItem['age_13_17F'] ?? 0;
  int age18_24f = firstItem['age_18_24F'] ?? 0;
  int age25_34f = firstItem['age_25_34F'] ?? 0;
  int age35_44f = firstItem['age_35_44F'] ?? 0;
  int age45_54f = firstItem['age_45_54F'] ?? 0;
  int age55_64f = firstItem['age_55_64F'] ?? 0;
  int age65f = firstItem['age_65_F'] ?? 0;

  // Retorna uma lista com as somas dos valores masculinos e femininos
  return [
    age13_17f,
    age18_24f,
    age25_34f,
    age35_44f,
    age45_54f,
    age55_64f,
    age65f
  ];
}

List<int>? distretariaind(
  DateTime? datainicio,
  DateTime? datafinal,
  List<dynamic>? insightsdemograficos,
) {
  // Check if the input parameters are valid
  if (datainicio == null ||
      datafinal == null ||
      insightsdemograficos == null ||
      insightsdemograficos.isEmpty) {
    return null; // Return null if any parameter is invalid
  }

  // Find the first item where the date is between datainicio and datafinal
  var firstItem = insightsdemograficos.firstWhere(
    (item) {
      DateTime itemDate = DateTime.parse(item[
          'collected_date']); // Assuming 'collected_date' is the key for the date
      // A condição abaixo verifica se a data está no intervalo, incluindo os limites (datainicio e datafinal)
      return (itemDate.isAtSameMomentAs(datainicio) ||
              itemDate.isAfter(datainicio)) &&
          (itemDate.isAtSameMomentAs(datafinal) ||
              itemDate.isBefore(datafinal));
    },
    orElse: () => null, // Return null if no item is found
  );

  // If no item is found, return null
  if (firstItem == null) {
    return null;
  }

  // Sum the values from the specified columns
  int age13_17i = firstItem['age_13_17I'] ?? 0;
  int age18_24i = firstItem['age_18_24I'] ?? 0;
  int age25_34i = firstItem['age_25_34I'] ?? 0;
  int age35_44i = firstItem['age_35_44I'] ?? 0;
  int age45_54i = firstItem['age_45_54I'] ?? 0;
  int age55_64i = firstItem['age_55_64I'] ?? 0;
  int age65i = firstItem['age_65_I'] ?? 0;

  // Retorna uma lista com as somas dos valores masculinos e femininos
  return [
    age13_17i,
    age18_24i,
    age25_34i,
    age35_44i,
    age45_54i,
    age55_64i,
    age65i
  ];
}

List<int>? distretariahomem(
  DateTime? datainicio,
  DateTime? datafinal,
  List<dynamic>? insightsdemograficos,
) {
  // Check if the input parameters are valid
  if (datainicio == null ||
      datafinal == null ||
      insightsdemograficos == null ||
      insightsdemograficos.isEmpty) {
    return null; // Return null if any parameter is invalid
  }

  // Find the first item where the date is between datainicio and datafinal
  var firstItem = insightsdemograficos.firstWhere(
    (item) {
      DateTime itemDate = DateTime.parse(item[
          'collected_date']); // Assuming 'collected_date' is the key for the date
      // A condição abaixo verifica se a data está no intervalo, incluindo os limites (datainicio e datafinal)
      return (itemDate.isAtSameMomentAs(datainicio) ||
              itemDate.isAfter(datainicio)) &&
          (itemDate.isAtSameMomentAs(datafinal) ||
              itemDate.isBefore(datafinal));
    },
    orElse: () => null, // Return null if no item is found
  );

  // If no item is found, return null
  if (firstItem == null) {
    return null;
  }

  // Sum the values from the specified columns
  int age13_17m = firstItem['age_13_17M'] ?? 0;
  int age18_24m = firstItem['age_18_24M'] ?? 0;
  int age25_34m = firstItem['age_25_34M'] ?? 0;
  int age35_44m = firstItem['age_35_44M'] ?? 0;
  int age45_54m = firstItem['age_45_54M'] ?? 0;
  int age55_64m = firstItem['age_55_64M'] ?? 0;
  int age65m = firstItem['age_65_M'] ?? 0;

  // Retorna uma lista com as somas dos valores masculinos e femininos
  return [
    age13_17m,
    age18_24m,
    age25_34m,
    age35_44m,
    age45_54m,
    age55_64m,
    age65m
  ];
}

bool bolrecuo(
  List<dynamic> insightsmensais,
  DateTime datainicio,
) {
  for (var item in insightsmensais) {
    // Obtém o valor da propriedade 'month'
    String monthStr = item['date'];

    // Converte a string para DateTime
    // Certifique-se de que o formato da string seja compatível com o DateTime.parse
    DateTime monthDate = DateTime.parse(monthStr);

    // Se a data convertida for posterior à dataFinal, retorna true
    if (monthDate.isBefore(datainicio)) {
      return true;
    }
  }
  // Se nenhum item atender à condição, retorna false
  return false;
}

int? somadisplay(
  List<dynamic>? insightsmensais,
  String variavel,
  DateTime datainicio,
  DateTime datafinal,
) {
  if (insightsmensais == null) return null;
  // Filter the insights list based on the provided conditions
  List<dynamic> filteredResults = insightsmensais.where((result) {
    try {
      DateTime resultDate = DateTime.parse(result['date']);
      return (resultDate.isAfter(datainicio) ||
              resultDate.isAtSameMomentAs(datainicio)) &&
          (resultDate.isBefore(datafinal) ||
              resultDate.isAtSameMomentAs(datafinal));
    } catch (e) {
      // Ignora o item se ocorrer erro na conversão da data
      return false;
    }
  }).toList();

  // Soma os valores da variável especificada
  int soma = 0;
  for (var result in filteredResults) {
    try {
      // 1. Acessa o valor: result[variavel]
      // 2. Trata NULO: (result[variavel] ?? 0) -> Se for null, usa 0
      // 3. Converte para String: .toString()
      // 4. Converte para Int: int.parse(...)
      soma += int.parse((result[variavel] ?? 0).toString());
    } catch (e) {
      // Trata casos onde a conversão para int pode falhar (e.g., o valor é uma string não numérica como "N/A")
    }
  }

  return soma;
}

double? somadisplayanuncio(
  List<dynamic>? insightsmensais,
  String variavel,
  DateTime datainicio,
  DateTime datafinal,
  String? conjunto,
  String? campanha,
) {
  if (insightsmensais == null) return null;
  // Filter the insights list based on the provided conditions
  List<dynamic> filteredResults = insightsmensais.where((result) {
    try {
      DateTime resultDate = DateTime.parse(result['date']);

      // Verifica se o filtro de data está aplicado
      bool isDateInRange = (resultDate.isAfter(datainicio) ||
              resultDate.isAtSameMomentAs(datainicio)) &&
          (resultDate.isBefore(datafinal) ||
              resultDate.isAtSameMomentAs(datafinal));

      // Filtros opcionais:
      // se `conjunto` for nulo ou vazio, o filtro é ignorado
      bool isConjuntoMatch = (conjunto == null || conjunto.isEmpty) ||
          (result['ad_set_id'] == conjunto);
      // se `campanha` for nulo ou vazio, o filtro é ignorado
      bool isCampanhaMatch = (campanha == null || campanha.isEmpty) ||
          (result['campaign_id'] == campanha);

      return isDateInRange && isConjuntoMatch && isCampanhaMatch;
    } catch (e) {
      // Ignora o item se ocorrer erro na conversão da data
      return false;
    }
  }).toList();

  // Soma os valores da variável especificada
  double soma = 0.0;
  for (var result in filteredResults) {
    try {
      soma += double.parse(result[variavel].toString());
    } catch (e) {
      // Trata casos onde a conversão para double pode falhar
    }
  }

  return soma;
}

List<dynamic>? listacampanhahome(
  List<dynamic>? insightsmensais,
  DateTime datainicio,
  DateTime datafinal,
) {
  if (insightsmensais == null) return null;
  // Filter the insights list based on the provided conditions
  List<dynamic> filteredResults = insightsmensais.where((result) {
    try {
      DateTime resultDate = DateTime.parse(result['date']);

      // Verifica se o filtro de data está aplicado
      bool isDateInRange = (resultDate.isAfter(datainicio) ||
              resultDate.isAtSameMomentAs(datainicio)) &&
          (resultDate.isBefore(datafinal) ||
              resultDate.isAtSameMomentAs(datafinal));

      return isDateInRange;
    } catch (e) {
      // Ignora o item se ocorrer erro na conversão da data
      return false;
    }
  }).toList();

  // Soma os valores da variável especificada
  Map<String, Map<String, dynamic>> uniqueCampaigns = {};

  for (var item in filteredResults) {
    String campaignId = item['campaign_id'];
    if (!uniqueCampaigns.containsKey(campaignId)) {
      uniqueCampaigns[campaignId] = {
        'campaign_name': item['campaign_name'],
        'campaign_id': campaignId,
      };
    }
  }

  return uniqueCampaigns.values.toList();
}

double? somadisplaygoogle(
  List<dynamic>? insightsmensais,
  String variavel,
  DateTime datainicio,
  DateTime datafinal,
  String? campanha,
) {
  // Verificação condicional: se a lista de entrada for nula, retorna 0.0
  if (insightsmensais == null) {
    return 0.0;
  }

  // Filter the insights list based on the provided conditions
  List<dynamic> filteredResults = insightsmensais.where((result) {
    try {
      DateTime resultDate = DateTime.parse(result['date']);

      // Verifica se o filtro de data está aplicado
      bool isDateInRange = (resultDate.isAfter(datainicio) ||
              resultDate.isAtSameMomentAs(datainicio)) &&
          (resultDate.isBefore(datafinal) ||
              resultDate.isAtSameMomentAs(datafinal));

      // Filtros opcionais:
      // se `campanha` for nulo ou vazio, o filtro é ignorado
      bool isCampanhaMatch = (campanha == null || campanha.isEmpty) ||
          (result['campaign_id'] == campanha);

      return isDateInRange && isCampanhaMatch;
    } catch (e) {
      // Ignora o item se ocorrer erro na conversão da data
      return false;
    }
  }).toList();

  // Soma os valores da variável especificada
  // Se a lista 'filteredResults' estiver vazia, a soma permanecerá 0.0
  double soma = 0.0;
  for (var result in filteredResults) {
    try {
      // Adiciona uma verificação para evitar erro se a 'variavel' não existir no mapa
      if (result[variavel] != null) {
        soma += double.parse(result[variavel].toString());
      }
    } catch (e) {
      // Trata casos onde a conversão para double pode falhar
    }
  }

  return soma;
}

List<double>? somadisplaygoogledevice(
  List<dynamic>? insightsmensais,
  String variavel,
  DateTime datainicio,
  DateTime datafinal,
  String? campanha,
) {
  // Lista de dispositivos na ordem desejada para o retorno
  final deviceOrder = ['MOBILE', 'DESKTOP', 'TABLET', 'CONNECTED_TV', 'OTHERS'];

  // Verificação condicional: se a lista de entrada for nula, retorna uma lista de zeros.
  if (insightsmensais == null) {
    return List.filled(deviceOrder.length, 0.0);
  }

  // Filtra a lista de insights com base nas condições fornecidas
  List<dynamic> filteredResults = insightsmensais.where((result) {
    try {
      DateTime resultDate = DateTime.parse(result['date']);

      // Verifica se o filtro de data está aplicado
      bool isDateInRange = (resultDate.isAfter(datainicio) ||
              resultDate.isAtSameMomentAs(datainicio)) &&
          (resultDate.isBefore(datafinal) ||
              resultDate.isAtSameMomentAs(datafinal));

      // Filtro opcional de campanha
      bool isCampanhaMatch = (campanha == null || campanha.isEmpty) ||
          (result['campaign_id'] == campanha);

      return isDateInRange && isCampanhaMatch;
    } catch (e) {
      // Ignora o item se ocorrer erro na conversão da data
      return false;
    }
  }).toList();

  // Mapa para agrupar as somas por dispositivo
  Map<String, double> deviceSums = {};

  // Itera sobre os resultados filtrados para somar os valores por dispositivo
  for (var result in filteredResults) {
    try {
      // Garante que as chaves 'variavel' e 'device' existem e não são nulas
      if (result[variavel] != null && result['device'] != null) {
        String device = result['device'].toString();
        double value = double.parse(result[variavel].toString());

        // Adiciona o valor à soma do dispositivo correspondente
        // Se o dispositivo ainda não estiver no mapa, inicia com 0.0
        deviceSums[device] = (deviceSums[device] ?? 0.0) + value;
      }
    } catch (e) {
      // Trata casos onde a conversão para double pode falhar
    }
  }

  // Monta a lista final de resultados na ordem especificada
  // Se um dispositivo não tiver valor, retorna 0.0 para ele
  List<double> orderedSums =
      deviceOrder.map((device) => deviceSums[device] ?? 0.0).toList();

  return orderedSums;
}

List<double>? somadisplaygoogledemografia(
  List<dynamic>? insightsmensais,
  String variavel,
  DateTime datainicio,
  DateTime datafinal,
  String? campanha,
) {
  // Lista de dispositivos na ordem desejada para o retorno
  final deviceOrder = ['MALE', 'FEMALE', 'UNDETERMINED'];

  // Verificação condicional: se a lista de entrada for nula, retorna uma lista de zeros.
  if (insightsmensais == null) {
    return List.filled(deviceOrder.length, 0.0);
  }

  // Filtra a lista de insights com base nas condições fornecidas
  List<dynamic> filteredResults = insightsmensais.where((result) {
    try {
      DateTime resultDate = DateTime.parse(result['date']);

      // Verifica se o filtro de data está aplicado
      bool isDateInRange = (resultDate.isAfter(datainicio) ||
              resultDate.isAtSameMomentAs(datainicio)) &&
          (resultDate.isBefore(datafinal) ||
              resultDate.isAtSameMomentAs(datafinal));

      // Filtro opcional de campanha
      bool isCampanhaMatch = (campanha == null || campanha.isEmpty) ||
          (result['campaign_id'] == campanha);

      return isDateInRange && isCampanhaMatch;
    } catch (e) {
      // Ignora o item se ocorrer erro na conversão da data
      return false;
    }
  }).toList();

  // Mapa para agrupar as somas por dispositivo
  Map<String, double> deviceSums = {};

  // Itera sobre os resultados filtrados para somar os valores por dispositivo
  for (var result in filteredResults) {
    try {
      // Garante que as chaves 'variavel' e 'device' existem e não são nulas
      if (result[variavel] != null && result['demographic_criterion'] != null) {
        String device = result['demographic_criterion'].toString();
        double value = double.parse(result[variavel].toString());

        // Adiciona o valor à soma do dispositivo correspondente
        // Se o dispositivo ainda não estiver no mapa, inicia com 0.0
        deviceSums[device] = (deviceSums[device] ?? 0.0) + value;
      }
    } catch (e) {
      // Trata casos onde a conversão para double pode falhar
    }
  }

  // Monta a lista final de resultados na ordem especificada
  // Se um dispositivo não tiver valor, retorna 0.0 para ele
  List<double> orderedSums =
      deviceOrder.map((device) => deviceSums[device] ?? 0.0).toList();

  return orderedSums;
}

List<double>? somadisplaygoogleweek(
  List<dynamic>? insightsmensais,
  String variavel,
  DateTime datainicio,
  DateTime datafinal,
  String? campanha,
) {
  // Lista de dispositivos na ordem desejada para o retorno
  final deviceOrder = [
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY'
  ];

  // Verificação condicional: se a lista de entrada for nula, retorna uma lista de zeros.
  if (insightsmensais == null) {
    return List.filled(deviceOrder.length, 0.0);
  }

  // Filtra a lista de insights com base nas condições fornecidas
  List<dynamic> filteredResults = insightsmensais.where((result) {
    try {
      DateTime resultDate = DateTime.parse(result['date']);

      // Verifica se o filtro de data está aplicado
      bool isDateInRange = (resultDate.isAfter(datainicio) ||
              resultDate.isAtSameMomentAs(datainicio)) &&
          (resultDate.isBefore(datafinal) ||
              resultDate.isAtSameMomentAs(datafinal));

      // Filtro opcional de campanha
      bool isCampanhaMatch = (campanha == null || campanha.isEmpty) ||
          (result['campaign_id'] == campanha);

      return isDateInRange && isCampanhaMatch;
    } catch (e) {
      // Ignora o item se ocorrer erro na conversão da data
      return false;
    }
  }).toList();

  // Mapa para agrupar as somas por dispositivo
  Map<String, double> deviceSums = {};

  // Itera sobre os resultados filtrados para somar os valores por dispositivo
  for (var result in filteredResults) {
    try {
      // Garante que as chaves 'variavel' e 'device' existem e não são nulas
      if (result[variavel] != null && result['day_of_week'] != null) {
        String device = result['day_of_week'].toString();
        double value = double.parse(result[variavel].toString());

        // Adiciona o valor à soma do dispositivo correspondente
        // Se o dispositivo ainda não estiver no mapa, inicia com 0.0
        deviceSums[device] = (deviceSums[device] ?? 0.0) + value;
      }
    } catch (e) {
      // Trata casos onde a conversão para double pode falhar
    }
  }

  // Monta a lista final de resultados na ordem especificada
  // Se um dispositivo não tiver valor, retorna 0.0 para ele
  List<double> orderedSums =
      deviceOrder.map((device) => deviceSums[device] ?? 0.0).toList();

  return orderedSums;
}

List<double>? somadisplaygoogleidade(
  List<dynamic>? insightsmensais,
  String variavel,
  DateTime datainicio,
  DateTime datafinal,
  String? campanha,
) {
// 1. Definição da ordem rigorosa das faixas etárias
  final deviceOrder = [
    'AGE_RANGE_18_24',
    'AGE_RANGE_25_34',
    'AGE_RANGE_35_44',
    'AGE_RANGE_45_54',
    'AGE_RANGE_55_64',
    'AGE_RANGE_65_UP',
    'AGE_RANGE_UNDETERMINED'
  ];

  // 2. Se a lista for nula ou vazia, já retorna a lista de zeros imediatamente
  if (insightsmensais == null || insightsmensais.isEmpty) {
    return List.filled(deviceOrder.length, 0.0);
  }

  // 3. Mapa inicializado com 0.0 para CADA item do deviceOrder
  // Isso garante que mesmo que o filtro não encontre nada, o valor será 0.0
  Map<String, double> deviceSums = {for (var item in deviceOrder) item: 0.0};

  // 4. Filtra e soma os valores
  for (var result in insightsmensais) {
    try {
      DateTime resultDate = DateTime.parse(result['date']);

      // Filtro de Data
      bool isDateInRange = (resultDate.isAfter(datainicio) ||
              resultDate.isAtSameMomentAs(datainicio)) &&
          (resultDate.isBefore(datafinal) ||
              resultDate.isAtSameMomentAs(datafinal));

      // Filtro de Campanha
      bool isCampanhaMatch = (campanha == null || campanha.isEmpty) ||
          (result['campaign_id']?.toString() == campanha);

      if (isDateInRange && isCampanhaMatch) {
        String? device = result['demographic_criterion']?.toString();
        var valueRaw = result[variavel];

        if (device != null && valueRaw != null) {
          double value = double.tryParse(valueRaw.toString()) ?? 0.0;

          // Só somamos se a chave existir no nosso mapa (estiver no deviceOrder)
          if (deviceSums.containsKey(device)) {
            deviceSums[device] = (deviceSums[device] ?? 0.0) + value;
          }
        }
      }
    } catch (e) {
      // Ignora erros de parsing de data ou valores nulos
      continue;
    }
  }

  // 5. Mapeia o resultado final garantindo a ordem do deviceOrder
  return deviceOrder.map((device) => deviceSums[device] ?? 0.0).toList();
}

double? mediadisplayanuncio(
  List<dynamic>? insightsmensais,
  String variavel,
  DateTime datainicio,
  DateTime datafinal,
  String? conjunto,
  String? campanha,
) {
  if (insightsmensais == null) return null;

// Filtra insights com base nas condições fornecidas
  List<dynamic> filteredResults = insightsmensais.where((result) {
    try {
      DateTime resultDate = DateTime.parse(result['date']);

      // Verifica o intervalo de datas
      bool isDateInRange = (resultDate.isAfter(datainicio) ||
              resultDate.isAtSameMomentAs(datainicio)) &&
          (resultDate.isBefore(datafinal) ||
              resultDate.isAtSameMomentAs(datafinal));

      // Filtros opcionais para conjunto e campanha
      // O filtro é ignorado se o valor for nulo ou vazio
      bool isConjuntoMatch = (conjunto == null || conjunto.isEmpty) ||
          (result['ad_set_id'] == conjunto);
      bool isCampanhaMatch = (campanha == null || campanha.isEmpty) ||
          (result['campaign_id'] == campanha);

      // Retorna true somente se todas as condições (incluindo as opcionais) forem verdadeiras
      return isDateInRange && isConjuntoMatch && isCampanhaMatch;
    } catch (e) {
      // Retorna false se houver um erro na conversão da data
      return false;
    }
  }).toList();

// Calcula a soma dos valores
  double soma = 0.0;
  int count = 0;

  for (var result in filteredResults) {
    try {
      soma += double.parse(result[variavel].toString());
      count++;
    } catch (e) {
      // Ignora o erro se não puder converter para double
    }
  }

// Calcula e retorna a média
  if (count == 0) return 0.0; // evita divisão por zero

  double average = soma / count;
  return double.parse(average.toStringAsFixed(2));
}

String? varpercentual(
  double mesatual,
  double mesanterior,
) {
  if (mesanterior == 0) {
    return "N/A";
  }

  if (mesanterior == 0.0) {
    return "N/A";
  }

  // Calcula a variação percentual: ((mês atual - mês anterior) / mês anterior) * 100
  double variation = ((mesatual - mesanterior) / mesanterior) * 100;

  // Arredonda para duas casas decimais e formata a string com sinal
  String formatted;
  if (variation >= 0) {
    formatted = "+${variation.toStringAsFixed(2)}%";
  } else {
    formatted = "${variation.toStringAsFixed(2)}%";
  }

  return formatted;
}

bool? verificarpos(String? data) {
  if (data != null) {
    return data.contains('+');
  }
  // If data is null, return null
  return null;
}

int? somadisplaypost(
  List<dynamic>? insightspost,
  String variavel,
  DateTime datainicio,
  DateTime datafinal,
  String? tipo,
) {
  if (insightspost == null) return null;
  // Filter the insights list based on the provided conditions
  List<dynamic> filteredResults = insightspost.where((result) {
    try {
      DateTime resultDate = DateTime.parse(result['post_timestamp']);
      return (resultDate.isAfter(datainicio) ||
              resultDate.isAtSameMomentAs(datainicio)) &&
          (resultDate.isBefore(datafinal) ||
              resultDate.isAtSameMomentAs(datafinal)) &&
          (result['media_type'] == tipo);
    } catch (e) {
      // Ignora o item se ocorrer erro na conversão da data
      return false;
    }
  }).toList();

  // Soma os valores da variável especificada
  int soma = 0;
  for (var result in filteredResults) {
    try {
      soma += int.parse(result[variavel].toString());
    } catch (e) {
      // Trata casos onde a conversão para int pode falhar
    }
  }

  return soma;
}

List<int>? tabeladadosdiariosX(
  DateTime? datainicio,
  DateTime? datafinal,
  dynamic insightsdiarios,
) {
  if (datainicio == null || datafinal == null || insightsdiarios == null) {
    return null;
  }

  try {
    // Usa a lista completa de insightsdiarios sem filtrar por cliente e tipo
    List<dynamic> results = insightsdiarios;

    // Converte as strings de data para DateTime e filtra pelo intervalo informado
    List<DateTime> dateList = [];
    for (var item in results) {
      try {
        if (item != null &&
            item is Map<String, dynamic> &&
            item.containsKey('date') &&
            item['date'] is String) {
          DateTime date = DateTime.parse(item['date']);
          if ((date.isAfter(datainicio) || date.isAtSameMomentAs(datainicio)) &&
              (date.isBefore(datafinal) || date.isAtSameMomentAs(datafinal))) {
            dateList.add(date);
          }
        }
      } catch (e) {
        // Ignora itens com data em formato inválido
      }
    }

    // Ordena as datas em ordem crescente
    dateList.sort();

    // Extrai o dia de cada data e retorna a lista
    List<int> dayList = dateList.map((date) => date.day).toList();

    return dayList;
  } catch (e) {
    return null; // Retorna null em caso de erro inesperado
  }
}

List<int>? tabeladadosdiariosXAds(
  DateTime? datainicio,
  DateTime? datafinal,
  dynamic insightsdiarios,
  String? campanha,
  String? conjunto,
) {
  if (datainicio == null || datafinal == null || insightsdiarios == null) {
    return null;
  }

  try {
    List<dynamic> results = insightsdiarios;

    // Conjunto para garantir datas únicas
    Set<int> uniqueDays = {};

    for (var item in results) {
      try {
        if (item != null &&
            item is Map<String, dynamic> &&
            item.containsKey('date') &&
            item['date'] is String) {
          // Filtros opcionais para campanha e conjunto de anúncios
          bool isCampanhaMatch = (campanha == null || campanha.isEmpty) ||
              (item['campaign_id'] == campanha);
          bool isConjuntoMatch = (conjunto == null || conjunto.isEmpty) ||
              (item['ad_set_id'] == conjunto);

          if (isCampanhaMatch && isConjuntoMatch) {
            DateTime date = DateTime.parse(item['date']);
            if ((date.isAfter(datainicio) ||
                    date.isAtSameMomentAs(datainicio)) &&
                (date.isBefore(datafinal) ||
                    date.isAtSameMomentAs(datafinal))) {
              uniqueDays.add(date.day);
            }
          }
        }
      } catch (e) {
        // Ignora erros individuais
      }
    }

    // Retorna lista ordenada dos dias únicos
    List<int> dayList = uniqueDays.toList()..sort();
    return dayList;
  } catch (e) {
    return null;
  }
}

List<int>? tabeladadosdiariosXGoogle(
  DateTime? datainicio,
  DateTime? datafinal,
  dynamic insightsdiarios,
  String? campanha,
) {
  if (datainicio == null || datafinal == null || insightsdiarios == null) {
    return null;
  }

  try {
    List<dynamic> results = insightsdiarios;

    // Conjunto para garantir datas únicas
    Set<int> uniqueDays = {};

    for (var item in results) {
      try {
        if (item != null &&
            item is Map<String, dynamic> &&
            item.containsKey('date') &&
            item['date'] is String) {
          // Filtros opcionais para campanha e conjunto de anúncios
          bool isCampanhaMatch = (campanha == null || campanha.isEmpty) ||
              (item['campaign_id'] == campanha);

          if (isCampanhaMatch) {
            DateTime date = DateTime.parse(item['date']);
            if ((date.isAfter(datainicio) ||
                    date.isAtSameMomentAs(datainicio)) &&
                (date.isBefore(datafinal) ||
                    date.isAtSameMomentAs(datafinal))) {
              uniqueDays.add(date.day);
            }
          }
        }
      } catch (e) {
        // Ignora erros individuais
      }
    }

    // Retorna lista ordenada dos dias únicos
    List<int> dayList = uniqueDays.toList()..sort();
    return dayList;
  } catch (e) {
    return null;
  }
}

List<int>? tabeladadosdiariosY(
  DateTime? datainicio,
  DateTime? datafinal,
  List<dynamic>? insightsdiarios,
  String? coluna,
) {
  if (datainicio == null ||
      datafinal == null ||
      insightsdiarios == null ||
      coluna == null) {
    return null;
  }

  // Usa toda a lista de insightsdiarios sem filtrar por 'username' ou 'platform'
  List<dynamic> filteredResults = insightsdiarios;

  // Converte as strings de data para DateTime e filtra pelo intervalo informado
  filteredResults = filteredResults.where((item) {
    try {
      DateTime date = DateTime.parse(item['date']);
      return (date.isAfter(datainicio) || date.isAtSameMomentAs(datainicio)) &&
          (date.isBefore(datafinal) || date.isAtSameMomentAs(datafinal));
    } catch (e) {
      return false; // Ignora itens com data em formato inválido
    }
  }).toList();

  // Ordena os resultados por data em ordem crescente
  filteredResults.sort((a, b) {
    DateTime dateA = DateTime.parse(a['date']);
    DateTime dateB = DateTime.parse(b['date']);
    return dateA.compareTo(dateB);
  });

  // Converte os valores do campo especificado por 'analise' para inteiros e retorna a lista
  List<int> parsedValues = [];
  for (var item in filteredResults) {
    try {
      parsedValues.add(int.parse(item[coluna].toString()));
    } catch (e) {
      // Trata casos onde a conversão para int pode falhar
    }
  }

  return parsedValues;
}

List<double>? tabeladadosdiariosYAds(
  DateTime? datainicio,
  DateTime? datafinal,
  List<dynamic>? insightsdiarios,
  String? coluna,
  String? conjunto,
  String? campanha,
) {
  if (datainicio == null ||
      datafinal == null ||
      insightsdiarios == null ||
      coluna == null) {
    // campanha e conjunto agora podem ser nulos
    return null;
  }

  try {
    // Filtra os resultados por data e, opcionalmente, por campanha e conjunto
    List<dynamic> filteredResults = insightsdiarios.where((item) {
      try {
        DateTime date = DateTime.parse(item['date']);

        // Verificação do intervalo de datas
        bool isDateInRange =
            (date.isAfter(datainicio) || date.isAtSameMomentAs(datainicio)) &&
                (date.isBefore(datafinal) || date.isAtSameMomentAs(datafinal));

        // Filtro opcional para a campanha
        bool isCampanhaMatch = (campanha == null || campanha.isEmpty) ||
            (item['campaign_id'] == campanha);

        // Filtro opcional para o conjunto de anúncios
        bool isConjuntoMatch = (conjunto == null || conjunto.isEmpty) ||
            (item['ad_set_id'] == conjunto);

        return isDateInRange && isCampanhaMatch && isConjuntoMatch;
      } catch (e) {
        return false;
      }
    }).toList();

    // Mapa para somar valores por data
    Map<String, double> valoresPorData = {};

    for (var item in filteredResults) {
      try {
        String dateStr = item['date'];
        double valor = double.tryParse(item[coluna].toString()) ?? 0.0;

        if (valoresPorData.containsKey(dateStr)) {
          valoresPorData[dateStr] = valoresPorData[dateStr]! + valor;
        } else {
          valoresPorData[dateStr] = valor;
        }
      } catch (e) {
        // Ignora erros de parsing
      }
    }

    // Ordena as datas e extrai os valores somados
    List<String> sortedDates = valoresPorData.keys.toList()
      ..sort((a, b) => DateTime.parse(a).compareTo(DateTime.parse(b)));

    List<double> valoresSomados =
        sortedDates.map((d) => valoresPorData[d]!).toList();

    return valoresSomados;
  } catch (e) {
    return null;
  }
}

List<double>? tabeladadosdiariosYGoogle(
  DateTime? datainicio,
  DateTime? datafinal,
  List<dynamic>? insightsdiarios,
  String? coluna,
  String? campanha,
) {
  if (datainicio == null ||
      datafinal == null ||
      insightsdiarios == null ||
      coluna == null) {
    // campanha e conjunto agora podem ser nulos
    return null;
  }

  try {
    // Filtra os resultados por data e, opcionalmente, por campanha e conjunto
    List<dynamic> filteredResults = insightsdiarios.where((item) {
      try {
        DateTime date = DateTime.parse(item['date']);

        // Verificação do intervalo de datas
        bool isDateInRange =
            (date.isAfter(datainicio) || date.isAtSameMomentAs(datainicio)) &&
                (date.isBefore(datafinal) || date.isAtSameMomentAs(datafinal));

        // Filtro opcional para a campanha
        bool isCampanhaMatch = (campanha == null || campanha.isEmpty) ||
            (item['campaign_id'] == campanha);

        return isDateInRange && isCampanhaMatch;
      } catch (e) {
        return false;
      }
    }).toList();

    // Mapa para somar valores por data
    Map<String, double> valoresPorData = {};

    for (var item in filteredResults) {
      try {
        String dateStr = item['date'];
        double valor = double.tryParse(item[coluna].toString()) ?? 0.0;

        if (valoresPorData.containsKey(dateStr)) {
          valoresPorData[dateStr] = valoresPorData[dateStr]! + valor;
        } else {
          valoresPorData[dateStr] = valor;
        }
      } catch (e) {
        // Ignora erros de parsing
      }
    }

    // Ordena as datas e extrai os valores somados
    List<String> sortedDates = valoresPorData.keys.toList()
      ..sort((a, b) => DateTime.parse(a).compareTo(DateTime.parse(b)));

    List<double> valoresSomados =
        sortedDates.map((d) => valoresPorData[d]!).toList();

    return valoresSomados;
  } catch (e) {
    return null;
  }
}

List<int>? porcentagemdemografica(
  DateTime? datainicio,
  DateTime? datafinal,
  List<dynamic>? insightsdemograficos,
) {
  // Check if the input parameters are valid
  if (datainicio == null ||
      datafinal == null ||
      insightsdemograficos == null ||
      insightsdemograficos.isEmpty) {
    return null; // Return null if any parameter is invalid
  }

  // Find the first item where the date is between datainicio and datafinal
  var firstItem = insightsdemograficos.firstWhere(
    (item) {
      DateTime itemDate = DateTime.parse(item[
          'collected_date']); // Assuming 'collected_date' is the key for the date
      // A condição abaixo verifica se a data está no intervalo, incluindo os limites (datainicio e datafinal)
      return (itemDate.isAtSameMomentAs(datainicio) ||
              itemDate.isAfter(datainicio)) &&
          (itemDate.isAtSameMomentAs(datafinal) ||
              itemDate.isBefore(datafinal));
    },
    orElse: () => null, // Return null if no item is found
  );

  // If no item is found, return null
  if (firstItem == null) {
    return null;
  }

  // Sum the values from the specified columns
  int age13_17m = firstItem['age_13_17M'] ?? 0;
  int age18_24m = firstItem['age_18_24M'] ?? 0;
  int age25_34m = firstItem['age_25_34M'] ?? 0;
  int age35_44m = firstItem['age_35_44M'] ?? 0;
  int age45_54m = firstItem['age_45_54M'] ?? 0;
  int age55_64m = firstItem['age_55_64M'] ?? 0;
  int age65m = firstItem['age_65_M'] ?? 0;

  int age13_17f = firstItem['age_13_17F'] ?? 0;
  int age18_24f = firstItem['age_18_24F'] ?? 0;
  int age25_34f = firstItem['age_25_34F'] ?? 0;
  int age35_44f = firstItem['age_35_44F'] ?? 0;
  int age45_54f = firstItem['age_45_54F'] ?? 0;
  int age55_64f = firstItem['age_55_64F'] ?? 0;
  int age65f = firstItem['age_65_F'] ?? 0;

  int age13_17i = firstItem['age_13_17I'] ?? 0;
  int age18_24i = firstItem['age_18_24I'] ?? 0;
  int age25_34i = firstItem['age_25_34I'] ?? 0;
  int age35_44i = firstItem['age_35_44I'] ?? 0;
  int age45_54i = firstItem['age_45_54I'] ?? 0;
  int age55_64i = firstItem['age_55_64I'] ?? 0;
  int age65i = firstItem['age_65_I'] ?? 0;

  // Retorna uma lista com as somas dos valores masculinos e femininos
  return [
    age13_17m +
        age18_24m +
        age25_34m +
        age35_44m +
        age45_54m +
        age55_64m +
        age65m,
    age13_17f +
        age18_24f +
        age25_34f +
        age35_44f +
        age45_54f +
        age55_64f +
        age65f,
    age13_17i +
        age18_24i +
        age25_34i +
        age35_44i +
        age45_54i +
        age55_64i +
        age65i,
  ];
}

List<dynamic>? filtrarcontas(
  List<dynamic>? contasretiradas,
  List<ContasRecord>? contasdousuario,
) {
  final Set<String> contasIds = {
    for (var conta in contasdousuario ?? []) conta.idconta
  };

  // Filter contasretiradas to exclude items with account_id in contasIds
  final filteredContas = contasretiradas?.where((conta) {
    // Assuming each conta in contasretiradas has an 'account_id' field
    return !contasIds.contains(conta['account_id']);
  }).toList();

  return filteredContas;
}

int? mediadisplaypost(
  List<dynamic>? insightspost,
  String variavel,
  DateTime datainicio,
  DateTime datafinal,
  String? tipo,
) {
  if (insightspost == null) return null;
  // Filtra a lista de insights com base nas condições fornecidas,
  // incluindo a comparação do valor da coluna 'tipo' com o argumento 'tipo'
  List<dynamic> filteredResults = insightspost.where((result) {
    try {
      DateTime resultDate = DateTime.parse(result['post_timestamp']);
      return (resultDate.isAfter(datainicio) ||
              resultDate.isAtSameMomentAs(datainicio)) &&
          (resultDate.isBefore(datafinal) ||
              resultDate.isAtSameMomentAs(datafinal)) &&
          (result['media_type'] == tipo);
    } catch (e) {
      // Ignora o item se ocorrer erro na conversão da data
      return false;
    }
  }).toList();

  // Verifica se há resultados filtrados para evitar divisão por zero
  if (filteredResults.isEmpty) return 0;

  // Soma os valores da variável especificada e conta os itens válidos
  int soma = 0;
  int count = 0;
  for (var result in filteredResults) {
    try {
      soma += int.parse(result[variavel].toString());
      count++;
    } catch (e) {
      // Trata casos onde a conversão para int pode falhar
    }
  }
  if (count == 0) return 0;

  // Calcula a média e arredonda para o inteiro mais próximo
  int media = (soma / count).round();
  return media;
}

List<dynamic>? listaposts(
  List<dynamic> insightspost,
  DateTime datainicio,
  DateTime datafinal,
  String? tipo,
) {
  List<dynamic> filteredPosts = insightspost.where((post) {
    DateTime postDate =
        DateTime.parse(post['post_timestamp']); // 'date' é a chave para a data
    return (postDate.isAfter(datainicio) ||
            postDate.isAtSameMomentAs(datainicio)) &&
        (postDate.isBefore(datafinal) || postDate.isAtSameMomentAs(datafinal));
  }).toList();

  // Ordena os posts filtrados pela coluna especificada (do maior para o menor)
  if (tipo != null) {
    filteredPosts.sort((a, b) {
      return b[tipo].compareTo(a[tipo]);
    });
  }

  return filteredPosts;
}

dynamic filtrorelatorio(
  List<dynamic>? listarelatorio,
  DateTime? datainicio,
  DateTime? datafinal,
) {
  // from listarelatorio parse date column to datetime and return the first item where date is between datainicio and datafinal including datafinal and datainicio
  if (listarelatorio == null || datainicio == null || datafinal == null) {
    return null;
  }

  for (var item in listarelatorio) {
    DateTime itemDate = DateTime.parse(
        item['date']); // Assuming 'date' is the key for the date column
    if (itemDate.isAfter(datainicio.subtract(Duration(days: 1))) &&
        itemDate.isBefore(datafinal.add(Duration(days: 1)))) {
      return item;
    }
  }

  return null;
}

List<dynamic>? filtroads(
  List<dynamic>? listaads,
  DateTime? datainicio,
  DateTime? datafinal,
  String? campanha,
  String? conjunto,
  String? coluna,
) {
  if (listaads == null ||
      datainicio == null ||
      datafinal == null ||
      coluna == null) {
    return null;
  }

  try {
    // Filtra os itens por data e, opcionalmente, por campanha e conjunto
    List<dynamic> filtrados = listaads.where((item) {
      try {
        DateTime itemDate = DateTime.parse(item['date']);

        // Verifica o intervalo de datas
        bool isDateInRange =
            itemDate.isAfter(datainicio.subtract(Duration(days: 1))) &&
                itemDate.isBefore(datafinal.add(Duration(days: 1)));

        // Filtro opcional para a campanha
        bool isCampanhaMatch = (campanha == null || campanha.isEmpty) ||
            (item['campaign_id'] == campanha);

        // Filtro opcional para o conjunto de anúncios
        bool isConjuntoMatch = (conjunto == null || conjunto.isEmpty) ||
            (item['ad_set_id'] == conjunto);

        // Retorna true somente se todas as condições forem verdadeiras
        return isDateInRange && isCampanhaMatch && isConjuntoMatch;
      } catch (e) {
        return false;
      }
    }).toList();

    // Ordena os itens com base na coluna
    filtrados.sort((a, b) {
      num valorA = num.tryParse(a[coluna].toString()) ?? 0;
      num valorB = num.tryParse(b[coluna].toString()) ?? 0;

      if (['cpc', 'cpm', 'cpp'].contains(coluna.toLowerCase())) {
        // Ordem crescente
        return valorA.compareTo(valorB);
      } else {
        // Ordem decrescente
        return valorB.compareTo(valorA);
      }
    });

    return filtrados;
  } catch (e) {
    return null;
  }
}

List<dynamic>? filtrogoogle(
  List<dynamic>? listaads,
  DateTime? datainicio,
  DateTime? datafinal,
  String? campanha,
  String? coluna,
) {
  if (listaads == null ||
      datainicio == null ||
      datafinal == null ||
      coluna == null) {
    return null;
  }

  try {
    // Filtra os itens por data e, opcionalmente, por campanha e conjunto
    List<dynamic> filtrados = listaads.where((item) {
      try {
        DateTime itemDate = DateTime.parse(item['date']);

        // Verifica o intervalo de datas
        bool isDateInRange =
            itemDate.isAfter(datainicio.subtract(Duration(days: 1))) &&
                itemDate.isBefore(datafinal.add(Duration(days: 1)));

        // Filtro opcional para a campanha
        bool isCampanhaMatch = (campanha == null || campanha.isEmpty) ||
            (item['campaign_id'] == campanha);

        // Retorna true somente se todas as condições forem verdadeiras
        return isDateInRange && isCampanhaMatch;
      } catch (e) {
        return false;
      }
    }).toList();

    // Ordena os itens com base na coluna
    filtrados.sort((a, b) {
      num valorA = num.tryParse(a[coluna].toString()) ?? 0;
      num valorB = num.tryParse(b[coluna].toString()) ?? 0;

      return valorB.compareTo(valorA);
    });

    return filtrados;
  } catch (e) {
    return null;
  }
}

dynamic filtroanuncios(
  List<dynamic>? listaads,
  DateTime? datainicio,
  DateTime? datafinal,
  String? campanha,
  String? conjunto,
) {
  if (listaads == null ||
      datainicio == null ||
      datafinal == null ||
      campanha == null ||
      conjunto == null) {
    return null;
  }

  for (var item in listaads) {
    try {
      DateTime itemDate = DateTime.parse(item['date']);

      if (itemDate.isAfter(datainicio.subtract(Duration(days: 1))) &&
          itemDate.isBefore(datafinal.add(Duration(days: 1))) &&
          item['campaign_id'] == campanha &&
          item['ad_set_id'] == conjunto) {
        return item;
      }
    } catch (e) {
      // Ignora itens inválidos
    }
  }

  return null;
}

dynamic filtrarestrategia(
  DateTime? datafinal,
  List<dynamic>? listaestrategia,
) {
// from listaestrategia parse date column as datetime and remove all items where date is after datafinal, from this item return the item where date is the most recent
  if (datafinal == null || listaestrategia == null) return null;

  // Parse date column and filter items
  List<dynamic> filteredList = listaestrategia.where((item) {
    DateTime itemDate =
        DateTime.parse(item['data_de_update']); // Assuming 'date' is the key
    return itemDate.isBefore(datafinal) || itemDate.isAtSameMomentAs(datafinal);
  }).toList();

  // Return the most recent item
  if (filteredList.isEmpty) return null;

  filteredList.sort(
      (a, b) => DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));
  return filteredList.first;
}

String? list2string(String? jsonList) {
  if (jsonList == null || jsonList.isEmpty) return null;
  try {
    List<dynamic> decoded = jsonDecode(jsonList);
    List<String> stringList = List<String>.from(decoded);
    return stringList.join('\n');
  } catch (e) {
    return jsonList; // fallback para o texto original caso não seja JSON válido
  }
}

bool? vernull(dynamic json) {
  // if json response is {"error":"Nenhum dado encontrado"} return false
  if (json is Map<String, dynamic> &&
      json['error'] == 'Nenhum dado encontrado em generated_reports') {
    return false;
  }
  return true;
}

dynamic fixsafari(String? link) {
  if (link != null && link.contains("www.dropbox.com")) {
    return link.replaceFirst("www.dropbox.com", "dl.dropboxusercontent.com");
  }
  return link;
}

bool? vernullcom(dynamic json) {
  // check if value is null or empty, if it is return true
  return json == null || (json is String && json.isEmpty);
}

String? stringify(List<String> list) {
  // get all list items in order and convert into a string, starting with [ and putting "" before and after the item and a comma between every item, closing with an ]
  if (list.isEmpty) return '[]';
  return '[' + list.map((item) => '"$item"').join(', ') + ']';
}

String? stringifylist(List<dynamic>? list) {
  return jsonEncode(list);
}

String? encode(dynamic stringjson) {
  return jsonEncode(stringjson);
}

List<String>? listacampanhameta(
  DateTime? dataInicio,
  DateTime? dataFinal,
  List<dynamic>? insightsmeta,
  String? campo,
) {
  if (dataInicio == null || dataFinal == null || insightsmeta == null) {
    return [];
  }

  try {
    List<dynamic> filteredData = insightsmeta
        .where((item) => item != null && item is Map<String, dynamic>)
        .toList();

    List<String> valoresUnicos = filteredData
        .where((item) {
          try {
            DateTime date = DateTime.parse(item['date']);
            return date.isAfter(dataInicio.subtract(const Duration(days: 1))) &&
                date.isBefore(dataFinal.add(const Duration(days: 1)));
          } catch (e) {
            return false;
          }
        })
        .map((item) => item[campo])
        .whereType<String>()
        .toSet()
        .toList();

    return valoresUnicos;
  } catch (e) {
    return [];
  }
}

List<String>? listaconjuntometa(
  DateTime? dataInicio,
  DateTime? dataFinal,
  List<dynamic>? insightsmeta,
  String? campo,
  String? campaignid,
) {
  if (dataInicio == null || dataFinal == null || insightsmeta == null) {
    return [];
  }

  try {
    List<dynamic> filteredData = insightsmeta
        .where((item) =>
            item != null &&
            item is Map<String, dynamic> &&
            item['campaign_id'] == campaignid)
        .toList();

    List<String> valoresUnicos = filteredData
        .where((item) {
          try {
            DateTime date = DateTime.parse(item['date']);
            return date.isAfter(dataInicio.subtract(const Duration(days: 1))) &&
                date.isBefore(dataFinal.add(const Duration(days: 1)));
          } catch (e) {
            return false;
          }
        })
        .map((item) => item[campo])
        .whereType<String>()
        .toSet()
        .toList();

    return valoresUnicos;
  } catch (e) {
    return [];
  }
}

double? fetchdata(
  dynamic dados,
  String? column,
) {
  if (column == null || dados == null) return null;

  try {
    final decodedJson = dados is String ? jsonDecode(dados) : dados;

    if (decodedJson is Map<String, dynamic> &&
        decodedJson.containsKey(column)) {
      final value = decodedJson[column];

      double? result;

      if (value is num) {
        result = value.toDouble();
      } else if (value is String) {
        result = double.tryParse(value);
      }

      if (result != null) {
        return double.parse(result.toStringAsFixed(2));
      }
    }
  } catch (e) {
    // Ignora erros no parsing ou conversão.
    return null;
  }

  return null;
}

String? arredondar(double? valor) {
  // arredonde o valor para duas casas decimais
  if (valor == null) return null;
  return valor.toStringAsFixed(2);
}

double? dividir(
  double? valor,
  double? divisor,
) {
  // divide valor by divisor and return data
  if (divisor == 0) {
    return 0; // Avoid division by zero
  }
  return valor != null && divisor != null ? valor / divisor : null;
}

double? dividirporcentagem(
  double? valor,
  double? divisor,
) {
  // divide valor by divisor and return data
  if (divisor == 0) {
    return 0; // Avoid division by zero
  }
  return valor != null && divisor != null ? valor / divisor * 100 : null;
}

double? dividirpormil(double? valor) {
  // divide valor by 1000
  if (valor == null) return null; // Check for null value
  return valor / 1000; // Divide the value by 1000
}

List<dynamic>? cardscampanha(List<dynamic>? dados) {
  // from dados json make a list of all unique campaign ids and return a json with the values of campaign_name, campaign_id and campaign_inferred_status of each unique item
  if (dados == null) return null;

  Map<String, Map<String, dynamic>> uniqueCampaigns = {};

  for (var item in dados) {
    String campaignId = item['campaign_id'];
    if (!uniqueCampaigns.containsKey(campaignId)) {
      uniqueCampaigns[campaignId] = {
        'campaign_name': item['campaign_name'],
        'campaign_id': campaignId,
        'campaign_inferred_status': item['campaign_inferred_status'],
      };
    }
  }

  return uniqueCampaigns.values.toList();
}

List<dynamic>? cardsconjunto(
  List<dynamic>? dadoscampanha,
  String? idcampanha,
) {
  // from dadoscampanha json filter items where campaign_id = idcampanha and return all itens ordering them by last_active_at, from most to least recent, this field is a string formated as "2025-12-10" and has to be parsed to datetime
  if (dadoscampanha == null || idcampanha == null) return null;

  // Filter items where campaign_id matches idcampanha
  var filteredItems =
      dadoscampanha.where((item) => item['campaign_id'] == idcampanha).toList();

  // Sort items by last_active_at from most to least recent
  filteredItems.sort((a, b) {
    DateTime dateA = DateTime.parse(a['last_active_at']);
    DateTime dateB = DateTime.parse(b['last_active_at']);
    return dateB.compareTo(dateA); // Sort in descending order
  });

  return filteredItems;
}

Color? correcaocor(
  double? porcentagem,
  Color? color,
) {
  // 1. Verificações de Nulidade
  if (porcentagem == null || color == null) return null;

  // 2. Normalizar o Progresso a
  // Como 'porcentagem' já está entre 0.0 e 1.0, usamos diretamente.
  // O clamp() garante que o valor permaneça nesse intervalo seguro.
  final double t = porcentagem.clamp(0.0, 1.0);

  // Aplicar a nova curva personalizada (1 - (1 - t)^15)
  final double curvedT = 1.0 - math.pow(1.0 - t, 15);

  // 3. Calcular o Alpha Final (0 a 255)
  final int alpha = (255 * curvedT).round().clamp(0, 255);

  // 4. Retornar a Cor com Alpha Ajustado
  return color.withAlpha(alpha);
}

List<double>? percentificar(List<double>? valores) {
// 1. Verificação básica de nulidade ou lista vazia
  if (valores == null || valores.isEmpty) return null;

  // 2. Calcula o total da soma
  double total = valores.reduce((a, b) => a + b);

  // 3. Verificação crucial: se o total for 0, todos os itens devem retornar 0%
  // Isso evita a divisão por zero (0 / 0)
  if (total == 0) {
    return List.filled(valores.length, 0.0);
  }

  // 4. Mapeia os valores para suas respectivas porcentagens
  return valores.map((value) {
    // Se o valor individual for 0, o resultado será 0.0 naturalmente
    double porcentagem = (value / total) * 100;

    // Arredondamento para 2 casas decimais
    return (porcentagem * 100).round() / 100.0;
  }).toList();
}

List<dynamic>? filtrocrm(
  List<dynamic>? dadoscrm,
  String? nome,
  String? status,
  double? valormin,
  double? valormax,
  DateTime? datacinicio,
  DateTime? datacfinal,
  DateTime? datafinicio,
  DateTime? dataffinal,
  DateTime? dataminicio,
  DateTime? datamfinal,
  String? campopers,
  String? valorpers,
  String? email,
) {
  if (dadoscrm == null) return null;

  return dadoscrm.where((item) {
    bool matches = true;

    // --- FILTRO DE NOME ---
    if (nome != null && nome.isNotEmpty) {
      final nomeDePesquisa = nome.toLowerCase();
      final nomeDoItem = item['nome']?.toLowerCase() ?? '';
      matches = matches && nomeDoItem.contains(nomeDePesquisa);
    }

    // --- FILTRO DE NOME ---
    if (email != null && email.isNotEmpty) {
      final emailDePesquisa = email.toLowerCase();
      final emailDoItem = item['email']?.toLowerCase() ?? '';
      matches = matches && emailDoItem.contains(emailDePesquisa);
    }

    // --- FILTRO DE STATUS ---
    if (status != null && status.isNotEmpty) {
      matches = matches && (item['status'] == status);
    }

    // --- FILTROS DE VALOR MÁXIMO E MÍNIMO (CORRIGIDO) ---
    // Tenta converter o valor do item para double. Se falhar (null, string inválida),
    // ele usa 0.0, mas essa é a variável que será comparada.
    final double valorDoItem =
        double.tryParse(item['valor_da_negociacao']?.toString() ?? '') ?? 0.0;

    final bool temFiltroDeValor = valormin != null || valormax != null;

    // Se houver algum filtro de valor, avaliamos o item:
    if (temFiltroDeValor) {
      // 1. REGRA: Se o item tem valor 0.0 (indicando nulo/inválido) E
      // o filtro MÍNIMO for maior que 0.0, o item é ocultado.
      if (valorDoItem == 0.0 && (valormin ?? 0.0) > 0.0) {
        matches = false;
      }
      // 2. REGRA: Se o item tem valor válido, aplicamos os filtros:
      else {
        // Se VALOR MÍNIMO está preenchido, o item deve ser MAIOR ou IGUAL a ele.
        if (valormin != null) {
          matches = matches && (valorDoItem >= valormin);
        }

        // Se VALOR MÁXIMO está preenchido, o item deve ser MENOR ou IGUAL a ele.
        if (valormax != null) {
          matches = matches && (valorDoItem <= valormax);
        }
      }
    }

    // --- FILTROS DE DATA DE CRIAÇÃO (data_de_entrada) ---
    // Conversão segura e verificação
    final DateTime? dataCriacao =
        DateTime.tryParse(item['data_de_entrada']?.toString() ?? '');

    if (datacinicio != null) {
      // Se a data de criação for nula, e houver filtro de início, o item é ocultado.
      if (dataCriacao == null) {
        matches = false;
      } else {
        // Verifica se a data de entrada é DEPOIS da data de início
        matches = matches && (dataCriacao.isAfter(datacinicio));
      }
    }
    if (datacfinal != null) {
      if (dataCriacao == null) {
        matches = false;
      } else {
        // Verifica se a data de entrada é ANTES da data final
        matches = matches && (dataCriacao.isBefore(datacfinal));
      }
    }

    // --- FILTRO DE DATA DE FECHAMENTO (data_de_fechamento) ---
    // 1. Tenta analisar a data de fechamento (dataFechamento é null se for nula/inválida).
    final DateTime? dataFechamento =
        DateTime.tryParse(item['data_de_fechamento']?.toString() ?? '');

    // Verifica se há alguma data de filtro de fechamento preenchida
    final bool temFiltroDeFechamento =
        datafinicio != null || dataffinal != null;

    // Se houver um filtro preenchido E a data de fechamento for nula, o item NÃO corresponde.
    if (temFiltroDeFechamento && dataFechamento == null) {
      matches = false;
    }
    // Se houver uma data de fechamento válida, aplica os filtros de intervalo
    else if (dataFechamento != null) {
      // Filtro de Data Inicial
      if (datafinicio != null) {
        matches = matches && dataFechamento.isAfter(datafinicio);
      }

      // Filtro de Data Final
      if (dataffinal != null) {
        matches = matches && dataFechamento.isBefore(dataffinal);
      }
    }

    // --- FILTROS DE DATA DE MOVIMENTAÇÃO (data_da_ultima_movimentacao) ---
    // Conversão segura e verificação
    final DateTime? dataMovimentacao = DateTime.tryParse(
        item['data_da_ultima_movimentacao']?.toString() ?? '');

    if (dataminicio != null) {
      if (dataMovimentacao == null) {
        matches = false;
      } else {
        matches = matches && (dataMovimentacao.isAfter(dataminicio));
      }
    }
    if (datamfinal != null) {
      if (dataMovimentacao == null) {
        matches = false;
      } else {
        matches = matches && (dataMovimentacao.isBefore(datamfinal));
      }
    }

    // --- FILTRO DE CAMPO PERSONALIZADO (campopers e valorpers) ---
    if (campopers != null &&
        campopers.isNotEmpty &&
        valorpers != null &&
        valorpers.isNotEmpty) {
      // 1. Acessa o valor do campo personalizado de forma segura e converte para minúsculas
      final String valorDoCampo =
          item['campos_adicionais'][campopers]?.toString().toLowerCase() ?? '';

      // 2. Converte o valor de pesquisa para minúsculas
      final String valorDePesquisa = valorpers.toLowerCase();

      // 3. Verifica se o valor do item contém o valor de pesquisa
      matches = matches && valorDoCampo.contains(valorDePesquisa);
    }

    return matches;
  }).toList();
}

List<CrmLeadsTesteRecord>? filtrocrmfirabase(
  List<CrmLeadsTesteRecord>? dadoscrm,
  String? nome,
  String? status,
  double? valormin,
  double? valormax,
  DateTime? datacinicio,
  DateTime? datacfinal,
  DateTime? datafinicio,
  DateTime? dataffinal,
  DateTime? dataminicio,
  DateTime? datamfinal,
  String? campopers,
  String? valorpers,
  String? email,
  String? responsavel,
) {
  // 1. Garantia de que se a entrada for nula, retornamos uma lista vazia em vez de null
  if (dadoscrm == null) {
    return [];
  }

  return dadoscrm.where((document) {
    // Filtro de Nome
    final matchesNome = (nome == null || nome.isEmpty) ||
        (document.nome.toLowerCase().contains(nome.toLowerCase()));

    // Filtro de Status
    final matchesStatus =
        (status == null || status.isEmpty) || document.status == status;

    // Filtro de responsavel
    final matchesResponsavel = (responsavel == null || responsavel.isEmpty) ||
        document.responsavel == responsavel;

    // Filtro de Valor (Tratando 0 como vazio se necessário, ou apenas null)
    final matchesValorMin =
        (valormin == null) || (document.valorNegociacao >= valormin);
    final matchesValorMax =
        (valormax == null) || (document.valorNegociacao <= valormax);

    // Filtros de Data (Verificando se o campo no documento não é nulo antes de comparar)
    final matchesDataInicio = (datacinicio == null) ||
        (document.dataEntrada != null &&
            (document.dataEntrada!.isAfter(datacinicio) ||
                document.dataEntrada!.isAtSameMomentAs(datacinicio)));

    final matchesDataFinal = (datacfinal == null) ||
        (document.dataEntrada != null &&
            (document.dataEntrada!.isBefore(datacfinal) ||
                document.dataEntrada!.isAtSameMomentAs(datacfinal)));

    final matchesDataMinInicio = (dataminicio == null) ||
        (document.dataDaUltimaMovimentacao != null &&
            (document.dataDaUltimaMovimentacao!.isAfter(dataminicio) ||
                document.dataDaUltimaMovimentacao!
                    .isAtSameMomentAs(dataminicio)));

    final matchesDataMinFinal = (datamfinal == null) ||
        (document.dataDaUltimaMovimentacao != null &&
            (document.dataDaUltimaMovimentacao!.isBefore(datamfinal) ||
                document.dataDaUltimaMovimentacao!
                    .isAtSameMomentAs(datamfinal)));

    final matchesDataFinInicio = (datafinicio == null) ||
        (document.dataDeFechamento != null &&
            (document.dataDeFechamento!.isAfter(datafinicio) ||
                document.dataDeFechamento!.isAtSameMomentAs(datafinicio)));

    final matchesDataFinFinal = (dataffinal == null) ||
        (document.dataDeFechamento != null &&
            (document.dataDeFechamento!.isBefore(dataffinal) ||
                document.dataDeFechamento!.isAtSameMomentAs(dataffinal)));

    // Filtro de Email
    final matchesEmail =
        (email == null || email.isEmpty) || (document.contato.email == email);

    // Filtro de Dados Extras (Só filtra se campopers e valorpers existirem)
    bool matchesExtras = true;
    if (campopers != null &&
        campopers.isNotEmpty &&
        valorpers != null &&
        valorpers.isNotEmpty) {
      matchesExtras = document.dadosExtras.any((extra) =>
          extra.titulo == campopers &&
          (extra.valor == valorpers || extra.valor.contains(valorpers)));
    }

    // Retorna verdadeiro apenas se passar em TODOS os critérios
    return matchesNome &&
        matchesStatus &&
        matchesResponsavel &&
        matchesValorMin &&
        matchesValorMax &&
        matchesDataInicio &&
        matchesDataFinal &&
        matchesDataMinInicio &&
        matchesDataMinFinal &&
        matchesDataFinInicio &&
        matchesDataFinFinal &&
        matchesEmail &&
        matchesExtras;
  }).toList();
}

int? filtrocrmcoluna(
  List<CrmLeadsTesteRecord>? dadoscrm,
  String? status,
) {
  // from dadoscrm list filter items where status = status column and return the nummber of items
  if (dadoscrm == null || status == null) {
    return null;
  }

  return dadoscrm.where((lead) => lead.status == status).length;
}

DateTime? datetimeparse(String? data) {
  // Se a string de data estiver no formato XX/XX/XXXX, analise o valor
  // da string para o formato datetime.
  if (data == null || data.isEmpty) return null;
  try {
    // 'dd/MM/yyyy' garante que o formato esperado (dia/mês/ano) seja respeitado
    return DateFormat('dd/MM/yyyy').parse(data);
  } catch (e) {
    // Retorna null em caso de falha na análise (ex: formato incorreto, data inválida)
    return null;
  }
}

List<String>? listastatus(List<dynamic>? crm) {
  // from crm get all unique values of $.status
  if (crm == null) return null;
  Set<String> uniqueStatuses = {};
  for (var item in crm) {
    if (item['status'] != null) {
      uniqueStatuses.add(item['status']);
    }
  }
  return uniqueStatuses.toList();
}

List<String>? campospersonalizados(List<dynamic>? crm) {
  // from crm return all field names from $.campos_adicionais json field
  if (crm == null) return null;
  List<String> fieldNames = [];

  for (var item in crm) {
    if (item['campos_adicionais'] != null) {
      var camposAdicionais = item['campos_adicionais'];
      if (camposAdicionais is Map) {
        fieldNames.addAll(
            camposAdicionais.keys.map((key) => key.toString()).toList());
      }
    }
  }

  return fieldNames.isNotEmpty ? fieldNames : null;
}

dynamic list2json(List<dynamic>? listjson) {
  // from list json get the first item, return item
  if (listjson != null && listjson.isNotEmpty) {
    return listjson.first; // Return the first item from the list
  }
  return null; // Return null if the list is null or empty
}

int? string2int(String? texto) {
  // parse texto as int
  if (texto == null) {
    return null; // Return null if the input is null
  }
  try {
    return int.parse(texto); // Attempt to parse the string as an integer
  } catch (e) {
    return null; // Return null if parsing fails
  }
}

List<dynamic>? camposadicionais(dynamic camposadicionaislist) {
  // from camposadicionais return a list  with "titulo": map name and "valor": map value for all columns of the json
  if (camposadicionaislist == null) return null;

  List<dynamic> result = [];
  camposadicionaislist.forEach((key, value) {
    result.add({
      "titulo": key,
      "valor": value,
    });
  });
  return result;
}

double? adddata(
  double? value1,
  double? value2,
  double? value3,
) {
  // add value1, value2 and value3 if any of them is null consider their value as 0
  return (value1 ?? 0) + (value2 ?? 0) + (value3 ?? 0);
}

double? somacrm(List<CrmLeadsTesteRecord>? crm) {
  // from crm document list give the sum value of valor_da_negociacao column
  if (crm == null) return null;
  return crm.fold<double>(
      0, (sum, record) => sum + (record.valorNegociacao ?? 0));
}

List<dynamic>? adicionaratualizacaocrm(
  List<dynamic>? listaentrada,
  String? datadeentrada,
  String? texto,
  String? tipo,
) {
  // add an item to lista de entrada json with the following values "data_de_entrada" = datadeentrada string, "texto"= texto string, "tipo"= tipo string, return the complete list
  if (listaentrada == null) {
    listaentrada = [];
  }

  // Create a new entry
  final newEntry = {
    "data_de_entrada": datadeentrada,
    "texto": texto,
    "tipo": tipo,
  };

  // Add the new entry to the list
  listaentrada.add(newEntry);

  // Return the updated list
  return listaentrada;
}

List<HistoricoStruct>? editarhistoricocrm(
  List<HistoricoStruct>? historico,
  int? indexnumber,
  String? texto,
  String? tipo,
  DateTime? data,
) {
  // from dados adicionais datatype, get the item in indexnumber index and replace titulo value with titulo and valor value with valor, return the full corrected list
  if (historico == null ||
      indexnumber == null ||
      indexnumber < 0 ||
      indexnumber >= historico.length) {
    return historico; // Return original list if input is invalid
  }

  // Create a copy of the list to avoid modifying the original
  List<HistoricoStruct> updatedList = List.from(historico);

  // Update the specified index with new titulo and valor
  updatedList[indexnumber] =
      HistoricoStruct(texto: texto, tipo: tipo, dataDeEntrada: data);

  return updatedList; // Return the updated list
}

List<DadosextrasStruct>? editarcamposextrascrmCopy(
  List<DadosextrasStruct>? dadosadicionais,
  int? indexnumber,
  String? titulo,
  String? valor,
) {
  // from dados adicionais datatype, get the item in indexnumber index and replace titulo value with titulo and valor value with valor, return the full corrected list
  if (dadosadicionais == null ||
      indexnumber == null ||
      indexnumber < 0 ||
      indexnumber >= dadosadicionais.length) {
    return dadosadicionais; // Return original list if input is invalid
  }

  // Create a copy of the list to avoid modifying the original
  List<DadosextrasStruct> updatedList = List.from(dadosadicionais);

  // Update the specified index with new titulo and valor
  updatedList[indexnumber] = DadosextrasStruct(titulo: titulo, valor: valor);

  return updatedList; // Return the updated list
}

List<ContascconvidadasStruct>? editarresponsavelcrm(
  List<ContascconvidadasStruct>? contasconvidadas,
  int? indexnumber,
  String? userid,
  String? nome,
  bool? admin,
) {
  // from dados adicionais datatype, get the item in indexnumber index and replace titulo value with titulo and valor value with valor, return the full corrected list
  if (contasconvidadas == null ||
      indexnumber == null ||
      indexnumber < 0 ||
      indexnumber >= contasconvidadas.length) {
    return contasconvidadas; // Return original list if input is invalid
  }

  // Create a copy of the list to avoid modifying the original
  List<ContascconvidadasStruct> updatedList = List.from(contasconvidadas);

  // Update the specified index with new titulo and valor
  updatedList[indexnumber] =
      ContascconvidadasStruct(userId: userid, nome: nome, permission: admin);

  return updatedList; // Return the updated list
}
