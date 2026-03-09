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

Future<String?> loginWithGoogle() async {
  final String clientId =
      '239094714054-40g8qaubq9cjjonlo4rrphesqccqsh1g.apps.googleusercontent.com';
  final String redirectUri = 'https://app.bamassessoria.com/selecaocontas';
  final String scope = 'https://www.googleapis.com/auth/adwords';
  final String responseType = 'code';
  final String accessType = 'offline';
  final String includeGrantedScopes = 'true';

  final Uri authUrl = Uri.https(
    'accounts.google.com',
    '/o/oauth2/v2/auth',
    {
      'scope': scope,
      'access_type': accessType,
      'include_granted_scopes': includeGrantedScopes,
      'response_type': responseType,
      'redirect_uri': redirectUri,
      'client_id': clientId,
    },
  );

  try {
    final String result = await FlutterWebAuth.authenticate(
      url: authUrl.toString(),
      callbackUrlScheme: 'https',
    );

    final Uri resultUri = Uri.parse(result);
    final String? authcode = resultUri.queryParameters['authcode'];

    if (authcode == null) {
      print('Nenhum código de autorização foi recebido.');
      return null;
    }

    print('Código de autorização recebido: $authcode');

    return authcode;
  } catch (e) {
    print('Erro durante o login com Google: $e');
    return null;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
