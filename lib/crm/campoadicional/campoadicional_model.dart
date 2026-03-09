import '/flutter_flow/flutter_flow_util.dart';
import 'campoadicional_widget.dart' show CampoadicionalWidget;
import 'package:flutter/material.dart';

class CampoadicionalModel extends FlutterFlowModel<CampoadicionalWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for camposadicionais widget.
  FocusNode? camposadicionaisFocusNode;
  TextEditingController? camposadicionaisTextController;
  String? Function(BuildContext, String?)?
      camposadicionaisTextControllerValidator;
  // State field(s) for camposadicionaiscel widget.
  FocusNode? camposadicionaiscelFocusNode;
  TextEditingController? camposadicionaiscelTextController;
  String? Function(BuildContext, String?)?
      camposadicionaiscelTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    camposadicionaisFocusNode?.dispose();
    camposadicionaisTextController?.dispose();

    camposadicionaiscelFocusNode?.dispose();
    camposadicionaiscelTextController?.dispose();
  }
}
