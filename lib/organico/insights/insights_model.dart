import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/loading/loading_widget.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'insights_widget.dart' show InsightsWidget;
import 'package:flutter/material.dart';

class InsightsModel extends FlutterFlowModel<InsightsWidget> {
  ///  Local state fields for this page.

  bool dropdown = false;

  bool temconta = false;

  bool loaded = false;

  bool demografia = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in insights widget.
  int? numcontasusuario;
  // Stores action output result for [Backend Call - API (Dados Mensais)] action in insights widget.
  ApiCallResponse? dadosmensaisbackend;
  // Stores action output result for [Custom Action - coletaultimodia] action in insights widget.
  DateTime? ultimodia;
  // Stores action output result for [Custom Action - coletaprimeirodia] action in insights widget.
  DateTime? primeirodia;
  // Stores action output result for [Custom Action - iniciomesanterior] action in insights widget.
  DateTime? primeirodiaanterior;
  // Stores action output result for [Custom Action - finalmesanterior] action in insights widget.
  DateTime? ultimodiaanterior;
  // Stores action output result for [Firestore Query - Query a collection] action in insights widget.
  ContasRecord? contaselecionada;
  // Stores action output result for [Backend Call - API (Demografia)] action in insights widget.
  ApiCallResponse? demografias;
  // Stores action output result for [Backend Call - API (Dados atuais insta)] action in insights widget.
  ApiCallResponse? dadosatuaisinsta;
  // Stores action output result for [Backend Call - API (Dados atuais face)] action in insights widget.
  ApiCallResponse? dadosatuaisface;
  // Model for menu component.
  late MenuModel menuModel;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? authCode;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? authCode2;
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
