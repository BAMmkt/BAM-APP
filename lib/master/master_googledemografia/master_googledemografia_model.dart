import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/loading/loading_widget.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'master_googledemografia_widget.dart' show MasterGoogledemografiaWidget;
import 'package:flutter/material.dart';

class MasterGoogledemografiaModel
    extends FlutterFlowModel<MasterGoogledemografiaWidget> {
  ///  Local state fields for this page.

  bool dropdown = false;

  bool temconta = false;

  bool loaded = false;

  String selectedtype = 'IMAGE';

  bool demografia = false;

  String idconta = '000000';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in master-googledemografia widget.
  int? numcontasusuario;
  // Stores action output result for [Firestore Query - Query a collection] action in master-googledemografia widget.
  ContasRecord? contamaster;
  // Stores action output result for [Firestore Query - Query a collection] action in master-googledemografia widget.
  ContasMasterRecord? contamasterrelacao;
  // Stores action output result for [Backend Call - Read Document] action in master-googledemografia widget.
  ContasRecord? loopconta;
  // Stores action output result for [Backend Call - API (Dados Google Demografia)] action in master-googledemografia widget.
  ApiCallResponse? dadospostbackend;
  // Stores action output result for [Custom Action - coletaultimodia] action in master-googledemografia widget.
  DateTime? ultimodia;
  // Stores action output result for [Custom Action - coletaprimeirodia] action in master-googledemografia widget.
  DateTime? primeirodia;
  // Stores action output result for [Custom Action - iniciomesanterior] action in master-googledemografia widget.
  DateTime? primeirodiaanterior;
  // Stores action output result for [Custom Action - finalmesanterior] action in master-googledemografia widget.
  DateTime? ultimodiaanterior;
  // Stores action output result for [Firestore Query - Query a collection] action in master-googledemografia widget.
  ContasRecord? contaselecionada;
  // State field(s) for campanha widget.
  String? campanhaValue1;
  FormFieldController<String>? campanhaValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? authCodepc;
  // State field(s) for campanha widget.
  String? campanhaValue2;
  FormFieldController<String>? campanhaValueController2;
  // State field(s) for DropDown widget.
  String? dropDownValue3;
  FormFieldController<String>? dropDownValueController3;
  // State field(s) for DropDown widget.
  String? dropDownValue4;
  FormFieldController<String>? dropDownValueController4;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? authCode;
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
