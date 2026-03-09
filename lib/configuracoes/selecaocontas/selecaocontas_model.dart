import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'selecaocontas_widget.dart' show SelecaocontasWidget;
import 'package:flutter/material.dart';

class SelecaocontasModel extends FlutterFlowModel<SelecaocontasWidget> {
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

  bool meta = false;

  bool google = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Contas)] action in selecaocontas widget.
  ApiCallResponse? buscacontas;
  // Stores action output result for [Firestore Query - Query a collection] action in selecaocontas widget.
  List<ContasRecord>? contasdousuario;
  // Stores action output result for [Backend Call - API (Contas Google)] action in selecaocontas widget.
  ApiCallResponse? buscacontasgoogle;
  // Stores action output result for [Firestore Query - Query a collection] action in selecaocontas widget.
  List<ContasRecord>? contasdousuariogoogle;
  // State field(s) for Checkbox widget.
  Map<dynamic, bool> checkboxValueMap1 = {};
  List<dynamic> get checkboxCheckedItems1 => checkboxValueMap1.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  // Stores action output result for [Backend Call - API (AccountIds)] action in Button widget.
  ApiCallResponse? contasenviadas;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ContasRecord? apiResult13d;
  // Stores action output result for [Backend Call - API (adicionar novo)] action in Button widget.
  ApiCallResponse? envioconta;
  // State field(s) for Checkbox widget.
  Map<dynamic, bool> checkboxValueMap2 = {};
  List<dynamic> get checkboxCheckedItems2 => checkboxValueMap2.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  // Stores action output result for [Backend Call - API (AccountIds)] action in Button widget.
  ApiCallResponse? contasenviadasgoogle;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ContasRecord? apiResult13dgoogle;
  // Stores action output result for [Backend Call - API (adicionar novo)] action in Button widget.
  ApiCallResponse? enviocontagoogle;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
