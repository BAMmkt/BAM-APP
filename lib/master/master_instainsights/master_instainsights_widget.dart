import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/loading/loading_widget.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'master_instainsights_model.dart';
export 'master_instainsights_model.dart';

class MasterInstainsightsWidget extends StatefulWidget {
  const MasterInstainsightsWidget({super.key});

  static String routeName = 'master-instainsights';
  static String routePath = '/masterinstainsights';

  @override
  State<MasterInstainsightsWidget> createState() =>
      _MasterInstainsightsWidgetState();
}

class _MasterInstainsightsWidgetState extends State<MasterInstainsightsWidget> {
  late MasterInstainsightsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MasterInstainsightsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (valueOrDefault(currentUserDocument?.lang, '') == 'por') {
        setAppLanguage(context, 'pt');
      } else {
        setAppLanguage(context, 'en');
      }

      if (valueOrDefault<bool>(currentUserDocument?.dark, false) == true) {
        setDarkModeSetting(context, ThemeMode.dark);
      } else {
        setDarkModeSetting(context, ThemeMode.light);
      }

      _model.numcontasusuario = await queryContasRecordCount(
        queryBuilder: (contasRecord) => contasRecord.where(
          'usuario',
          isEqualTo: currentUserReference,
        ),
      );
      if (_model.numcontasusuario! > 0) {
        _model.temconta = true;
        safeSetState(() {});
        if (valueOrDefault(currentUserDocument?.type, '') == 'master') {
          _model.contamaster = await queryContasRecordOnce(
            queryBuilder: (contasRecord) => contasRecord.where(
              'idconta',
              isEqualTo:
                  valueOrDefault(currentUserDocument?.idcontaselecionada, ''),
            ),
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          _model.contamasterrelacao = await queryContasMasterRecordOnce(
            queryBuilder: (contasMasterRecord) => contasMasterRecord.where(
              'contas_id',
              isEqualTo: _model.contamaster?.reference,
            ),
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          for (int loop1Index = 0;
              loop1Index < _model.contamasterrelacao!.contasconectadas.length;
              loop1Index++) {
            final currentLoop1Item =
                _model.contamasterrelacao!.contasconectadas[loop1Index];
            _model.loopconta =
                await ContasRecord.getDocumentOnce(currentLoop1Item);
            if ((_model.loopconta?.plataforma == 'instagram') ||
                (_model.loopconta?.plataforma == 'facebook')) {
              _model.idconta = _model.loopconta!.idconta;
              safeSetState(() {});
              _model.dadosmensaisbackend = await DadosMensaisCall.call(
                filterColumn: 'related_id',
                filterValue: _model.loopconta?.idconta,
                filterColumn2: 'user_id',
                filterValue2:
                    valueOrDefault<bool>(currentUserDocument?.admin, false)
                        ? currentUserUid
                        : valueOrDefault(currentUserDocument?.lenderId, ''),
              );

              await Future.wait([
                Future(() async {
                  _model.ultimodia = await actions.coletaultimodia(
                    getJsonField(
                      (_model.dadosmensaisbackend?.jsonBody ?? ''),
                      r'''$''',
                      true,
                    )!,
                  );
                }),
                Future(() async {
                  _model.primeirodia = await actions.coletaprimeirodia(
                    getJsonField(
                      (_model.dadosmensaisbackend?.jsonBody ?? ''),
                      r'''$''',
                      true,
                    )!,
                  );
                }),
              ]);
              if ((_model.ultimodia != null) && (_model.primeirodia != null)
                  ? true
                  : false) {
                await Future.wait([
                  Future(() async {
                    FFAppState().DataInicioMes = _model.primeirodia;
                    safeSetState(() {});
                    _model.primeirodiaanterior =
                        await actions.iniciomesanterior(
                      _model.primeirodia,
                    );
                    FFAppState().DataInicioMesAnterior =
                        _model.primeirodiaanterior;
                    safeSetState(() {});
                  }),
                  Future(() async {
                    FFAppState().DataFinalMes = _model.ultimodia;
                    safeSetState(() {});
                    _model.ultimodiaanterior = await actions.finalmesanterior(
                      _model.primeirodia,
                    );
                    FFAppState().DataFinalMesAnterior =
                        _model.ultimodiaanterior;
                    safeSetState(() {});
                  }),
                ]);
                _model.contaselecionada = await queryContasRecordOnce(
                  queryBuilder: (contasRecord) => contasRecord.where(
                    'idconta',
                    isEqualTo: _model.idconta,
                  ),
                  singleRecord: true,
                ).then((s) => s.firstOrNull);
                _model.demografias = await DemografiaCall.call(
                  filterColumn: 'related_id',
                  filterValue: _model.loopconta?.idconta,
                  filterColumn2: 'user_id',
                  filterValue2:
                      valueOrDefault<bool>(currentUserDocument?.admin, false)
                          ? currentUserUid
                          : valueOrDefault(currentUserDocument?.lenderId, ''),
                );

                if ((_model.demografias?.succeeded ?? true)) {
                  _model.demografia = true;
                  safeSetState(() {});
                }
                if ('instagram' == _model.loopconta?.plataforma
                    ? true
                    : false) {
                  _model.dadosatuaisinsta = await DadosAtuaisInstaCall.call(
                    accountId: _model.idconta,
                  );

                  if ((_model.dadosatuaisinsta?.succeeded ?? true)) {
                    if (_model.contaselecionada?.nome !=
                        getJsonField(
                          (_model.dadosatuaisinsta?.jsonBody ?? ''),
                          r'''$.username''',
                        ).toString()) {
                      await _model.contaselecionada!.reference
                          .update(createContasRecordData(
                        nome: getJsonField(
                          (_model.dadosatuaisinsta?.jsonBody ?? ''),
                          r'''$.username''',
                        ).toString(),
                      ));
                    }
                  }
                } else {
                  _model.dadosatuaisface = await DadosAtuaisFaceCall.call(
                    accountId: _model.idconta,
                  );

                  if ((_model.dadosatuaisface?.succeeded ?? true)) {
                    if (_model.contaselecionada?.nome !=
                        getJsonField(
                          (_model.dadosatuaisinsta?.jsonBody ?? ''),
                          r'''$.name''',
                        ).toString()) {
                      await _model.contaselecionada!.reference
                          .update(createContasRecordData(
                        nome: getJsonField(
                          (_model.dadosatuaisface?.jsonBody ?? ''),
                          r'''$.name''',
                        ).toString(),
                      ));
                    }
                  }
                }

                _model.loaded = true;
                safeSetState(() {});
              }
            }
          }
        } else {
          context.pushNamed(HomeWidget.routeName);
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final chartPieChartColorsList2 = [
      FlutterFlowTheme.of(context).primary,
      FlutterFlowTheme.of(context).error,
      FlutterFlowTheme.of(context).warning
    ];
    final chartPieChartColorsList5 = [
      FlutterFlowTheme.of(context).primary,
      FlutterFlowTheme.of(context).error,
      FlutterFlowTheme.of(context).warning
    ];
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: Container(
          width: MediaQuery.sizeOf(context).width * 0.66,
          child: Drawer(
            elevation: 16.0,
            child: WebViewAware(
              child: wrapWithModel(
                model: _model.menuModel,
                updateCallback: () => safeSetState(() {}),
                child: MenuWidget(),
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (_model.loaded)
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (responsiveVisibility(
                      context: context,
                      tabletLandscape: false,
                      desktop: false,
                    ))
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if ((_model.temconta == true) && _model.loaded)
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height: 280.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 24.0, 24.0, 24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FlutterFlowIconButton(
                                          borderRadius: 8.0,
                                          buttonSize: 50.0,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          icon: Icon(
                                            Icons.menu,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 30.0,
                                          ),
                                          onPressed: () async {
                                            scaffoldKey.currentState!
                                                .openDrawer();
                                          },
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Material(
                                              color: Colors.transparent,
                                              elevation: 4.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                              ),
                                              child: Container(
                                                width: 80.0,
                                                height: 80.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.0),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.0),
                                                  child: Image.network(
                                                    _model.contaselecionada
                                                                ?.plataforma ==
                                                            'instagram'
                                                        ? getJsonField(
                                                            (_model.dadosatuaisinsta
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.profile_picture_url''',
                                                          ).toString()
                                                        : getJsonField(
                                                            (_model.dadosatuaisface
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.picture''',
                                                          ).toString(),
                                                    width: 80.0,
                                                    height: 80.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _model.contaselecionada
                                                                ?.plataforma ==
                                                            'instagram'
                                                        ? getJsonField(
                                                            (_model.dadosatuaisinsta
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.username''',
                                                          ).toString()
                                                        : getJsonField(
                                                            (_model.dadosatuaisface
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.name''',
                                                          ).toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .oswald(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 24.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Text(
                                                    _model.contaselecionada
                                                                ?.plataforma ==
                                                            'instagram'
                                                        ? getJsonField(
                                                            (_model.dadosatuaisinsta
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.biography''',
                                                          ).toString()
                                                        : getJsonField(
                                                            (_model.dadosatuaisface
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.about''',
                                                          )
                                                            .toString()
                                                            .maybeHandleOverflow(
                                                              maxChars: 120,
                                                              replacement: '…',
                                                            ),
                                                    maxLines: 3,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLarge
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 16.0)),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  _model.contaselecionada
                                                              ?.plataforma ==
                                                          'instagram'
                                                      ? getJsonField(
                                                          (_model.dadosatuaisinsta
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.followers_count''',
                                                        ).toString()
                                                      : getJsonField(
                                                          (_model.dadosatuaisface
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.fan_count''',
                                                        ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .headlineMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.oswald(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '2kmwz53l' /* Seguidores */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  _model.contaselecionada
                                                              ?.plataforma ==
                                                          'instagram'
                                                      ? getJsonField(
                                                          (_model.dadosatuaisinsta
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.media_count''',
                                                        ).toString()
                                                      : getJsonField(
                                                          (_model.dadosatuaisface
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.media_count''',
                                                        ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .headlineMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.oswald(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '2fho4vf9' /* Posts */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            if (_model.contaselecionada
                                                    ?.plataforma ==
                                                'instagram')
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    _model.contaselecionada
                                                                ?.plataforma ==
                                                            'instagram'
                                                        ? getJsonField(
                                                            (_model.dadosatuaisinsta
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.follows_count''',
                                                          ).toString()
                                                        : getJsonField(
                                                            (_model.dadosatuaisface
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.follows_count''',
                                                          ).toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .oswald(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'qi2rb0u0' /* Seguindo */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                          ].divide(SizedBox(width: 24.0)),
                                        ),
                                      ].divide(SizedBox(height: 15.0)),
                                    ),
                                  ),
                                ),
                              if ((_model.temconta == true) &&
                                  (_model.loaded == true))
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0.0),
                                      bottomRight: Radius.circular(0.0),
                                      topLeft: Radius.circular(32.0),
                                      topRight: Radius.circular(32.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        22.0, 24.0, 22.0, 24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '4xm9z2c6' /* Resultados da página */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall
                                              .override(
                                                font: GoogleFonts.oswald(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmall
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .fontStyle,
                                              ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          elevation: 2.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 20.0, 20.0, 20.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'auw6p5f0' /* Seleção de período */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .oswald(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      FlutterFlowIconButton(
                                                        borderRadius: 8.0,
                                                        buttonSize: 40.0,
                                                        fillColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryBackground,
                                                        disabledColor:
                                                            Colors.transparent,
                                                        disabledIconColor:
                                                            Colors.transparent,
                                                        icon: Icon(
                                                          Icons
                                                              .arrow_back_ios_sharp,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 25.0,
                                                        ),
                                                        onPressed:
                                                            !functions.bolrecuo(
                                                                    getJsonField(
                                                                      (_model.dadosmensaisbackend
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                      r'''$''',
                                                                      true,
                                                                    )!,
                                                                    FFAppState()
                                                                        .DataInicioMes!)
                                                                ? null
                                                                : () async {
                                                                    await Future
                                                                        .wait([
                                                                      Future(
                                                                          () async {
                                                                        FFAppState().DataInicioMes =
                                                                            functions.reduzirdatainicio(FFAppState().DataInicioMes);
                                                                        FFAppState().DataInicioMesAnterior =
                                                                            functions.reduzirdatainicio(FFAppState().DataInicioMesAnterior);
                                                                        safeSetState(
                                                                            () {});
                                                                      }),
                                                                      Future(
                                                                          () async {
                                                                        FFAppState().DataFinalMes =
                                                                            functions.reduzirdatafinal(FFAppState().DataFinalMes);
                                                                        FFAppState().DataFinalMesAnterior =
                                                                            functions.reduzirdatafinal(FFAppState().DataFinalMesAnterior);
                                                                        safeSetState(
                                                                            () {});
                                                                      }),
                                                                    ]);
                                                                  },
                                                      ),
                                                      Text(
                                                        '${dateTimeFormat(
                                                          "d/M",
                                                          FFAppState()
                                                              .DataInicioMes,
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        )} - ${dateTimeFormat(
                                                          "d/M",
                                                          FFAppState()
                                                              .DataFinalMes,
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        )}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      20.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      FlutterFlowIconButton(
                                                        borderRadius: 8.0,
                                                        buttonSize: 40.0,
                                                        fillColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryBackground,
                                                        disabledColor:
                                                            Colors.transparent,
                                                        disabledIconColor:
                                                            Colors.transparent,
                                                        icon: Icon(
                                                          Icons
                                                              .arrow_forward_ios_sharp,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 25.0,
                                                        ),
                                                        onPressed: !functions
                                                                .bolavanco(
                                                                    getJsonField(
                                                                      (_model.dadosmensaisbackend
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                      r'''$''',
                                                                      true,
                                                                    )!,
                                                                    FFAppState()
                                                                        .DataFinalMes!)!
                                                            ? null
                                                            : () async {
                                                                await Future
                                                                    .wait([
                                                                  Future(
                                                                      () async {
                                                                    FFAppState()
                                                                            .DataInicioMes =
                                                                        functions
                                                                            .aumentardatainicio(FFAppState().DataInicioMes);
                                                                    FFAppState()
                                                                            .DataInicioMesAnterior =
                                                                        functions
                                                                            .aumentardatainicio(FFAppState().DataInicioMesAnterior);
                                                                    safeSetState(
                                                                        () {});
                                                                  }),
                                                                  Future(
                                                                      () async {
                                                                    FFAppState()
                                                                            .DataFinalMes =
                                                                        functions
                                                                            .aumentardatafinal(FFAppState().DataFinalMes);
                                                                    FFAppState()
                                                                            .DataFinalMesAnterior =
                                                                        functions
                                                                            .aumentardatafinal(FFAppState().DataFinalMesAnterior);
                                                                    safeSetState(
                                                                        () {});
                                                                  }),
                                                                ]);
                                                              },
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: AuthUserStreamWidget(
                                              builder: (context) =>
                                                  FutureBuilder<
                                                      ApiCallResponse>(
                                                future: DadosMensaisCall.call(
                                                  filterColumn: 'related_id',
                                                  filterValue: _model.idconta,
                                                  filterColumn2: 'user_id',
                                                  filterValue2: valueOrDefault<
                                                              bool>(
                                                          currentUserDocument
                                                              ?.admin,
                                                          false)
                                                      ? currentUserUid
                                                      : valueOrDefault(
                                                          currentUserDocument
                                                              ?.lenderId,
                                                          ''),
                                                ),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 50,
                                                        height: 50,
                                                        child:
                                                            CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  final containerDadosMensaisResponse =
                                                      snapshot.data!;

                                                  return Material(
                                                    color: Colors.transparent,
                                                    elevation: 2.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    20.0,
                                                                    20.0,
                                                                    20.0,
                                                                    20.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    '69lyyqmi' /* Dados descritivos */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .oswald(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            formatNumber(
                                                                              functions.somadisplay(
                                                                                  getJsonField(
                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                    r'''$''',
                                                                                    true,
                                                                                  ),
                                                                                  'follows_and_unfollows',
                                                                                  FFAppState().DataInicioMes!,
                                                                                  FFAppState().DataFinalMes!),
                                                                              formatType: FormatType.compact,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                  font: GoogleFonts.oswald(
                                                                                    fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  fontSize: 22.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                [
                                                                              if (functions.verificarpos(valueOrDefault<String>(
                                                                                    functions.varpercentual(
                                                                                        functions
                                                                                            .somadisplay(
                                                                                                getJsonField(
                                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'follows_and_unfollows',
                                                                                                FFAppState().DataInicioMes!,
                                                                                                FFAppState().DataFinalMes!)!
                                                                                            .toDouble(),
                                                                                        functions
                                                                                            .somadisplay(
                                                                                                getJsonField(
                                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'follows_and_unfollows',
                                                                                                FFAppState().DataInicioMesAnterior!,
                                                                                                FFAppState().DataFinalMesAnterior!)!
                                                                                            .toDouble()),
                                                                                    '+10%',
                                                                                  )) ??
                                                                                  true)
                                                                                Icon(
                                                                                  Icons.trending_up,
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  size: 15.0,
                                                                                ),
                                                                              if (!functions.verificarpos(valueOrDefault<String>(
                                                                                functions.varpercentual(
                                                                                    functions
                                                                                        .somadisplay(
                                                                                            getJsonField(
                                                                                              containerDadosMensaisResponse.jsonBody,
                                                                                              r'''$''',
                                                                                              true,
                                                                                            ),
                                                                                            'follows_and_unfollows',
                                                                                            FFAppState().DataInicioMes!,
                                                                                            FFAppState().DataFinalMes!)!
                                                                                        .toDouble(),
                                                                                    functions
                                                                                        .somadisplay(
                                                                                            getJsonField(
                                                                                              containerDadosMensaisResponse.jsonBody,
                                                                                              r'''$''',
                                                                                              true,
                                                                                            ),
                                                                                            'follows_and_unfollows',
                                                                                            FFAppState().DataInicioMesAnterior!,
                                                                                            FFAppState().DataFinalMesAnterior!)!
                                                                                        .toDouble()),
                                                                                '+10%',
                                                                              ))!)
                                                                                Icon(
                                                                                  Icons.trending_down,
                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                  size: 15.0,
                                                                                ),
                                                                              Text(
                                                                                valueOrDefault<String>(
                                                                                  functions.varpercentual(
                                                                                      functions
                                                                                          .somadisplay(
                                                                                              getJsonField(
                                                                                                containerDadosMensaisResponse.jsonBody,
                                                                                                r'''$''',
                                                                                                true,
                                                                                              ),
                                                                                              'follows_and_unfollows',
                                                                                              FFAppState().DataInicioMes!,
                                                                                              FFAppState().DataFinalMes!)!
                                                                                          .toDouble(),
                                                                                      functions
                                                                                          .somadisplay(
                                                                                              getJsonField(
                                                                                                containerDadosMensaisResponse.jsonBody,
                                                                                                r'''$''',
                                                                                                true,
                                                                                              ),
                                                                                              'follows_and_unfollows',
                                                                                              FFAppState().DataInicioMesAnterior!,
                                                                                              FFAppState().DataFinalMesAnterior!)!
                                                                                          .toDouble()),
                                                                                  '+10%',
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: functions.verificarpos(valueOrDefault<String>(
                                                                                        functions.varpercentual(
                                                                                            functions
                                                                                                .somadisplay(
                                                                                                    getJsonField(
                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                      r'''$''',
                                                                                                      true,
                                                                                                    ),
                                                                                                    'follows_and_unfollows',
                                                                                                    FFAppState().DataInicioMes!,
                                                                                                    FFAppState().DataFinalMes!)!
                                                                                                .toDouble(),
                                                                                            functions
                                                                                                .somadisplay(
                                                                                                    getJsonField(
                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                      r'''$''',
                                                                                                      true,
                                                                                                    ),
                                                                                                    'follows_and_unfollows',
                                                                                                    FFAppState().DataInicioMesAnterior!,
                                                                                                    FFAppState().DataFinalMesAnterior!)!
                                                                                                .toDouble()),
                                                                                        '+10%',
                                                                                      ))!
                                                                                          ? FlutterFlowTheme.of(context).primary
                                                                                          : FlutterFlowTheme.of(context).error,
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 4.0)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'ast9aotd' /* Seguidores */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            formatNumber(
                                                                              functions.somadisplay(
                                                                                  getJsonField(
                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                    r'''$''',
                                                                                    true,
                                                                                  ),
                                                                                  'likes',
                                                                                  FFAppState().DataInicioMes!,
                                                                                  FFAppState().DataFinalMes!),
                                                                              formatType: FormatType.compact,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                  font: GoogleFonts.oswald(
                                                                                    fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  fontSize: 22.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                [
                                                                              if (functions.verificarpos(valueOrDefault<String>(
                                                                                    functions.varpercentual(
                                                                                        functions
                                                                                            .somadisplay(
                                                                                                getJsonField(
                                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'likes',
                                                                                                FFAppState().DataInicioMes!,
                                                                                                FFAppState().DataFinalMes!)!
                                                                                            .toDouble(),
                                                                                        functions
                                                                                            .somadisplay(
                                                                                                getJsonField(
                                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'likes',
                                                                                                FFAppState().DataInicioMesAnterior!,
                                                                                                FFAppState().DataFinalMesAnterior!)!
                                                                                            .toDouble()),
                                                                                    '+10%',
                                                                                  )) ??
                                                                                  true)
                                                                                Icon(
                                                                                  Icons.trending_up,
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  size: 15.0,
                                                                                ),
                                                                              if (!functions.verificarpos(valueOrDefault<String>(
                                                                                functions.varpercentual(
                                                                                    functions
                                                                                        .somadisplay(
                                                                                            getJsonField(
                                                                                              containerDadosMensaisResponse.jsonBody,
                                                                                              r'''$''',
                                                                                              true,
                                                                                            ),
                                                                                            'likes',
                                                                                            FFAppState().DataInicioMes!,
                                                                                            FFAppState().DataFinalMes!)!
                                                                                        .toDouble(),
                                                                                    functions
                                                                                        .somadisplay(
                                                                                            getJsonField(
                                                                                              containerDadosMensaisResponse.jsonBody,
                                                                                              r'''$''',
                                                                                              true,
                                                                                            ),
                                                                                            'likes',
                                                                                            FFAppState().DataInicioMesAnterior!,
                                                                                            FFAppState().DataFinalMesAnterior!)!
                                                                                        .toDouble()),
                                                                                '+10%',
                                                                              ))!)
                                                                                Icon(
                                                                                  Icons.trending_down,
                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                  size: 15.0,
                                                                                ),
                                                                              Text(
                                                                                valueOrDefault<String>(
                                                                                  functions.varpercentual(
                                                                                      functions
                                                                                          .somadisplay(
                                                                                              getJsonField(
                                                                                                containerDadosMensaisResponse.jsonBody,
                                                                                                r'''$''',
                                                                                                true,
                                                                                              ),
                                                                                              'likes',
                                                                                              FFAppState().DataInicioMes!,
                                                                                              FFAppState().DataFinalMes!)!
                                                                                          .toDouble(),
                                                                                      functions
                                                                                          .somadisplay(
                                                                                              getJsonField(
                                                                                                containerDadosMensaisResponse.jsonBody,
                                                                                                r'''$''',
                                                                                                true,
                                                                                              ),
                                                                                              'likes',
                                                                                              FFAppState().DataInicioMesAnterior!,
                                                                                              FFAppState().DataFinalMesAnterior!)!
                                                                                          .toDouble()),
                                                                                  '+10%',
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: functions.verificarpos(valueOrDefault<String>(
                                                                                        functions.varpercentual(
                                                                                            functions
                                                                                                .somadisplay(
                                                                                                    getJsonField(
                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                      r'''$''',
                                                                                                      true,
                                                                                                    ),
                                                                                                    'likes',
                                                                                                    FFAppState().DataInicioMes!,
                                                                                                    FFAppState().DataFinalMes!)!
                                                                                                .toDouble(),
                                                                                            functions
                                                                                                .somadisplay(
                                                                                                    getJsonField(
                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                      r'''$''',
                                                                                                      true,
                                                                                                    ),
                                                                                                    'likes',
                                                                                                    FFAppState().DataInicioMesAnterior!,
                                                                                                    FFAppState().DataFinalMesAnterior!)!
                                                                                                .toDouble()),
                                                                                        '+10%',
                                                                                      ))!
                                                                                          ? FlutterFlowTheme.of(context).primary
                                                                                          : FlutterFlowTheme.of(context).error,
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 4.0)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'b87y1tv2' /* Likes */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            formatNumber(
                                                                              functions.somadisplay(
                                                                                  getJsonField(
                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                    r'''$''',
                                                                                    true,
                                                                                  ),
                                                                                  'comments',
                                                                                  FFAppState().DataInicioMes!,
                                                                                  FFAppState().DataFinalMes!),
                                                                              formatType: FormatType.compact,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                  font: GoogleFonts.oswald(
                                                                                    fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  fontSize: 22.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                [
                                                                              if (functions.verificarpos(valueOrDefault<String>(
                                                                                    functions.varpercentual(
                                                                                        functions
                                                                                            .somadisplay(
                                                                                                getJsonField(
                                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'comments',
                                                                                                FFAppState().DataInicioMes!,
                                                                                                FFAppState().DataFinalMes!)!
                                                                                            .toDouble(),
                                                                                        functions
                                                                                            .somadisplay(
                                                                                                getJsonField(
                                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'comments',
                                                                                                FFAppState().DataInicioMesAnterior!,
                                                                                                FFAppState().DataFinalMesAnterior!)!
                                                                                            .toDouble()),
                                                                                    '+10%',
                                                                                  )) ??
                                                                                  true)
                                                                                Icon(
                                                                                  Icons.trending_up,
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  size: 15.0,
                                                                                ),
                                                                              if (!functions.verificarpos(valueOrDefault<String>(
                                                                                functions.varpercentual(
                                                                                    functions
                                                                                        .somadisplay(
                                                                                            getJsonField(
                                                                                              containerDadosMensaisResponse.jsonBody,
                                                                                              r'''$''',
                                                                                              true,
                                                                                            ),
                                                                                            'comments',
                                                                                            FFAppState().DataInicioMes!,
                                                                                            FFAppState().DataFinalMes!)!
                                                                                        .toDouble(),
                                                                                    functions
                                                                                        .somadisplay(
                                                                                            getJsonField(
                                                                                              containerDadosMensaisResponse.jsonBody,
                                                                                              r'''$''',
                                                                                              true,
                                                                                            ),
                                                                                            'comments',
                                                                                            FFAppState().DataInicioMesAnterior!,
                                                                                            FFAppState().DataFinalMesAnterior!)!
                                                                                        .toDouble()),
                                                                                '+10%',
                                                                              ))!)
                                                                                Icon(
                                                                                  Icons.trending_down,
                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                  size: 15.0,
                                                                                ),
                                                                              Text(
                                                                                valueOrDefault<String>(
                                                                                  functions.varpercentual(
                                                                                      functions
                                                                                          .somadisplay(
                                                                                              getJsonField(
                                                                                                containerDadosMensaisResponse.jsonBody,
                                                                                                r'''$''',
                                                                                                true,
                                                                                              ),
                                                                                              'comments',
                                                                                              FFAppState().DataInicioMes!,
                                                                                              FFAppState().DataFinalMes!)!
                                                                                          .toDouble(),
                                                                                      functions
                                                                                          .somadisplay(
                                                                                              getJsonField(
                                                                                                containerDadosMensaisResponse.jsonBody,
                                                                                                r'''$''',
                                                                                                true,
                                                                                              ),
                                                                                              'comments',
                                                                                              FFAppState().DataInicioMesAnterior!,
                                                                                              FFAppState().DataFinalMesAnterior!)!
                                                                                          .toDouble()),
                                                                                  '+10%',
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: functions.verificarpos(valueOrDefault<String>(
                                                                                        functions.varpercentual(
                                                                                            functions
                                                                                                .somadisplay(
                                                                                                    getJsonField(
                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                      r'''$''',
                                                                                                      true,
                                                                                                    ),
                                                                                                    'comments',
                                                                                                    FFAppState().DataInicioMes!,
                                                                                                    FFAppState().DataFinalMes!)!
                                                                                                .toDouble(),
                                                                                            functions
                                                                                                .somadisplay(
                                                                                                    getJsonField(
                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                      r'''$''',
                                                                                                      true,
                                                                                                    ),
                                                                                                    'comments',
                                                                                                    FFAppState().DataInicioMesAnterior!,
                                                                                                    FFAppState().DataFinalMesAnterior!)!
                                                                                                .toDouble()),
                                                                                        '+10%',
                                                                                      ))!
                                                                                          ? FlutterFlowTheme.of(context).primary
                                                                                          : FlutterFlowTheme.of(context).error,
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 4.0)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'xh8owi3g' /* Comentários */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            formatNumber(
                                                                              functions.somadisplay(
                                                                                  getJsonField(
                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                    r'''$''',
                                                                                    true,
                                                                                  ),
                                                                                  'shares',
                                                                                  FFAppState().DataInicioMes!,
                                                                                  FFAppState().DataFinalMes!),
                                                                              formatType: FormatType.compact,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                  font: GoogleFonts.oswald(
                                                                                    fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  fontSize: 22.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                [
                                                                              if (functions.verificarpos(valueOrDefault<String>(
                                                                                    functions.varpercentual(
                                                                                        functions
                                                                                            .somadisplay(
                                                                                                getJsonField(
                                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'shares',
                                                                                                FFAppState().DataInicioMes!,
                                                                                                FFAppState().DataFinalMes!)!
                                                                                            .toDouble(),
                                                                                        functions
                                                                                            .somadisplay(
                                                                                                getJsonField(
                                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'shares',
                                                                                                FFAppState().DataInicioMesAnterior!,
                                                                                                FFAppState().DataFinalMesAnterior!)!
                                                                                            .toDouble()),
                                                                                    '+10%',
                                                                                  )) ??
                                                                                  true)
                                                                                Icon(
                                                                                  Icons.trending_up,
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  size: 15.0,
                                                                                ),
                                                                              if (!functions.verificarpos(valueOrDefault<String>(
                                                                                functions.varpercentual(
                                                                                    functions
                                                                                        .somadisplay(
                                                                                            getJsonField(
                                                                                              containerDadosMensaisResponse.jsonBody,
                                                                                              r'''$''',
                                                                                              true,
                                                                                            ),
                                                                                            'shares',
                                                                                            FFAppState().DataInicioMes!,
                                                                                            FFAppState().DataFinalMes!)!
                                                                                        .toDouble(),
                                                                                    functions
                                                                                        .somadisplay(
                                                                                            getJsonField(
                                                                                              containerDadosMensaisResponse.jsonBody,
                                                                                              r'''$''',
                                                                                              true,
                                                                                            ),
                                                                                            'shares',
                                                                                            FFAppState().DataInicioMesAnterior!,
                                                                                            FFAppState().DataFinalMesAnterior!)!
                                                                                        .toDouble()),
                                                                                '+10%',
                                                                              ))!)
                                                                                Icon(
                                                                                  Icons.trending_down,
                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                  size: 15.0,
                                                                                ),
                                                                              Text(
                                                                                valueOrDefault<String>(
                                                                                  functions.varpercentual(
                                                                                      functions
                                                                                          .somadisplay(
                                                                                              getJsonField(
                                                                                                containerDadosMensaisResponse.jsonBody,
                                                                                                r'''$''',
                                                                                                true,
                                                                                              ),
                                                                                              'shares',
                                                                                              FFAppState().DataInicioMes!,
                                                                                              FFAppState().DataFinalMes!)!
                                                                                          .toDouble(),
                                                                                      functions
                                                                                          .somadisplay(
                                                                                              getJsonField(
                                                                                                containerDadosMensaisResponse.jsonBody,
                                                                                                r'''$''',
                                                                                                true,
                                                                                              ),
                                                                                              'shares',
                                                                                              FFAppState().DataInicioMesAnterior!,
                                                                                              FFAppState().DataFinalMesAnterior!)!
                                                                                          .toDouble()),
                                                                                  '+10%',
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: functions.verificarpos(valueOrDefault<String>(
                                                                                        functions.varpercentual(
                                                                                            functions
                                                                                                .somadisplay(
                                                                                                    getJsonField(
                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                      r'''$''',
                                                                                                      true,
                                                                                                    ),
                                                                                                    'shares',
                                                                                                    FFAppState().DataInicioMes!,
                                                                                                    FFAppState().DataFinalMes!)!
                                                                                                .toDouble(),
                                                                                            functions
                                                                                                .somadisplay(
                                                                                                    getJsonField(
                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                      r'''$''',
                                                                                                      true,
                                                                                                    ),
                                                                                                    'shares',
                                                                                                    FFAppState().DataInicioMesAnterior!,
                                                                                                    FFAppState().DataFinalMesAnterior!)!
                                                                                                .toDouble()),
                                                                                        '+10%',
                                                                                      ))!
                                                                                          ? FlutterFlowTheme.of(context).primary
                                                                                          : FlutterFlowTheme.of(context).error,
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 4.0)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '6bl959xi' /* Compartilhamentos */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            formatNumber(
                                                                              functions.somadisplay(
                                                                                  getJsonField(
                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                    r'''$''',
                                                                                    true,
                                                                                  ),
                                                                                  'total_interactions',
                                                                                  FFAppState().DataInicioMes!,
                                                                                  FFAppState().DataFinalMes!),
                                                                              formatType: FormatType.compact,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                  font: GoogleFonts.oswald(
                                                                                    fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  fontSize: 22.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                [
                                                                              if (functions.verificarpos(valueOrDefault<String>(
                                                                                    functions.varpercentual(
                                                                                        functions
                                                                                            .somadisplay(
                                                                                                getJsonField(
                                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'total_interactions',
                                                                                                FFAppState().DataInicioMes!,
                                                                                                FFAppState().DataFinalMes!)!
                                                                                            .toDouble(),
                                                                                        functions
                                                                                            .somadisplay(
                                                                                                getJsonField(
                                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'total_interactions',
                                                                                                FFAppState().DataInicioMesAnterior!,
                                                                                                FFAppState().DataFinalMesAnterior!)!
                                                                                            .toDouble()),
                                                                                    '+10%',
                                                                                  )) ??
                                                                                  true)
                                                                                Icon(
                                                                                  Icons.trending_up,
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  size: 15.0,
                                                                                ),
                                                                              if (!functions.verificarpos(valueOrDefault<String>(
                                                                                functions.varpercentual(
                                                                                    functions
                                                                                        .somadisplay(
                                                                                            getJsonField(
                                                                                              containerDadosMensaisResponse.jsonBody,
                                                                                              r'''$''',
                                                                                              true,
                                                                                            ),
                                                                                            'total_interactions',
                                                                                            FFAppState().DataInicioMes!,
                                                                                            FFAppState().DataFinalMes!)!
                                                                                        .toDouble(),
                                                                                    functions
                                                                                        .somadisplay(
                                                                                            getJsonField(
                                                                                              containerDadosMensaisResponse.jsonBody,
                                                                                              r'''$''',
                                                                                              true,
                                                                                            ),
                                                                                            'total_interactions',
                                                                                            FFAppState().DataInicioMesAnterior!,
                                                                                            FFAppState().DataFinalMesAnterior!)!
                                                                                        .toDouble()),
                                                                                '+10%',
                                                                              ))!)
                                                                                Icon(
                                                                                  Icons.trending_down,
                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                  size: 15.0,
                                                                                ),
                                                                              Text(
                                                                                valueOrDefault<String>(
                                                                                  functions.varpercentual(
                                                                                      functions
                                                                                          .somadisplay(
                                                                                              getJsonField(
                                                                                                containerDadosMensaisResponse.jsonBody,
                                                                                                r'''$''',
                                                                                                true,
                                                                                              ),
                                                                                              'total_interactions',
                                                                                              FFAppState().DataInicioMes!,
                                                                                              FFAppState().DataFinalMes!)!
                                                                                          .toDouble(),
                                                                                      functions
                                                                                          .somadisplay(
                                                                                              getJsonField(
                                                                                                containerDadosMensaisResponse.jsonBody,
                                                                                                r'''$''',
                                                                                                true,
                                                                                              ),
                                                                                              'total_interactions',
                                                                                              FFAppState().DataInicioMesAnterior!,
                                                                                              FFAppState().DataFinalMesAnterior!)!
                                                                                          .toDouble()),
                                                                                  '+10%',
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: functions.verificarpos(valueOrDefault<String>(
                                                                                        functions.varpercentual(
                                                                                            functions
                                                                                                .somadisplay(
                                                                                                    getJsonField(
                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                      r'''$''',
                                                                                                      true,
                                                                                                    ),
                                                                                                    'total_interactions',
                                                                                                    FFAppState().DataInicioMes!,
                                                                                                    FFAppState().DataFinalMes!)!
                                                                                                .toDouble(),
                                                                                            functions
                                                                                                .somadisplay(
                                                                                                    getJsonField(
                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                      r'''$''',
                                                                                                      true,
                                                                                                    ),
                                                                                                    'total_interactions',
                                                                                                    FFAppState().DataInicioMesAnterior!,
                                                                                                    FFAppState().DataFinalMesAnterior!)!
                                                                                                .toDouble()),
                                                                                        '+10%',
                                                                                      ))!
                                                                                          ? FlutterFlowTheme.of(context).primary
                                                                                          : FlutterFlowTheme.of(context).error,
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 4.0)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'xs68hhnu' /* Engajamento */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            formatNumber(
                                                                              functions.somadisplay(
                                                                                  getJsonField(
                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                    r'''$''',
                                                                                    true,
                                                                                  ),
                                                                                  'accounts_engaged',
                                                                                  FFAppState().DataInicioMes!,
                                                                                  FFAppState().DataFinalMes!),
                                                                              formatType: FormatType.compact,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                  font: GoogleFonts.oswald(
                                                                                    fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  fontSize: 22.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                [
                                                                              if (functions.verificarpos(valueOrDefault<String>(
                                                                                    functions.varpercentual(
                                                                                        functions
                                                                                            .somadisplay(
                                                                                                getJsonField(
                                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'accounts_engaged',
                                                                                                FFAppState().DataInicioMes!,
                                                                                                FFAppState().DataFinalMes!)!
                                                                                            .toDouble(),
                                                                                        functions
                                                                                            .somadisplay(
                                                                                                getJsonField(
                                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'accounts_engaged',
                                                                                                FFAppState().DataInicioMesAnterior!,
                                                                                                FFAppState().DataFinalMesAnterior!)!
                                                                                            .toDouble()),
                                                                                    '+10%',
                                                                                  )) ??
                                                                                  true)
                                                                                Icon(
                                                                                  Icons.trending_up,
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  size: 15.0,
                                                                                ),
                                                                              if (!functions.verificarpos(valueOrDefault<String>(
                                                                                functions.varpercentual(
                                                                                    functions
                                                                                        .somadisplay(
                                                                                            getJsonField(
                                                                                              containerDadosMensaisResponse.jsonBody,
                                                                                              r'''$''',
                                                                                              true,
                                                                                            ),
                                                                                            'accounts_engaged',
                                                                                            FFAppState().DataInicioMes!,
                                                                                            FFAppState().DataFinalMes!)!
                                                                                        .toDouble(),
                                                                                    functions
                                                                                        .somadisplay(
                                                                                            getJsonField(
                                                                                              containerDadosMensaisResponse.jsonBody,
                                                                                              r'''$''',
                                                                                              true,
                                                                                            ),
                                                                                            'accounts_engaged',
                                                                                            FFAppState().DataInicioMesAnterior!,
                                                                                            FFAppState().DataFinalMesAnterior!)!
                                                                                        .toDouble()),
                                                                                '+10%',
                                                                              ))!)
                                                                                Icon(
                                                                                  Icons.trending_down,
                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                  size: 15.0,
                                                                                ),
                                                                              Text(
                                                                                valueOrDefault<String>(
                                                                                  functions.varpercentual(
                                                                                      functions
                                                                                          .somadisplay(
                                                                                              getJsonField(
                                                                                                containerDadosMensaisResponse.jsonBody,
                                                                                                r'''$''',
                                                                                                true,
                                                                                              ),
                                                                                              'accounts_engaged',
                                                                                              FFAppState().DataInicioMes!,
                                                                                              FFAppState().DataFinalMes!)!
                                                                                          .toDouble(),
                                                                                      functions
                                                                                          .somadisplay(
                                                                                              getJsonField(
                                                                                                containerDadosMensaisResponse.jsonBody,
                                                                                                r'''$''',
                                                                                                true,
                                                                                              ),
                                                                                              'accounts_engaged',
                                                                                              FFAppState().DataInicioMesAnterior!,
                                                                                              FFAppState().DataFinalMesAnterior!)!
                                                                                          .toDouble()),
                                                                                  '+10%',
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: functions.verificarpos(valueOrDefault<String>(
                                                                                        functions.varpercentual(
                                                                                            functions
                                                                                                .somadisplay(
                                                                                                    getJsonField(
                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                      r'''$''',
                                                                                                      true,
                                                                                                    ),
                                                                                                    'accounts_engaged',
                                                                                                    FFAppState().DataInicioMes!,
                                                                                                    FFAppState().DataFinalMes!)!
                                                                                                .toDouble(),
                                                                                            functions
                                                                                                .somadisplay(
                                                                                                    getJsonField(
                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                      r'''$''',
                                                                                                      true,
                                                                                                    ),
                                                                                                    'accounts_engaged',
                                                                                                    FFAppState().DataInicioMesAnterior!,
                                                                                                    FFAppState().DataFinalMesAnterior!)!
                                                                                                .toDouble()),
                                                                                        '+10%',
                                                                                      ))!
                                                                                          ? FlutterFlowTheme.of(context).primary
                                                                                          : FlutterFlowTheme.of(context).error,
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 4.0)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'txwqe1la' /* Contas Engajadas */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            formatNumber(
                                                                              functions.somadisplay(
                                                                                  getJsonField(
                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                    r'''$''',
                                                                                    true,
                                                                                  ),
                                                                                  'views',
                                                                                  FFAppState().DataInicioMes!,
                                                                                  FFAppState().DataFinalMes!),
                                                                              formatType: FormatType.compact,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                  font: GoogleFonts.oswald(
                                                                                    fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  fontSize: 22.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                [
                                                                              if (functions.verificarpos(valueOrDefault<String>(
                                                                                    functions.varpercentual(
                                                                                        functions
                                                                                            .somadisplay(
                                                                                                getJsonField(
                                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'views',
                                                                                                FFAppState().DataInicioMes!,
                                                                                                FFAppState().DataFinalMes!)!
                                                                                            .toDouble(),
                                                                                        functions
                                                                                            .somadisplay(
                                                                                                getJsonField(
                                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'views',
                                                                                                FFAppState().DataInicioMesAnterior!,
                                                                                                FFAppState().DataFinalMesAnterior!)!
                                                                                            .toDouble()),
                                                                                    '+10%',
                                                                                  )) ??
                                                                                  true)
                                                                                Icon(
                                                                                  Icons.trending_up,
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  size: 15.0,
                                                                                ),
                                                                              if (!functions.verificarpos(valueOrDefault<String>(
                                                                                functions.varpercentual(
                                                                                    functions
                                                                                        .somadisplay(
                                                                                            getJsonField(
                                                                                              containerDadosMensaisResponse.jsonBody,
                                                                                              r'''$''',
                                                                                              true,
                                                                                            ),
                                                                                            'views',
                                                                                            FFAppState().DataInicioMes!,
                                                                                            FFAppState().DataFinalMes!)!
                                                                                        .toDouble(),
                                                                                    functions
                                                                                        .somadisplay(
                                                                                            getJsonField(
                                                                                              containerDadosMensaisResponse.jsonBody,
                                                                                              r'''$''',
                                                                                              true,
                                                                                            ),
                                                                                            'views',
                                                                                            FFAppState().DataInicioMesAnterior!,
                                                                                            FFAppState().DataFinalMesAnterior!)!
                                                                                        .toDouble()),
                                                                                '+10%',
                                                                              ))!)
                                                                                Icon(
                                                                                  Icons.trending_down,
                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                  size: 15.0,
                                                                                ),
                                                                              Text(
                                                                                valueOrDefault<String>(
                                                                                  functions.varpercentual(
                                                                                      functions
                                                                                          .somadisplay(
                                                                                              getJsonField(
                                                                                                containerDadosMensaisResponse.jsonBody,
                                                                                                r'''$''',
                                                                                                true,
                                                                                              ),
                                                                                              'views',
                                                                                              FFAppState().DataInicioMes!,
                                                                                              FFAppState().DataFinalMes!)!
                                                                                          .toDouble(),
                                                                                      functions
                                                                                          .somadisplay(
                                                                                              getJsonField(
                                                                                                containerDadosMensaisResponse.jsonBody,
                                                                                                r'''$''',
                                                                                                true,
                                                                                              ),
                                                                                              'views',
                                                                                              FFAppState().DataInicioMesAnterior!,
                                                                                              FFAppState().DataFinalMesAnterior!)!
                                                                                          .toDouble()),
                                                                                  '+10%',
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: functions.verificarpos(valueOrDefault<String>(
                                                                                        functions.varpercentual(
                                                                                            functions
                                                                                                .somadisplay(
                                                                                                    getJsonField(
                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                      r'''$''',
                                                                                                      true,
                                                                                                    ),
                                                                                                    'views',
                                                                                                    FFAppState().DataInicioMes!,
                                                                                                    FFAppState().DataFinalMes!)!
                                                                                                .toDouble(),
                                                                                            functions
                                                                                                .somadisplay(
                                                                                                    getJsonField(
                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                      r'''$''',
                                                                                                      true,
                                                                                                    ),
                                                                                                    'views',
                                                                                                    FFAppState().DataInicioMesAnterior!,
                                                                                                    FFAppState().DataFinalMesAnterior!)!
                                                                                                .toDouble()),
                                                                                        '+10%',
                                                                                      ))!
                                                                                          ? FlutterFlowTheme.of(context).primary
                                                                                          : FlutterFlowTheme.of(context).error,
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 4.0)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'qpqsh7zs' /* Visualizações */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      if (formatNumber(
                                                                            functions.somadisplay(
                                                                                getJsonField(
                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                  r'''$''',
                                                                                  true,
                                                                                ),
                                                                                'reach',
                                                                                FFAppState().DataInicioMes!,
                                                                                FFAppState().DataFinalMes!),
                                                                            formatType:
                                                                                FormatType.compact,
                                                                          ) ==
                                                                          '0')
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'c7h4tw8i' /* Indisponível */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .displaySmall
                                                                              .override(
                                                                                font: GoogleFonts.oswald(
                                                                                  fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                fontSize: 22.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                              ),
                                                                        ),
                                                                      if (formatNumber(
                                                                            functions.somadisplay(
                                                                                getJsonField(
                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                  r'''$''',
                                                                                  true,
                                                                                ),
                                                                                'reach',
                                                                                FFAppState().DataInicioMes!,
                                                                                FFAppState().DataFinalMes!),
                                                                            formatType:
                                                                                FormatType.compact,
                                                                          ) !=
                                                                          '0')
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              formatNumber(
                                                                                functions.somadisplay(
                                                                                    getJsonField(
                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                      r'''$''',
                                                                                      true,
                                                                                    ),
                                                                                    'reach',
                                                                                    FFAppState().DataInicioMes!,
                                                                                    FFAppState().DataFinalMes!),
                                                                                formatType: FormatType.compact,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                    font: GoogleFonts.oswald(
                                                                                      fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    fontSize: 22.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                if (functions.verificarpos(valueOrDefault<String>(
                                                                                      functions.varpercentual(
                                                                                          functions
                                                                                              .somadisplay(
                                                                                                  getJsonField(
                                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                                    r'''$''',
                                                                                                    true,
                                                                                                  ),
                                                                                                  'reach',
                                                                                                  FFAppState().DataInicioMes!,
                                                                                                  FFAppState().DataFinalMes!)!
                                                                                              .toDouble(),
                                                                                          functions
                                                                                              .somadisplay(
                                                                                                  getJsonField(
                                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                                    r'''$''',
                                                                                                    true,
                                                                                                  ),
                                                                                                  'reach',
                                                                                                  FFAppState().DataInicioMesAnterior!,
                                                                                                  FFAppState().DataFinalMesAnterior!)!
                                                                                              .toDouble()),
                                                                                      '+10%',
                                                                                    )) ??
                                                                                    true)
                                                                                  Icon(
                                                                                    Icons.trending_up,
                                                                                    color: FlutterFlowTheme.of(context).primary,
                                                                                    size: 15.0,
                                                                                  ),
                                                                                if (!functions.verificarpos(valueOrDefault<String>(
                                                                                  functions.varpercentual(
                                                                                      functions
                                                                                          .somadisplay(
                                                                                              getJsonField(
                                                                                                containerDadosMensaisResponse.jsonBody,
                                                                                                r'''$''',
                                                                                                true,
                                                                                              ),
                                                                                              'reach',
                                                                                              FFAppState().DataInicioMes!,
                                                                                              FFAppState().DataFinalMes!)!
                                                                                          .toDouble(),
                                                                                      functions
                                                                                          .somadisplay(
                                                                                              getJsonField(
                                                                                                containerDadosMensaisResponse.jsonBody,
                                                                                                r'''$''',
                                                                                                true,
                                                                                              ),
                                                                                              'reach',
                                                                                              FFAppState().DataInicioMesAnterior!,
                                                                                              FFAppState().DataFinalMesAnterior!)!
                                                                                          .toDouble()),
                                                                                  '+10%',
                                                                                ))!)
                                                                                  Icon(
                                                                                    Icons.trending_down,
                                                                                    color: FlutterFlowTheme.of(context).error,
                                                                                    size: 15.0,
                                                                                  ),
                                                                                Text(
                                                                                  valueOrDefault<String>(
                                                                                    functions.varpercentual(
                                                                                        functions
                                                                                            .somadisplay(
                                                                                                getJsonField(
                                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'reach',
                                                                                                FFAppState().DataInicioMes!,
                                                                                                FFAppState().DataFinalMes!)!
                                                                                            .toDouble(),
                                                                                        functions
                                                                                            .somadisplay(
                                                                                                getJsonField(
                                                                                                  containerDadosMensaisResponse.jsonBody,
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'reach',
                                                                                                FFAppState().DataInicioMesAnterior!,
                                                                                                FFAppState().DataFinalMesAnterior!)!
                                                                                            .toDouble()),
                                                                                    '+10%',
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: functions.verificarpos(valueOrDefault<String>(
                                                                                          functions.varpercentual(
                                                                                              functions
                                                                                                  .somadisplay(
                                                                                                      getJsonField(
                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                        r'''$''',
                                                                                                        true,
                                                                                                      ),
                                                                                                      'reach',
                                                                                                      FFAppState().DataInicioMes!,
                                                                                                      FFAppState().DataFinalMes!)!
                                                                                                  .toDouble(),
                                                                                              functions
                                                                                                  .somadisplay(
                                                                                                      getJsonField(
                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                        r'''$''',
                                                                                                        true,
                                                                                                      ),
                                                                                                      'reach',
                                                                                                      FFAppState().DataInicioMesAnterior!,
                                                                                                      FFAppState().DataFinalMesAnterior!)!
                                                                                                  .toDouble()),
                                                                                          '+10%',
                                                                                        ))!
                                                                                            ? FlutterFlowTheme.of(context).primary
                                                                                            : FlutterFlowTheme.of(context).error,
                                                                                        fontSize: 12.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ].divide(SizedBox(width: 4.0)),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '4rvirwca' /* Alcance */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 10.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        AuthUserStreamWidget(
                                          builder: (context) =>
                                              FutureBuilder<ApiCallResponse>(
                                            future: DadosDiariosCall.call(
                                              filterColumn: 'related_id',
                                              filterValue: _model.idconta,
                                              filterColumn2: 'user_id',
                                              filterValue2:
                                                  valueOrDefault<bool>(
                                                          currentUserDocument
                                                              ?.admin,
                                                          false)
                                                      ? currentUserUid
                                                      : valueOrDefault(
                                                          currentUserDocument
                                                              ?.lenderId,
                                                          ''),
                                            ),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              final containerDadosDiariosResponse =
                                                  snapshot.data!;

                                              return Material(
                                                color: Colors.transparent,
                                                elevation: 2.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20.0,
                                                                20.0,
                                                                20.0,
                                                                20.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child: Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              '6u1a2a0x' /* Resultados diários */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .oswald(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child:
                                                              FlutterFlowDropDown<
                                                                  String>(
                                                            controller: _model
                                                                    .dropDownValueController1 ??=
                                                                FormFieldController<
                                                                    String>(
                                                              _model.dropDownValue1 ??=
                                                                  'follows_and_unfollows',
                                                            ),
                                                            options: List<
                                                                String>.from([
                                                              'follows_and_unfollows',
                                                              'likes',
                                                              'reach',
                                                              'views',
                                                              'comments',
                                                              'shares',
                                                              'total_interactions',
                                                              'accounts_engaged'
                                                            ]),
                                                            optionLabels: [
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'hjnfc22b' /* Seguidores */,
                                                              ),
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'ufhz3s97' /* Likes */,
                                                              ),
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'wc8ep9d5' /* Alcance */,
                                                              ),
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'ojadiy2k' /* Visualizações */,
                                                              ),
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                '77iry4au' /* Comentários */,
                                                              ),
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'y7kaceyx' /* Compartilhamentos */,
                                                              ),
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                '7opc8cc6' /* Engajamento */,
                                                              ),
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                '9urhbi77' /* Contas Engajadas */,
                                                              )
                                                            ],
                                                            onChanged: (val) =>
                                                                safeSetState(() =>
                                                                    _model.dropDownValue1 =
                                                                        val),
                                                            width: 150.0,
                                                            height: 30.0,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                            hintText:
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                              'ma9omddt' /* Select... */,
                                                            ),
                                                            icon: Icon(
                                                              Icons
                                                                  .keyboard_arrow_down_rounded,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              size: 24.0,
                                                            ),
                                                            fillColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            elevation: 2.0,
                                                            borderColor: Colors
                                                                .transparent,
                                                            borderWidth: 0.0,
                                                            borderRadius: 8.0,
                                                            margin:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            hidesUnderline:
                                                                true,
                                                            isOverButton: false,
                                                            isSearchable: false,
                                                            isMultiSelect:
                                                                false,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      10.0),
                                                          child: Container(
                                                            width: 370.0,
                                                            height: 230.0,
                                                            child:
                                                                FlutterFlowLineChart(
                                                              data: [
                                                                FFLineChartData(
                                                                  xData: functions
                                                                      .tabeladadosdiariosX(
                                                                          FFAppState()
                                                                              .DataInicioMesAnterior,
                                                                          FFAppState()
                                                                              .DataFinalMesAnterior,
                                                                          getJsonField(
                                                                            containerDadosDiariosResponse.jsonBody,
                                                                            r'''$''',
                                                                          ))!,
                                                                  yData: functions.tabeladadosdiariosY(
                                                                      FFAppState().DataInicioMesAnterior,
                                                                      FFAppState().DataFinalMesAnterior,
                                                                      getJsonField(
                                                                        containerDadosDiariosResponse
                                                                            .jsonBody,
                                                                        r'''$''',
                                                                        true,
                                                                      ),
                                                                      _model.dropDownValue1)!,
                                                                  settings:
                                                                      LineChartBarData(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .warning,
                                                                    barWidth:
                                                                        2.0,
                                                                    isCurved:
                                                                        true,
                                                                    preventCurveOverShooting:
                                                                        true,
                                                                    dotData: FlDotData(
                                                                        show:
                                                                            false),
                                                                    belowBarData:
                                                                        BarAreaData(
                                                                      show:
                                                                          true,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .customColor1,
                                                                    ),
                                                                  ),
                                                                ),
                                                                FFLineChartData(
                                                                  xData: functions
                                                                      .tabeladadosdiariosX(
                                                                          FFAppState()
                                                                              .DataInicioMes,
                                                                          FFAppState()
                                                                              .DataFinalMes,
                                                                          getJsonField(
                                                                            containerDadosDiariosResponse.jsonBody,
                                                                            r'''$''',
                                                                          ))!,
                                                                  yData: functions.tabeladadosdiariosY(
                                                                      FFAppState().DataInicioMes,
                                                                      FFAppState().DataFinalMes,
                                                                      getJsonField(
                                                                        containerDadosDiariosResponse
                                                                            .jsonBody,
                                                                        r'''$''',
                                                                        true,
                                                                      ),
                                                                      _model.dropDownValue1)!,
                                                                  settings:
                                                                      LineChartBarData(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    barWidth:
                                                                        2.0,
                                                                    isCurved:
                                                                        true,
                                                                    preventCurveOverShooting:
                                                                        true,
                                                                    dotData: FlDotData(
                                                                        show:
                                                                            false),
                                                                    belowBarData:
                                                                        BarAreaData(
                                                                      show:
                                                                          true,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent1,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                              chartStylingInfo:
                                                                  ChartStylingInfo(
                                                                enableTooltip:
                                                                    true,
                                                                tooltipBackgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                showBorder:
                                                                    false,
                                                              ),
                                                              axisBounds:
                                                                  AxisBounds(),
                                                              xAxisLabelInfo:
                                                                  AxisLabelInfo(
                                                                reservedSize:
                                                                    32.0,
                                                              ),
                                                              yAxisLabelInfo:
                                                                  AxisLabelInfo(
                                                                reservedSize:
                                                                    40.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Container(
                                                                  width: 15.0,
                                                                  height: 15.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            2.0),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'ee0i64uw' /* Período atual */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 5.0)),
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Container(
                                                                  width: 15.0,
                                                                  height: 15.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .warning,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            2.0),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'ymfr6xla' /* Período anterior */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 5.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 10.0)),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          elevation: 2.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            child: Visibility(
                                              visible: _model.demografia,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20.0,
                                                                20.0,
                                                                20.0,
                                                                20.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'ro7xivnf' /* Demografia */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .oswald(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                1.0,
                                                            height: 280.0,
                                                            child:
                                                                FlutterFlowPieChart(
                                                              data:
                                                                  FFPieChartData(
                                                                values: functions
                                                                    .porcentagemdemografica(
                                                                        FFAppState()
                                                                            .DataInicioMes,
                                                                        FFAppState()
                                                                            .DataFinalMes,
                                                                        getJsonField(
                                                                          (_model.demografias?.jsonBody ??
                                                                              ''),
                                                                          r'''$''',
                                                                          true,
                                                                        ))!,
                                                                colors:
                                                                    chartPieChartColorsList2,
                                                                radius: [140.0],
                                                                borderWidth: [
                                                                  0.0
                                                                ],
                                                                borderColor: [
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText
                                                                ],
                                                              ),
                                                              donutHoleRadius:
                                                                  0.0,
                                                              donutHoleColor:
                                                                  Colors
                                                                      .transparent,
                                                              sectionLabelType:
                                                                  PieChartSectionLabelType
                                                                      .percent,
                                                              sectionLabelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .oswald(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        fontSize:
                                                                            18.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .fontStyle,
                                                                      ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      5.0,
                                                                      0.0,
                                                                      10.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Container(
                                                                width: 15.0,
                                                                height: 15.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              2.0),
                                                                ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'jrax9kby' /* Homens */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              Container(
                                                                width: 15.0,
                                                                height: 15.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              2.0),
                                                                ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  '07fh2jll' /* Mulheres */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              Container(
                                                                width: 15.0,
                                                                height: 15.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .warning,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              2.0),
                                                                ),
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  '4omudae2' /* Indefinido */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  1.0,
                                                          height: 200.0,
                                                          child:
                                                              FlutterFlowBarChart(
                                                            barData: [
                                                              FFBarChartData(
                                                                yData: functions
                                                                    .distretariahomem(
                                                                        FFAppState()
                                                                            .DataInicioMes,
                                                                        FFAppState()
                                                                            .DataFinalMes,
                                                                        getJsonField(
                                                                          (_model.demografias?.jsonBody ??
                                                                              ''),
                                                                          r'''$''',
                                                                          true,
                                                                        ))!,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                              FFBarChartData(
                                                                yData: functions
                                                                    .distretariamulher(
                                                                        FFAppState()
                                                                            .DataInicioMes,
                                                                        FFAppState()
                                                                            .DataFinalMes,
                                                                        getJsonField(
                                                                          (_model.demografias?.jsonBody ??
                                                                              ''),
                                                                          r'''$''',
                                                                          true,
                                                                        ))!,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                              ),
                                                              FFBarChartData(
                                                                yData: functions
                                                                    .distretariaind(
                                                                        FFAppState()
                                                                            .DataInicioMes,
                                                                        FFAppState()
                                                                            .DataFinalMes,
                                                                        getJsonField(
                                                                          (_model.demografias?.jsonBody ??
                                                                              ''),
                                                                          r'''$''',
                                                                          true,
                                                                        ))!,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .warning,
                                                              )
                                                            ],
                                                            xLabels: FFAppConstants
                                                                .labelsdemografia,
                                                            barWidth: 10.0,
                                                            barBorderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            barSpace: 0.0,
                                                            groupSpace: 0.0,
                                                            alignment:
                                                                BarChartAlignment
                                                                    .spaceBetween,
                                                            chartStylingInfo:
                                                                ChartStylingInfo(
                                                              enableTooltip:
                                                                  true,
                                                              tooltipBackgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                              showBorder: false,
                                                            ),
                                                            axisBounds:
                                                                AxisBounds(),
                                                            xAxisLabelInfo:
                                                                AxisLabelInfo(
                                                              reservedSize:
                                                                  20.0,
                                                            ),
                                                            yAxisLabelInfo:
                                                                AxisLabelInfo(
                                                              reservedSize:
                                                                  42.0,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'bhn5ctu0' /* 13-17 */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                '15r7rgc3' /* 18-24 */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'giaav4v1' /* 25-34 */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'flfcm8ve' /* 35-44 */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'tqs137ls' /* 45-54 */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                '7j91ou9e' /* 55-64 */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'o4fxmhy1' /* 65+ */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 16.0)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 24.0)),
                                    ),
                                  ),
                                ),
                              if ((_model.temconta == false) &&
                                  (_model.loaded == true) &&
                                  valueOrDefault<bool>(
                                      currentUserDocument?.admin, false))
                                Expanded(
                                  child: AuthUserStreamWidget(
                                    builder: (context) => Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              1.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(32.0),
                                          topRight: Radius.circular(32.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            22.0, 24.0, 22.0, 24.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'sb4bqebg' /* Conecte sua conta */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineSmall
                                                  .override(
                                                    font: GoogleFonts.oswald(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineSmall
                                                              .fontStyle,
                                                    ),
                                                    color: Color(0xFF14181C),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineSmall
                                                            .fontStyle,
                                                  ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'edioa26k' /* Para adicionar uma conta do In... */,
                                              ),
                                              textAlign: TextAlign.center,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                      ),
                                            ),
                                            Material(
                                              color: Colors.transparent,
                                              elevation: 4.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(24.0, 24.0,
                                                          24.0, 24.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'urwconmi' /* Ao conectar sua conta do Faceb... */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .data_usage,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                size: 24.0,
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'entdck3h' /* insights da página e posts */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 12.0)),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              FaIcon(
                                                                FontAwesomeIcons
                                                                    .commentDots,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                size: 24.0,
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'j6yt5vfg' /* comentários */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 12.0)),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 16.0)),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 24.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            FFButtonWidget(
                                              onPressed: () async {
                                                _model.authCode = await actions
                                                    .loginWithFacebook();

                                                safeSetState(() {});
                                              },
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                'svcq7e3k' /* Conectar Conta */,
                                              ),
                                              options: FFButtonOptions(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                height: 48.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleMedium
                                                    .override(
                                                      font: GoogleFonts.oswald(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .fontStyle,
                                                      ),
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .fontStyle,
                                                    ),
                                                elevation: 3.0,
                                                borderRadius:
                                                    BorderRadius.circular(28.0),
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 24.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if ((_model.temconta == false) &&
                                  (_model.loaded == true) &&
                                  !valueOrDefault<bool>(
                                      currentUserDocument?.admin, false))
                                Expanded(
                                  child: AuthUserStreamWidget(
                                    builder: (context) => Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(32.0),
                                          topRight: Radius.circular(32.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            22.0, 24.0, 22.0, 24.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'lrbfmbao' /* Aguarde a conexão da sua conta */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineSmall
                                                  .override(
                                                    font: GoogleFonts.oswald(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineSmall
                                                              .fontStyle,
                                                    ),
                                                    color: Color(0xFF14181C),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineSmall
                                                            .fontStyle,
                                                  ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '7ojrt9de' /* Entre em contato com a equipe ... */,
                                              ),
                                              textAlign: TextAlign.center,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                      ),
                                            ),
                                            FFButtonWidget(
                                              onPressed: () async {
                                                await launchURL(
                                                    'https://api.whatsapp.com/send?phone=5511932137807&text=Preciso%20ativar%20meu%20acesso%20no%20BAM%20App.%20O%20email%20cadastrado%20é${currentUserEmail}');
                                              },
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                'wvlrrh1t' /* Contatar Equipe */,
                                              ),
                                              options: FFButtonOptions(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                height: 48.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleMedium
                                                    .override(
                                                      font: GoogleFonts.oswald(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .fontStyle,
                                                      ),
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .fontStyle,
                                                    ),
                                                elevation: 3.0,
                                                borderRadius:
                                                    BorderRadius.circular(28.0),
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 24.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                    ))
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if ((_model.temconta == true) && _model.loaded)
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height: 280.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 24.0, 24.0, 24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FlutterFlowIconButton(
                                          borderRadius: 8.0,
                                          buttonSize: 50.0,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          icon: Icon(
                                            Icons.menu,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 30.0,
                                          ),
                                          onPressed: () async {
                                            scaffoldKey.currentState!
                                                .openDrawer();
                                          },
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Material(
                                              color: Colors.transparent,
                                              elevation: 4.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                              ),
                                              child: Container(
                                                width: 80.0,
                                                height: 80.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.0),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.0),
                                                  child: Image.network(
                                                    _model.contaselecionada
                                                                ?.plataforma ==
                                                            'instagram'
                                                        ? getJsonField(
                                                            (_model.dadosatuaisinsta
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.profile_picture_url''',
                                                          ).toString()
                                                        : getJsonField(
                                                            (_model.dadosatuaisface
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.picture''',
                                                          ).toString(),
                                                    width: 80.0,
                                                    height: 80.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _model.contaselecionada
                                                                ?.plataforma ==
                                                            'instagram'
                                                        ? getJsonField(
                                                            (_model.dadosatuaisinsta
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.username''',
                                                          ).toString()
                                                        : getJsonField(
                                                            (_model.dadosatuaisface
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.name''',
                                                          ).toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .oswald(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 24.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Text(
                                                    _model.contaselecionada
                                                                ?.plataforma ==
                                                            'instagram'
                                                        ? getJsonField(
                                                            (_model.dadosatuaisinsta
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.biography''',
                                                          ).toString()
                                                        : getJsonField(
                                                            (_model.dadosatuaisface
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.about''',
                                                          )
                                                            .toString()
                                                            .maybeHandleOverflow(
                                                              maxChars: 120,
                                                              replacement: '…',
                                                            ),
                                                    maxLines: 3,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLarge
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 16.0)),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  _model.contaselecionada
                                                              ?.plataforma ==
                                                          'instagram'
                                                      ? getJsonField(
                                                          (_model.dadosatuaisinsta
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.followers_count''',
                                                        ).toString()
                                                      : getJsonField(
                                                          (_model.dadosatuaisface
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.fan_count''',
                                                        ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .headlineMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.oswald(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'jue8m26a' /* Seguidores */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  _model.contaselecionada
                                                              ?.plataforma ==
                                                          'instagram'
                                                      ? getJsonField(
                                                          (_model.dadosatuaisinsta
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.media_count''',
                                                        ).toString()
                                                      : getJsonField(
                                                          (_model.dadosatuaisface
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.media_count''',
                                                        ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .headlineMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.oswald(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'lydj5frx' /* Posts */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            if (_model.contaselecionada
                                                    ?.plataforma ==
                                                'instagram')
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    _model.contaselecionada
                                                                ?.plataforma ==
                                                            'instagram'
                                                        ? getJsonField(
                                                            (_model.dadosatuaisinsta
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.follows_count''',
                                                          ).toString()
                                                        : getJsonField(
                                                            (_model.dadosatuaisface
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.follows_count''',
                                                          ).toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .oswald(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'oxxie4i5' /* Seguindo */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                          ].divide(SizedBox(width: 35.0)),
                                        ),
                                      ].divide(SizedBox(height: 15.0)),
                                    ),
                                  ),
                                ),
                              if ((_model.temconta == true) &&
                                  (_model.loaded == true))
                                Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0.0),
                                      bottomRight: Radius.circular(0.0),
                                      topLeft: Radius.circular(32.0),
                                      topRight: Radius.circular(32.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            22.0, 24.0, 22.0, 24.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Material(
                                                      color: Colors.transparent,
                                                      elevation: 2.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.35,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.0),
                                                        ),
                                                        child: Visibility(
                                                          visible: _model
                                                                  .contaselecionada
                                                                  ?.plataforma ==
                                                              'instagram',
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    1.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          20.0),
                                                              child:
                                                                  SingleChildScrollView(
                                                                primary: false,
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          20.0,
                                                                          0.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                'wgi909qd' /* Seleção de período */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                    font: GoogleFonts.oswald(
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                                    fontSize: 26.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children:
                                                                          [
                                                                        FlutterFlowIconButton(
                                                                          borderRadius:
                                                                              8.0,
                                                                          buttonSize:
                                                                              40.0,
                                                                          fillColor:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          disabledColor:
                                                                              Colors.transparent,
                                                                          disabledIconColor:
                                                                              Colors.transparent,
                                                                          icon:
                                                                              Icon(
                                                                            Icons.arrow_back_ios_sharp,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                25.0,
                                                                          ),
                                                                          onPressed: !functions.bolrecuo(
                                                                                  getJsonField(
                                                                                    (_model.dadosmensaisbackend?.jsonBody ?? ''),
                                                                                    r'''$''',
                                                                                    true,
                                                                                  )!,
                                                                                  FFAppState().DataInicioMes!)
                                                                              ? null
                                                                              : () async {
                                                                                  await Future.wait([
                                                                                    Future(() async {
                                                                                      FFAppState().DataInicioMes = functions.reduzirdatainicio(FFAppState().DataInicioMes);
                                                                                      FFAppState().DataInicioMesAnterior = functions.reduzirdatainicio(FFAppState().DataInicioMesAnterior);
                                                                                      safeSetState(() {});
                                                                                    }),
                                                                                    Future(() async {
                                                                                      FFAppState().DataFinalMes = functions.reduzirdatafinal(FFAppState().DataFinalMes);
                                                                                      FFAppState().DataFinalMesAnterior = functions.reduzirdatafinal(FFAppState().DataFinalMesAnterior);
                                                                                      safeSetState(() {});
                                                                                    }),
                                                                                  ]);
                                                                                },
                                                                        ),
                                                                        Text(
                                                                          '${dateTimeFormat(
                                                                            "d/M",
                                                                            FFAppState().DataInicioMes,
                                                                            locale:
                                                                                FFLocalizations.of(context).languageCode,
                                                                          )} - ${dateTimeFormat(
                                                                            "d/M",
                                                                            FFAppState().DataFinalMes,
                                                                            locale:
                                                                                FFLocalizations.of(context).languageCode,
                                                                          )}',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .headlineMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 20.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                        FlutterFlowIconButton(
                                                                          borderRadius:
                                                                              8.0,
                                                                          buttonSize:
                                                                              40.0,
                                                                          fillColor:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          disabledColor:
                                                                              Colors.transparent,
                                                                          disabledIconColor:
                                                                              Colors.transparent,
                                                                          icon:
                                                                              Icon(
                                                                            Icons.arrow_forward_ios_sharp,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                25.0,
                                                                          ),
                                                                          onPressed: !functions.bolavanco(
                                                                                  getJsonField(
                                                                                    (_model.dadosmensaisbackend?.jsonBody ?? ''),
                                                                                    r'''$''',
                                                                                    true,
                                                                                  )!,
                                                                                  FFAppState().DataFinalMes!)!
                                                                              ? null
                                                                              : () async {
                                                                                  await Future.wait([
                                                                                    Future(() async {
                                                                                      FFAppState().DataInicioMes = functions.aumentardatainicio(FFAppState().DataInicioMes);
                                                                                      FFAppState().DataInicioMesAnterior = functions.aumentardatainicio(FFAppState().DataInicioMesAnterior);
                                                                                      safeSetState(() {});
                                                                                    }),
                                                                                    Future(() async {
                                                                                      FFAppState().DataFinalMes = functions.aumentardatafinal(FFAppState().DataFinalMes);
                                                                                      FFAppState().DataFinalMesAnterior = functions.aumentardatafinal(FFAppState().DataFinalMesAnterior);
                                                                                      safeSetState(() {});
                                                                                    }),
                                                                                  ]);
                                                                                },
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              width: 16.0)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      2.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child:
                                                              AuthUserStreamWidget(
                                                            builder: (context) =>
                                                                FutureBuilder<
                                                                    ApiCallResponse>(
                                                              future:
                                                                  DadosMensaisCall
                                                                      .call(
                                                                filterColumn:
                                                                    'related_id',
                                                                filterValue:
                                                                    _model
                                                                        .idconta,
                                                                filterColumn2:
                                                                    'user_id',
                                                                filterValue2: valueOrDefault<
                                                                            bool>(
                                                                        currentUserDocument
                                                                            ?.admin,
                                                                        false)
                                                                    ? currentUserUid
                                                                    : valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.lenderId,
                                                                        ''),
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        valueColor:
                                                                            AlwaysStoppedAnimation<Color>(
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                final containerDadosMensaisResponse =
                                                                    snapshot
                                                                        .data!;

                                                                return Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  elevation:
                                                                      2.0,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16.0),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.35,
                                                                    height:
                                                                        450.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          20.0,
                                                                          20.0,
                                                                          20.0,
                                                                          20.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                20.0),
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                '8vtv88qv' /* Dados descritivos */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                    font: GoogleFonts.oswald(
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                                    fontSize: 26.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.end,
                                                                            children:
                                                                                [
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        flex: 1,
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Text(
                                                                                                  formatNumber(
                                                                                                    functions.somadisplay(
                                                                                                        getJsonField(
                                                                                                          containerDadosMensaisResponse.jsonBody,
                                                                                                          r'''$''',
                                                                                                          true,
                                                                                                        ),
                                                                                                        'follows_and_unfollows',
                                                                                                        FFAppState().DataInicioMes!,
                                                                                                        FFAppState().DataFinalMes!),
                                                                                                    formatType: FormatType.compact,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                                        font: GoogleFonts.oswald(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        fontSize: 26.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                                Row(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  children: [
                                                                                                    if (functions.verificarpos(valueOrDefault<String>(
                                                                                                          functions.varpercentual(
                                                                                                              functions
                                                                                                                  .somadisplay(
                                                                                                                      getJsonField(
                                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                                        r'''$''',
                                                                                                                        true,
                                                                                                                      ),
                                                                                                                      'follows_and_unfollows',
                                                                                                                      FFAppState().DataInicioMes!,
                                                                                                                      FFAppState().DataFinalMes!)!
                                                                                                                  .toDouble(),
                                                                                                              functions
                                                                                                                  .somadisplay(
                                                                                                                      getJsonField(
                                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                                        r'''$''',
                                                                                                                        true,
                                                                                                                      ),
                                                                                                                      'follows_and_unfollows',
                                                                                                                      FFAppState().DataInicioMesAnterior!,
                                                                                                                      FFAppState().DataFinalMesAnterior!)!
                                                                                                                  .toDouble()),
                                                                                                          '+10%',
                                                                                                        )) ??
                                                                                                        true)
                                                                                                      Icon(
                                                                                                        Icons.trending_up,
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        size: 19.0,
                                                                                                      ),
                                                                                                    if (!functions.verificarpos(valueOrDefault<String>(
                                                                                                      functions.varpercentual(
                                                                                                          functions
                                                                                                              .somadisplay(
                                                                                                                  getJsonField(
                                                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                                                    r'''$''',
                                                                                                                    true,
                                                                                                                  ),
                                                                                                                  'follows_and_unfollows',
                                                                                                                  FFAppState().DataInicioMes!,
                                                                                                                  FFAppState().DataFinalMes!)!
                                                                                                              .toDouble(),
                                                                                                          functions
                                                                                                              .somadisplay(
                                                                                                                  getJsonField(
                                                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                                                    r'''$''',
                                                                                                                    true,
                                                                                                                  ),
                                                                                                                  'follows_and_unfollows',
                                                                                                                  FFAppState().DataInicioMesAnterior!,
                                                                                                                  FFAppState().DataFinalMesAnterior!)!
                                                                                                              .toDouble()),
                                                                                                      '+10%',
                                                                                                    ))!)
                                                                                                      Icon(
                                                                                                        Icons.trending_down,
                                                                                                        color: FlutterFlowTheme.of(context).error,
                                                                                                        size: 19.0,
                                                                                                      ),
                                                                                                    Text(
                                                                                                      valueOrDefault<String>(
                                                                                                        functions.varpercentual(
                                                                                                            functions
                                                                                                                .somadisplay(
                                                                                                                    getJsonField(
                                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                                      r'''$''',
                                                                                                                      true,
                                                                                                                    ),
                                                                                                                    'follows_and_unfollows',
                                                                                                                    FFAppState().DataInicioMes!,
                                                                                                                    FFAppState().DataFinalMes!)!
                                                                                                                .toDouble(),
                                                                                                            functions
                                                                                                                .somadisplay(
                                                                                                                    getJsonField(
                                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                                      r'''$''',
                                                                                                                      true,
                                                                                                                    ),
                                                                                                                    'follows_and_unfollows',
                                                                                                                    FFAppState().DataInicioMesAnterior!,
                                                                                                                    FFAppState().DataFinalMesAnterior!)!
                                                                                                                .toDouble()),
                                                                                                        '+10%',
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.inter(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: functions.verificarpos(valueOrDefault<String>(
                                                                                                              functions.varpercentual(
                                                                                                                  functions
                                                                                                                      .somadisplay(
                                                                                                                          getJsonField(
                                                                                                                            containerDadosMensaisResponse.jsonBody,
                                                                                                                            r'''$''',
                                                                                                                            true,
                                                                                                                          ),
                                                                                                                          'follows_and_unfollows',
                                                                                                                          FFAppState().DataInicioMes!,
                                                                                                                          FFAppState().DataFinalMes!)!
                                                                                                                      .toDouble(),
                                                                                                                  functions
                                                                                                                      .somadisplay(
                                                                                                                          getJsonField(
                                                                                                                            containerDadosMensaisResponse.jsonBody,
                                                                                                                            r'''$''',
                                                                                                                            true,
                                                                                                                          ),
                                                                                                                          'follows_and_unfollows',
                                                                                                                          FFAppState().DataInicioMesAnterior!,
                                                                                                                          FFAppState().DataFinalMesAnterior!)!
                                                                                                                      .toDouble()),
                                                                                                              '+10%',
                                                                                                            ))!
                                                                                                                ? FlutterFlowTheme.of(context).primary
                                                                                                                : FlutterFlowTheme.of(context).error,
                                                                                                            fontSize: 16.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ].divide(SizedBox(width: 4.0)),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                '5fu8uzsq' /* Seguidores */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    fontSize: 19.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        flex: 1,
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Text(
                                                                                                  formatNumber(
                                                                                                    functions.somadisplay(
                                                                                                        getJsonField(
                                                                                                          containerDadosMensaisResponse.jsonBody,
                                                                                                          r'''$''',
                                                                                                          true,
                                                                                                        ),
                                                                                                        'comments',
                                                                                                        FFAppState().DataInicioMes!,
                                                                                                        FFAppState().DataFinalMes!),
                                                                                                    formatType: FormatType.compact,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                                        font: GoogleFonts.oswald(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        fontSize: 26.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                                Row(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  children: [
                                                                                                    if (functions.verificarpos(valueOrDefault<String>(
                                                                                                          functions.varpercentual(
                                                                                                              functions
                                                                                                                  .somadisplay(
                                                                                                                      getJsonField(
                                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                                        r'''$''',
                                                                                                                        true,
                                                                                                                      ),
                                                                                                                      'comments',
                                                                                                                      FFAppState().DataInicioMes!,
                                                                                                                      FFAppState().DataFinalMes!)!
                                                                                                                  .toDouble(),
                                                                                                              functions
                                                                                                                  .somadisplay(
                                                                                                                      getJsonField(
                                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                                        r'''$''',
                                                                                                                        true,
                                                                                                                      ),
                                                                                                                      'comments',
                                                                                                                      FFAppState().DataInicioMesAnterior!,
                                                                                                                      FFAppState().DataFinalMesAnterior!)!
                                                                                                                  .toDouble()),
                                                                                                          '+10%',
                                                                                                        )) ??
                                                                                                        true)
                                                                                                      Icon(
                                                                                                        Icons.trending_up,
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        size: 19.0,
                                                                                                      ),
                                                                                                    if (!functions.verificarpos(valueOrDefault<String>(
                                                                                                      functions.varpercentual(
                                                                                                          functions
                                                                                                              .somadisplay(
                                                                                                                  getJsonField(
                                                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                                                    r'''$''',
                                                                                                                    true,
                                                                                                                  ),
                                                                                                                  'comments',
                                                                                                                  FFAppState().DataInicioMes!,
                                                                                                                  FFAppState().DataFinalMes!)!
                                                                                                              .toDouble(),
                                                                                                          functions
                                                                                                              .somadisplay(
                                                                                                                  getJsonField(
                                                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                                                    r'''$''',
                                                                                                                    true,
                                                                                                                  ),
                                                                                                                  'comments',
                                                                                                                  FFAppState().DataInicioMesAnterior!,
                                                                                                                  FFAppState().DataFinalMesAnterior!)!
                                                                                                              .toDouble()),
                                                                                                      '+10%',
                                                                                                    ))!)
                                                                                                      Icon(
                                                                                                        Icons.trending_down,
                                                                                                        color: FlutterFlowTheme.of(context).error,
                                                                                                        size: 19.0,
                                                                                                      ),
                                                                                                    Text(
                                                                                                      valueOrDefault<String>(
                                                                                                        functions.varpercentual(
                                                                                                            functions
                                                                                                                .somadisplay(
                                                                                                                    getJsonField(
                                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                                      r'''$''',
                                                                                                                      true,
                                                                                                                    ),
                                                                                                                    'comments',
                                                                                                                    FFAppState().DataInicioMes!,
                                                                                                                    FFAppState().DataFinalMes!)!
                                                                                                                .toDouble(),
                                                                                                            functions
                                                                                                                .somadisplay(
                                                                                                                    getJsonField(
                                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                                      r'''$''',
                                                                                                                      true,
                                                                                                                    ),
                                                                                                                    'comments',
                                                                                                                    FFAppState().DataInicioMesAnterior!,
                                                                                                                    FFAppState().DataFinalMesAnterior!)!
                                                                                                                .toDouble()),
                                                                                                        '+10%',
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.inter(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: functions.verificarpos(valueOrDefault<String>(
                                                                                                              functions.varpercentual(
                                                                                                                  functions
                                                                                                                      .somadisplay(
                                                                                                                          getJsonField(
                                                                                                                            containerDadosMensaisResponse.jsonBody,
                                                                                                                            r'''$''',
                                                                                                                            true,
                                                                                                                          ),
                                                                                                                          'comments',
                                                                                                                          FFAppState().DataInicioMes!,
                                                                                                                          FFAppState().DataFinalMes!)!
                                                                                                                      .toDouble(),
                                                                                                                  functions
                                                                                                                      .somadisplay(
                                                                                                                          getJsonField(
                                                                                                                            containerDadosMensaisResponse.jsonBody,
                                                                                                                            r'''$''',
                                                                                                                            true,
                                                                                                                          ),
                                                                                                                          'comments',
                                                                                                                          FFAppState().DataInicioMesAnterior!,
                                                                                                                          FFAppState().DataFinalMesAnterior!)!
                                                                                                                      .toDouble()),
                                                                                                              '+10%',
                                                                                                            ))!
                                                                                                                ? FlutterFlowTheme.of(context).primary
                                                                                                                : FlutterFlowTheme.of(context).error,
                                                                                                            fontSize: 16.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ].divide(SizedBox(width: 4.0)),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'gnjxs3gm' /* Comentários */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    fontSize: 19.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        flex: 1,
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Text(
                                                                                                  formatNumber(
                                                                                                    functions.somadisplay(
                                                                                                        getJsonField(
                                                                                                          containerDadosMensaisResponse.jsonBody,
                                                                                                          r'''$''',
                                                                                                          true,
                                                                                                        ),
                                                                                                        'total_interactions',
                                                                                                        FFAppState().DataInicioMes!,
                                                                                                        FFAppState().DataFinalMes!),
                                                                                                    formatType: FormatType.compact,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                                        font: GoogleFonts.oswald(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        fontSize: 26.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                                Row(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  children: [
                                                                                                    if (functions.verificarpos(valueOrDefault<String>(
                                                                                                          functions.varpercentual(
                                                                                                              functions
                                                                                                                  .somadisplay(
                                                                                                                      getJsonField(
                                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                                        r'''$''',
                                                                                                                        true,
                                                                                                                      ),
                                                                                                                      'total_interactions',
                                                                                                                      FFAppState().DataInicioMes!,
                                                                                                                      FFAppState().DataFinalMes!)!
                                                                                                                  .toDouble(),
                                                                                                              functions
                                                                                                                  .somadisplay(
                                                                                                                      getJsonField(
                                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                                        r'''$''',
                                                                                                                        true,
                                                                                                                      ),
                                                                                                                      'total_interactions',
                                                                                                                      FFAppState().DataInicioMesAnterior!,
                                                                                                                      FFAppState().DataFinalMesAnterior!)!
                                                                                                                  .toDouble()),
                                                                                                          '+10%',
                                                                                                        )) ??
                                                                                                        true)
                                                                                                      Icon(
                                                                                                        Icons.trending_up,
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        size: 19.0,
                                                                                                      ),
                                                                                                    if (!functions.verificarpos(valueOrDefault<String>(
                                                                                                      functions.varpercentual(
                                                                                                          functions
                                                                                                              .somadisplay(
                                                                                                                  getJsonField(
                                                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                                                    r'''$''',
                                                                                                                    true,
                                                                                                                  ),
                                                                                                                  'total_interactions',
                                                                                                                  FFAppState().DataInicioMes!,
                                                                                                                  FFAppState().DataFinalMes!)!
                                                                                                              .toDouble(),
                                                                                                          functions
                                                                                                              .somadisplay(
                                                                                                                  getJsonField(
                                                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                                                    r'''$''',
                                                                                                                    true,
                                                                                                                  ),
                                                                                                                  'total_interactions',
                                                                                                                  FFAppState().DataInicioMesAnterior!,
                                                                                                                  FFAppState().DataFinalMesAnterior!)!
                                                                                                              .toDouble()),
                                                                                                      '+10%',
                                                                                                    ))!)
                                                                                                      Icon(
                                                                                                        Icons.trending_down,
                                                                                                        color: FlutterFlowTheme.of(context).error,
                                                                                                        size: 19.0,
                                                                                                      ),
                                                                                                    Text(
                                                                                                      valueOrDefault<String>(
                                                                                                        functions.varpercentual(
                                                                                                            functions
                                                                                                                .somadisplay(
                                                                                                                    getJsonField(
                                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                                      r'''$''',
                                                                                                                      true,
                                                                                                                    ),
                                                                                                                    'total_interactions',
                                                                                                                    FFAppState().DataInicioMes!,
                                                                                                                    FFAppState().DataFinalMes!)!
                                                                                                                .toDouble(),
                                                                                                            functions
                                                                                                                .somadisplay(
                                                                                                                    getJsonField(
                                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                                      r'''$''',
                                                                                                                      true,
                                                                                                                    ),
                                                                                                                    'total_interactions',
                                                                                                                    FFAppState().DataInicioMesAnterior!,
                                                                                                                    FFAppState().DataFinalMesAnterior!)!
                                                                                                                .toDouble()),
                                                                                                        '+10%',
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.inter(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: functions.verificarpos(valueOrDefault<String>(
                                                                                                              functions.varpercentual(
                                                                                                                  functions
                                                                                                                      .somadisplay(
                                                                                                                          getJsonField(
                                                                                                                            containerDadosMensaisResponse.jsonBody,
                                                                                                                            r'''$''',
                                                                                                                            true,
                                                                                                                          ),
                                                                                                                          'total_interactions',
                                                                                                                          FFAppState().DataInicioMes!,
                                                                                                                          FFAppState().DataFinalMes!)!
                                                                                                                      .toDouble(),
                                                                                                                  functions
                                                                                                                      .somadisplay(
                                                                                                                          getJsonField(
                                                                                                                            containerDadosMensaisResponse.jsonBody,
                                                                                                                            r'''$''',
                                                                                                                            true,
                                                                                                                          ),
                                                                                                                          'total_interactions',
                                                                                                                          FFAppState().DataInicioMesAnterior!,
                                                                                                                          FFAppState().DataFinalMesAnterior!)!
                                                                                                                      .toDouble()),
                                                                                                              '+10%',
                                                                                                            ))!
                                                                                                                ? FlutterFlowTheme.of(context).primary
                                                                                                                : FlutterFlowTheme.of(context).error,
                                                                                                            fontSize: 16.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ].divide(SizedBox(width: 4.0)),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'nqct2ebd' /* Engajamento */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    fontSize: 19.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        flex: 1,
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Text(
                                                                                                  formatNumber(
                                                                                                    functions.somadisplay(
                                                                                                        getJsonField(
                                                                                                          containerDadosMensaisResponse.jsonBody,
                                                                                                          r'''$''',
                                                                                                          true,
                                                                                                        ),
                                                                                                        'views',
                                                                                                        FFAppState().DataInicioMes!,
                                                                                                        FFAppState().DataFinalMes!),
                                                                                                    formatType: FormatType.compact,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                                        font: GoogleFonts.oswald(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        fontSize: 26.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                                Row(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  children: [
                                                                                                    if (functions.verificarpos(valueOrDefault<String>(
                                                                                                          functions.varpercentual(
                                                                                                              functions
                                                                                                                  .somadisplay(
                                                                                                                      getJsonField(
                                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                                        r'''$''',
                                                                                                                        true,
                                                                                                                      ),
                                                                                                                      'views',
                                                                                                                      FFAppState().DataInicioMes!,
                                                                                                                      FFAppState().DataFinalMes!)!
                                                                                                                  .toDouble(),
                                                                                                              functions
                                                                                                                  .somadisplay(
                                                                                                                      getJsonField(
                                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                                        r'''$''',
                                                                                                                        true,
                                                                                                                      ),
                                                                                                                      'views',
                                                                                                                      FFAppState().DataInicioMesAnterior!,
                                                                                                                      FFAppState().DataFinalMesAnterior!)!
                                                                                                                  .toDouble()),
                                                                                                          '+10%',
                                                                                                        )) ??
                                                                                                        true)
                                                                                                      Icon(
                                                                                                        Icons.trending_up,
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        size: 19.0,
                                                                                                      ),
                                                                                                    if (!functions.verificarpos(valueOrDefault<String>(
                                                                                                      functions.varpercentual(
                                                                                                          functions
                                                                                                              .somadisplay(
                                                                                                                  getJsonField(
                                                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                                                    r'''$''',
                                                                                                                    true,
                                                                                                                  ),
                                                                                                                  'views',
                                                                                                                  FFAppState().DataInicioMes!,
                                                                                                                  FFAppState().DataFinalMes!)!
                                                                                                              .toDouble(),
                                                                                                          functions
                                                                                                              .somadisplay(
                                                                                                                  getJsonField(
                                                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                                                    r'''$''',
                                                                                                                    true,
                                                                                                                  ),
                                                                                                                  'views',
                                                                                                                  FFAppState().DataInicioMesAnterior!,
                                                                                                                  FFAppState().DataFinalMesAnterior!)!
                                                                                                              .toDouble()),
                                                                                                      '+10%',
                                                                                                    ))!)
                                                                                                      Icon(
                                                                                                        Icons.trending_down,
                                                                                                        color: FlutterFlowTheme.of(context).error,
                                                                                                        size: 19.0,
                                                                                                      ),
                                                                                                    Text(
                                                                                                      valueOrDefault<String>(
                                                                                                        functions.varpercentual(
                                                                                                            functions
                                                                                                                .somadisplay(
                                                                                                                    getJsonField(
                                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                                      r'''$''',
                                                                                                                      true,
                                                                                                                    ),
                                                                                                                    'views',
                                                                                                                    FFAppState().DataInicioMes!,
                                                                                                                    FFAppState().DataFinalMes!)!
                                                                                                                .toDouble(),
                                                                                                            functions
                                                                                                                .somadisplay(
                                                                                                                    getJsonField(
                                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                                      r'''$''',
                                                                                                                      true,
                                                                                                                    ),
                                                                                                                    'views',
                                                                                                                    FFAppState().DataInicioMesAnterior!,
                                                                                                                    FFAppState().DataFinalMesAnterior!)!
                                                                                                                .toDouble()),
                                                                                                        '+10%',
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.inter(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: functions.verificarpos(valueOrDefault<String>(
                                                                                                              functions.varpercentual(
                                                                                                                  functions
                                                                                                                      .somadisplay(
                                                                                                                          getJsonField(
                                                                                                                            containerDadosMensaisResponse.jsonBody,
                                                                                                                            r'''$''',
                                                                                                                            true,
                                                                                                                          ),
                                                                                                                          'views',
                                                                                                                          FFAppState().DataInicioMes!,
                                                                                                                          FFAppState().DataFinalMes!)!
                                                                                                                      .toDouble(),
                                                                                                                  functions
                                                                                                                      .somadisplay(
                                                                                                                          getJsonField(
                                                                                                                            containerDadosMensaisResponse.jsonBody,
                                                                                                                            r'''$''',
                                                                                                                            true,
                                                                                                                          ),
                                                                                                                          'views',
                                                                                                                          FFAppState().DataInicioMesAnterior!,
                                                                                                                          FFAppState().DataFinalMesAnterior!)!
                                                                                                                      .toDouble()),
                                                                                                              '+10%',
                                                                                                            ))!
                                                                                                                ? FlutterFlowTheme.of(context).primary
                                                                                                                : FlutterFlowTheme.of(context).error,
                                                                                                            fontSize: 16.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ].divide(SizedBox(width: 4.0)),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'uczih74e' /* Visualizações */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    fontSize: 19.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ].divide(SizedBox(height: 20.0)),
                                                                              ),
                                                                              Flexible(
                                                                                flex: 1,
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Column(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Text(
                                                                                                  formatNumber(
                                                                                                    functions.somadisplay(
                                                                                                        getJsonField(
                                                                                                          containerDadosMensaisResponse.jsonBody,
                                                                                                          r'''$''',
                                                                                                          true,
                                                                                                        ),
                                                                                                        'likes',
                                                                                                        FFAppState().DataInicioMes!,
                                                                                                        FFAppState().DataFinalMes!),
                                                                                                    formatType: FormatType.compact,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                                        font: GoogleFonts.oswald(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        fontSize: 26.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                                Row(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  children: [
                                                                                                    if (functions.verificarpos(valueOrDefault<String>(
                                                                                                          functions.varpercentual(
                                                                                                              functions
                                                                                                                  .somadisplay(
                                                                                                                      getJsonField(
                                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                                        r'''$''',
                                                                                                                        true,
                                                                                                                      ),
                                                                                                                      'likes',
                                                                                                                      FFAppState().DataInicioMes!,
                                                                                                                      FFAppState().DataFinalMes!)!
                                                                                                                  .toDouble(),
                                                                                                              functions
                                                                                                                  .somadisplay(
                                                                                                                      getJsonField(
                                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                                        r'''$''',
                                                                                                                        true,
                                                                                                                      ),
                                                                                                                      'likes',
                                                                                                                      FFAppState().DataInicioMesAnterior!,
                                                                                                                      FFAppState().DataFinalMesAnterior!)!
                                                                                                                  .toDouble()),
                                                                                                          '+10%',
                                                                                                        )) ??
                                                                                                        true)
                                                                                                      Icon(
                                                                                                        Icons.trending_up,
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        size: 19.0,
                                                                                                      ),
                                                                                                    if (!functions.verificarpos(valueOrDefault<String>(
                                                                                                      functions.varpercentual(
                                                                                                          functions
                                                                                                              .somadisplay(
                                                                                                                  getJsonField(
                                                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                                                    r'''$''',
                                                                                                                    true,
                                                                                                                  ),
                                                                                                                  'likes',
                                                                                                                  FFAppState().DataInicioMes!,
                                                                                                                  FFAppState().DataFinalMes!)!
                                                                                                              .toDouble(),
                                                                                                          functions
                                                                                                              .somadisplay(
                                                                                                                  getJsonField(
                                                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                                                    r'''$''',
                                                                                                                    true,
                                                                                                                  ),
                                                                                                                  'likes',
                                                                                                                  FFAppState().DataInicioMesAnterior!,
                                                                                                                  FFAppState().DataFinalMesAnterior!)!
                                                                                                              .toDouble()),
                                                                                                      '+10%',
                                                                                                    ))!)
                                                                                                      Icon(
                                                                                                        Icons.trending_down,
                                                                                                        color: FlutterFlowTheme.of(context).error,
                                                                                                        size: 19.0,
                                                                                                      ),
                                                                                                    Text(
                                                                                                      valueOrDefault<String>(
                                                                                                        functions.varpercentual(
                                                                                                            functions
                                                                                                                .somadisplay(
                                                                                                                    getJsonField(
                                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                                      r'''$''',
                                                                                                                      true,
                                                                                                                    ),
                                                                                                                    'likes',
                                                                                                                    FFAppState().DataInicioMes!,
                                                                                                                    FFAppState().DataFinalMes!)!
                                                                                                                .toDouble(),
                                                                                                            functions
                                                                                                                .somadisplay(
                                                                                                                    getJsonField(
                                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                                      r'''$''',
                                                                                                                      true,
                                                                                                                    ),
                                                                                                                    'likes',
                                                                                                                    FFAppState().DataInicioMesAnterior!,
                                                                                                                    FFAppState().DataFinalMesAnterior!)!
                                                                                                                .toDouble()),
                                                                                                        '+10%',
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.inter(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: functions.verificarpos(valueOrDefault<String>(
                                                                                                              functions.varpercentual(
                                                                                                                  functions
                                                                                                                      .somadisplay(
                                                                                                                          getJsonField(
                                                                                                                            containerDadosMensaisResponse.jsonBody,
                                                                                                                            r'''$''',
                                                                                                                            true,
                                                                                                                          ),
                                                                                                                          'likes',
                                                                                                                          FFAppState().DataInicioMes!,
                                                                                                                          FFAppState().DataFinalMes!)!
                                                                                                                      .toDouble(),
                                                                                                                  functions
                                                                                                                      .somadisplay(
                                                                                                                          getJsonField(
                                                                                                                            containerDadosMensaisResponse.jsonBody,
                                                                                                                            r'''$''',
                                                                                                                            true,
                                                                                                                          ),
                                                                                                                          'likes',
                                                                                                                          FFAppState().DataInicioMesAnterior!,
                                                                                                                          FFAppState().DataFinalMesAnterior!)!
                                                                                                                      .toDouble()),
                                                                                                              '+10%',
                                                                                                            ))!
                                                                                                                ? FlutterFlowTheme.of(context).primary
                                                                                                                : FlutterFlowTheme.of(context).error,
                                                                                                            fontSize: 16.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ].divide(SizedBox(width: 4.0)),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'f4uztgve' /* Likes */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    fontSize: 19.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Text(
                                                                                                  formatNumber(
                                                                                                    functions.somadisplay(
                                                                                                        getJsonField(
                                                                                                          containerDadosMensaisResponse.jsonBody,
                                                                                                          r'''$''',
                                                                                                          true,
                                                                                                        ),
                                                                                                        'shares',
                                                                                                        FFAppState().DataInicioMes!,
                                                                                                        FFAppState().DataFinalMes!),
                                                                                                    formatType: FormatType.compact,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                                        font: GoogleFonts.oswald(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        fontSize: 26.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                                Row(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  children: [
                                                                                                    if (functions.verificarpos(valueOrDefault<String>(
                                                                                                          functions.varpercentual(
                                                                                                              functions
                                                                                                                  .somadisplay(
                                                                                                                      getJsonField(
                                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                                        r'''$''',
                                                                                                                        true,
                                                                                                                      ),
                                                                                                                      'shares',
                                                                                                                      FFAppState().DataInicioMes!,
                                                                                                                      FFAppState().DataFinalMes!)!
                                                                                                                  .toDouble(),
                                                                                                              functions
                                                                                                                  .somadisplay(
                                                                                                                      getJsonField(
                                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                                        r'''$''',
                                                                                                                        true,
                                                                                                                      ),
                                                                                                                      'shares',
                                                                                                                      FFAppState().DataInicioMesAnterior!,
                                                                                                                      FFAppState().DataFinalMesAnterior!)!
                                                                                                                  .toDouble()),
                                                                                                          '+10%',
                                                                                                        )) ??
                                                                                                        true)
                                                                                                      Icon(
                                                                                                        Icons.trending_up,
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        size: 19.0,
                                                                                                      ),
                                                                                                    if (!functions.verificarpos(valueOrDefault<String>(
                                                                                                      functions.varpercentual(
                                                                                                          functions
                                                                                                              .somadisplay(
                                                                                                                  getJsonField(
                                                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                                                    r'''$''',
                                                                                                                    true,
                                                                                                                  ),
                                                                                                                  'shares',
                                                                                                                  FFAppState().DataInicioMes!,
                                                                                                                  FFAppState().DataFinalMes!)!
                                                                                                              .toDouble(),
                                                                                                          functions
                                                                                                              .somadisplay(
                                                                                                                  getJsonField(
                                                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                                                    r'''$''',
                                                                                                                    true,
                                                                                                                  ),
                                                                                                                  'shares',
                                                                                                                  FFAppState().DataInicioMesAnterior!,
                                                                                                                  FFAppState().DataFinalMesAnterior!)!
                                                                                                              .toDouble()),
                                                                                                      '+10%',
                                                                                                    ))!)
                                                                                                      Icon(
                                                                                                        Icons.trending_down,
                                                                                                        color: FlutterFlowTheme.of(context).error,
                                                                                                        size: 19.0,
                                                                                                      ),
                                                                                                    Text(
                                                                                                      valueOrDefault<String>(
                                                                                                        functions.varpercentual(
                                                                                                            functions
                                                                                                                .somadisplay(
                                                                                                                    getJsonField(
                                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                                      r'''$''',
                                                                                                                      true,
                                                                                                                    ),
                                                                                                                    'shares',
                                                                                                                    FFAppState().DataInicioMes!,
                                                                                                                    FFAppState().DataFinalMes!)!
                                                                                                                .toDouble(),
                                                                                                            functions
                                                                                                                .somadisplay(
                                                                                                                    getJsonField(
                                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                                      r'''$''',
                                                                                                                      true,
                                                                                                                    ),
                                                                                                                    'shares',
                                                                                                                    FFAppState().DataInicioMesAnterior!,
                                                                                                                    FFAppState().DataFinalMesAnterior!)!
                                                                                                                .toDouble()),
                                                                                                        '+10%',
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.inter(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: functions.verificarpos(valueOrDefault<String>(
                                                                                                              functions.varpercentual(
                                                                                                                  functions
                                                                                                                      .somadisplay(
                                                                                                                          getJsonField(
                                                                                                                            containerDadosMensaisResponse.jsonBody,
                                                                                                                            r'''$''',
                                                                                                                            true,
                                                                                                                          ),
                                                                                                                          'shares',
                                                                                                                          FFAppState().DataInicioMes!,
                                                                                                                          FFAppState().DataFinalMes!)!
                                                                                                                      .toDouble(),
                                                                                                                  functions
                                                                                                                      .somadisplay(
                                                                                                                          getJsonField(
                                                                                                                            containerDadosMensaisResponse.jsonBody,
                                                                                                                            r'''$''',
                                                                                                                            true,
                                                                                                                          ),
                                                                                                                          'shares',
                                                                                                                          FFAppState().DataInicioMesAnterior!,
                                                                                                                          FFAppState().DataFinalMesAnterior!)!
                                                                                                                      .toDouble()),
                                                                                                              '+10%',
                                                                                                            ))!
                                                                                                                ? FlutterFlowTheme.of(context).primary
                                                                                                                : FlutterFlowTheme.of(context).error,
                                                                                                            fontSize: 16.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ].divide(SizedBox(width: 4.0)),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'ctzdr11n' /* Compartilhamentos */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    fontSize: 19.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Text(
                                                                                                  formatNumber(
                                                                                                    functions.somadisplay(
                                                                                                        getJsonField(
                                                                                                          containerDadosMensaisResponse.jsonBody,
                                                                                                          r'''$''',
                                                                                                          true,
                                                                                                        ),
                                                                                                        'accounts_engaged',
                                                                                                        FFAppState().DataInicioMes!,
                                                                                                        FFAppState().DataFinalMes!),
                                                                                                    formatType: FormatType.compact,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                                        font: GoogleFonts.oswald(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        fontSize: 26.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                                Row(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  children: [
                                                                                                    if (functions.verificarpos(valueOrDefault<String>(
                                                                                                          functions.varpercentual(
                                                                                                              functions
                                                                                                                  .somadisplay(
                                                                                                                      getJsonField(
                                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                                        r'''$''',
                                                                                                                        true,
                                                                                                                      ),
                                                                                                                      'accounts_engaged',
                                                                                                                      FFAppState().DataInicioMes!,
                                                                                                                      FFAppState().DataFinalMes!)!
                                                                                                                  .toDouble(),
                                                                                                              functions
                                                                                                                  .somadisplay(
                                                                                                                      getJsonField(
                                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                                        r'''$''',
                                                                                                                        true,
                                                                                                                      ),
                                                                                                                      'accounts_engaged',
                                                                                                                      FFAppState().DataInicioMesAnterior!,
                                                                                                                      FFAppState().DataFinalMesAnterior!)!
                                                                                                                  .toDouble()),
                                                                                                          '+10%',
                                                                                                        )) ??
                                                                                                        true)
                                                                                                      Icon(
                                                                                                        Icons.trending_up,
                                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                                        size: 19.0,
                                                                                                      ),
                                                                                                    if (!functions.verificarpos(valueOrDefault<String>(
                                                                                                      functions.varpercentual(
                                                                                                          functions
                                                                                                              .somadisplay(
                                                                                                                  getJsonField(
                                                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                                                    r'''$''',
                                                                                                                    true,
                                                                                                                  ),
                                                                                                                  'accounts_engaged',
                                                                                                                  FFAppState().DataInicioMes!,
                                                                                                                  FFAppState().DataFinalMes!)!
                                                                                                              .toDouble(),
                                                                                                          functions
                                                                                                              .somadisplay(
                                                                                                                  getJsonField(
                                                                                                                    containerDadosMensaisResponse.jsonBody,
                                                                                                                    r'''$''',
                                                                                                                    true,
                                                                                                                  ),
                                                                                                                  'accounts_engaged',
                                                                                                                  FFAppState().DataInicioMesAnterior!,
                                                                                                                  FFAppState().DataFinalMesAnterior!)!
                                                                                                              .toDouble()),
                                                                                                      '+10%',
                                                                                                    ))!)
                                                                                                      Icon(
                                                                                                        Icons.trending_down,
                                                                                                        color: FlutterFlowTheme.of(context).error,
                                                                                                        size: 19.0,
                                                                                                      ),
                                                                                                    Text(
                                                                                                      valueOrDefault<String>(
                                                                                                        functions.varpercentual(
                                                                                                            functions
                                                                                                                .somadisplay(
                                                                                                                    getJsonField(
                                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                                      r'''$''',
                                                                                                                      true,
                                                                                                                    ),
                                                                                                                    'accounts_engaged',
                                                                                                                    FFAppState().DataInicioMes!,
                                                                                                                    FFAppState().DataFinalMes!)!
                                                                                                                .toDouble(),
                                                                                                            functions
                                                                                                                .somadisplay(
                                                                                                                    getJsonField(
                                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                                      r'''$''',
                                                                                                                      true,
                                                                                                                    ),
                                                                                                                    'accounts_engaged',
                                                                                                                    FFAppState().DataInicioMesAnterior!,
                                                                                                                    FFAppState().DataFinalMesAnterior!)!
                                                                                                                .toDouble()),
                                                                                                        '+10%',
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.inter(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: functions.verificarpos(valueOrDefault<String>(
                                                                                                              functions.varpercentual(
                                                                                                                  functions
                                                                                                                      .somadisplay(
                                                                                                                          getJsonField(
                                                                                                                            containerDadosMensaisResponse.jsonBody,
                                                                                                                            r'''$''',
                                                                                                                            true,
                                                                                                                          ),
                                                                                                                          'accounts_engaged',
                                                                                                                          FFAppState().DataInicioMes!,
                                                                                                                          FFAppState().DataFinalMes!)!
                                                                                                                      .toDouble(),
                                                                                                                  functions
                                                                                                                      .somadisplay(
                                                                                                                          getJsonField(
                                                                                                                            containerDadosMensaisResponse.jsonBody,
                                                                                                                            r'''$''',
                                                                                                                            true,
                                                                                                                          ),
                                                                                                                          'accounts_engaged',
                                                                                                                          FFAppState().DataInicioMesAnterior!,
                                                                                                                          FFAppState().DataFinalMesAnterior!)!
                                                                                                                      .toDouble()),
                                                                                                              '+10%',
                                                                                                            ))!
                                                                                                                ? FlutterFlowTheme.of(context).primary
                                                                                                                : FlutterFlowTheme.of(context).error,
                                                                                                            fontSize: 16.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ].divide(SizedBox(width: 4.0)),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'l7ya0t8s' /* Contas Engajadas */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    fontSize: 19.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            if (formatNumber(
                                                                                                  functions.somadisplay(
                                                                                                      getJsonField(
                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                        r'''$''',
                                                                                                        true,
                                                                                                      ),
                                                                                                      'reach',
                                                                                                      FFAppState().DataInicioMes!,
                                                                                                      FFAppState().DataFinalMes!),
                                                                                                  formatType: FormatType.compact,
                                                                                                ) ==
                                                                                                '0')
                                                                                              Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'j5j5zmf1' /* Indisponível */,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                                      font: GoogleFonts.oswald(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                      ),
                                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                                      fontSize: 26.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            if (formatNumber(
                                                                                                  functions.somadisplay(
                                                                                                      getJsonField(
                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                        r'''$''',
                                                                                                        true,
                                                                                                      ),
                                                                                                      'reach',
                                                                                                      FFAppState().DataInicioMes!,
                                                                                                      FFAppState().DataFinalMes!),
                                                                                                  formatType: FormatType.compact,
                                                                                                ) !=
                                                                                                '0')
                                                                                              Row(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    formatNumber(
                                                                                                      functions.somadisplay(
                                                                                                          getJsonField(
                                                                                                            containerDadosMensaisResponse.jsonBody,
                                                                                                            r'''$''',
                                                                                                            true,
                                                                                                          ),
                                                                                                          'reach',
                                                                                                          FFAppState().DataInicioMes!,
                                                                                                          FFAppState().DataFinalMes!),
                                                                                                      formatType: FormatType.compact,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                                          font: GoogleFonts.oswald(
                                                                                                            fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                          ),
                                                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                                                          fontSize: 26.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                  Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    children: [
                                                                                                      if (functions.verificarpos(valueOrDefault<String>(
                                                                                                            functions.varpercentual(
                                                                                                                functions
                                                                                                                    .somadisplay(
                                                                                                                        getJsonField(
                                                                                                                          containerDadosMensaisResponse.jsonBody,
                                                                                                                          r'''$''',
                                                                                                                          true,
                                                                                                                        ),
                                                                                                                        'reach',
                                                                                                                        FFAppState().DataInicioMes!,
                                                                                                                        FFAppState().DataFinalMes!)!
                                                                                                                    .toDouble(),
                                                                                                                functions
                                                                                                                    .somadisplay(
                                                                                                                        getJsonField(
                                                                                                                          containerDadosMensaisResponse.jsonBody,
                                                                                                                          r'''$''',
                                                                                                                          true,
                                                                                                                        ),
                                                                                                                        'reach',
                                                                                                                        FFAppState().DataInicioMesAnterior!,
                                                                                                                        FFAppState().DataFinalMesAnterior!)!
                                                                                                                    .toDouble()),
                                                                                                            '+10%',
                                                                                                          )) ??
                                                                                                          true)
                                                                                                        Icon(
                                                                                                          Icons.trending_up,
                                                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                                                          size: 19.0,
                                                                                                        ),
                                                                                                      if (!functions.verificarpos(valueOrDefault<String>(
                                                                                                        functions.varpercentual(
                                                                                                            functions
                                                                                                                .somadisplay(
                                                                                                                    getJsonField(
                                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                                      r'''$''',
                                                                                                                      true,
                                                                                                                    ),
                                                                                                                    'reach',
                                                                                                                    FFAppState().DataInicioMes!,
                                                                                                                    FFAppState().DataFinalMes!)!
                                                                                                                .toDouble(),
                                                                                                            functions
                                                                                                                .somadisplay(
                                                                                                                    getJsonField(
                                                                                                                      containerDadosMensaisResponse.jsonBody,
                                                                                                                      r'''$''',
                                                                                                                      true,
                                                                                                                    ),
                                                                                                                    'reach',
                                                                                                                    FFAppState().DataInicioMesAnterior!,
                                                                                                                    FFAppState().DataFinalMesAnterior!)!
                                                                                                                .toDouble()),
                                                                                                        '+10%',
                                                                                                      ))!)
                                                                                                        Icon(
                                                                                                          Icons.trending_down,
                                                                                                          color: FlutterFlowTheme.of(context).error,
                                                                                                          size: 19.0,
                                                                                                        ),
                                                                                                      Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          functions.varpercentual(
                                                                                                              functions
                                                                                                                  .somadisplay(
                                                                                                                      getJsonField(
                                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                                        r'''$''',
                                                                                                                        true,
                                                                                                                      ),
                                                                                                                      'reach',
                                                                                                                      FFAppState().DataInicioMes!,
                                                                                                                      FFAppState().DataFinalMes!)!
                                                                                                                  .toDouble(),
                                                                                                              functions
                                                                                                                  .somadisplay(
                                                                                                                      getJsonField(
                                                                                                                        containerDadosMensaisResponse.jsonBody,
                                                                                                                        r'''$''',
                                                                                                                        true,
                                                                                                                      ),
                                                                                                                      'reach',
                                                                                                                      FFAppState().DataInicioMesAnterior!,
                                                                                                                      FFAppState().DataFinalMesAnterior!)!
                                                                                                                  .toDouble()),
                                                                                                          '+10%',
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.inter(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                              color: functions.verificarpos(valueOrDefault<String>(
                                                                                                                functions.varpercentual(
                                                                                                                    functions
                                                                                                                        .somadisplay(
                                                                                                                            getJsonField(
                                                                                                                              containerDadosMensaisResponse.jsonBody,
                                                                                                                              r'''$''',
                                                                                                                              true,
                                                                                                                            ),
                                                                                                                            'reach',
                                                                                                                            FFAppState().DataInicioMes!,
                                                                                                                            FFAppState().DataFinalMes!)!
                                                                                                                        .toDouble(),
                                                                                                                    functions
                                                                                                                        .somadisplay(
                                                                                                                            getJsonField(
                                                                                                                              containerDadosMensaisResponse.jsonBody,
                                                                                                                              r'''$''',
                                                                                                                              true,
                                                                                                                            ),
                                                                                                                            'reach',
                                                                                                                            FFAppState().DataInicioMesAnterior!,
                                                                                                                            FFAppState().DataFinalMesAnterior!)!
                                                                                                                        .toDouble()),
                                                                                                                '+10%',
                                                                                                              ))!
                                                                                                                  ? FlutterFlowTheme.of(context).primary
                                                                                                                  : FlutterFlowTheme.of(context).error,
                                                                                                              fontSize: 16.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ].divide(SizedBox(width: 4.0)),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'f1xv4atr' /* Alcance */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                    font: GoogleFonts.inter(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    fontSize: 19.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 20.0)),
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 15.0)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 20.0)),
                                                ),
                                                AuthUserStreamWidget(
                                                  builder: (context) =>
                                                      FutureBuilder<
                                                          ApiCallResponse>(
                                                    future:
                                                        DadosDiariosCall.call(
                                                      filterColumn:
                                                          'related_id',
                                                      filterValue:
                                                          _model.idconta,
                                                      filterColumn2: 'user_id',
                                                      filterValue2: valueOrDefault<
                                                                  bool>(
                                                              currentUserDocument
                                                                  ?.admin,
                                                              false)
                                                          ? currentUserUid
                                                          : valueOrDefault(
                                                              currentUserDocument
                                                                  ?.lenderId,
                                                              ''),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50,
                                                            height: 50,
                                                            child:
                                                                CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                      Color>(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      final containerDadosDiariosResponse =
                                                          snapshot.data!;

                                                      return Material(
                                                        color:
                                                            Colors.transparent,
                                                        elevation: 2.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.0),
                                                        ),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.61,
                                                          height: 590.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Expanded(
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            20.0,
                                                                            20.0,
                                                                            20.0,
                                                                            20.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children:
                                                                              [
                                                                            Align(
                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                              child: Text(
                                                                                FFLocalizations.of(context).getText(
                                                                                  'jxm9y30w' /* Resultados diários */,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                      font: GoogleFonts.oswald(
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                      ),
                                                                                      fontSize: 26.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                              child: FlutterFlowDropDown<String>(
                                                                                controller: _model.dropDownValueController2 ??= FormFieldController<String>(
                                                                                  _model.dropDownValue2 ??= 'follows_and_unfollows',
                                                                                ),
                                                                                options: List<String>.from([
                                                                                  'follows_and_unfollows',
                                                                                  'likes',
                                                                                  'reach',
                                                                                  'views',
                                                                                  'comments',
                                                                                  'shares',
                                                                                  'total_interactions',
                                                                                  'accounts_engaged'
                                                                                ]),
                                                                                optionLabels: [
                                                                                  FFLocalizations.of(context).getText(
                                                                                    '6lzuh7mf' /* Seguidores */,
                                                                                  ),
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'pwvoj843' /* Likes */,
                                                                                  ),
                                                                                  FFLocalizations.of(context).getText(
                                                                                    '7sr28dlc' /* Alcance */,
                                                                                  ),
                                                                                  FFLocalizations.of(context).getText(
                                                                                    '2wag5mpn' /* Visualizações */,
                                                                                  ),
                                                                                  FFLocalizations.of(context).getText(
                                                                                    '5w0z6d5z' /* Comentários */,
                                                                                  ),
                                                                                  FFLocalizations.of(context).getText(
                                                                                    '8nom3mg1' /* Compartilhamentos */,
                                                                                  ),
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'c1072s9i' /* Engajamento */,
                                                                                  ),
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'dj9eivcw' /* Contas Engajadas */,
                                                                                  )
                                                                                ],
                                                                                onChanged: (val) => safeSetState(() => _model.dropDownValue2 = val),
                                                                                width: 150.0,
                                                                                height: 30.0,
                                                                                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      fontSize: 19.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                hintText: FFLocalizations.of(context).getText(
                                                                                  '6s18q8kj' /* Select... */,
                                                                                ),
                                                                                icon: Icon(
                                                                                  Icons.keyboard_arrow_down_rounded,
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  size: 24.0,
                                                                                ),
                                                                                fillColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                elevation: 2.0,
                                                                                borderColor: Colors.transparent,
                                                                                borderWidth: 0.0,
                                                                                borderRadius: 8.0,
                                                                                margin: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                hidesUnderline: true,
                                                                                isOverButton: false,
                                                                                isSearchable: false,
                                                                                isMultiSelect: false,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                                                              child: Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                height: 400.0,
                                                                                child: FlutterFlowLineChart(
                                                                                  data: [
                                                                                    FFLineChartData(
                                                                                      xData: functions.tabeladadosdiariosX(
                                                                                          FFAppState().DataInicioMesAnterior,
                                                                                          FFAppState().DataFinalMesAnterior,
                                                                                          getJsonField(
                                                                                            containerDadosDiariosResponse.jsonBody,
                                                                                            r'''$''',
                                                                                          ))!,
                                                                                      yData: functions.tabeladadosdiariosY(
                                                                                          FFAppState().DataInicioMesAnterior,
                                                                                          FFAppState().DataFinalMesAnterior,
                                                                                          getJsonField(
                                                                                            containerDadosDiariosResponse.jsonBody,
                                                                                            r'''$''',
                                                                                            true,
                                                                                          ),
                                                                                          _model.dropDownValue2)!,
                                                                                      settings: LineChartBarData(
                                                                                        color: FlutterFlowTheme.of(context).warning,
                                                                                        barWidth: 2.0,
                                                                                        isCurved: true,
                                                                                        preventCurveOverShooting: true,
                                                                                        dotData: FlDotData(show: false),
                                                                                        belowBarData: BarAreaData(
                                                                                          show: true,
                                                                                          color: FlutterFlowTheme.of(context).customColor1,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    FFLineChartData(
                                                                                      xData: functions.tabeladadosdiariosX(
                                                                                          FFAppState().DataInicioMes,
                                                                                          FFAppState().DataFinalMes,
                                                                                          getJsonField(
                                                                                            containerDadosDiariosResponse.jsonBody,
                                                                                            r'''$''',
                                                                                          ))!,
                                                                                      yData: functions.tabeladadosdiariosY(
                                                                                          FFAppState().DataInicioMes,
                                                                                          FFAppState().DataFinalMes,
                                                                                          getJsonField(
                                                                                            containerDadosDiariosResponse.jsonBody,
                                                                                            r'''$''',
                                                                                            true,
                                                                                          ),
                                                                                          _model.dropDownValue2)!,
                                                                                      settings: LineChartBarData(
                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                        barWidth: 2.0,
                                                                                        isCurved: true,
                                                                                        preventCurveOverShooting: true,
                                                                                        dotData: FlDotData(show: false),
                                                                                        belowBarData: BarAreaData(
                                                                                          show: true,
                                                                                          color: FlutterFlowTheme.of(context).accent1,
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                  chartStylingInfo: ChartStylingInfo(
                                                                                    enableTooltip: true,
                                                                                    tooltipBackgroundColor: FlutterFlowTheme.of(context).alternate,
                                                                                    backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                    showBorder: false,
                                                                                  ),
                                                                                  axisBounds: AxisBounds(),
                                                                                  xAxisLabelInfo: AxisLabelInfo(
                                                                                    reservedSize: 32.0,
                                                                                  ),
                                                                                  yAxisLabelInfo: AxisLabelInfo(
                                                                                    reservedSize: 40.0,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 30.0,
                                                                                      height: 30.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                        borderRadius: BorderRadius.circular(2.0),
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      FFLocalizations.of(context).getText(
                                                                                        'qsgp204j' /* Período atual */,
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            fontSize: 16.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ].divide(SizedBox(width: 5.0)),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 30.0,
                                                                                      height: 30.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).warning,
                                                                                        borderRadius: BorderRadius.circular(2.0),
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      FFLocalizations.of(context).getText(
                                                                                        'c77998n0' /* Período anterior */,
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            fontSize: 16.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ].divide(SizedBox(width: 5.0)),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ].divide(SizedBox(height: 10.0)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 20.0)),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Material(
                                                  color: Colors.transparent,
                                                  elevation: 2.0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                  ),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.48,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    child: Visibility(
                                                      visible:
                                                          _model.demografia,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            20.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'sfvf5kfl' /* Demografia - Gênero */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .titleMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .oswald(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize:
                                                                        22.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0,
                                                                      -1.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              -1.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.35,
                                                                            height:
                                                                                280.0,
                                                                            child:
                                                                                FlutterFlowPieChart(
                                                                              data: FFPieChartData(
                                                                                values: functions.porcentagemdemografica(
                                                                                    FFAppState().DataInicioMes,
                                                                                    FFAppState().DataFinalMes,
                                                                                    getJsonField(
                                                                                      (_model.demografias?.jsonBody ?? ''),
                                                                                      r'''$''',
                                                                                      true,
                                                                                    ))!,
                                                                                colors: chartPieChartColorsList5,
                                                                                radius: [
                                                                                  140.0
                                                                                ],
                                                                                borderWidth: [
                                                                                  0.0
                                                                                ],
                                                                                borderColor: [
                                                                                  FlutterFlowTheme.of(context).primaryText
                                                                                ],
                                                                              ),
                                                                              donutHoleRadius: 0.0,
                                                                              donutHoleColor: Colors.transparent,
                                                                              sectionLabelType: PieChartSectionLabelType.percent,
                                                                              sectionLabelStyle: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                    font: GoogleFonts.oswald(
                                                                                      fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                    fontSize: 18.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment: AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            10.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children:
                                                                              [
                                                                            Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 23.0,
                                                                                      height: 19.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).error,
                                                                                        borderRadius: BorderRadius.circular(2.0),
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      FFLocalizations.of(context).getText(
                                                                                        'pq0hdn9u' /* Mulheres */,
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            fontSize: 20.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ].divide(SizedBox(width: 10.0)),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 23.0,
                                                                                      height: 19.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).warning,
                                                                                        borderRadius: BorderRadius.circular(2.0),
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      FFLocalizations.of(context).getText(
                                                                                        'tbxncitd' /* Indefinido */,
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            fontSize: 20.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ].divide(SizedBox(width: 10.0)),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 23.0,
                                                                                      height: 19.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                        borderRadius: BorderRadius.circular(2.0),
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      FFLocalizations.of(context).getText(
                                                                                        'qp67ky6w' /* Homens */,
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            fontSize: 20.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ].divide(SizedBox(width: 10.0)),
                                                                                ),
                                                                              ].divide(SizedBox(height: 15.0)),
                                                                            ),
                                                                          ].divide(SizedBox(width: 14.0)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 20.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Material(
                                                  color: Colors.transparent,
                                                  elevation: 2.0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                  ),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.48,
                                                    height: 375.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    child: Visibility(
                                                      visible:
                                                          _model.demografia,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, -1.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            20.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'excx31zr' /* Demografia - Gênero e Idade */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .override(
                                                                                font: GoogleFonts.oswald(
                                                                                  fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                ),
                                                                                fontSize: 22.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                                                                              child: Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.46,
                                                                                height: 200.0,
                                                                                child: FlutterFlowBarChart(
                                                                                  barData: [
                                                                                    FFBarChartData(
                                                                                      yData: functions.distretariahomem(
                                                                                          FFAppState().DataInicioMes,
                                                                                          FFAppState().DataFinalMes,
                                                                                          getJsonField(
                                                                                            (_model.demografias?.jsonBody ?? ''),
                                                                                            r'''$''',
                                                                                            true,
                                                                                          ))!,
                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                    ),
                                                                                    FFBarChartData(
                                                                                      yData: functions.distretariamulher(
                                                                                          FFAppState().DataInicioMes,
                                                                                          FFAppState().DataFinalMes,
                                                                                          getJsonField(
                                                                                            (_model.demografias?.jsonBody ?? ''),
                                                                                            r'''$''',
                                                                                            true,
                                                                                          ))!,
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                    ),
                                                                                    FFBarChartData(
                                                                                      yData: functions.distretariaind(
                                                                                          FFAppState().DataInicioMes,
                                                                                          FFAppState().DataFinalMes,
                                                                                          getJsonField(
                                                                                            (_model.demografias?.jsonBody ?? ''),
                                                                                            r'''$''',
                                                                                            true,
                                                                                          ))!,
                                                                                      color: FlutterFlowTheme.of(context).warning,
                                                                                    )
                                                                                  ],
                                                                                  xLabels: FFAppConstants.labelsdemografia,
                                                                                  barWidth: 10.0,
                                                                                  barBorderRadius: BorderRadius.circular(8.0),
                                                                                  barSpace: 0.0,
                                                                                  groupSpace: 0.0,
                                                                                  alignment: BarChartAlignment.spaceBetween,
                                                                                  chartStylingInfo: ChartStylingInfo(
                                                                                    enableTooltip: true,
                                                                                    tooltipBackgroundColor: FlutterFlowTheme.of(context).alternate,
                                                                                    backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                    showBorder: false,
                                                                                  ),
                                                                                  axisBounds: AxisBounds(),
                                                                                  xAxisLabelInfo: AxisLabelInfo(
                                                                                    reservedSize: 20.0,
                                                                                  ),
                                                                                  yAxisLabelInfo: AxisLabelInfo(
                                                                                    reservedSize: 42.0,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                25.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'flrfnxrb' /* 13-17 */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        fontSize: 16.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'juy5e7zs' /* 18-24 */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        fontSize: 16.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    '2a95i8gt' /* 25-34 */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        fontSize: 16.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'kzck5t4b' /* 35-44 */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        fontSize: 16.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'bawaxb1m' /* 45-54 */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        fontSize: 16.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    '089ed5em' /* 55-64 */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        fontSize: 16.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    '43jer7ac' /* 65+ */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        fontSize: 16.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 20.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 20.0)),
                                            ),
                                          ].divide(SizedBox(height: 24.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if ((_model.temconta == false) &&
                                  (_model.loaded == true) &&
                                  valueOrDefault<bool>(
                                      currentUserDocument?.admin, false))
                                Expanded(
                                  child: AuthUserStreamWidget(
                                    builder: (context) => Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              1.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(32.0),
                                          topRight: Radius.circular(32.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            22.0, 24.0, 22.0, 24.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'se9vrj2v' /* Conecte sua conta */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineSmall
                                                  .override(
                                                    font: GoogleFonts.oswald(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineSmall
                                                              .fontStyle,
                                                    ),
                                                    color: Color(0xFF14181C),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineSmall
                                                            .fontStyle,
                                                  ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'yx2z6cma' /* Para adicionar uma conta do In... */,
                                              ),
                                              textAlign: TextAlign.center,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                      ),
                                            ),
                                            Material(
                                              color: Colors.transparent,
                                              elevation: 4.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(24.0, 24.0,
                                                          24.0, 24.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'fq8n04wu' /* Ao conectar sua conta do Faceb... */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .data_usage,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                size: 24.0,
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'd8kpkdo5' /* insights da página e posts */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 12.0)),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              FaIcon(
                                                                FontAwesomeIcons
                                                                    .commentDots,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                size: 24.0,
                                                              ),
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'j8as1l8b' /* comentários */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 12.0)),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 16.0)),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 24.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            FFButtonWidget(
                                              onPressed: () async {
                                                _model.authCode2 = await actions
                                                    .loginWithFacebook();

                                                safeSetState(() {});
                                              },
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                'jizpbzj4' /* Conectar Conta */,
                                              ),
                                              options: FFButtonOptions(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                height: 48.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleMedium
                                                    .override(
                                                      font: GoogleFonts.oswald(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .fontStyle,
                                                      ),
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .fontStyle,
                                                    ),
                                                elevation: 3.0,
                                                borderRadius:
                                                    BorderRadius.circular(28.0),
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 24.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if ((_model.temconta == false) &&
                                  (_model.loaded == true) &&
                                  !valueOrDefault<bool>(
                                      currentUserDocument?.admin, false))
                                Expanded(
                                  child: AuthUserStreamWidget(
                                    builder: (context) => Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(32.0),
                                          topRight: Radius.circular(32.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            22.0, 24.0, 22.0, 24.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '8e0m2of4' /* Aguarde a conexão da sua conta */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .headlineSmall
                                                  .override(
                                                    font: GoogleFonts.oswald(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineSmall
                                                              .fontStyle,
                                                    ),
                                                    color: Color(0xFF14181C),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineSmall
                                                            .fontStyle,
                                                  ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'bheo9ttb' /* Entre em contato com a equipe ... */,
                                              ),
                                              textAlign: TextAlign.center,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyLarge
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                      ),
                                            ),
                                            FFButtonWidget(
                                              onPressed: () async {
                                                await launchURL(
                                                    'https://api.whatsapp.com/send?phone=5511932137807&text=Preciso%20ativar%20meu%20acesso%20no%20BAM%20App.%20O%20email%20cadastrado%20é${currentUserEmail}');
                                              },
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                'v4iql68u' /* Contatar Equipe */,
                                              ),
                                              options: FFButtonOptions(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                height: 48.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleMedium
                                                    .override(
                                                      font: GoogleFonts.oswald(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .fontStyle,
                                                      ),
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .fontStyle,
                                                    ),
                                                elevation: 3.0,
                                                borderRadius:
                                                    BorderRadius.circular(28.0),
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 24.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            if (!_model.loaded)
              Expanded(
                child: wrapWithModel(
                  model: _model.loadingModel,
                  updateCallback: () => safeSetState(() {}),
                  child: LoadingWidget(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
