import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'relatorioestrategico_widget.dart' show RelatorioestrategicoWidget;
import 'package:flutter/material.dart';

class RelatorioestrategicoModel
    extends FlutterFlowModel<RelatorioestrategicoWidget> {
  ///  Local state fields for this page.

  bool dropdown = false;

  bool temconta = false;

  bool loaded = false;

  bool semestrategia = false;

  bool editmode = false;

  String? relatorio;

  String? metas;

  String? sugestoescont;

  String? metasanteriores;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Relatorioestrategico widget.
  int? numcontasusuario;
  // Stores action output result for [Backend Call - API (Dados Estrategia)] action in Relatorioestrategico widget.
  ApiCallResponse? dadosmensaisbackend;
  // Stores action output result for [Custom Action - coletaultimodia] action in Relatorioestrategico widget.
  DateTime? ultimodia;
  // Stores action output result for [Custom Action - coletaprimeirodia] action in Relatorioestrategico widget.
  DateTime? primeirodia;
  // Stores action output result for [Custom Action - iniciomesanterior] action in Relatorioestrategico widget.
  DateTime? primeirodiaanterior;
  // Stores action output result for [Custom Action - finalmesanterior] action in Relatorioestrategico widget.
  DateTime? ultimodiaanterior;
  // Stores action output result for [Firestore Query - Query a collection] action in Relatorioestrategico widget.
  ContasRecord? contaselecionada;
  // Stores action output result for [Backend Call - API (Dados atuais insta)] action in Relatorioestrategico widget.
  ApiCallResponse? dadosatuaisinsta;
  // Stores action output result for [Backend Call - API (Dados atuais face)] action in Relatorioestrategico widget.
  ApiCallResponse? dadosatuaisface;
  // Model for menu component.
  late MenuModel menuModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextFieldma widget.
  FocusNode? textFieldmaFocusNode;
  TextEditingController? textFieldmaTextController;
  String? Function(BuildContext, String?)? textFieldmaTextControllerValidator;
  // State field(s) for TextFieldmf widget.
  FocusNode? textFieldmfFocusNode;
  TextEditingController? textFieldmfTextController;
  String? Function(BuildContext, String?)? textFieldmfTextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // State field(s) for RatingBar widget.
  double? ratingBarValue1;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController5;
  String? Function(BuildContext, String?)? textController5Validator;
  // Stores action output result for [Backend Call - API (avaliar relatorio)] action in Button widget.
  ApiCallResponse? apiResultmwx;
  // Stores action output result for [Backend Call - API (resetar relatorio)] action in Icon widget.
  ApiCallResponse? apiResultrvb;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? authCode;
  // Stores action output result for [Backend Call - API (Editar Relatorio)] action in Button widget.
  ApiCallResponse? apiResult8mp;
  // State field(s) for relatoriopc widget.
  FocusNode? relatoriopcFocusNode;
  TextEditingController? relatoriopcTextController;
  String? Function(BuildContext, String?)? relatoriopcTextControllerValidator;
  // State field(s) for metasapc widget.
  FocusNode? metasapcFocusNode;
  TextEditingController? metasapcTextController;
  String? Function(BuildContext, String?)? metasapcTextControllerValidator;
  // State field(s) for metasfpc widget.
  FocusNode? metasfpcFocusNode;
  TextEditingController? metasfpcTextController;
  String? Function(BuildContext, String?)? metasfpcTextControllerValidator;
  // State field(s) for sugestoespc widget.
  FocusNode? sugestoespcFocusNode;
  TextEditingController? sugestoespcTextController;
  String? Function(BuildContext, String?)? sugestoespcTextControllerValidator;
  // State field(s) for RatingBar widget.
  double? ratingBarValue2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController10;
  String? Function(BuildContext, String?)? textController10Validator;
  // Stores action output result for [Backend Call - API (avaliar relatorio)] action in Button widget.
  ApiCallResponse? apiResultmwxpc;
  // Stores action output result for [Backend Call - API (resetar relatorio)] action in Icon widget.
  ApiCallResponse? apiResultrvbpc;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? authCodepc;
  // Stores action output result for [Backend Call - API (Editar Relatorio)] action in Button widget.
  ApiCallResponse? apiResult8mppc;

  @override
  void initState(BuildContext context) {
    menuModel = createModel(context, () => MenuModel());
  }

  @override
  void dispose() {
    menuModel.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldmaFocusNode?.dispose();
    textFieldmaTextController?.dispose();

    textFieldmfFocusNode?.dispose();
    textFieldmfTextController?.dispose();

    textFieldFocusNode2?.dispose();
    textController4?.dispose();

    textFieldFocusNode3?.dispose();
    textController5?.dispose();

    relatoriopcFocusNode?.dispose();
    relatoriopcTextController?.dispose();

    metasapcFocusNode?.dispose();
    metasapcTextController?.dispose();

    metasfpcFocusNode?.dispose();
    metasfpcTextController?.dispose();

    sugestoespcFocusNode?.dispose();
    sugestoespcTextController?.dispose();

    textFieldFocusNode4?.dispose();
    textController10?.dispose();
  }
}
