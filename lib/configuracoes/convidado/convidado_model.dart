import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'convidado_widget.dart' show ConvidadoWidget;
import 'package:flutter/material.dart';

class ConvidadoModel extends FlutterFlowModel<ConvidadoWidget> {
  ///  Local state fields for this page.

  bool loaded = false;

  List<String> contasselecionadas = [];
  void addToContasselecionadas(String item) => contasselecionadas.add(item);
  void removeFromContasselecionadas(String item) =>
      contasselecionadas.remove(item);
  void removeAtIndexFromContasselecionadas(int index) =>
      contasselecionadas.removeAt(index);
  void insertAtIndexInContasselecionadas(int index, String item) =>
      contasselecionadas.insert(index, item);
  void updateContasselecionadasAtIndex(int index, Function(String) updateFn) =>
      contasselecionadas[index] = updateFn(contasselecionadas[index]);

  int? loopadd = 0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Custom Action - getDocRefFromID] action in DropDown widget.
  DocumentReference? docref;
  // State field(s) for Checkbox widget.
  Map<ContasRecord, bool> checkboxValueMap = {};
  List<ContasRecord> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ContasRecord? apiResult13d;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
