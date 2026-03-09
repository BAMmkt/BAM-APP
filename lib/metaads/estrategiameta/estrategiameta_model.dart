import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'estrategiameta_widget.dart' show EstrategiametaWidget;
import 'package:flutter/material.dart';

class EstrategiametaModel extends FlutterFlowModel<EstrategiametaWidget> {
  ///  Local state fields for this page.

  bool dropdown = false;

  bool temconta = false;

  bool loaded = false;

  int? indexpage = 1;

  double? indexpercent = 0.056;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in estrategiameta widget.
  int? numcontasusuario;
  // Stores action output result for [Firestore Query - Query a collection] action in estrategiameta widget.
  ContasRecord? contaselecionada;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for Descricaoempresa widget.
  FocusNode? descricaoempresaFocusNode;
  TextEditingController? descricaoempresaTextController;
  String? Function(BuildContext, String?)?
      descricaoempresaTextControllerValidator;
  // State field(s) for produtosaanunciar widget.
  FocusNode? produtosaanunciarFocusNode;
  TextEditingController? produtosaanunciarTextController;
  String? Function(BuildContext, String?)?
      produtosaanunciarTextControllerValidator;
  // State field(s) for diferencialempresa widget.
  FocusNode? diferencialempresaFocusNode;
  TextEditingController? diferencialempresaTextController;
  String? Function(BuildContext, String?)?
      diferencialempresaTextControllerValidator;
  // State field(s) for listaconcorrentes widget.
  FocusNode? listaconcorrentesFocusNode;
  TextEditingController? listaconcorrentesTextController;
  String? Function(BuildContext, String?)?
      listaconcorrentesTextControllerValidator;
  // State field(s) for adjetivosimagem widget.
  FormFieldController<List<String>>? adjetivosimagemValueController;
  List<String>? get adjetivosimagemValues =>
      adjetivosimagemValueController?.value;
  set adjetivosimagemValues(List<String>? val) =>
      adjetivosimagemValueController?.value = val;
  // State field(s) for adjetivosnoassociar widget.
  FormFieldController<List<String>>? adjetivosnoassociarValueController;
  List<String>? get adjetivosnoassociarValues =>
      adjetivosnoassociarValueController?.value;
  set adjetivosnoassociarValues(List<String>? val) =>
      adjetivosnoassociarValueController?.value = val;
  // State field(s) for objetivocampanha widget.
  FormFieldController<List<String>>? objetivocampanhaValueController;
  List<String>? get objetivocampanhaValues =>
      objetivocampanhaValueController?.value;
  set objetivocampanhaValues(List<String>? v) =>
      objetivocampanhaValueController?.value = v;

  // State field(s) for generopredominante widget.
  FormFieldController<List<String>>? generopredominanteValueController;
  List<String>? get generopredominanteValues =>
      generopredominanteValueController?.value;
  set generopredominanteValues(List<String>? v) =>
      generopredominanteValueController?.value = v;

  // State field(s) for faixasetarias widget.
  FormFieldController<List<String>>? faixasetariasValueController;
  List<String>? get faixasetariasValues => faixasetariasValueController?.value;
  set faixasetariasValues(List<String>? v) =>
      faixasetariasValueController?.value = v;

  // State field(s) for localizacaogeografica widget.
  FocusNode? localizacaogeograficaFocusNode;
  TextEditingController? localizacaogeograficaTextController;
  String? Function(BuildContext, String?)?
      localizacaogeograficaTextControllerValidator;
  // State field(s) for padroesinteresse widget.
  FocusNode? padroesinteresseFocusNode;
  TextEditingController? padroesinteresseTextController;
  String? Function(BuildContext, String?)?
      padroesinteresseTextControllerValidator;
  // State field(s) for padroescomportamento widget.
  FocusNode? padroescomportamentoFocusNode;
  TextEditingController? padroescomportamentoTextController;
  String? Function(BuildContext, String?)?
      padroescomportamentoTextControllerValidator;
  // State field(s) for caracteristicasinteracao widget.
  FormFieldController<List<String>>? caracteristicasinteracaoValueController;
  List<String>? get caracteristicasinteracaoValues =>
      caracteristicasinteracaoValueController?.value;
  set caracteristicasinteracaoValues(List<String>? v) =>
      caracteristicasinteracaoValueController?.value = v;

  // State field(s) for principalsegmento widget.
  FormFieldController<List<String>>? principalsegmentoValueController;
  List<String>? get principalsegmentoValues =>
      principalsegmentoValueController?.value;
  set principalsegmentoValues(List<String>? v) =>
      principalsegmentoValueController?.value = v;

  // State field(s) for recursosdisponiveis widget.
  FormFieldController<List<String>>? recursosdisponiveisValueController;
  List<String>? get recursosdisponiveisValues =>
      recursosdisponiveisValueController?.value;
  set recursosdisponiveisValues(List<String>? v) =>
      recursosdisponiveisValueController?.value = v;

  // State field(s) for investimentomensal widget.
  FormFieldController<List<String>>? investimentomensalValueController;
  List<String>? get investimentomensalValues =>
      investimentomensalValueController?.value;
  set investimentomensalValues(List<String>? v) =>
      investimentomensalValueController?.value = v;

  // State field(s) for informacaoadicional widget.
  FocusNode? informacaoadicionalFocusNode;
  TextEditingController? informacaoadicionalTextController;
  String? Function(BuildContext, String?)?
      informacaoadicionalTextControllerValidator;
  // Stores action output result for [Backend Call - API (envioestrategiaMeta)] action in Button widget.
  ApiCallResponse? envioestrategia;
  // Model for menu component.
  late MenuModel menuModel;

  @override
  void initState(BuildContext context) {
    menuModel = createModel(context, () => MenuModel());
  }

  @override
  void dispose() {
    descricaoempresaFocusNode?.dispose();
    descricaoempresaTextController?.dispose();

    produtosaanunciarFocusNode?.dispose();
    produtosaanunciarTextController?.dispose();

    diferencialempresaFocusNode?.dispose();
    diferencialempresaTextController?.dispose();

    listaconcorrentesFocusNode?.dispose();
    listaconcorrentesTextController?.dispose();

    localizacaogeograficaFocusNode?.dispose();
    localizacaogeograficaTextController?.dispose();

    padroesinteresseFocusNode?.dispose();
    padroesinteresseTextController?.dispose();

    padroescomportamentoFocusNode?.dispose();
    padroescomportamentoTextController?.dispose();

    informacaoadicionalFocusNode?.dispose();
    informacaoadicionalTextController?.dispose();

    menuModel.dispose();
  }
}
