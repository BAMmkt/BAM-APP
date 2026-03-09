const axios = require("axios").default;
const qs = require("qs");

async function _contasCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var userId = ffVariables["userId"];
  var authCode = ffVariables["authCode"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/contas`;
  var headers = {};
  var params = {};
  var ffApiRequestBody = `
{
  "user_id": "${escapeStringForJson(userId)}",
  "auth_code": "${escapeStringForJson(authCode)}"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _contasGoogleCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var userId = ffVariables["userId"];
  var authCode = ffVariables["authCode"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/google_contas`;
  var headers = {};
  var params = {};
  var ffApiRequestBody = `
{
  "user_id": "${escapeStringForJson(userId)}",
  "auth_code": "${escapeStringForJson(authCode)}"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _accountIdsCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var accountId = ffVariables["accountId"];
  var userId = ffVariables["userId"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/conta_ativa`;
  var headers = {};
  var params = {};
  var ffApiRequestBody = `
{
  "account_id": ${accountId},
  "user_id":"${escapeStringForJson(userId)}"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosMensaisCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `user_insights_monthly`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _cronogramaCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `cronogramas_ordenados`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosEstrategiaCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `generated_reports`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosPostsCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `posts_insights`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosAdsCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];
  var filterValue3 = ffVariables["filterValue3"];
  var filterColumn3 = ffVariables["filterColumn3"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `meta_ads_P3`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
    filter_column3: filterColumn3,
    filter_value3: filterValue3,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosConjuntosCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];
  var filterValue3 = ffVariables["filterValue3"];
  var filterColumn3 = ffVariables["filterColumn3"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `meta_ads_sets`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
    filter_column3: filterColumn3,
    filter_value3: filterValue3,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosCRMCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];
  var filterValue3 = ffVariables["filterValue3"];
  var filterColumn3 = ffVariables["filterColumn3"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `clientes_crm`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
    filter_column3: filterColumn3,
    filter_value3: filterValue3,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _iadataCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];
  var filterValue3 = ffVariables["filterValue3"];
  var filterColumn3 = ffVariables["filterColumn3"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `ia_training_reports`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
    filter_column3: filterColumn3,
    filter_value3: filterValue3,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosAdsMensalCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];
  var filterColumn3 = ffVariables["filterColumn3"];
  var filterValue3 = ffVariables["filterValue3"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `meta_ads_P3_mensal`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
    filter_column3: filterColumn3,
    filter_value3: filterValue3,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosGoogleCampanhaCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];
  var filterColumn3 = ffVariables["filterColumn3"];
  var filterValue3 = ffVariables["filterValue3"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `google_ads_campaign_performance`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
    filter_column3: filterColumn3,
    filter_value3: filterValue3,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosGoogleConfiguracoesCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];
  var filterColumn3 = ffVariables["filterColumn3"];
  var filterValue3 = ffVariables["filterValue3"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `google_ads_strategy_data`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
    filter_column3: filterColumn3,
    filter_value3: filterValue3,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosGoogleDemografiaCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];
  var filterColumn3 = ffVariables["filterColumn3"];
  var filterValue3 = ffVariables["filterValue3"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `google_ads_demographics`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
    filter_column3: filterColumn3,
    filter_value3: filterValue3,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosGooglePalavrasChaveCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];
  var filterColumn3 = ffVariables["filterColumn3"];
  var filterValue3 = ffVariables["filterValue3"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `google_ads_keyword_performance`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
    filter_column3: filterColumn3,
    filter_value3: filterValue3,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosGoogleTermoDeBuscaCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];
  var filterColumn3 = ffVariables["filterColumn3"];
  var filterValue3 = ffVariables["filterValue3"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `google_ads_search_term_performance`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
    filter_column3: filterColumn3,
    filter_value3: filterValue3,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosGoogleTermoDeBuscaMensalCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];
  var filterColumn3 = ffVariables["filterColumn3"];
  var filterValue3 = ffVariables["filterValue3"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `google_ads_search_term_performance_monthly`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
    filter_column3: filterColumn3,
    filter_value3: filterValue3,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosGooglePalavrasChaveMensalCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];
  var filterColumn3 = ffVariables["filterColumn3"];
  var filterValue3 = ffVariables["filterValue3"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `google_ads_keyword_performance_monthly`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
    filter_column3: filterColumn3,
    filter_value3: filterValue3,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosGoogleDemografiaMensalCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];
  var filterColumn3 = ffVariables["filterColumn3"];
  var filterValue3 = ffVariables["filterValue3"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `google_ads_demographics_monthly`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
    filter_column3: filterColumn3,
    filter_value3: filterValue3,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosGoogleCampanhaMensalCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];
  var filterColumn3 = ffVariables["filterColumn3"];
  var filterValue3 = ffVariables["filterValue3"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `google_ads_campaign_performance_monthly`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
    filter_column3: filterColumn3,
    filter_value3: filterValue3,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosComentariosCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `analise_comentarios`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosFormularioCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `estrategia`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosFormularioMasterCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `estrategia_master`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _demografiaCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterColumn2 = ffVariables["filterColumn2"];
  var filterValue2 = ffVariables["filterValue2"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `ig_follower_demographics`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosDiariosCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var filterColumn = ffVariables["filterColumn"];
  var filterValue = ffVariables["filterValue"];
  var filterValue2 = ffVariables["filterValue2"];
  var filterColumn2 = ffVariables["filterColumn2"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/flutterflow-data`;
  var headers = {};
  var params = {
    table: `user_insights`,
    filter_column: filterColumn,
    filter_value: filterValue,
    filter_column2: filterColumn2,
    filter_value2: filterValue2,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosAtuaisInstaCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var accountId = ffVariables["accountId"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/ig_dados_perfil`;
  var headers = {};
  var params = {};
  var ffApiRequestBody = `
{
  "account_id": "${escapeStringForJson(accountId)}"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _dadosAtuaisFaceCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var accountId = ffVariables["accountId"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/fb_dados_perfil`;
  var headers = {};
  var params = {};
  var ffApiRequestBody = `
{
  "page_id": "${escapeStringForJson(accountId)}"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _envioestrategiaCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var relatedId = ffVariables["relatedId"];
  var dataDeUpdate = ffVariables["dataDeUpdate"];
  var descricaoDaEmpresa = ffVariables["descricaoDaEmpresa"];
  var caracteristicaMaisElogiada = ffVariables["caracteristicaMaisElogiada"];
  var adjetivosAssociados = ffVariables["adjetivosAssociados"];
  var adjetivosNaoAssociar = ffVariables["adjetivosNaoAssociar"];
  var faixaEtariaMedia = ffVariables["faixaEtariaMedia"];
  var generoPredominante = ffVariables["generoPredominante"];
  var caracteristicasInteracao = ffVariables["caracteristicasInteracao"];
  var segmentosClientes = ffVariables["segmentosClientes"];
  var objetivosComunicacao = ffVariables["objetivosComunicacao"];
  var frequenciaPlanejada = ffVariables["frequenciaPlanejada"];
  var userId = ffVariables["userId"];
  var infosAdicionais = ffVariables["infosAdicionais"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/armazena_estrategias`;
  var headers = {};
  var params = {};
  var ffApiRequestBody = `
{
  "related_id": "${escapeStringForJson(relatedId)}",
  "data_de_update": "${escapeStringForJson(dataDeUpdate)}",
  "descricao_da_empresa": "${escapeStringForJson(descricaoDaEmpresa)}",
  "caracteristica_mais_elogiada": "${escapeStringForJson(caracteristicaMaisElogiada)}",
  "adjetivos_associados": "${adjetivosAssociados}",
  "adjetivos_nao_associar": "${adjetivosNaoAssociar}",
  "faixa_etaria_media": "${faixaEtariaMedia}",
  "genero_predominante": "${escapeStringForJson(generoPredominante)}",
  "caracteristicas_interacao": "${caracteristicasInteracao}",
  "segmentos_clientes": "${segmentosClientes}",
  "objetivos_comunicacao": "${objetivosComunicacao}",
  "frequencia_planejada": "${escapeStringForJson(frequenciaPlanejada)}",
  "user_id": "${escapeStringForJson(userId)}",
  "infos_adicionais": "${escapeStringForJson(infosAdicionais)}"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _envioestrategiaGoogleCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var relatedId = ffVariables["relatedId"];
  var dataDeUpdate = ffVariables["dataDeUpdate"];
  var descricaoDaEmpresa = ffVariables["descricaoDaEmpresa"];
  var diferencialDosConcorrentes = ffVariables["diferencialDosConcorrentes"];
  var adjetivosAssociados = ffVariables["adjetivosAssociados"];
  var adjetivosNaoAssociar = ffVariables["adjetivosNaoAssociar"];
  var faixaEtariaMedia = ffVariables["faixaEtariaMedia"];
  var generoPredominante = ffVariables["generoPredominante"];
  var caracteristicasInteracao = ffVariables["caracteristicasInteracao"];
  var segmentosClientes = ffVariables["segmentosClientes"];
  var objetivosCampanha = ffVariables["objetivosCampanha"];
  var userId = ffVariables["userId"];
  var infosAdicionais = ffVariables["infosAdicionais"];
  var termosRelacionados = ffVariables["termosRelacionados"];
  var termosIndesejados = ffVariables["termosIndesejados"];
  var localizacaoDosClientes = ffVariables["localizacaoDosClientes"];
  var produtosAAnunciar = ffVariables["produtosAAnunciar"];
  var investimentoMensal = ffVariables["investimentoMensal"];

  var url = `https://armazena-estrategia-google-ads-239094714054.southamerica-east1.run.app`;
  var headers = {};
  var params = {};
  var ffApiRequestBody = `
{
  "related_id": "${escapeStringForJson(relatedId)}",
  "data_de_update": "${escapeStringForJson(dataDeUpdate)}",
  "descricao_da_empresa": "${escapeStringForJson(descricaoDaEmpresa)}",
  "produtos_a_anunciar": "${escapeStringForJson(produtosAAnunciar)}",
  "diferencial_dos_concorrentes": "${escapeStringForJson(diferencialDosConcorrentes)}",
  "termos_relacionados": "${escapeStringForJson(termosRelacionados)}",
  "termos_indesejados": "${escapeStringForJson(termosIndesejados)}",
  "adjetivos_associados": ${adjetivosAssociados},
  "adjetivos_nao_associar": ${adjetivosNaoAssociar},
  "faixa_etaria_media": ${faixaEtariaMedia},
  "genero_predominante": "${escapeStringForJson(generoPredominante)}",
  "localizacao_dos_clientes": "${escapeStringForJson(localizacaoDosClientes)}",
  "caracteristicas_interacao": ${caracteristicasInteracao},
  "segmentos_clientes": ${segmentosClientes},
  "objetivos_campanha": ${objetivosCampanha},
  "investimento_mensal": "${escapeStringForJson(investimentoMensal)}",
  "user_id": "${escapeStringForJson(userId)}",
  "infos_adicionais": "${escapeStringForJson(infosAdicionais)}"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _envioestrategiaMasterCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var relatedId = ffVariables["relatedId"];
  var dataDeUpdate = ffVariables["dataDeUpdate"];
  var descricaoDaEmpresa = ffVariables["descricaoDaEmpresa"];
  var diferencialDosConcorrentes = ffVariables["diferencialDosConcorrentes"];
  var adjetivosAssociados = ffVariables["adjetivosAssociados"];
  var adjetivosNaoAssociar = ffVariables["adjetivosNaoAssociar"];
  var faixaEtariaMedia = ffVariables["faixaEtariaMedia"];
  var generoPredominante = ffVariables["generoPredominante"];
  var caracteristicasInteracao = ffVariables["caracteristicasInteracao"];
  var segmentosClientes = ffVariables["segmentosClientes"];
  var objetivosCampanhaGoogle = ffVariables["objetivosCampanhaGoogle"];
  var userId = ffVariables["userId"];
  var infosAdicionais = ffVariables["infosAdicionais"];
  var termosRelacionados = ffVariables["termosRelacionados"];
  var termosIndesejados = ffVariables["termosIndesejados"];
  var localizacaoDosClientes = ffVariables["localizacaoDosClientes"];
  var produtosAAnunciarGoogle = ffVariables["produtosAAnunciarGoogle"];
  var investimentoMensalGoogle = ffVariables["investimentoMensalGoogle"];
  var concorrentes = ffVariables["concorrentes"];
  var produtosAAnunciarMeta = ffVariables["produtosAAnunciarMeta"];
  var interessesDoPublico = ffVariables["interessesDoPublico"];
  var comportamentosDoPublico = ffVariables["comportamentosDoPublico"];
  var objetivosComunicacaoOrganica =
    ffVariables["objetivosComunicacaoOrganica"];
  var objetivosCampanhaMetaads = ffVariables["objetivosCampanhaMetaads"];
  var investimentoMensalMetaads = ffVariables["investimentoMensalMetaads"];
  var recursosDeConteudo = ffVariables["recursosDeConteudo"];
  var frequenciaPlanejada = ffVariables["frequenciaPlanejada"];
  var plataformasConectadas = ffVariables["plataformasConectadas"];
  var relatedUsername = ffVariables["relatedUsername"];

  var url = `https://armazena-estrategia-master-239094714054.southamerica-east1.run.app`;
  var headers = {};
  var params = {};
  var ffApiRequestBody = `
{
  "related_id": "${escapeStringForJson(relatedId)}",
  "related_username": "${escapeStringForJson(relatedUsername)}",
  "plataformas_ids": ${plataformasConectadas},
  "descricao_da_empresa": "${escapeStringForJson(descricaoDaEmpresa)}",
  "concorrentes": "${escapeStringForJson(concorrentes)}",
  "diferencial_dos_concorrentes": "${escapeStringForJson(diferencialDosConcorrentes)}",
  "produtos_a_anunciar_google": "${escapeStringForJson(produtosAAnunciarGoogle)}",
  "produtos_a_anunciar_meta": "${escapeStringForJson(produtosAAnunciarMeta)}",
  "termos_relacionados": "${escapeStringForJson(termosRelacionados)}",
  "termos_indesejados": "${escapeStringForJson(termosIndesejados)}",
  "adjetivos_associados": ${adjetivosAssociados},
  "adjetivos_nao_associar": ${adjetivosNaoAssociar},
  "faixa_etaria_media": ${faixaEtariaMedia},
  "genero_predominante": "${escapeStringForJson(generoPredominante)}",
  "localizacao_dos_clientes": "${escapeStringForJson(localizacaoDosClientes)}",
  "interesses_do_publico": "${escapeStringForJson(interessesDoPublico)}",
  "comportamentos_do_publico": "${escapeStringForJson(comportamentosDoPublico)}",
  "caracteristicas_interacao": ${caracteristicasInteracao},
  "segmentos_clientes": ${segmentosClientes},
  "objetivos_comunicacao_organica": ${objetivosComunicacaoOrganica},
  "objetivos_campanha_google": ${objetivosCampanhaGoogle},
  "investimento_mensal_google": "${escapeStringForJson(investimentoMensalGoogle)}",
  "objetivos_campanha_metaads": ${objetivosCampanhaMetaads},
  "investimento_mensal_metaads": "${escapeStringForJson(investimentoMensalMetaads)}",
  "recursos_de_conteudo": ${recursosDeConteudo},
  "frequencia_planejada": "${escapeStringForJson(frequenciaPlanejada)}",
  "user_id": "${escapeStringForJson(userId)}",
  "infos_adicionais": "${escapeStringForJson(infosAdicionais)}"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _envioestrategiaMetaCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var relatedId = ffVariables["relatedId"];
  var dataDeUpdate = ffVariables["dataDeUpdate"];
  var descricaoDaEmpresa = ffVariables["descricaoDaEmpresa"];
  var diferencialDosConcorrentes = ffVariables["diferencialDosConcorrentes"];
  var adjetivosAssociados = ffVariables["adjetivosAssociados"];
  var adjetivosNaoAssociar = ffVariables["adjetivosNaoAssociar"];
  var faixaEtariaMedia = ffVariables["faixaEtariaMedia"];
  var generoPredominante = ffVariables["generoPredominante"];
  var caracteristicasInteracao = ffVariables["caracteristicasInteracao"];
  var segmentosClientes = ffVariables["segmentosClientes"];
  var objetivosCampanha = ffVariables["objetivosCampanha"];
  var userId = ffVariables["userId"];
  var infosAdicionais = ffVariables["infosAdicionais"];
  var localizacaoDosClientes = ffVariables["localizacaoDosClientes"];
  var produtosAAnunciar = ffVariables["produtosAAnunciar"];
  var investimentoMensal = ffVariables["investimentoMensal"];
  var concorrentes = ffVariables["concorrentes"];
  var interessesDoPublico = ffVariables["interessesDoPublico"];
  var comportamentosDoPublico = ffVariables["comportamentosDoPublico"];
  var recursosDeConteudo = ffVariables["recursosDeConteudo"];

  var url = `https://armazena-estrategia-meta-ads-239094714054.southamerica-east1.run.app`;
  var headers = {};
  var params = {};
  var ffApiRequestBody = `
{
  "related_id": "${escapeStringForJson(relatedId)}",
  "data_de_update": "${escapeStringForJson(dataDeUpdate)}",
  "descricao_da_empresa": "${escapeStringForJson(descricaoDaEmpresa)}",
  "produtos_a_anunciar": "${escapeStringForJson(produtosAAnunciar)}",
  "concorrentes":"${escapeStringForJson(concorrentes)}",
  "diferencial_dos_concorrentes": "${escapeStringForJson(diferencialDosConcorrentes)}",
  "adjetivos_associados": ${adjetivosAssociados},
  "adjetivos_nao_associar": ${adjetivosNaoAssociar},
  "faixa_etaria_media": ${faixaEtariaMedia},
  "genero_predominante": "${escapeStringForJson(generoPredominante)}",
  "localizacao_dos_clientes": "${escapeStringForJson(localizacaoDosClientes)}",
  "interesses_do_publico":"${escapeStringForJson(interessesDoPublico)}",
  "comportamentos_do_publico":"${escapeStringForJson(comportamentosDoPublico)}",
  "caracteristicas_interacao": ${caracteristicasInteracao},
  "segmentos_clientes": ${segmentosClientes},
  "recursos_de_conteudo":${recursosDeConteudo},
  "objetivos_campanha": ${objetivosCampanha},
  "investimento_mensal":"${escapeStringForJson(investimentoMensal)}",
  "user_id": "${escapeStringForJson(userId)}",
  "infos_adicionais": "${escapeStringForJson(infosAdicionais)}"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _enviocomentarioCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var id = ffVariables["id"];
  var usuario = ffVariables["usuario"];
  var comentario = ffVariables["comentario"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/comentarios_cronogramas`;
  var headers = {};
  var params = {};
  var ffApiRequestBody = `
{
  "id": "${escapeStringForJson(id)}",
  "comentarios": {
    "${escapeStringForJson(usuario)}": "${escapeStringForJson(comentario)}"
  }
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _aprovacaocronogramaCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var idpost = ffVariables["idpost"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/aprova_cronogramas`;
  var headers = {};
  var params = {};
  var ffApiRequestBody = `
{
  "id": "${escapeStringForJson(idpost)}"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _editarRelatorioCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var id = ffVariables["id"];
  var meta = ffVariables["meta"];
  var relatorio = ffVariables["relatorio"];
  var sugestoes = ffVariables["sugestoes"];
  var metasPassadas = ffVariables["metasPassadas"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/edita-relatorios`;
  var headers = {};
  var params = {};
  var ffApiRequestBody = `
{
  "id": "${escapeStringForJson(id)}",
  "relatorio": "${escapeStringForJson(relatorio)}",
  "metas_proximo_mes": "${escapeStringForJson(meta)}",
  "sugestoes_de_conteudo": "${escapeStringForJson(sugestoes)}",
  "metas_passadas": "${escapeStringForJson(metasPassadas)}"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _adicionarNovoCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var userId = ffVariables["userId"];
  var accountId = ffVariables["accountId"];
  var username = ffVariables["username"];
  var accessToken = ffVariables["accessToken"];
  var platform = ffVariables["platform"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/conta_ativa`;
  var headers = {};
  var params = {};
  var ffApiRequestBody = `
{
  "user_id": "${escapeStringForJson(userId)}",
  "account_id": "${escapeStringForJson(accountId)}",
  "username": "${escapeStringForJson(username)}",
  "access_token": "${escapeStringForJson(accessToken)}",
  "platform": "${escapeStringForJson(platform)}"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _resetarRelatorioCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var id = ffVariables["id"];
  var relatedId = ffVariables["relatedId"];
  var userId = ffVariables["userId"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/prep_dados_analise`;
  var headers = {};
  var params = {};
  var ffApiRequestBody = `
{
  "id_relatorio": "${escapeStringForJson(id)}",
  "user_id": "${escapeStringForJson(userId)}",
  "related_id": "${escapeStringForJson(relatedId)}"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _avaliarRelatorioCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var id = ffVariables["id"];
  var comentarios = ffVariables["comentarios"];
  var classificacao = ffVariables["classificacao"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/classificacao_relatorios`;
  var headers = {};
  var params = {};
  var ffApiRequestBody = `
{
  "id_relatorio": "${escapeStringForJson(id)}",
  "classificacao": "${escapeStringForJson(classificacao)}",
  "comentarios": "${escapeStringForJson(comentarios)}"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}
async function _resetarComentarioCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var relatedId = ffVariables["relatedId"];
  var userId = ffVariables["userId"];

  var url = `https://southamerica-east1-bam-geo-416915.cloudfunctions.net/prep_dados_analise_comentarios_cn`;
  var headers = {};
  var params = {};
  var ffApiRequestBody = `
{
  "user_id": "${escapeStringForJson(userId)}",
  "related_id": "${escapeStringForJson(relatedId)}"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
    isStreamingApi: false,
  });
}

/// Helper functions to route to the appropriate API Call.

async function makeApiCall(context, data) {
  var callName = data["callName"] || "";
  var variables = data["variables"] || {};

  const callMap = {
    ContasCall: _contasCall,
    ContasGoogleCall: _contasGoogleCall,
    AccountIdsCall: _accountIdsCall,
    DadosMensaisCall: _dadosMensaisCall,
    CronogramaCall: _cronogramaCall,
    DadosEstrategiaCall: _dadosEstrategiaCall,
    DadosPostsCall: _dadosPostsCall,
    DadosAdsCall: _dadosAdsCall,
    DadosConjuntosCall: _dadosConjuntosCall,
    DadosCRMCall: _dadosCRMCall,
    IadataCall: _iadataCall,
    DadosAdsMensalCall: _dadosAdsMensalCall,
    DadosGoogleCampanhaCall: _dadosGoogleCampanhaCall,
    DadosGoogleConfiguracoesCall: _dadosGoogleConfiguracoesCall,
    DadosGoogleDemografiaCall: _dadosGoogleDemografiaCall,
    DadosGooglePalavrasChaveCall: _dadosGooglePalavrasChaveCall,
    DadosGoogleTermoDeBuscaCall: _dadosGoogleTermoDeBuscaCall,
    DadosGoogleTermoDeBuscaMensalCall: _dadosGoogleTermoDeBuscaMensalCall,
    DadosGooglePalavrasChaveMensalCall: _dadosGooglePalavrasChaveMensalCall,
    DadosGoogleDemografiaMensalCall: _dadosGoogleDemografiaMensalCall,
    DadosGoogleCampanhaMensalCall: _dadosGoogleCampanhaMensalCall,
    DadosComentariosCall: _dadosComentariosCall,
    DadosFormularioCall: _dadosFormularioCall,
    DadosFormularioMasterCall: _dadosFormularioMasterCall,
    DemografiaCall: _demografiaCall,
    DadosDiariosCall: _dadosDiariosCall,
    DadosAtuaisInstaCall: _dadosAtuaisInstaCall,
    DadosAtuaisFaceCall: _dadosAtuaisFaceCall,
    EnvioestrategiaCall: _envioestrategiaCall,
    EnvioestrategiaGoogleCall: _envioestrategiaGoogleCall,
    EnvioestrategiaMasterCall: _envioestrategiaMasterCall,
    EnvioestrategiaMetaCall: _envioestrategiaMetaCall,
    EnviocomentarioCall: _enviocomentarioCall,
    AprovacaocronogramaCall: _aprovacaocronogramaCall,
    EditarRelatorioCall: _editarRelatorioCall,
    AdicionarNovoCall: _adicionarNovoCall,
    ResetarRelatorioCall: _resetarRelatorioCall,
    AvaliarRelatorioCall: _avaliarRelatorioCall,
    ResetarComentarioCall: _resetarComentarioCall,
  };

  if (!(callName in callMap)) {
    return {
      statusCode: 400,
      error: `API Call "${callName}" not defined as private API.`,
    };
  }

  var apiCall = callMap[callName];
  var response = await apiCall(context, variables);
  return response;
}

async function makeApiRequest({
  method,
  url,
  headers,
  params,
  body,
  returnBody,
  isStreamingApi,
}) {
  return axios
    .request({
      method: method,
      url: url,
      headers: headers,
      params: params,
      responseType: isStreamingApi ? "stream" : "json",
      ...(body && { data: body }),
    })
    .then((response) => {
      return {
        statusCode: response.status,
        headers: response.headers,
        ...(returnBody && { body: response.data }),
        isStreamingApi: isStreamingApi,
      };
    })
    .catch(function (error) {
      return {
        statusCode: error.response.status,
        headers: error.response.headers,
        ...(returnBody && { body: error.response.data }),
        error: error.message,
      };
    });
}

const _unauthenticatedResponse = {
  statusCode: 401,
  headers: {},
  error: "API call requires authentication",
};

function createBody({ headers, params, body, bodyType }) {
  switch (bodyType) {
    case "JSON":
      headers["Content-Type"] = "application/json";
      return body;
    case "TEXT":
      headers["Content-Type"] = "text/plain";
      return body;
    case "X_WWW_FORM_URL_ENCODED":
      headers["Content-Type"] = "application/x-www-form-urlencoded";
      return qs.stringify(params);
  }
}
function escapeStringForJson(val) {
  if (typeof val !== "string") {
    return val;
  }
  return val
    .replace(/[\\]/g, "\\\\")
    .replace(/["]/g, '\\"')
    .replace(/[\n]/g, "\\n")
    .replace(/[\t]/g, "\\t");
}

module.exports = { makeApiCall };
