import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'gerenciamentocontas_widget.dart' show GerenciamentocontasWidget;
import 'package:flutter/material.dart';

class GerenciamentocontasModel
    extends FlutterFlowModel<GerenciamentocontasWidget> {
  ///  Local state fields for this page.

  bool remover = false;

  bool adicionar = false;

  String? nomeconta;

  String? idconta;

  String? plataforma;

  bool crmadd = false;

  bool contaconectada = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Switch widget.
  bool? switchValue;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? authCode;
  // Stores action output result for [Custom Action - loginWithGoogle] action in Button widget.
  String? authCodegoogle;
  // Stores action output result for [Backend Call - API (Vincular crm)] action in Button widget.
  ApiCallResponse? apiResultrqm;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
