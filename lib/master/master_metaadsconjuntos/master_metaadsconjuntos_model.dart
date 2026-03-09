import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/loading/loading_widget.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'master_metaadsconjuntos_widget.dart' show MasterMetaadsconjuntosWidget;
import 'package:flutter/material.dart';

class MasterMetaadsconjuntosModel
    extends FlutterFlowModel<MasterMetaadsconjuntosWidget> {
  ///  Local state fields for this page.

  bool dropdown = false;

  bool temconta = false;

  bool loaded = false;

  String selectedtype = 'IMAGE';

  String idconta = '00000';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in master-metaadsconjuntos widget.
  int? numcontasusuario;
  // Stores action output result for [Firestore Query - Query a collection] action in master-metaadsconjuntos widget.
  ContasRecord? contamaster;
  // Stores action output result for [Firestore Query - Query a collection] action in master-metaadsconjuntos widget.
  ContasMasterRecord? contamasterrelacao;
  // Stores action output result for [Backend Call - Read Document] action in master-metaadsconjuntos widget.
  ContasRecord? loopconta;
  // Stores action output result for [Backend Call - API (Dados Conjuntos)] action in master-metaadsconjuntos widget.
  ApiCallResponse? dadospostbackend;
  // Stores action output result for [Firestore Query - Query a collection] action in master-metaadsconjuntos widget.
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
