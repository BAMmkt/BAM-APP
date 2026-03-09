import '/backend/backend.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'crmperfil_widget.dart' show CrmperfilWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CrmperfilModel extends FlutterFlowModel<CrmperfilWidget> {
  ///  Local state fields for this page.

  bool dropdown = false;

  bool temconta = false;

  bool loaded = false;

  String selectedtype = 'IMAGE';

  DateTime? datacinicio;

  DateTime? datacfinal;

  DateTime? dataminicio;

  DateTime? datamfinal;

  DateTime? datafinicio;

  DateTime? dataffinal;

  bool atividade = false;

  bool delete = false;

  bool editaropcoes = false;

  bool editarresponsaveis = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Crmperfil widget.
  int? numcontasusuario;
  // Stores action output result for [Firestore Query - Query a collection] action in Crmperfil widget.
  int? contagempipeline;
  // Stores action output result for [Backend Call - Create Document] action in Crmperfil widget.
  PipelinecrmRecord? dadoscrm;
  // Stores action output result for [Firestore Query - Query a collection] action in Crmperfil widget.
  PipelinecrmRecord? colunaspipeline;
  // Model for menu component.
  late MenuModel menuModel;
  // State field(s) for nomecel widget.
  FocusNode? nomecelFocusNode;
  TextEditingController? nomecelTextController;
  String? Function(BuildContext, String?)? nomecelTextControllerValidator;
  // State field(s) for statuscel widget.
  String? statuscelValue;
  FormFieldController<String>? statuscelValueController;
  // State field(s) for emailcel widget.
  FocusNode? emailcelFocusNode;
  TextEditingController? emailcelTextController;
  String? Function(BuildContext, String?)? emailcelTextControllerValidator;
  // State field(s) for telefonecel widget.
  FocusNode? telefonecelFocusNode;
  TextEditingController? telefonecelTextController;
  String? Function(BuildContext, String?)? telefonecelTextControllerValidator;
  // State field(s) for valordanegociaocel widget.
  FocusNode? valordanegociaocelFocusNode;
  TextEditingController? valordanegociaocelTextController;
  String? Function(BuildContext, String?)?
      valordanegociaocelTextControllerValidator;
  // State field(s) for Adicionadoemcel widget.
  FocusNode? adicionadoemcelFocusNode;
  TextEditingController? adicionadoemcelTextController;
  String? Function(BuildContext, String?)?
      adicionadoemcelTextControllerValidator;
  // State field(s) for ultimamovicel widget.
  FocusNode? ultimamovicelFocusNode;
  TextEditingController? ultimamovicelTextController;
  String? Function(BuildContext, String?)? ultimamovicelTextControllerValidator;
  // State field(s) for datadefechamentocel widget.
  FocusNode? datadefechamentocelFocusNode;
  TextEditingController? datadefechamentocelTextController;
  String? Function(BuildContext, String?)?
      datadefechamentocelTextControllerValidator;
  // State field(s) for DropDowncel widget.
  String? dropDowncelValue;
  FormFieldController<String>? dropDowncelValueController;
  // State field(s) for Atividadecel widget.
  FocusNode? atividadecelFocusNode;
  TextEditingController? atividadecelTextController;
  String? Function(BuildContext, String?)? atividadecelTextControllerValidator;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? veraddpc2;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for Atividade widget.
  FocusNode? atividadeFocusNode;
  TextEditingController? atividadeTextController;
  String? Function(BuildContext, String?)? atividadeTextControllerValidator;
  // State field(s) for nome widget.
  FocusNode? nomeFocusNode;
  TextEditingController? nomeTextController;
  String? Function(BuildContext, String?)? nomeTextControllerValidator;
  // State field(s) for status widget.
  String? statusValue;
  FormFieldController<String>? statusValueController;
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // State field(s) for telefone widget.
  FocusNode? telefoneFocusNode;
  TextEditingController? telefoneTextController;
  String? Function(BuildContext, String?)? telefoneTextControllerValidator;
  // State field(s) for valordanegociao widget.
  FocusNode? valordanegociaoFocusNode;
  TextEditingController? valordanegociaoTextController;
  String? Function(BuildContext, String?)?
      valordanegociaoTextControllerValidator;
  // State field(s) for Adicionadoem widget.
  FocusNode? adicionadoemFocusNode;
  TextEditingController? adicionadoemTextController;
  late MaskTextInputFormatter adicionadoemMask;
  String? Function(BuildContext, String?)? adicionadoemTextControllerValidator;
  // State field(s) for ultimamovi widget.
  FocusNode? ultimamoviFocusNode;
  TextEditingController? ultimamoviTextController;
  late MaskTextInputFormatter ultimamoviMask;
  String? Function(BuildContext, String?)? ultimamoviTextControllerValidator;
  // State field(s) for datadefechamento widget.
  FocusNode? datadefechamentoFocusNode;
  TextEditingController? datadefechamentoTextController;
  late MaskTextInputFormatter datadefechamentoMask;
  String? Function(BuildContext, String?)?
      datadefechamentoTextControllerValidator;
  // State field(s) for responsavel widget.
  String? responsavelValue;
  FormFieldController<String>? responsavelValueController;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? veraddpc;
  // State field(s) for Switch widget.
  bool? switchValue;
  // Stores action output result for [Custom Action - reorderItems] action in ListView widget.
  List<String>? listaordenada;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController17;
  String? Function(BuildContext, String?)? textController17Validator;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  List<ContasRecord>? refreshserponsavel;

  @override
  void initState(BuildContext context) {
    menuModel = createModel(context, () => MenuModel());
  }

  @override
  void dispose() {
    menuModel.dispose();
    nomecelFocusNode?.dispose();
    nomecelTextController?.dispose();

    emailcelFocusNode?.dispose();
    emailcelTextController?.dispose();

    telefonecelFocusNode?.dispose();
    telefonecelTextController?.dispose();

    valordanegociaocelFocusNode?.dispose();
    valordanegociaocelTextController?.dispose();

    adicionadoemcelFocusNode?.dispose();
    adicionadoemcelTextController?.dispose();

    ultimamovicelFocusNode?.dispose();
    ultimamovicelTextController?.dispose();

    datadefechamentocelFocusNode?.dispose();
    datadefechamentocelTextController?.dispose();

    atividadecelFocusNode?.dispose();
    atividadecelTextController?.dispose();

    atividadeFocusNode?.dispose();
    atividadeTextController?.dispose();

    nomeFocusNode?.dispose();
    nomeTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    telefoneFocusNode?.dispose();
    telefoneTextController?.dispose();

    valordanegociaoFocusNode?.dispose();
    valordanegociaoTextController?.dispose();

    adicionadoemFocusNode?.dispose();
    adicionadoemTextController?.dispose();

    ultimamoviFocusNode?.dispose();
    ultimamoviTextController?.dispose();

    datadefechamentoFocusNode?.dispose();
    datadefechamentoTextController?.dispose();

    textFieldFocusNode?.dispose();
    textController17?.dispose();
  }
}
