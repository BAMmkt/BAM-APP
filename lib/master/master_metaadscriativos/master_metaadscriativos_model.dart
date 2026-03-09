import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/loading/loading_widget.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'master_metaadscriativos_widget.dart' show MasterMetaadscriativosWidget;
import 'package:flutter/material.dart';

class MasterMetaadscriativosModel
    extends FlutterFlowModel<MasterMetaadscriativosWidget> {
  ///  Local state fields for this page.

  bool dropdown = false;

  bool temconta = false;

  bool loaded = false;

  String selectedtype = 'IMAGE';

  String idconta = '00000';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in master-metaadscriativos widget.
  int? numcontasusuario;
  // Stores action output result for [Firestore Query - Query a collection] action in master-metaadscriativos widget.
  ContasRecord? contamaster;
  // Stores action output result for [Firestore Query - Query a collection] action in master-metaadscriativos widget.
  ContasMasterRecord? contamasterrelacao;
  // Stores action output result for [Backend Call - Read Document] action in master-metaadscriativos widget.
  ContasRecord? loopconta;
  // Stores action output result for [Backend Call - API (Dados Ads Mensal)] action in master-metaadscriativos widget.
  ApiCallResponse? dadospostbackend;
  // Stores action output result for [Custom Action - filtroprimeiroanuncio] action in master-metaadscriativos widget.
  dynamic mostrecentad;
  // Stores action output result for [Custom Action - coletaultimodia] action in master-metaadscriativos widget.
  DateTime? ultimodia;
  // Stores action output result for [Custom Action - coletaprimeirodia] action in master-metaadscriativos widget.
  DateTime? primeirodia;
  // Stores action output result for [Custom Action - iniciomesanterior] action in master-metaadscriativos widget.
  DateTime? primeirodiaanterior;
  // Stores action output result for [Custom Action - finalmesanterior] action in master-metaadscriativos widget.
  DateTime? ultimodiaanterior;
  // Stores action output result for [Firestore Query - Query a collection] action in master-metaadscriativos widget.
  ContasRecord? contaselecionada;
  // Model for menu component.
  late MenuModel menuModel;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? veraddpc;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
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
