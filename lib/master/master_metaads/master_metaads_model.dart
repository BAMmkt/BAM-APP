import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/loading/loading_widget.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'master_metaads_widget.dart' show MasterMetaadsWidget;
import 'package:flutter/material.dart';

class MasterMetaadsModel extends FlutterFlowModel<MasterMetaadsWidget> {
  ///  Local state fields for this page.

  bool dropdown = false;

  bool temconta = false;

  bool loaded = false;

  String selectedtype = 'IMAGE';

  String idconta = '00000';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in master-metaads widget.
  int? numcontasusuario;
  // Stores action output result for [Firestore Query - Query a collection] action in master-metaads widget.
  ContasRecord? contamaster;
  // Stores action output result for [Firestore Query - Query a collection] action in master-metaads widget.
  ContasMasterRecord? contamasterrelacao;
  // Stores action output result for [Backend Call - Read Document] action in master-metaads widget.
  ContasRecord? loopconta;
  // Stores action output result for [Backend Call - API (Dados Ads Mensal)] action in master-metaads widget.
  ApiCallResponse? dadospostbackend;
  // Stores action output result for [Custom Action - coletaultimodia] action in master-metaads widget.
  DateTime? ultimodia;
  // Stores action output result for [Custom Action - coletaprimeirodia] action in master-metaads widget.
  DateTime? primeirodia;
  // Stores action output result for [Custom Action - iniciomesanterior] action in master-metaads widget.
  DateTime? primeirodiaanterior;
  // Stores action output result for [Custom Action - finalmesanterior] action in master-metaads widget.
  DateTime? ultimodiaanterior;
  // Stores action output result for [Firestore Query - Query a collection] action in master-metaads widget.
  ContasRecord? contaselecionada;
  // Model for menu component.
  late MenuModel menuModel;
  // State field(s) for campanha widget.
  String? campanhaValue1;
  FormFieldController<String>? campanhaValueController1;
  // State field(s) for conjunto widget.
  String? conjuntoValue1;
  FormFieldController<String>? conjuntoValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? veradd;
  // State field(s) for campanha widget.
  String? campanhaValue2;
  FormFieldController<String>? campanhaValueController2;
  // State field(s) for conjunto widget.
  String? conjuntoValue2;
  FormFieldController<String>? conjuntoValueController2;
  // State field(s) for DropDown widget.
  String? dropDownValue3;
  FormFieldController<String>? dropDownValueController3;
  // State field(s) for DropDown widget.
  String? dropDownValue4;
  FormFieldController<String>? dropDownValueController4;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? veraddpc;
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
