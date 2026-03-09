import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/loading/loading_widget.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'criativos_widget.dart' show CriativosWidget;
import 'package:flutter/material.dart';

class CriativosModel extends FlutterFlowModel<CriativosWidget> {
  ///  Local state fields for this page.

  bool dropdown = false;

  bool temconta = false;

  bool loaded = false;

  String selectedtype = 'IMAGE';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in criativos widget.
  int? numcontasusuario;
  // Stores action output result for [Backend Call - API (Dados Ads Mensal)] action in criativos widget.
  ApiCallResponse? dadospostbackend;
  // Stores action output result for [Custom Action - filtroprimeiroanuncio] action in criativos widget.
  dynamic mostrecentad;
  // Stores action output result for [Custom Action - coletaultimodia] action in criativos widget.
  DateTime? ultimodia;
  // Stores action output result for [Custom Action - coletaprimeirodia] action in criativos widget.
  DateTime? primeirodia;
  // Stores action output result for [Custom Action - iniciomesanterior] action in criativos widget.
  DateTime? primeirodiaanterior;
  // Stores action output result for [Custom Action - finalmesanterior] action in criativos widget.
  DateTime? ultimodiaanterior;
  // Stores action output result for [Firestore Query - Query a collection] action in criativos widget.
  ContasRecord? contaselecionada;
  // Model for menu component.
  late MenuModel menuModel;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? veradd;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
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
