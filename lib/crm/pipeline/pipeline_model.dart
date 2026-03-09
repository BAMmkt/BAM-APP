import '/backend/backend.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'pipeline_widget.dart' show PipelineWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PipelineModel extends FlutterFlowModel<PipelineWidget> {
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

  bool config = false;

  bool adicionar = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in pipeline widget.
  int? numcontasusuario;
  // Stores action output result for [Firestore Query - Query a collection] action in pipeline widget.
  int? contagempipeline;
  // Stores action output result for [Backend Call - Create Document] action in pipeline widget.
  PipelinecrmRecord? configcrm;
  // Stores action output result for [Firestore Query - Query a collection] action in pipeline widget.
  PipelinecrmRecord? colunaspipeline;
  // Model for menu component.
  late MenuModel menuModel;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? veraddpc;
  // State field(s) for nome widget.
  FocusNode? nomeFocusNode;
  TextEditingController? nomeTextController;
  String? Function(BuildContext, String?)? nomeTextControllerValidator;
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // State field(s) for responsavel widget.
  String? responsavelValue;
  FormFieldController<String>? responsavelValueController;
  // State field(s) for valormin widget.
  FocusNode? valorminFocusNode;
  TextEditingController? valorminTextController;
  String? Function(BuildContext, String?)? valorminTextControllerValidator;
  // State field(s) for valormax widget.
  FocusNode? valormaxFocusNode;
  TextEditingController? valormaxTextController;
  String? Function(BuildContext, String?)? valormaxTextControllerValidator;
  // State field(s) for datacinicio widget.
  FocusNode? datacinicioFocusNode;
  TextEditingController? datacinicioTextController;
  late MaskTextInputFormatter datacinicioMask;
  String? Function(BuildContext, String?)? datacinicioTextControllerValidator;
  // State field(s) for datacfinal widget.
  FocusNode? datacfinalFocusNode;
  TextEditingController? datacfinalTextController;
  late MaskTextInputFormatter datacfinalMask;
  String? Function(BuildContext, String?)? datacfinalTextControllerValidator;
  // State field(s) for datafinicio widget.
  FocusNode? datafinicioFocusNode;
  TextEditingController? datafinicioTextController;
  late MaskTextInputFormatter datafinicioMask;
  String? Function(BuildContext, String?)? datafinicioTextControllerValidator;
  // State field(s) for dataffinal widget.
  FocusNode? dataffinalFocusNode;
  TextEditingController? dataffinalTextController;
  late MaskTextInputFormatter dataffinalMask;
  String? Function(BuildContext, String?)? dataffinalTextControllerValidator;
  // State field(s) for dataminicio widget.
  FocusNode? dataminicioFocusNode;
  TextEditingController? dataminicioTextController;
  late MaskTextInputFormatter dataminicioMask;
  String? Function(BuildContext, String?)? dataminicioTextControllerValidator;
  // State field(s) for datamfinal widget.
  FocusNode? datamfinalFocusNode;
  TextEditingController? datamfinalTextController;
  late MaskTextInputFormatter datamfinalMask;
  String? Function(BuildContext, String?)? datamfinalTextControllerValidator;
  // State field(s) for campopers widget.
  String? campopersValue;
  FormFieldController<String>? campopersValueController;
  // State field(s) for valorpers widget.
  FocusNode? valorpersFocusNode;
  TextEditingController? valorpersTextController;
  String? Function(BuildContext, String?)? valorpersTextControllerValidator;
  // Stores action output result for [Custom Action - reorderItems] action in ListView widget.
  List<String>? listaordenada;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController12;
  String? Function(BuildContext, String?)? textController12Validator;

  @override
  void initState(BuildContext context) {
    menuModel = createModel(context, () => MenuModel());
  }

  @override
  void dispose() {
    menuModel.dispose();
    nomeFocusNode?.dispose();
    nomeTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    valorminFocusNode?.dispose();
    valorminTextController?.dispose();

    valormaxFocusNode?.dispose();
    valormaxTextController?.dispose();

    datacinicioFocusNode?.dispose();
    datacinicioTextController?.dispose();

    datacfinalFocusNode?.dispose();
    datacfinalTextController?.dispose();

    datafinicioFocusNode?.dispose();
    datafinicioTextController?.dispose();

    dataffinalFocusNode?.dispose();
    dataffinalTextController?.dispose();

    dataminicioFocusNode?.dispose();
    dataminicioTextController?.dispose();

    datamfinalFocusNode?.dispose();
    datamfinalTextController?.dispose();

    valorpersFocusNode?.dispose();
    valorpersTextController?.dispose();

    textFieldFocusNode?.dispose();
    textController12?.dispose();
  }

  /// Action blocks.
  Future clickaddlead(BuildContext context) async {}
}
