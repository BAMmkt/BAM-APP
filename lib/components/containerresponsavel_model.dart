import '/flutter_flow/flutter_flow_util.dart';
import 'containerresponsavel_widget.dart' show ContainerresponsavelWidget;
import 'package:flutter/material.dart';

class ContainerresponsavelModel
    extends FlutterFlowModel<ContainerresponsavelWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for responsaveledit widget.
  FocusNode? responsaveleditFocusNode;
  TextEditingController? responsaveleditTextController;
  String? Function(BuildContext, String?)?
      responsaveleditTextControllerValidator;
  // State field(s) for boolocultar widget.
  bool? boolocultarValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    responsaveleditFocusNode?.dispose();
    responsaveleditTextController?.dispose();
  }
}
