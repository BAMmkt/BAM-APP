import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'containerresponsavel_model.dart';
export 'containerresponsavel_model.dart';

class ContainerresponsavelWidget extends StatefulWidget {
  const ContainerresponsavelWidget({
    super.key,
    this.parameter1,
    this.parameter2,
    this.parameter3,
    this.parameter4,
    bool? parameter5,
    this.parameter6,
  }) : this.parameter5 = parameter5 ?? false;

  final String? parameter1;
  final List<ContascconvidadasStruct>? parameter2;
  final int? parameter3;
  final String? parameter4;
  final bool parameter5;
  final DocumentReference? parameter6;

  @override
  State<ContainerresponsavelWidget> createState() =>
      _ContainerresponsavelWidgetState();
}

class _ContainerresponsavelWidgetState
    extends State<ContainerresponsavelWidget> {
  late ContainerresponsavelModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContainerresponsavelModel());

    _model.responsaveleditTextController ??=
        TextEditingController(text: widget.parameter1);
    _model.responsaveleditFocusNode ??= FocusNode();

    _model.boolocultarValue = widget.parameter5;
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                width: 600.0,
                child: TextFormField(
                  controller: _model.responsaveleditTextController,
                  focusNode: _model.responsaveleditFocusNode,
                  onChanged: (_) => EasyDebounce.debounce(
                    '_model.responsaveleditTextController',
                    Duration(milliseconds: 2000),
                    () async {
                      await widget.parameter6!.update({
                        ...mapToFirestore(
                          {
                            'responsavel':
                                getContascconvidadasListFirestoreData(
                              functions.editarresponsavelcrm(
                                  widget.parameter2?.toList(),
                                  widget.parameter3,
                                  widget.parameter4,
                                  _model.responsaveleditTextController.text,
                                  widget.parameter5),
                            ),
                          },
                        ),
                      });
                    },
                  ),
                  autofocus: false,
                  enabled: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: FFLocalizations.of(context).getText(
                      'h1a7l5t4' /* Nome do Responsável */,
                    ),
                    labelStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                    hintStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                  enableInteractiveSelection: true,
                  validator: _model.responsaveleditTextControllerValidator
                      .asValidator(context),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  FFLocalizations.of(context).getText(
                    'p0gogvz6' /* Admin */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        font: GoogleFonts.inter(
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                ),
                Switch.adaptive(
                  value: _model.boolocultarValue!,
                  onChanged: (newValue) async {
                    safeSetState(() => _model.boolocultarValue = newValue);
                    if (newValue) {
                      await widget.parameter6!.update({
                        ...mapToFirestore(
                          {
                            'responsavel':
                                getContascconvidadasListFirestoreData(
                              functions.editarresponsavelcrm(
                                  widget.parameter2?.toList(),
                                  widget.parameter3,
                                  widget.parameter4,
                                  widget.parameter1,
                                  true),
                            ),
                          },
                        ),
                      });
                    } else {
                      await widget.parameter6!.update({
                        ...mapToFirestore(
                          {
                            'responsavel':
                                getContascconvidadasListFirestoreData(
                              functions.editarresponsavelcrm(
                                  widget.parameter2?.toList(),
                                  widget.parameter3,
                                  widget.parameter4,
                                  widget.parameter1,
                                  true),
                            ),
                          },
                        ),
                      });
                    }
                  },
                  activeColor: FlutterFlowTheme.of(context).primary,
                  activeTrackColor: FlutterFlowTheme.of(context).primary,
                  inactiveTrackColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  inactiveThumbColor: FlutterFlowTheme.of(context).primary,
                ),
                FlutterFlowIconButton(
                  borderRadius: 8.0,
                  buttonSize: 40.0,
                  icon: FaIcon(
                    FontAwesomeIcons.trashAlt,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    await widget.parameter6!.update({
                      ...mapToFirestore(
                        {
                          'responsavel': FieldValue.arrayRemove([
                            getContascconvidadasFirestoreData(
                              createContascconvidadasStruct(
                                userId: widget.parameter4,
                                nome: widget.parameter1,
                                permission: widget.parameter5,
                                clearUnsetFields: false,
                              ),
                              true,
                            )
                          ]),
                        },
                      ),
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
