import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'contamaster_widget.dart' show ContamasterWidget;
import 'package:flutter/material.dart';

class ContamasterModel extends FlutterFlowModel<ContamasterWidget> {
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

  List<DocumentReference> contasid = [];
  void addToContasid(DocumentReference item) => contasid.add(item);
  void removeFromContasid(DocumentReference item) => contasid.remove(item);
  void removeAtIndexFromContasid(int index) => contasid.removeAt(index);
  void insertAtIndexInContasid(int index, DocumentReference item) =>
      contasid.insert(index, item);
  void updateContasidAtIndex(int index, Function(DocumentReference) updateFn) =>
      contasid[index] = updateFn(contasid[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for Checkbox widget.
  Map<ContasRecord, bool> checkboxValueMap = {};
  List<ContasRecord> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ContasMasterRecord? colecaomaster;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ContasRecord? contasoutput;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
