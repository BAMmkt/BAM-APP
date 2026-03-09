import '/flutter_flow/flutter_flow_util.dart';
import 'historico_widget.dart' show HistoricoWidget;
import 'package:flutter/material.dart';

class HistoricoModel extends FlutterFlowModel<HistoricoWidget> {
  ///  Local state fields for this component.

  bool edit = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Atividade widget.
  FocusNode? atividadeFocusNode;
  TextEditingController? atividadeTextController;
  String? Function(BuildContext, String?)? atividadeTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    atividadeFocusNode?.dispose();
    atividadeTextController?.dispose();
  }
}
