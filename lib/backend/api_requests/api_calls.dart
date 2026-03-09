import 'dart:convert';
import '../cloud_functions/cloud_functions.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApi';

class ContasCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
    String? authCode = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ContasCall',
        'variables': {
          'userId': userId,
          'authCode': authCode,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ContasGoogleCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
    String? authCode = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ContasGoogleCall',
        'variables': {
          'userId': userId,
          'authCode': authCode,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class AccountIdsCall {
  static Future<ApiCallResponse> call({
    List<String>? accountIdList,
    String? userId = '',
  }) async {
    final accountId = _serializeList(accountIdList);

    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'AccountIdsCall',
        'variables': {
          'accountId': accountId,
          'userId': userId,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosMensaisCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosMensaisCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CronogramaCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CronogramaCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  static List? cronograma(dynamic response) => getJsonField(
        response,
        r'''$''',
        true,
      ) as List?;
}

class DadosEstrategiaCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosEstrategiaCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosPostsCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosPostsCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  static List? post(dynamic response) => getJsonField(
        response,
        r'''$''',
        true,
      ) as List?;
}

class DadosAdsCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
    String? filterValue3 = '',
    String? filterColumn3 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosAdsCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
          'filterValue3': filterValue3,
          'filterColumn3': filterColumn3,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosConjuntosCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
    String? filterValue3 = '',
    String? filterColumn3 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosConjuntosCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
          'filterValue3': filterValue3,
          'filterColumn3': filterColumn3,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosCRMCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
    String? filterValue3 = '',
    String? filterColumn3 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosCRMCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
          'filterValue3': filterValue3,
          'filterColumn3': filterColumn3,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class IadataCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
    String? filterValue3 = '',
    String? filterColumn3 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'IadataCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
          'filterValue3': filterValue3,
          'filterColumn3': filterColumn3,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosAdsMensalCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
    String? filterColumn3 = '',
    String? filterValue3 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosAdsMensalCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
          'filterColumn3': filterColumn3,
          'filterValue3': filterValue3,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosGoogleCampanhaCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
    String? filterColumn3 = '',
    String? filterValue3 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosGoogleCampanhaCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
          'filterColumn3': filterColumn3,
          'filterValue3': filterValue3,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosGoogleConfiguracoesCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
    String? filterColumn3 = '',
    String? filterValue3 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosGoogleConfiguracoesCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
          'filterColumn3': filterColumn3,
          'filterValue3': filterValue3,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosGoogleDemografiaCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
    String? filterColumn3 = '',
    String? filterValue3 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosGoogleDemografiaCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
          'filterColumn3': filterColumn3,
          'filterValue3': filterValue3,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosGooglePalavrasChaveCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
    String? filterColumn3 = '',
    String? filterValue3 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosGooglePalavrasChaveCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
          'filterColumn3': filterColumn3,
          'filterValue3': filterValue3,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosGoogleTermoDeBuscaCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
    String? filterColumn3 = '',
    String? filterValue3 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosGoogleTermoDeBuscaCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
          'filterColumn3': filterColumn3,
          'filterValue3': filterValue3,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosGoogleTermoDeBuscaMensalCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
    String? filterColumn3 = '',
    String? filterValue3 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosGoogleTermoDeBuscaMensalCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
          'filterColumn3': filterColumn3,
          'filterValue3': filterValue3,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosGooglePalavrasChaveMensalCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
    String? filterColumn3 = '',
    String? filterValue3 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosGooglePalavrasChaveMensalCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
          'filterColumn3': filterColumn3,
          'filterValue3': filterValue3,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosGoogleDemografiaMensalCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
    String? filterColumn3 = '',
    String? filterValue3 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosGoogleDemografiaMensalCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
          'filterColumn3': filterColumn3,
          'filterValue3': filterValue3,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosGoogleCampanhaMensalCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
    String? filterColumn3 = '',
    String? filterValue3 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosGoogleCampanhaMensalCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
          'filterColumn3': filterColumn3,
          'filterValue3': filterValue3,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosComentariosCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosComentariosCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosFormularioCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosFormularioCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosFormularioMasterCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosFormularioMasterCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DemografiaCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterColumn2 = '',
    String? filterValue2 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DemografiaCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterColumn2': filterColumn2,
          'filterValue2': filterValue2,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosDiariosCall {
  static Future<ApiCallResponse> call({
    String? filterColumn = '',
    String? filterValue = '',
    String? filterValue2 = '',
    String? filterColumn2 = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosDiariosCall',
        'variables': {
          'filterColumn': filterColumn,
          'filterValue': filterValue,
          'filterValue2': filterValue2,
          'filterColumn2': filterColumn2,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosAtuaisInstaCall {
  static Future<ApiCallResponse> call({
    String? accountId = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosAtuaisInstaCall',
        'variables': {
          'accountId': accountId,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DadosAtuaisFaceCall {
  static Future<ApiCallResponse> call({
    String? accountId = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DadosAtuaisFaceCall',
        'variables': {
          'accountId': accountId,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class EnvioestrategiaCall {
  static Future<ApiCallResponse> call({
    String? relatedId = '',
    String? dataDeUpdate = '',
    String? descricaoDaEmpresa = '',
    String? caracteristicaMaisElogiada = '',
    List<String>? adjetivosAssociadosList,
    List<String>? adjetivosNaoAssociarList,
    List<String>? faixaEtariaMediaList,
    String? generoPredominante = '',
    List<String>? caracteristicasInteracaoList,
    List<String>? segmentosClientesList,
    List<String>? objetivosComunicacaoList,
    String? frequenciaPlanejada = '',
    String? userId = '',
    String? infosAdicionais = '',
  }) async {
    final adjetivosAssociados = _serializeList(adjetivosAssociadosList);
    final adjetivosNaoAssociar = _serializeList(adjetivosNaoAssociarList);
    final faixaEtariaMedia = _serializeList(faixaEtariaMediaList);
    final caracteristicasInteracao =
        _serializeList(caracteristicasInteracaoList);
    final segmentosClientes = _serializeList(segmentosClientesList);
    final objetivosComunicacao = _serializeList(objetivosComunicacaoList);

    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'EnvioestrategiaCall',
        'variables': {
          'relatedId': relatedId,
          'dataDeUpdate': dataDeUpdate,
          'descricaoDaEmpresa': descricaoDaEmpresa,
          'caracteristicaMaisElogiada': caracteristicaMaisElogiada,
          'adjetivosAssociados': adjetivosAssociados,
          'adjetivosNaoAssociar': adjetivosNaoAssociar,
          'faixaEtariaMedia': faixaEtariaMedia,
          'generoPredominante': generoPredominante,
          'caracteristicasInteracao': caracteristicasInteracao,
          'segmentosClientes': segmentosClientes,
          'objetivosComunicacao': objetivosComunicacao,
          'frequenciaPlanejada': frequenciaPlanejada,
          'userId': userId,
          'infosAdicionais': infosAdicionais,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class AtualizarCrmCall {
  static Future<ApiCallResponse> call({
    int? id,
    String? nome = '',
    String? telefone = '',
    String? email = '',
    String? userId = '',
    String? relatedId = '',
    double? valorDaNegociacao,
    String? dataDeEntrada = '',
    String? dataDeFechamento = '',
    dynamic atualizacoesJson,
    dynamic camposAdicionaisJson,
    String? status = '',
    String? dataDaUltimaMovimentacao = '',
    bool? delete,
  }) async {
    final atualizacoes = _serializeJson(atualizacoesJson, true);
    final camposAdicionais = _serializeJson(camposAdicionaisJson);
    final ffApiRequestBody = '''
{
  "id": ${id},
  "nome": "${escapeStringForJson(nome)}",
  "telefone": "${escapeStringForJson(telefone)}",
  "email": "${escapeStringForJson(email)}",
  "user_id": "${escapeStringForJson(userId)}",
  "related_id": "${escapeStringForJson(relatedId)}",
  "status": "${escapeStringForJson(status)}",
  "valor_da_negociacao": ${valorDaNegociacao},
  "data_de_entrada": "${escapeStringForJson(dataDeEntrada)}",
  "data_de_fechamento": "${escapeStringForJson(dataDeFechamento)}",
  "data_da_ultima_movimentacao": "${escapeStringForJson(dataDaUltimaMovimentacao)}",
  "atualizacoes": ${atualizacoes},
  "campos_adicionais": ${camposAdicionais},
  "delete": ${delete}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'atualizar crm',
      apiUrl:
          'https://update-clientes-crm-239094714054.southamerica-east1.run.app',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class EnvioestrategiaGoogleCall {
  static Future<ApiCallResponse> call({
    String? relatedId = '',
    String? dataDeUpdate = '',
    String? descricaoDaEmpresa = '',
    String? diferencialDosConcorrentes = '',
    List<String>? adjetivosAssociadosList,
    List<String>? adjetivosNaoAssociarList,
    List<String>? faixaEtariaMediaList,
    String? generoPredominante = '',
    List<String>? caracteristicasInteracaoList,
    List<String>? segmentosClientesList,
    List<String>? objetivosCampanhaList,
    String? userId = '',
    String? infosAdicionais = '',
    String? termosRelacionados = '',
    String? termosIndesejados = '',
    String? localizacaoDosClientes = '',
    String? produtosAAnunciar = '',
    String? investimentoMensal = '',
  }) async {
    final adjetivosAssociados = _serializeList(adjetivosAssociadosList);
    final adjetivosNaoAssociar = _serializeList(adjetivosNaoAssociarList);
    final faixaEtariaMedia = _serializeList(faixaEtariaMediaList);
    final caracteristicasInteracao =
        _serializeList(caracteristicasInteracaoList);
    final segmentosClientes = _serializeList(segmentosClientesList);
    final objetivosCampanha = _serializeList(objetivosCampanhaList);

    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'EnvioestrategiaGoogleCall',
        'variables': {
          'relatedId': relatedId,
          'dataDeUpdate': dataDeUpdate,
          'descricaoDaEmpresa': descricaoDaEmpresa,
          'diferencialDosConcorrentes': diferencialDosConcorrentes,
          'adjetivosAssociados': adjetivosAssociados,
          'adjetivosNaoAssociar': adjetivosNaoAssociar,
          'faixaEtariaMedia': faixaEtariaMedia,
          'generoPredominante': generoPredominante,
          'caracteristicasInteracao': caracteristicasInteracao,
          'segmentosClientes': segmentosClientes,
          'objetivosCampanha': objetivosCampanha,
          'userId': userId,
          'infosAdicionais': infosAdicionais,
          'termosRelacionados': termosRelacionados,
          'termosIndesejados': termosIndesejados,
          'localizacaoDosClientes': localizacaoDosClientes,
          'produtosAAnunciar': produtosAAnunciar,
          'investimentoMensal': investimentoMensal,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class EnvioestrategiaMasterCall {
  static Future<ApiCallResponse> call({
    String? relatedId = '',
    String? dataDeUpdate = '',
    String? descricaoDaEmpresa = '',
    String? diferencialDosConcorrentes = '',
    List<String>? adjetivosAssociadosList,
    List<String>? adjetivosNaoAssociarList,
    List<String>? faixaEtariaMediaList,
    String? generoPredominante = '',
    List<String>? caracteristicasInteracaoList,
    List<String>? segmentosClientesList,
    List<String>? objetivosCampanhaGoogleList,
    String? userId = '',
    String? infosAdicionais = '',
    String? termosRelacionados = '',
    String? termosIndesejados = '',
    String? localizacaoDosClientes = '',
    String? produtosAAnunciarGoogle = '',
    String? investimentoMensalGoogle = '',
    String? concorrentes = '',
    String? produtosAAnunciarMeta = '',
    String? interessesDoPublico = '',
    String? comportamentosDoPublico = '',
    List<String>? objetivosComunicacaoOrganicaList,
    List<String>? objetivosCampanhaMetaadsList,
    String? investimentoMensalMetaads = '',
    List<String>? recursosDeConteudoList,
    String? frequenciaPlanejada = '',
    List<String>? plataformasConectadasList,
    String? relatedUsername = '',
  }) async {
    final adjetivosAssociados = _serializeList(adjetivosAssociadosList);
    final adjetivosNaoAssociar = _serializeList(adjetivosNaoAssociarList);
    final faixaEtariaMedia = _serializeList(faixaEtariaMediaList);
    final caracteristicasInteracao =
        _serializeList(caracteristicasInteracaoList);
    final segmentosClientes = _serializeList(segmentosClientesList);
    final objetivosCampanhaGoogle = _serializeList(objetivosCampanhaGoogleList);
    final objetivosComunicacaoOrganica =
        _serializeList(objetivosComunicacaoOrganicaList);
    final objetivosCampanhaMetaads =
        _serializeList(objetivosCampanhaMetaadsList);
    final recursosDeConteudo = _serializeList(recursosDeConteudoList);
    final plataformasConectadas = _serializeList(plataformasConectadasList);

    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'EnvioestrategiaMasterCall',
        'variables': {
          'relatedId': relatedId,
          'dataDeUpdate': dataDeUpdate,
          'descricaoDaEmpresa': descricaoDaEmpresa,
          'diferencialDosConcorrentes': diferencialDosConcorrentes,
          'adjetivosAssociados': adjetivosAssociados,
          'adjetivosNaoAssociar': adjetivosNaoAssociar,
          'faixaEtariaMedia': faixaEtariaMedia,
          'generoPredominante': generoPredominante,
          'caracteristicasInteracao': caracteristicasInteracao,
          'segmentosClientes': segmentosClientes,
          'objetivosCampanhaGoogle': objetivosCampanhaGoogle,
          'userId': userId,
          'infosAdicionais': infosAdicionais,
          'termosRelacionados': termosRelacionados,
          'termosIndesejados': termosIndesejados,
          'localizacaoDosClientes': localizacaoDosClientes,
          'produtosAAnunciarGoogle': produtosAAnunciarGoogle,
          'investimentoMensalGoogle': investimentoMensalGoogle,
          'concorrentes': concorrentes,
          'produtosAAnunciarMeta': produtosAAnunciarMeta,
          'interessesDoPublico': interessesDoPublico,
          'comportamentosDoPublico': comportamentosDoPublico,
          'objetivosComunicacaoOrganica': objetivosComunicacaoOrganica,
          'objetivosCampanhaMetaads': objetivosCampanhaMetaads,
          'investimentoMensalMetaads': investimentoMensalMetaads,
          'recursosDeConteudo': recursosDeConteudo,
          'frequenciaPlanejada': frequenciaPlanejada,
          'plataformasConectadas': plataformasConectadas,
          'relatedUsername': relatedUsername,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class EnvioestrategiaMetaCall {
  static Future<ApiCallResponse> call({
    String? relatedId = '',
    String? dataDeUpdate = '',
    String? descricaoDaEmpresa = '',
    String? diferencialDosConcorrentes = '',
    List<String>? adjetivosAssociadosList,
    List<String>? adjetivosNaoAssociarList,
    List<String>? faixaEtariaMediaList,
    String? generoPredominante = '',
    List<String>? caracteristicasInteracaoList,
    List<String>? segmentosClientesList,
    List<String>? objetivosCampanhaList,
    String? userId = '',
    String? infosAdicionais = '',
    String? localizacaoDosClientes = '',
    String? produtosAAnunciar = '',
    String? investimentoMensal = '',
    String? concorrentes = '',
    String? interessesDoPublico = '',
    String? comportamentosDoPublico = '',
    List<String>? recursosDeConteudoList,
  }) async {
    final adjetivosAssociados = _serializeList(adjetivosAssociadosList);
    final adjetivosNaoAssociar = _serializeList(adjetivosNaoAssociarList);
    final faixaEtariaMedia = _serializeList(faixaEtariaMediaList);
    final caracteristicasInteracao =
        _serializeList(caracteristicasInteracaoList);
    final segmentosClientes = _serializeList(segmentosClientesList);
    final objetivosCampanha = _serializeList(objetivosCampanhaList);
    final recursosDeConteudo = _serializeList(recursosDeConteudoList);

    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'EnvioestrategiaMetaCall',
        'variables': {
          'relatedId': relatedId,
          'dataDeUpdate': dataDeUpdate,
          'descricaoDaEmpresa': descricaoDaEmpresa,
          'diferencialDosConcorrentes': diferencialDosConcorrentes,
          'adjetivosAssociados': adjetivosAssociados,
          'adjetivosNaoAssociar': adjetivosNaoAssociar,
          'faixaEtariaMedia': faixaEtariaMedia,
          'generoPredominante': generoPredominante,
          'caracteristicasInteracao': caracteristicasInteracao,
          'segmentosClientes': segmentosClientes,
          'objetivosCampanha': objetivosCampanha,
          'userId': userId,
          'infosAdicionais': infosAdicionais,
          'localizacaoDosClientes': localizacaoDosClientes,
          'produtosAAnunciar': produtosAAnunciar,
          'investimentoMensal': investimentoMensal,
          'concorrentes': concorrentes,
          'interessesDoPublico': interessesDoPublico,
          'comportamentosDoPublico': comportamentosDoPublico,
          'recursosDeConteudo': recursosDeConteudo,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class EnviocomentarioCall {
  static Future<ApiCallResponse> call({
    String? id = '',
    String? usuario = '',
    String? comentario = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'EnviocomentarioCall',
        'variables': {
          'id': id,
          'usuario': usuario,
          'comentario': comentario,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class AprovacaocronogramaCall {
  static Future<ApiCallResponse> call({
    String? idpost = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'AprovacaocronogramaCall',
        'variables': {
          'idpost': idpost,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class EditarRelatorioCall {
  static Future<ApiCallResponse> call({
    String? id = '',
    String? meta = '',
    String? relatorio = '',
    String? sugestoes = '',
    String? metasPassadas = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'EditarRelatorioCall',
        'variables': {
          'id': id,
          'meta': meta,
          'relatorio': relatorio,
          'sugestoes': sugestoes,
          'metasPassadas': metasPassadas,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class AdicionarNovoCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
    String? accountId = '',
    String? username = '',
    String? accessToken = '',
    String? platform = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'AdicionarNovoCall',
        'variables': {
          'userId': userId,
          'accountId': accountId,
          'username': username,
          'accessToken': accessToken,
          'platform': platform,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ResetarRelatorioCall {
  static Future<ApiCallResponse> call({
    String? id = '',
    String? relatedId = '',
    String? userId = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ResetarRelatorioCall',
        'variables': {
          'id': id,
          'relatedId': relatedId,
          'userId': userId,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class AvaliarRelatorioCall {
  static Future<ApiCallResponse> call({
    String? id = '',
    String? comentarios = '',
    String? classificacao = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'AvaliarRelatorioCall',
        'variables': {
          'id': id,
          'comentarios': comentarios,
          'classificacao': classificacao,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ResetarComentarioCall {
  static Future<ApiCallResponse> call({
    String? relatedId = '',
    String? userId = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ResetarComentarioCall',
        'variables': {
          'relatedId': relatedId,
          'userId': userId,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class VincularCrmCall {
  static Future<ApiCallResponse> call({
    String? fbId = '',
    String? igId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "fb_id": "${escapeStringForJson(fbId)}",
  "ig_id": "${escapeStringForJson(igId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Vincular crm',
      apiUrl:
          'https://webhook-meta-ativacao-239094714054.southamerica-east1.run.app',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
