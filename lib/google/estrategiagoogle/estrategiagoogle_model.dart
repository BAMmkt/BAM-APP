import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'estrategiagoogle_widget.dart' show EstrategiagoogleWidget;
import 'package:flutter/material.dart';

class EstrategiagoogleModel extends FlutterFlowModel<EstrategiagoogleWidget> {
  ///  Local state fields for this page.

  bool dropdown = false;

  bool temconta = false;

  bool loaded = false;

  int? indexpage = 1;

  double? indexpercent = 0.0676;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in estrategiagoogle widget.
  int? numcontasusuario;
  // Stores action output result for [Firestore Query - Query a collection] action in estrategiagoogle widget.
  ContasRecord? contaselecionada;
  // Stores action output result for [Backend Call - API (Dados atuais insta)] action in estrategiagoogle widget.
  ApiCallResponse? dadosatuaisinsta;
  // Stores action output result for [Backend Call - API (Dados atuais face)] action in estrategiagoogle widget.
  ApiCallResponse? dadosatuaisface;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for descricaoempresa widget.
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
  // State field(s) for termosassociados widget.
  FocusNode? termosassociadosFocusNode;
  TextEditingController? termosassociadosTextController;
  String? Function(BuildContext, String?)?
      termosassociadosTextControllerValidator;
  // State field(s) for termosdesassociados widget.
  FocusNode? termosdesassociadosFocusNode;
  TextEditingController? termosdesassociadosTextController;
  String? Function(BuildContext, String?)?
      termosdesassociadosTextControllerValidator;
  // State field(s) for adjetivosassociados widget.
  FormFieldController<List<String>>? adjetivosassociadosValueController;
  List<String>? get adjetivosassociadosValues =>
      adjetivosassociadosValueController?.value;
  set adjetivosassociadosValues(List<String>? val) =>
      adjetivosassociadosValueController?.value = val;
  // State field(s) for adjetivosnaoassociados widget.
  FormFieldController<List<String>>? adjetivosnaoassociadosValueController;
  List<String>? get adjetivosnaoassociadosValues =>
      adjetivosnaoassociadosValueController?.value;
  set adjetivosnaoassociadosValues(List<String>? val) =>
      adjetivosnaoassociadosValueController?.value = val;
  // State field(s) for objetivocampanha widget.
  FormFieldController<List<String>>? objetivocampanhaValueController;
  List<String>? get objetivocampanhaValues =>
      objetivocampanhaValueController?.value;
  set objetivocampanhaValues(List<String>? v) =>
      objetivocampanhaValueController?.value = v;

  // State field(s) for generopublico widget.
  FormFieldController<List<String>>? generopublicoValueController;
  List<String>? get generopublicoValues => generopublicoValueController?.value;
  set generopublicoValues(List<String>? v) =>
      generopublicoValueController?.value = v;

  // State field(s) for faixaetaria widget.
  FormFieldController<List<String>>? faixaetariaValueController;
  List<String>? get faixaetariaValues => faixaetariaValueController?.value;
  set faixaetariaValues(List<String>? v) =>
      faixaetariaValueController?.value = v;

  // State field(s) for localizacaogeografica widget.
  FocusNode? localizacaogeograficaFocusNode;
  TextEditingController? localizacaogeograficaTextController;
  String? Function(BuildContext, String?)?
      localizacaogeograficaTextControllerValidator;
  // State field(s) for caracteristicasinteracao widget.
  FormFieldController<List<String>>? caracteristicasinteracaoValueController;
  List<String>? get caracteristicasinteracaoValues =>
      caracteristicasinteracaoValueController?.value;
  set caracteristicasinteracaoValues(List<String>? v) =>
      caracteristicasinteracaoValueController?.value = v;

  // State field(s) for segmentodepublico widget.
  FormFieldController<List<String>>? segmentodepublicoValueController;
  List<String>? get segmentodepublicoValues =>
      segmentodepublicoValueController?.value;
  set segmentodepublicoValues(List<String>? v) =>
      segmentodepublicoValueController?.value = v;

  // State field(s) for orcamentomensal widget.
  FormFieldController<List<String>>? orcamentomensalValueController;
  List<String>? get orcamentomensalValues =>
      orcamentomensalValueController?.value;
  set orcamentomensalValues(List<String>? v) =>
      orcamentomensalValueController?.value = v;

  // State field(s) for infosadicionais widget.
  FocusNode? infosadicionaisFocusNode;
  TextEditingController? infosadicionaisTextController;
  String? Function(BuildContext, String?)?
      infosadicionaisTextControllerValidator;
  // Stores action output result for [Backend Call - API (envioestrategiaGoogle)] action in Button widget.
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

    termosassociadosFocusNode?.dispose();
    termosassociadosTextController?.dispose();

    termosdesassociadosFocusNode?.dispose();
    termosdesassociadosTextController?.dispose();

    localizacaogeograficaFocusNode?.dispose();
    localizacaogeograficaTextController?.dispose();

    infosadicionaisFocusNode?.dispose();
    infosadicionaisTextController?.dispose();

    menuModel.dispose();
  }
}
