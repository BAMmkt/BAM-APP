import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/loading/loading_widget.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'conjuntos_widget.dart' show ConjuntosWidget;
import 'package:flutter/material.dart';

class ConjuntosModel extends FlutterFlowModel<ConjuntosWidget> {
  ///  Local state fields for this page.

  bool dropdown = false;

  bool temconta = false;

  bool loaded = false;

  String selectedtype = 'IMAGE';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in conjuntos widget.
  int? numcontasusuario;
  // Stores action output result for [Backend Call - API (Dados Conjuntos)] action in conjuntos widget.
  ApiCallResponse? dadospostbackend;
  // Stores action output result for [Firestore Query - Query a collection] action in conjuntos widget.
  ContasRecord? contaselecionada;
  // Model for menu component.
  late MenuModel menuModel;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? veradd;
  // Model for loading component.
  late LoadingModel loadingModel;

  @override
  void initState(BuildContext context) {
    menuModel = createModel(context, () => MenuModel());
    loadingModel = createModel(context, () => LoadingModel());
  }

  @override
  void dispose() {
    menuModel.dispose();
    loadingModel.dispose();
  }
}
