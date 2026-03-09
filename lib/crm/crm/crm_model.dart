import '/backend/backend.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'crm_widget.dart' show CrmWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CrmModel extends FlutterFlowModel<CrmWidget> {
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

  bool filtrocelular = false;

  bool adicionar = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in CRM widget.
  int? numcontasusuario;
  // Stores action output result for [Firestore Query - Query a collection] action in CRM widget.
  int? contagempipeline;
  // Stores action output result for [Backend Call - Create Document] action in CRM widget.
  PipelinecrmRecord? configcrm;
  // Stores action output result for [Firestore Query - Query a collection] action in CRM widget.
  PipelinecrmRecord? colunaspipeline;
  // Model for menu component.
  late MenuModel menuModel;
  // Stores action output result for [Custom Action - csvdownload] action in Button widget.
  FFUploadedFile? listacrm;
  // State field(s) for Nomecrmc widget.
  FocusNode? nomecrmcFocusNode;
  TextEditingController? nomecrmcTextController;
  String? Function(BuildContext, String?)? nomecrmcTextControllerValidator;
  // State field(s) for emailcrmc widget.
  FocusNode? emailcrmcFocusNode;
  TextEditingController? emailcrmcTextController;
  String? Function(BuildContext, String?)? emailcrmcTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  CrmLeadsTesteRecord? postatualizarcrmceel;
  // State field(s) for nomec widget.
  FocusNode? nomecFocusNode;
  TextEditingController? nomecTextController;
  String? Function(BuildContext, String?)? nomecTextControllerValidator;
  // State field(s) for emailc widget.
  FocusNode? emailcFocusNode;
  TextEditingController? emailcTextController;
  String? Function(BuildContext, String?)? emailcTextControllerValidator;
  // State field(s) for statusc widget.
  String? statuscValue;
  FormFieldController<String>? statuscValueController;
  // State field(s) for responsavelc widget.
  String? responsavelcValue;
  FormFieldController<String>? responsavelcValueController;
  // State field(s) for valorminc widget.
  FocusNode? valormincFocusNode;
  TextEditingController? valormincTextController;
  String? Function(BuildContext, String?)? valormincTextControllerValidator;
  // State field(s) for valormaxc widget.
  FocusNode? valormaxcFocusNode;
  TextEditingController? valormaxcTextController;
  String? Function(BuildContext, String?)? valormaxcTextControllerValidator;
  // State field(s) for datacinicio widget.
  FocusNode? datacinicioFocusNode1;
  TextEditingController? datacinicioTextController1;
  late MaskTextInputFormatter datacinicioMask1;
  String? Function(BuildContext, String?)? datacinicioTextController1Validator;
  // State field(s) for datacfinal widget.
  FocusNode? datacfinalFocusNode1;
  TextEditingController? datacfinalTextController1;
  late MaskTextInputFormatter datacfinalMask1;
  String? Function(BuildContext, String?)? datacfinalTextController1Validator;
  // State field(s) for datafinicio widget.
  FocusNode? datafinicioFocusNode1;
  TextEditingController? datafinicioTextController1;
  late MaskTextInputFormatter datafinicioMask1;
  String? Function(BuildContext, String?)? datafinicioTextController1Validator;
  // State field(s) for dataffinal widget.
  FocusNode? dataffinalFocusNode1;
  TextEditingController? dataffinalTextController1;
  late MaskTextInputFormatter dataffinalMask1;
  String? Function(BuildContext, String?)? dataffinalTextController1Validator;
  // State field(s) for dataminicio widget.
  FocusNode? dataminicioFocusNode1;
  TextEditingController? dataminicioTextController1;
  late MaskTextInputFormatter dataminicioMask1;
  String? Function(BuildContext, String?)? dataminicioTextController1Validator;
  // State field(s) for datamfinal widget.
  FocusNode? datamfinalFocusNode1;
  TextEditingController? datamfinalTextController1;
  late MaskTextInputFormatter datamfinalMask1;
  String? Function(BuildContext, String?)? datamfinalTextController1Validator;
  // State field(s) for campopersc widget.
  String? campoperscValue;
  FormFieldController<String>? campoperscValueController;
  // State field(s) for valorpersc widget.
  FocusNode? valorperscFocusNode;
  TextEditingController? valorperscTextController;
  String? Function(BuildContext, String?)? valorperscTextControllerValidator;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? veradd;
  // Stores action output result for [Custom Action - csvdownload] action in Button widget.
  FFUploadedFile? listacrmpc;
  // State field(s) for Nomecrm widget.
  FocusNode? nomecrmFocusNode;
  TextEditingController? nomecrmTextController;
  String? Function(BuildContext, String?)? nomecrmTextControllerValidator;
  // State field(s) for emailcrm widget.
  FocusNode? emailcrmFocusNode;
  TextEditingController? emailcrmTextController;
  String? Function(BuildContext, String?)? emailcrmTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  CrmLeadsTesteRecord? postatualizarcrmpc;
  // State field(s) for nome widget.
  FocusNode? nomeFocusNode;
  TextEditingController? nomeTextController;
  String? Function(BuildContext, String?)? nomeTextControllerValidator;
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // State field(s) for status widget.
  String? statusValue;
  FormFieldController<String>? statusValueController;
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
  FocusNode? datacinicioFocusNode2;
  TextEditingController? datacinicioTextController2;
  late MaskTextInputFormatter datacinicioMask2;
  String? Function(BuildContext, String?)? datacinicioTextController2Validator;
  // State field(s) for datacfinal widget.
  FocusNode? datacfinalFocusNode2;
  TextEditingController? datacfinalTextController2;
  late MaskTextInputFormatter datacfinalMask2;
  String? Function(BuildContext, String?)? datacfinalTextController2Validator;
  // State field(s) for datafinicio widget.
  FocusNode? datafinicioFocusNode2;
  TextEditingController? datafinicioTextController2;
  late MaskTextInputFormatter datafinicioMask2;
  String? Function(BuildContext, String?)? datafinicioTextController2Validator;
  // State field(s) for dataffinal widget.
  FocusNode? dataffinalFocusNode2;
  TextEditingController? dataffinalTextController2;
  late MaskTextInputFormatter dataffinalMask2;
  String? Function(BuildContext, String?)? dataffinalTextController2Validator;
  // State field(s) for dataminicio widget.
  FocusNode? dataminicioFocusNode2;
  TextEditingController? dataminicioTextController2;
  late MaskTextInputFormatter dataminicioMask2;
  String? Function(BuildContext, String?)? dataminicioTextController2Validator;
  // State field(s) for datamfinal widget.
  FocusNode? datamfinalFocusNode2;
  TextEditingController? datamfinalTextController2;
  late MaskTextInputFormatter datamfinalMask2;
  String? Function(BuildContext, String?)? datamfinalTextController2Validator;
  // State field(s) for campopers widget.
  String? campopersValue;
  FormFieldController<String>? campopersValueController;
  // State field(s) for valorpers widget.
  FocusNode? valorpersFocusNode;
  TextEditingController? valorpersTextController;
  String? Function(BuildContext, String?)? valorpersTextControllerValidator;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? veraddpc;

  @override
  void initState(BuildContext context) {
    menuModel = createModel(context, () => MenuModel());
  }

  @override
  void dispose() {
    menuModel.dispose();
    nomecrmcFocusNode?.dispose();
    nomecrmcTextController?.dispose();

    emailcrmcFocusNode?.dispose();
    emailcrmcTextController?.dispose();

    nomecFocusNode?.dispose();
    nomecTextController?.dispose();

    emailcFocusNode?.dispose();
    emailcTextController?.dispose();

    valormincFocusNode?.dispose();
    valormincTextController?.dispose();

    valormaxcFocusNode?.dispose();
    valormaxcTextController?.dispose();

    datacinicioFocusNode1?.dispose();
    datacinicioTextController1?.dispose();

    datacfinalFocusNode1?.dispose();
    datacfinalTextController1?.dispose();

    datafinicioFocusNode1?.dispose();
    datafinicioTextController1?.dispose();

    dataffinalFocusNode1?.dispose();
    dataffinalTextController1?.dispose();

    dataminicioFocusNode1?.dispose();
    dataminicioTextController1?.dispose();

    datamfinalFocusNode1?.dispose();
    datamfinalTextController1?.dispose();

    valorperscFocusNode?.dispose();
    valorperscTextController?.dispose();

    nomecrmFocusNode?.dispose();
    nomecrmTextController?.dispose();

    emailcrmFocusNode?.dispose();
    emailcrmTextController?.dispose();

    nomeFocusNode?.dispose();
    nomeTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    valorminFocusNode?.dispose();
    valorminTextController?.dispose();

    valormaxFocusNode?.dispose();
    valormaxTextController?.dispose();

    datacinicioFocusNode2?.dispose();
    datacinicioTextController2?.dispose();

    datacfinalFocusNode2?.dispose();
    datacfinalTextController2?.dispose();

    datafinicioFocusNode2?.dispose();
    datafinicioTextController2?.dispose();

    dataffinalFocusNode2?.dispose();
    dataffinalTextController2?.dispose();

    dataminicioFocusNode2?.dispose();
    dataminicioTextController2?.dispose();

    datamfinalFocusNode2?.dispose();
    datamfinalTextController2?.dispose();

    valorpersFocusNode?.dispose();
    valorpersTextController?.dispose();
  }
}
