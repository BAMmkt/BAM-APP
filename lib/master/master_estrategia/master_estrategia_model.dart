import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'master_estrategia_widget.dart' show MasterEstrategiaWidget;
import 'package:flutter/material.dart';

class MasterEstrategiaModel extends FlutterFlowModel<MasterEstrategiaWidget> {
  ///  Local state fields for this page.

  bool dropdown = false;

  bool temconta = false;

  bool loaded = false;

  int? indexpage = 1;

  double? indexpercent = 0.04166;

  bool mastergoogle = false;

  bool masterinsta = false;

  bool mastermeta = false;

  List<ContasRecord> listcontamaster = [];
  void addToListcontamaster(ContasRecord item) => listcontamaster.add(item);
  void removeFromListcontamaster(ContasRecord item) =>
      listcontamaster.remove(item);
  void removeAtIndexFromListcontamaster(int index) =>
      listcontamaster.removeAt(index);
  void insertAtIndexInListcontamaster(int index, ContasRecord item) =>
      listcontamaster.insert(index, item);
  void updateListcontamasterAtIndex(
          int index, Function(ContasRecord) updateFn) =>
      listcontamaster[index] = updateFn(listcontamaster[index]);

  List<String> listacontas = [];
  void addToListacontas(String item) => listacontas.add(item);
  void removeFromListacontas(String item) => listacontas.remove(item);
  void removeAtIndexFromListacontas(int index) => listacontas.removeAt(index);
  void insertAtIndexInListacontas(int index, String item) =>
      listacontas.insert(index, item);
  void updateListacontasAtIndex(int index, Function(String) updateFn) =>
      listacontas[index] = updateFn(listacontas[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in master-estrategia widget.
  int? numcontasusuario;
  // Stores action output result for [Firestore Query - Query a collection] action in master-estrategia widget.
  ContasRecord? contamaster;
  // Stores action output result for [Firestore Query - Query a collection] action in master-estrategia widget.
  ContasMasterRecord? contamasterrelacao;
  // Stores action output result for [Backend Call - Read Document] action in master-estrategia widget.
  ContasRecord? loopconta;
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
  // State field(s) for listaconcorrentes widget.
  FocusNode? listaconcorrentesFocusNode;
  TextEditingController? listaconcorrentesTextController;
  String? Function(BuildContext, String?)?
      listaconcorrentesTextControllerValidator;
  // State field(s) for diferencialempresa widget.
  FocusNode? diferencialempresaFocusNode;
  TextEditingController? diferencialempresaTextController;
  String? Function(BuildContext, String?)?
      diferencialempresaTextControllerValidator;
  // State field(s) for produtosaanunciargoogle widget.
  FocusNode? produtosaanunciargoogleFocusNode;
  TextEditingController? produtosaanunciargoogleTextController;
  String? Function(BuildContext, String?)?
      produtosaanunciargoogleTextControllerValidator;
  // State field(s) for produtosaanunciarmeta widget.
  FocusNode? produtosaanunciarmetaFocusNode;
  TextEditingController? produtosaanunciarmetaTextController;
  String? Function(BuildContext, String?)?
      produtosaanunciarmetaTextControllerValidator;
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

  // State field(s) for segmentodepublico widget.
  FormFieldController<List<String>>? segmentodepublicoValueController;
  List<String>? get segmentodepublicoValues =>
      segmentodepublicoValueController?.value;
  set segmentodepublicoValues(List<String>? v) =>
      segmentodepublicoValueController?.value = v;

  // State field(s) for objetivocomunicacaoorganica widget.
  FormFieldController<List<String>>? objetivocomunicacaoorganicaValueController;
  List<String>? get objetivocomunicacaoorganicaValues =>
      objetivocomunicacaoorganicaValueController?.value;
  set objetivocomunicacaoorganicaValues(List<String>? v) =>
      objetivocomunicacaoorganicaValueController?.value = v;

  // State field(s) for objetivocampanhagoogle widget.
  FormFieldController<List<String>>? objetivocampanhagoogleValueController;
  List<String>? get objetivocampanhagoogleValues =>
      objetivocampanhagoogleValueController?.value;
  set objetivocampanhagoogleValues(List<String>? v) =>
      objetivocampanhagoogleValueController?.value = v;

  // State field(s) for orcamentomensalgoogle widget.
  FormFieldController<List<String>>? orcamentomensalgoogleValueController;
  List<String>? get orcamentomensalgoogleValues =>
      orcamentomensalgoogleValueController?.value;
  set orcamentomensalgoogleValues(List<String>? v) =>
      orcamentomensalgoogleValueController?.value = v;

  // State field(s) for objetivocampanhameta widget.
  FormFieldController<List<String>>? objetivocampanhametaValueController;
  List<String>? get objetivocampanhametaValues =>
      objetivocampanhametaValueController?.value;
  set objetivocampanhametaValues(List<String>? v) =>
      objetivocampanhametaValueController?.value = v;

  // State field(s) for orcamentomensalmeta widget.
  FormFieldController<List<String>>? orcamentomensalmetaValueController;
  List<String>? get orcamentomensalmetaValues =>
      orcamentomensalmetaValueController?.value;
  set orcamentomensalmetaValues(List<String>? v) =>
      orcamentomensalmetaValueController?.value = v;

  // State field(s) for recursosdisponiveis widget.
  FormFieldController<List<String>>? recursosdisponiveisValueController;
  List<String>? get recursosdisponiveisValues =>
      recursosdisponiveisValueController?.value;
  set recursosdisponiveisValues(List<String>? v) =>
      recursosdisponiveisValueController?.value = v;

  // State field(s) for frequenciaplanejada widget.
  FormFieldController<List<String>>? frequenciaplanejadaValueController;
  List<String>? get frequenciaplanejadaValues =>
      frequenciaplanejadaValueController?.value;
  set frequenciaplanejadaValues(List<String>? v) =>
      frequenciaplanejadaValueController?.value = v;

  // State field(s) for infosadicionais widget.
  FocusNode? infosadicionaisFocusNode;
  TextEditingController? infosadicionaisTextController;
  String? Function(BuildContext, String?)?
      infosadicionaisTextControllerValidator;
  // Stores action output result for [Backend Call - API (envioestrategiaMaster)] action in Button widget.
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

    listaconcorrentesFocusNode?.dispose();
    listaconcorrentesTextController?.dispose();

    diferencialempresaFocusNode?.dispose();
    diferencialempresaTextController?.dispose();

    produtosaanunciargoogleFocusNode?.dispose();
    produtosaanunciargoogleTextController?.dispose();

    produtosaanunciarmetaFocusNode?.dispose();
    produtosaanunciarmetaTextController?.dispose();

    termosassociadosFocusNode?.dispose();
    termosassociadosTextController?.dispose();

    termosdesassociadosFocusNode?.dispose();
    termosdesassociadosTextController?.dispose();

    localizacaogeograficaFocusNode?.dispose();
    localizacaogeograficaTextController?.dispose();

    padroesinteresseFocusNode?.dispose();
    padroesinteresseTextController?.dispose();

    padroescomportamentoFocusNode?.dispose();
    padroescomportamentoTextController?.dispose();

    infosadicionaisFocusNode?.dispose();
    infosadicionaisTextController?.dispose();

    menuModel.dispose();
  }
}
