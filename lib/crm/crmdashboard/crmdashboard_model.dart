import '/backend/backend.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'crmdashboard_widget.dart' show CrmdashboardWidget;
import 'package:flutter/material.dart';

class CrmdashboardModel extends FlutterFlowModel<CrmdashboardWidget> {
  ///  Local state fields for this page.

  bool temconta = false;
  bool loaded = false;
  DateTime? dataInicio;
  DateTime? dataFinal;
  bool filtrarPerdidos = false;
  bool showConfig = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in crmdashboard widget.
  int? numcontasusuario;
  // Stores action output result for [Firestore Query - Query a collection] action in crmdashboard widget.
  PipelinecrmRecord? colunaspipeline;
  // Model for menu component.
  late MenuModel menuModel;
  // State field(s) for responsavelDropdown widget.
  String? responsavelValue;
  FormFieldController<String>? responsavelValueController;
  // State field(s) for config dropdowns.
  FormFieldController<String>? colunaVendaController;
  FormFieldController<String>? colunaPerdidoController;

  @override
  void initState(BuildContext context) {
    menuModel = createModel(context, () => MenuModel());
  }

  @override
  void dispose() {
    menuModel.dispose();
    colunaVendaController?.dispose();
    colunaPerdidoController?.dispose();
  }
}
