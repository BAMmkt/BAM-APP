import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'boolocultar_model.dart';
export 'boolocultar_model.dart';

class BoolocultarWidget extends StatefulWidget {
  const BoolocultarWidget({
    super.key,
    this.parameter1,
    this.parameter2,
  });

  final bool? parameter1;
  final DocumentReference? parameter2;

  @override
  State<BoolocultarWidget> createState() => _BoolocultarWidgetState();
}

class _BoolocultarWidgetState extends State<BoolocultarWidget> {
  late BoolocultarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BoolocultarModel());

    _model.boolocultarValue = widget.parameter1!;
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: _model.boolocultarValue!,
      onChanged: (newValue) async {
        safeSetState(() => _model.boolocultarValue = newValue);
        if (newValue) {
          await widget.parameter2!.update(createContasRecordData(
            oculto: true,
          ));
        } else {
          await widget.parameter2!.update(createContasRecordData(
            oculto: false,
          ));
        }
      },
      activeColor: FlutterFlowTheme.of(context).primary,
      activeTrackColor: FlutterFlowTheme.of(context).primary,
      inactiveTrackColor: FlutterFlowTheme.of(context).secondaryBackground,
      inactiveThumbColor: FlutterFlowTheme.of(context).primary,
    );
  }
}
