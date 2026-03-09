import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/loading/loading_widget.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'master_googleinsights_widget.dart' show MasterGoogleinsightsWidget;
import 'package:flutter/material.dart';

class MasterGoogleinsightsModel
    extends FlutterFlowModel<MasterGoogleinsightsWidget> {
  ///  Local state fields for this page.

  bool dropdown = false;

  bool temconta = false;

  bool loaded = false;

  String selectedtype = 'IMAGE';

  bool demografia = false;

  String idconta = '00000';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in master-googleinsights widget.
  int? numcontasusuario;
  // Stores action output result for [Firestore Query - Query a collection] action in master-googleinsights widget.
  ContasRecord? contamaster;
  // Stores action output result for [Firestore Query - Query a collection] action in master-googleinsights widget.
  ContasMasterRecord? contamasterrelacao;
  // Stores action output result for [Backend Call - Read Document] action in master-googleinsights widget.
  ContasRecord? loopconta;
  // Stores action output result for [Backend Call - API (Dados Google Campanha)] action in master-googleinsights widget.
  ApiCallResponse? dadospostbackend;
  // Stores action output result for [Custom Action - coletaultimodia] action in master-googleinsights widget.
  DateTime? ultimodia;
  // Stores action output result for [Custom Action - coletaprimeirodia] action in master-googleinsights widget.
  DateTime? primeirodia;
  // Stores action output result for [Custom Action - iniciomesanterior] action in master-googleinsights widget.
  DateTime? primeirodiaanterior;
  // Stores action output result for [Custom Action - finalmesanterior] action in master-googleinsights widget.
  DateTime? ultimodiaanterior;
  // Stores action output result for [Firestore Query - Query a collection] action in master-googleinsights widget.
  ContasRecord? contaselecionada;
  // State field(s) for campanha widget.
  String? campanhaValue1;
  FormFieldController<String>? campanhaValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? authCode;
  // State field(s) for campanha widget.
  String? campanhaValue2;
  FormFieldController<String>? campanhaValueController2;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? authCodepc;
  // Model for loading component.
  late LoadingModel loadingModel;
  // Model for menu component.
  late MenuModel menuModel;

  @override
  void initState(BuildContext context) {
    loadingModel = createModel(context, () => LoadingModel());
    menuModel = createModel(context, () => MenuModel());
  }

  @override
  void dispose() {
    loadingModel.dispose();
    menuModel.dispose();
  }
}
