import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'addleadcrm_widget.dart' show AddleadcrmWidget;
import 'package:flutter/material.dart';

class AddleadcrmModel extends FlutterFlowModel<AddleadcrmWidget> {
  ///  State fields for stateful widgets in this component.

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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nomecrmFocusNode?.dispose();
    nomecrmTextController?.dispose();

    emailcrmFocusNode?.dispose();
    emailcrmTextController?.dispose();
  }

  /// Action blocks.
  Future booladicionarconta(BuildContext context) async {
    await booladicionarconta(context);
  }
}
