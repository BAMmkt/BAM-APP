import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'botaocomentario_widget.dart' show BotaocomentarioWidget;
import 'package:flutter/material.dart';

class BotaocomentarioModel extends FlutterFlowModel<BotaocomentarioWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (enviocomentario)] action in IconButton widget.
  ApiCallResponse? apiResultufmpc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
