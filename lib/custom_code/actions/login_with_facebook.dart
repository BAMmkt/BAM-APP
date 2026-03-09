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

import 'dart:convert';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

Future<String?> loginWithFacebook() async {
  final String clientId = '7553807504745690';
  final String clientSecret = 'bdb95a6d009ad861419cf809a76c3add';
  final String redirectUri = 'https://app.bamassessoria.com/selecaocontas';
  final String state = '{st=state123abc,ds=123456789}';
  final String scope =
      'public_profile,email,instagram_basic,pages_show_list,instagram_manage_comments';

  final Uri authUrl = Uri.https(
    'www.facebook.com',
    '/v21.0/dialog/oauth',
    {
      'client_id': clientId,
      'redirect_uri': redirectUri,
      'state': state,
      'scope': scope,
    },
  );

  try {
    final String result = await FlutterWebAuth.authenticate(
      url: authUrl.toString(),
      callbackUrlScheme: 'https', // Use 'https' para URIs baseadas na web
    );

    final Uri resultUri = Uri.parse(result);
    final String? code = resultUri.queryParameters['code'];

    if (code == null) {
      print('Nenhum código de autorização foi recebido.');
      return null;
    }

    print('Código de autorização recebido: $code');

    final Uri tokenUri = Uri.https(
      'graph.facebook.com',
      '/v21.0/oauth/access_token',
      {
        'client_id': clientId,
        'redirect_uri': redirectUri,
        'client_secret': clientSecret,
        'code': code,
      },
    );

    final http.Response tokenResponse = await http.get(tokenUri);

    if (tokenResponse.statusCode != 200) {
      print('Erro na requisição do Access Token: ${tokenResponse.body}');
      return null;
    }

    final Map<String, dynamic> tokenData = json.decode(tokenResponse.body);
    final String? accessToken = tokenData['access_token'];

    if (accessToken != null) {
      print('Access Token obtido: $accessToken');
      return accessToken;
    } else {
      print('Erro: Access Token não foi retornado. Resposta: $tokenData');
      return null;
    }
  } catch (e) {
    print('Erro durante o login com Facebook: $e');
    return null;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
