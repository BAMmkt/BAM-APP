import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/loading/loading_widget.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'master_instacomentario_widget.dart' show MasterInstacomentarioWidget;
import 'package:flutter/material.dart';

class MasterInstacomentarioModel
    extends FlutterFlowModel<MasterInstacomentarioWidget> {
  ///  Local state fields for this page.

  bool dropdown = false;

  bool temconta = false;

  bool loaded = false;

  String selectedtype = 'Imagem';

  String idconta = '00000';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in master-instacomentario widget.
  int? numcontasusuario;
  // Stores action output result for [Firestore Query - Query a collection] action in master-instacomentario widget.
  ContasRecord? contamaster;
  // Stores action output result for [Firestore Query - Query a collection] action in master-instacomentario widget.
  ContasMasterRecord? contamasterrelacao;
  // Stores action output result for [Backend Call - Read Document] action in master-instacomentario widget.
  ContasRecord? loopconta;
  // Stores action output result for [Backend Call - API (Dados Comentarios)] action in master-instacomentario widget.
  ApiCallResponse? dadospostbackend;
  // Stores action output result for [Custom Action - coletaultimodia] action in master-instacomentario widget.
  DateTime? ultimodia;
  // Stores action output result for [Custom Action - coletaprimeirodia] action in master-instacomentario widget.
  DateTime? primeirodia;
  // Stores action output result for [Custom Action - iniciomesanterior] action in master-instacomentario widget.
  DateTime? primeirodiaanterior;
  // Stores action output result for [Custom Action - finalmesanterior] action in master-instacomentario widget.
  DateTime? ultimodiaanterior;
  // Stores action output result for [Firestore Query - Query a collection] action in master-instacomentario widget.
  ContasRecord? contaselecionada;
  // Stores action output result for [Backend Call - API (Dados atuais insta)] action in master-instacomentario widget.
  ApiCallResponse? dadosatuaisinsta;
  // Stores action output result for [Backend Call - API (Dados atuais face)] action in master-instacomentario widget.
  ApiCallResponse? dadosatuaisface;
  // Model for menu component.
  late MenuModel menuModel;
  // Stores action output result for [Backend Call - API (resetar comentario)] action in Icon widget.
  ApiCallResponse? apiResultrvbpc;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? authCodepc;
  // Stores action output result for [Backend Call - API (resetar comentario)] action in Icon widget.
  ApiCallResponse? apiResultrvb;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? authCode;
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
