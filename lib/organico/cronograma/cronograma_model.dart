import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/organico/botaocomentario/botaocomentario_widget.dart';
import '/organico/crono/crono_widget.dart';
import '/index.dart';
import 'cronograma_widget.dart' show CronogramaWidget;
import 'dart:async';
import 'package:flutter/material.dart';

class CronogramaModel extends FlutterFlowModel<CronogramaWidget> {
  ///  Local state fields for this page.

  bool comentario = false;

  String? idcomentario;

  bool temconta = false;

  bool loaded = false;

  String? name;

  String nomecliente = 'null';

  String idconta = '00000';

  bool master = false;

  DocumentReference? idref;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in cronograma widget.
  int? numcontasusuario;
  // Stores action output result for [Firestore Query - Query a collection] action in cronograma widget.
  ContasRecord? contamaster;
  // Stores action output result for [Firestore Query - Query a collection] action in cronograma widget.
  ContasMasterRecord? contamasterrelacao;
  // Stores action output result for [Backend Call - Read Document] action in cronograma widget.
  ContasRecord? loopconta;
  // Stores action output result for [Firestore Query - Query a collection] action in cronograma widget.
  ContasRecord? contaselecionada;
  // Stores action output result for [Backend Call - API (Dados atuais insta)] action in cronograma widget.
  ApiCallResponse? dadosatuaisinsta;
  // Stores action output result for [Backend Call - API (Dados atuais insta)] action in cronograma widget.
  ApiCallResponse? dadosatuaisface;
  Completer<ApiCallResponse>? apiRequestCompleter2;
  // Models for crono dynamic component.
  late FlutterFlowDynamicModels<CronoModel> cronoModels1;
  // Stores action output result for [Backend Call - API (aprovacaocronograma)] action in Icon widget.
  ApiCallResponse? like;
  // Stores action output result for [Backend Call - API (aprovacaocronograma)] action in Icon widget.
  ApiCallResponse? unlike;
  Completer<ApiCallResponse>? apiRequestCompleter1;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (enviocomentario)] action in IconButton widget.
  ApiCallResponse? apiResultufm;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Models for crono dynamic component.
  late FlutterFlowDynamicModels<CronoModel> cronoModels2;
  // Stores action output result for [Backend Call - API (aprovacaocronograma)] action in Icon widget.
  ApiCallResponse? likepc;
  Completer<ApiCallResponse>? apiRequestCompleter3;
  // Stores action output result for [Backend Call - API (aprovacaocronograma)] action in Icon widget.
  ApiCallResponse? unlikepc;
  // Models for botaocomentario dynamic component.
  late FlutterFlowDynamicModels<BotaocomentarioModel> botaocomentarioModels;

  @override
  void initState(BuildContext context) {
    cronoModels1 = FlutterFlowDynamicModels(() => CronoModel());
    cronoModels2 = FlutterFlowDynamicModels(() => CronoModel());
    botaocomentarioModels =
        FlutterFlowDynamicModels(() => BotaocomentarioModel());
  }

  @override
  void dispose() {
    cronoModels1.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    cronoModels2.dispose();
    botaocomentarioModels.dispose();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter2?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForApiRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter1?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForApiRequestCompleted3({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter3?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
