import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'menu_widget.dart' show MenuWidget;
import 'package:flutter/material.dart';

class MenuModel extends FlutterFlowModel<MenuWidget> {
  ///  Local state fields for this component.

  bool dropdown = false;

  bool masterinsta = false;

  bool mastermetaads = false;

  bool mastergoogle = false;

  String nomegoogle = 'null';

  String nomemetaads = 'null';

  String nomeinsta = 'null';

  String tipoorg = 'null';

  bool master = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in menu widget.
  ContasRecord? contamaster;
  // Stores action output result for [Firestore Query - Query a collection] action in menu widget.
  ContasMasterRecord? contamasterrelacao;
  // Stores action output result for [Backend Call - Read Document] action in menu widget.
  ContasRecord? loopconta;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
