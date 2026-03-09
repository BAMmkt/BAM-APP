import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/loading/loading_widget.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_media_display.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'master_instapost_model.dart';
export 'master_instapost_model.dart';

class MasterInstapostWidget extends StatefulWidget {
  const MasterInstapostWidget({super.key});

  static String routeName = 'master-instapost';
  static String routePath = '/masterinstapost';

  @override
  State<MasterInstapostWidget> createState() => _MasterInstapostWidgetState();
}

class _MasterInstapostWidgetState extends State<MasterInstapostWidget> {
  late MasterInstapostModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MasterInstapostModel());

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
              _model.nomeconta = _model.loopconta!.nome;
              safeSetState(() {});
              _model.dadospostbackend = await DadosPostsCall.call(
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
                      (_model.dadospostbackend?.jsonBody ?? ''),
                      r'''$''',
                      true,
                    )!,
                  );
                }),
                Future(() async {
                  _model.primeirodia = await actions.coletaprimeirodia(
                    getJsonField(
                      (_model.dadospostbackend?.jsonBody ?? ''),
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
                if ('instagram' == _model.contaselecionada?.plataforma
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
                      phone: false,
                      tablet: false,
                    ))
                      Flexible(
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if ((_model.temconta == true) &&
                                        _model.loaded)
                                      Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 280.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 24.0, 24.0, 24.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FutureBuilder<ApiCallResponse>(
                                                future: CronogramaCall.call(
                                                  filterColumn: 'cliente',
                                                  filterValue: _model.nomeconta,
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
                                                  final rowCronogramaResponse =
                                                      snapshot.data!;

                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      FlutterFlowIconButton(
                                                        borderRadius: 8.0,
                                                        buttonSize: 50.0,
                                                        fillColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryBackground,
                                                        icon: Icon(
                                                          Icons.menu,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 30.0,
                                                        ),
                                                        onPressed: () async {
                                                          scaffoldKey
                                                              .currentState!
                                                              .openDrawer();
                                                        },
                                                      ),
                                                      if (!functions.vernullcom(
                                                          getJsonField(
                                                        rowCronogramaResponse
                                                            .jsonBody,
                                                        r'''$''',
                                                      ))!)
                                                        FlutterFlowIconButton(
                                                          borderRadius: 8.0,
                                                          buttonSize: 50.0,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          icon: Icon(
                                                            Icons
                                                                .schedule_sharp,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 30.0,
                                                          ),
                                                          onPressed: () async {
                                                            context.pushNamed(
                                                                CronogramaWidget
                                                                    .routeName);
                                                          },
                                                        ),
                                                    ],
                                                  );
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
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40.0),
                                                    ),
                                                    child: Container(
                                                      width: 80.0,
                                                      height: 80.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40.0),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40.0),
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
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
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
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .oswald(
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
                                                                fontSize: 28.0,
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
                                                                    maxChars:
                                                                        120,
                                                                    replacement:
                                                                        '…',
                                                                  ),
                                                          maxLines: 3,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
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
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .oswald(
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
                                                                      32.0,
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
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'mj1h7gsz' /* Seguidores */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      18.0,
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
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .oswald(
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
                                                                      32.0,
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
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'xtdm4nw6' /* Posts */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      18.0,
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
                                                    ],
                                                  ),
                                                  if (_model.contaselecionada
                                                          ?.plataforma ==
                                                      'instagram')
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
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
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .oswald(
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
                                                                fontSize: 32.0,
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
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'fp192sho' /* Seguindo */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 18.0,
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
                                        width:
                                            MediaQuery.sizeOf(context).width *
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  22.0, 24.0, 22.0, 24.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'nwbw23iv' /* Resultados da página */,
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
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
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Material(
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
                                                                  0.48,
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
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      '4mdvcgwz' /* Seleção de período */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.oswald(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              22.0,
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
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    FlutterFlowIconButton(
                                                                      borderRadius:
                                                                          8.0,
                                                                      buttonSize:
                                                                          40.0,
                                                                      fillColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primaryBackground,
                                                                      disabledColor:
                                                                          Colors
                                                                              .transparent,
                                                                      disabledIconColor:
                                                                          Colors
                                                                              .transparent,
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_back_ios_sharp,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        size:
                                                                            25.0,
                                                                      ),
                                                                      onPressed: !functions.bolrecuopost(
                                                                              getJsonField(
                                                                                (_model.dadospostbackend?.jsonBody ?? ''),
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
                                                                        FFAppState()
                                                                            .DataInicioMes,
                                                                        locale:
                                                                            FFLocalizations.of(context).languageCode,
                                                                      )} - ${dateTimeFormat(
                                                                        "d/M",
                                                                        FFAppState()
                                                                            .DataFinalMes,
                                                                        locale:
                                                                            FFLocalizations.of(context).languageCode,
                                                                      )}',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                20.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                    FlutterFlowIconButton(
                                                                      borderRadius:
                                                                          8.0,
                                                                      buttonSize:
                                                                          40.0,
                                                                      fillColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primaryBackground,
                                                                      disabledColor:
                                                                          Colors
                                                                              .transparent,
                                                                      disabledIconColor:
                                                                          Colors
                                                                              .transparent,
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_forward_ios_sharp,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        size:
                                                                            25.0,
                                                                      ),
                                                                      onPressed: !functions.bolavancopost(
                                                                              getJsonField(
                                                                                (_model.dadospostbackend?.jsonBody ?? ''),
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
                                                                      width:
                                                                          16.0)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child: Material(
                                                            color: Colors
                                                                .transparent,
                                                            elevation: 2.0,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                            ),
                                                            child: Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.48,
                                                              height: 540.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16.0),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20.0,
                                                                        20.0,
                                                                        20.0,
                                                                        20.0),
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
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'x1w1l1f9' /* Dados descritivos */,
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
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                          child:
                                                                              FlutterFlowDropDown<String>(
                                                                            controller: _model.dropDownValueController1 ??=
                                                                                FormFieldController<String>(
                                                                              _model.dropDownValue1 ??= 'Media',
                                                                            ),
                                                                            options:
                                                                                List<String>.from([
                                                                              'Media',
                                                                              'Soma'
                                                                            ]),
                                                                            optionLabels: [
                                                                              FFLocalizations.of(context).getText(
                                                                                'oa1tpenv' /* Média */,
                                                                              ),
                                                                              FFLocalizations.of(context).getText(
                                                                                'cfmgkyhn' /* Soma */,
                                                                              )
                                                                            ],
                                                                            onChanged: (val) =>
                                                                                safeSetState(() => _model.dropDownValue1 = val),
                                                                            width:
                                                                                100.0,
                                                                            height:
                                                                                30.0,
                                                                            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  fontSize: 18.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                            icon:
                                                                                Icon(
                                                                              Icons.keyboard_arrow_down_rounded,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 24.0,
                                                                            ),
                                                                            fillColor:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
                                                                            elevation:
                                                                                2.0,
                                                                            borderColor:
                                                                                Colors.transparent,
                                                                            borderWidth:
                                                                                0.0,
                                                                            borderRadius:
                                                                                8.0,
                                                                            margin: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            hidesUnderline:
                                                                                true,
                                                                            isOverButton:
                                                                                false,
                                                                            isSearchable:
                                                                                false,
                                                                            isMultiSelect:
                                                                                false,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children:
                                                                            [
                                                                          Flexible(
                                                                            child:
                                                                                FFButtonWidget(
                                                                              onPressed: () async {
                                                                                _model.selectedtype = 'IMAGE';
                                                                                safeSetState(() {});
                                                                              },
                                                                              text: FFLocalizations.of(context).getText(
                                                                                'ugrllm9i' /* Imagem */,
                                                                              ),
                                                                              options: FFButtonOptions(
                                                                                width: 200.0,
                                                                                height: 30.0,
                                                                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                color: _model.selectedtype == 'IMAGE' ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).primaryBackground,
                                                                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                      font: GoogleFonts.oswald(
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                      ),
                                                                                      color: _model.selectedtype == 'IMAGE' ? FlutterFlowTheme.of(context).primaryBackground : FlutterFlowTheme.of(context).primary,
                                                                                      fontSize: 20.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                    ),
                                                                                elevation: 0.0,
                                                                                borderSide: BorderSide(
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  width: 2.0,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(40.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child:
                                                                                FFButtonWidget(
                                                                              onPressed: () async {
                                                                                _model.selectedtype = 'CAROUSEL_ALBUM';
                                                                                safeSetState(() {});
                                                                              },
                                                                              text: FFLocalizations.of(context).getText(
                                                                                'ycaqugi7' /* Carrossel */,
                                                                              ),
                                                                              options: FFButtonOptions(
                                                                                width: 200.0,
                                                                                height: 30.0,
                                                                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                color: _model.selectedtype == 'CAROUSEL_ALBUM' ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).primaryBackground,
                                                                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                      font: GoogleFonts.oswald(
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                      ),
                                                                                      color: _model.selectedtype == 'CAROUSEL_ALBUM' ? FlutterFlowTheme.of(context).primaryBackground : FlutterFlowTheme.of(context).primary,
                                                                                      fontSize: 20.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                    ),
                                                                                elevation: 0.0,
                                                                                borderSide: BorderSide(
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  width: 2.0,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(40.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child:
                                                                                FFButtonWidget(
                                                                              onPressed: () async {
                                                                                _model.selectedtype = 'VIDEO';
                                                                                safeSetState(() {});
                                                                              },
                                                                              text: FFLocalizations.of(context).getText(
                                                                                '0oluevs9' /* Vídeo */,
                                                                              ),
                                                                              options: FFButtonOptions(
                                                                                width: 200.0,
                                                                                height: 30.0,
                                                                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                color: _model.selectedtype == 'VIDEO' ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).primaryBackground,
                                                                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                      font: GoogleFonts.oswald(
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                      ),
                                                                                      color: _model.selectedtype == 'VIDEO' ? FlutterFlowTheme.of(context).primaryBackground : FlutterFlowTheme.of(context).primary,
                                                                                      fontSize: 20.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                    ),
                                                                                elevation: 0.0,
                                                                                borderSide: BorderSide(
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  width: 2.0,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(40.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 5.0)),
                                                                      ),
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
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    _model.dropDownValue1 == 'Soma'
                                                                                        ? formatNumber(
                                                                                            functions.somadisplaypost(
                                                                                                getJsonField(
                                                                                                  (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'reach',
                                                                                                FFAppState().DataInicioMes!,
                                                                                                FFAppState().DataFinalMes!,
                                                                                                _model.selectedtype),
                                                                                            formatType: FormatType.compact,
                                                                                          )
                                                                                        : formatNumber(
                                                                                            functions.mediadisplaypost(
                                                                                                getJsonField(
                                                                                                  (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'reach',
                                                                                                FFAppState().DataInicioMes!,
                                                                                                FFAppState().DataFinalMes!,
                                                                                                _model.selectedtype),
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
                                                                                ],
                                                                              ),
                                                                              Text(
                                                                                FFLocalizations.of(context).getText(
                                                                                  '7if1g6fm' /* Alcance */,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      fontSize: 18.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                    ),
                                                                              ),
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
                                                                                          _model.dropDownValue1 == 'Soma'
                                                                                              ? formatNumber(
                                                                                                  functions.somadisplaypost(
                                                                                                      getJsonField(
                                                                                                        (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                                        r'''$''',
                                                                                                        true,
                                                                                                      ),
                                                                                                      'views',
                                                                                                      FFAppState().DataInicioMes!,
                                                                                                      FFAppState().DataFinalMes!,
                                                                                                      _model.selectedtype),
                                                                                                  formatType: FormatType.compact,
                                                                                                )
                                                                                              : formatNumber(
                                                                                                  functions.mediadisplaypost(
                                                                                                      getJsonField(
                                                                                                        (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                                        r'''$''',
                                                                                                        true,
                                                                                                      ),
                                                                                                      'views',
                                                                                                      FFAppState().DataInicioMes!,
                                                                                                      FFAppState().DataFinalMes!,
                                                                                                      _model.selectedtype),
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
                                                                                      ],
                                                                                    ),
                                                                                    Text(
                                                                                      FFLocalizations.of(context).getText(
                                                                                        '5ucc9bar' /* Visualizações */,
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            fontSize: 18.0,
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
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    _model.dropDownValue1 == 'Soma'
                                                                                        ? formatNumber(
                                                                                            functions.somadisplaypost(
                                                                                                getJsonField(
                                                                                                  (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'like_count',
                                                                                                FFAppState().DataInicioMes!,
                                                                                                FFAppState().DataFinalMes!,
                                                                                                _model.selectedtype),
                                                                                            formatType: FormatType.compact,
                                                                                          )
                                                                                        : formatNumber(
                                                                                            functions.mediadisplaypost(
                                                                                                getJsonField(
                                                                                                  (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'like_count',
                                                                                                FFAppState().DataInicioMes!,
                                                                                                FFAppState().DataFinalMes!,
                                                                                                _model.selectedtype),
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
                                                                                ],
                                                                              ),
                                                                              Text(
                                                                                FFLocalizations.of(context).getText(
                                                                                  'w9yvyul7' /* Likes */,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      fontSize: 18.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                    ),
                                                                              ),
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
                                                                                          _model.dropDownValue1 == 'Soma'
                                                                                              ? formatNumber(
                                                                                                  functions.somadisplaypost(
                                                                                                      getJsonField(
                                                                                                        (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                                        r'''$''',
                                                                                                        true,
                                                                                                      ),
                                                                                                      'comments_count',
                                                                                                      FFAppState().DataInicioMes!,
                                                                                                      FFAppState().DataFinalMes!,
                                                                                                      _model.selectedtype),
                                                                                                  formatType: FormatType.compact,
                                                                                                )
                                                                                              : formatNumber(
                                                                                                  functions.mediadisplaypost(
                                                                                                      getJsonField(
                                                                                                        (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                                        r'''$''',
                                                                                                        true,
                                                                                                      ),
                                                                                                      'comments_count',
                                                                                                      FFAppState().DataInicioMes!,
                                                                                                      FFAppState().DataFinalMes!,
                                                                                                      _model.selectedtype),
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
                                                                                      ],
                                                                                    ),
                                                                                    Text(
                                                                                      FFLocalizations.of(context).getText(
                                                                                        '6a2iqcat' /* Comentários */,
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            fontSize: 18.0,
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
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                _model.dropDownValue1 == 'Soma'
                                                                                    ? formatNumber(
                                                                                        functions.somadisplaypost(
                                                                                            getJsonField(
                                                                                              (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                              r'''$''',
                                                                                              true,
                                                                                            ),
                                                                                            'shares',
                                                                                            FFAppState().DataInicioMes!,
                                                                                            FFAppState().DataFinalMes!,
                                                                                            _model.selectedtype),
                                                                                        formatType: FormatType.compact,
                                                                                      )
                                                                                    : formatNumber(
                                                                                        functions.mediadisplaypost(
                                                                                            getJsonField(
                                                                                              (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                              r'''$''',
                                                                                              true,
                                                                                            ),
                                                                                            'shares',
                                                                                            FFAppState().DataInicioMes!,
                                                                                            FFAppState().DataFinalMes!,
                                                                                            _model.selectedtype),
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
                                                                            ],
                                                                          ),
                                                                          Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'qh644ymn' /* Compartilhamentos */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  fontSize: 18.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
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
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    _model.dropDownValue1 == 'Soma'
                                                                                        ? formatNumber(
                                                                                            functions.somadisplaypost(
                                                                                                getJsonField(
                                                                                                  (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'total_interactions',
                                                                                                FFAppState().DataInicioMes!,
                                                                                                FFAppState().DataFinalMes!,
                                                                                                _model.selectedtype),
                                                                                            formatType: FormatType.compact,
                                                                                          )
                                                                                        : formatNumber(
                                                                                            functions.mediadisplaypost(
                                                                                                getJsonField(
                                                                                                  (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                                  r'''$''',
                                                                                                  true,
                                                                                                ),
                                                                                                'total_interactions',
                                                                                                FFAppState().DataInicioMes!,
                                                                                                FFAppState().DataFinalMes!,
                                                                                                _model.selectedtype),
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
                                                                                ],
                                                                              ),
                                                                              Text(
                                                                                FFLocalizations.of(context).getText(
                                                                                  'n4andnor' /* Engajamento */,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      fontSize: 18.0,
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
                                                                      height:
                                                                          10.0)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 20.0)),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.48,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Material(
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 2.0,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      0.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      16.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      16.0),
                                                            ),
                                                          ),
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                1.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        0.0),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        16.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        16.0),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          20.0,
                                                                          20.0,
                                                                          10.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
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
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'gmitjia9' /* Melhores Posts */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .override(
                                                                              font: GoogleFonts.oswald(
                                                                                fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              fontSize: 22.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child: FlutterFlowDropDown<
                                                                            String>(
                                                                          controller: _model.dropDownValueController2 ??=
                                                                              FormFieldController<String>(
                                                                            _model.dropDownValue2 ??=
                                                                                'reach',
                                                                          ),
                                                                          options:
                                                                              List<String>.from([
                                                                            'reach',
                                                                            'views',
                                                                            'like_count',
                                                                            'comments_count',
                                                                            'total_interactions',
                                                                            'shares'
                                                                          ]),
                                                                          optionLabels: [
                                                                            FFLocalizations.of(context).getText(
                                                                              '1hcmxp73' /* Alcance */,
                                                                            ),
                                                                            FFLocalizations.of(context).getText(
                                                                              '36ff4mlr' /* Impressões */,
                                                                            ),
                                                                            FFLocalizations.of(context).getText(
                                                                              'gjlmy2ig' /* Likes */,
                                                                            ),
                                                                            FFLocalizations.of(context).getText(
                                                                              'ud9hlvsv' /* Visualizações */,
                                                                            ),
                                                                            FFLocalizations.of(context).getText(
                                                                              'wuwb3zbw' /* Engajamento */,
                                                                            ),
                                                                            FFLocalizations.of(context).getText(
                                                                              'z2hzkmj7' /* Compartilhamentos */,
                                                                            )
                                                                          ],
                                                                          onChanged: (val) =>
                                                                              safeSetState(() => _model.dropDownValue2 = val),
                                                                          width:
                                                                              150.0,
                                                                          height:
                                                                              30.0,
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 18.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                          icon:
                                                                              Icon(
                                                                            Icons.keyboard_arrow_down_rounded,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                          fillColor:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          elevation:
                                                                              2.0,
                                                                          borderColor:
                                                                              Colors.transparent,
                                                                          borderWidth:
                                                                              0.0,
                                                                          borderRadius:
                                                                              8.0,
                                                                          margin: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          hidesUnderline:
                                                                              true,
                                                                          isOverButton:
                                                                              false,
                                                                          isSearchable:
                                                                              false,
                                                                          isMultiSelect:
                                                                              false,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    height:
                                                                        10.0)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.48,
                                                          height: 630.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Builder(
                                                            builder: (context) {
                                                              final listaposts = functions
                                                                      .listaposts(
                                                                          getJsonField(
                                                                            (_model.dadospostbackend?.jsonBody ??
                                                                                ''),
                                                                            r'''$''',
                                                                            true,
                                                                          )!,
                                                                          FFAppState().DataInicioMes!,
                                                                          FFAppState().DataFinalMes!,
                                                                          _model.dropDownValue2)
                                                                      ?.toList() ??
                                                                  [];

                                                              return Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 780.0,
                                                                child: Stack(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0),
                                                                      child: PageView
                                                                          .builder(
                                                                        controller:
                                                                            _model.pageViewController1 ??=
                                                                                PageController(initialPage: max(0, min(0, listaposts.length - 1))),
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        itemCount:
                                                                            listaposts.length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                listapostsIndex) {
                                                                          final listapostsItem =
                                                                              listaposts[listapostsIndex];
                                                                          return Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Material(
                                                                                color: Colors.transparent,
                                                                                elevation: 2.0,
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.only(
                                                                                    bottomLeft: Radius.circular(16.0),
                                                                                    bottomRight: Radius.circular(16.0),
                                                                                    topLeft: Radius.circular(0.0),
                                                                                    topRight: Radius.circular(0.0),
                                                                                  ),
                                                                                ),
                                                                                child: Container(
                                                                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                  height: 600.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                    borderRadius: BorderRadius.only(
                                                                                      bottomLeft: Radius.circular(16.0),
                                                                                      bottomRight: Radius.circular(16.0),
                                                                                      topLeft: Radius.circular(0.0),
                                                                                      topRight: Radius.circular(0.0),
                                                                                    ),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Flexible(
                                                                                              child: Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  FlutterFlowMediaDisplay(
                                                                                                    path: getJsonField(
                                                                                                      listapostsItem,
                                                                                                      r'''$.media_url''',
                                                                                                    ).toString(),
                                                                                                    imageBuilder: (path) => ClipRRect(
                                                                                                      borderRadius: BorderRadius.circular(0.0),
                                                                                                      child: Image.network(
                                                                                                        path,
                                                                                                        width: 360.0,
                                                                                                        height: 450.0,
                                                                                                        fit: BoxFit.fitWidth,
                                                                                                      ),
                                                                                                    ),
                                                                                                    videoPlayerBuilder: (path) => FlutterFlowVideoPlayer(
                                                                                                      path: path,
                                                                                                      width: 360.0,
                                                                                                      height: 450.0,
                                                                                                      autoPlay: false,
                                                                                                      looping: true,
                                                                                                      showControls: true,
                                                                                                      allowFullScreen: true,
                                                                                                      allowPlaybackSpeedMenu: false,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                                                                                                      child: Text(
                                                                                                        getJsonField(
                                                                                                          listapostsItem,
                                                                                                          r'''$.caption''',
                                                                                                        ).toString().maybeHandleOverflow(
                                                                                                              maxChars: 130,
                                                                                                              replacement: '…',
                                                                                                            ),
                                                                                                        maxLines: 3,
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
                                                                                                    ),
                                                                                                  ),
                                                                                                ].divide(SizedBox(height: 10.0)),
                                                                                              ),
                                                                                            ),
                                                                                            Flexible(
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 20.0),
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                                                                getJsonField(
                                                                                                                  listapostsItem,
                                                                                                                  r'''$.reach''',
                                                                                                                ).toString(),
                                                                                                                style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                                                      font: GoogleFonts.oswald(
                                                                                                                        fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                                      ),
                                                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                                                      fontSize: 24.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                          Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              '4ce5wr7i' /* Alcance */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                                  font: GoogleFonts.inter(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                  fontSize: 18.0,
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
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Row(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                            children: [
                                                                                                              Text(
                                                                                                                getJsonField(
                                                                                                                  listapostsItem,
                                                                                                                  r'''$.views''',
                                                                                                                ).toString(),
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
                                                                                                            ],
                                                                                                          ),
                                                                                                          Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              'dguk6cjr' /* Visualizações */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                                  font: GoogleFonts.inter(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                  fontSize: 18.0,
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
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Row(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                            children: [
                                                                                                              Text(
                                                                                                                getJsonField(
                                                                                                                  listapostsItem,
                                                                                                                  r'''$.like_count''',
                                                                                                                ).toString(),
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
                                                                                                            ],
                                                                                                          ),
                                                                                                          Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              'rpln9sz9' /* Likes */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                                  font: GoogleFonts.inter(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                  fontSize: 18.0,
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
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Row(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                            children: [
                                                                                                              Text(
                                                                                                                getJsonField(
                                                                                                                  listapostsItem,
                                                                                                                  r'''$.comments_count''',
                                                                                                                ).toString(),
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
                                                                                                            ],
                                                                                                          ),
                                                                                                          Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              '37ku9vxg' /* Comentários */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                                  font: GoogleFonts.inter(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                  fontSize: 18.0,
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
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Row(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                            children: [
                                                                                                              Text(
                                                                                                                getJsonField(
                                                                                                                  listapostsItem,
                                                                                                                  r'''$.total_interactions''',
                                                                                                                ).toString(),
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
                                                                                                            ],
                                                                                                          ),
                                                                                                          Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              '9gy4lw0m' /* Engajamento */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                                  font: GoogleFonts.inter(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                  fontSize: 18.0,
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
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Row(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                            children: [
                                                                                                              Text(
                                                                                                                getJsonField(
                                                                                                                  listapostsItem,
                                                                                                                  r'''$.shares''',
                                                                                                                ).toString(),
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
                                                                                                            ],
                                                                                                          ),
                                                                                                          Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              '88nw3uhj' /* Compartilhamentos */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                                  font: GoogleFonts.inter(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                  fontSize: 18.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ].divide(SizedBox(height: 20.0)),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                _model.comentario = true;
                                                                                                _model.id = getJsonField(
                                                                                                  listapostsItem,
                                                                                                  r'''$.post_id''',
                                                                                                ).toString();
                                                                                                safeSetState(() {});
                                                                                                safeSetState(() => _model.apiRequestCompleter2 = null);
                                                                                                await _model.waitForApiRequestCompleted2();
                                                                                              },
                                                                                              child: Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'gtr84w2f' /* Ver todos os comentários */,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.inter(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                      fontSize: 18.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                            Align(
                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                              child: Text(
                                                                                                getJsonField(
                                                                                                  listapostsItem,
                                                                                                  r'''$.post_timestamp''',
                                                                                                ).toString(),
                                                                                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                      font: GoogleFonts.inter(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                      ),
                                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                      fontSize: 18.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ].divide(SizedBox(height: 10.0)),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            5.0),
                                                                        child: smooth_page_indicator
                                                                            .SmoothPageIndicator(
                                                                          controller: _model.pageViewController1 ??=
                                                                              PageController(initialPage: max(0, min(0, listaposts.length - 1))),
                                                                          count:
                                                                              listaposts.length,
                                                                          axisDirection:
                                                                              Axis.horizontal,
                                                                          onDotClicked:
                                                                              (i) async {
                                                                            await _model.pageViewController1!.animateToPage(
                                                                              i,
                                                                              duration: Duration(milliseconds: 500),
                                                                              curve: Curves.ease,
                                                                            );
                                                                            safeSetState(() {});
                                                                          },
                                                                          effect:
                                                                              smooth_page_indicator.SlideEffect(
                                                                            spacing:
                                                                                8.0,
                                                                            radius:
                                                                                8.0,
                                                                            dotWidth:
                                                                                8.0,
                                                                            dotHeight:
                                                                                8.0,
                                                                            dotColor:
                                                                                FlutterFlowTheme.of(context).accent1,
                                                                            activeDotColor:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            paintStyle:
                                                                                PaintingStyle.fill,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 10.0)),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 20.0)),
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
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                1.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(32.0),
                                                topRight: Radius.circular(32.0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      22.0, 24.0, 22.0, 24.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'in3xz1df' /* Conecte sua conta */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineSmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .oswald(
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
                                                              Color(0xFF14181C),
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
                                                      'cpanorug' /* Para adicionar uma conta do In... */,
                                                    ),
                                                    textAlign: TextAlign.center,
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
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
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
                                                                    24.0,
                                                                    24.0,
                                                                    24.0,
                                                                    24.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'abfwkq7g' /* Ao conectar sua conta do Faceb... */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyLarge
                                                                  .override(
                                                                    font: GoogleFonts
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
                                                                  MainAxisSize
                                                                      .max,
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
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        '351ewjfh' /* insights da página e posts */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          12.0)),
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
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'zbk9pso1' /* comentários */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          12.0)),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height:
                                                                      16.0)),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 24.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      _model.authCodepc =
                                                          await actions
                                                              .loginWithFacebook();

                                                      safeSetState(() {});
                                                    },
                                                    text: FFLocalizations.of(
                                                            context)
                                                        .getText(
                                                      'usavjxcc' /* Conectar Conta */,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      height: 48.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      textStyle:
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
                                                                color: Colors
                                                                    .white,
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
                                                      elevation: 3.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              28.0),
                                                    ),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 24.0)),
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
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            height: 100.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(32.0),
                                                topRight: Radius.circular(32.0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      22.0, 24.0, 22.0, 24.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '7la3i16q' /* Aguarde a conexão da sua conta */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineSmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .oswald(
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
                                                              Color(0xFF14181C),
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
                                                      '1pdyn1co' /* Entre em contato com a equipe ... */,
                                                    ),
                                                    textAlign: TextAlign.center,
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
                                                    text: FFLocalizations.of(
                                                            context)
                                                        .getText(
                                                      'l10nduyo' /* Contatar Equipe */,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      height: 48.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      textStyle:
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
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
                                                      elevation: 3.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              28.0),
                                                    ),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 24.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (_model.comentario)
                                Align(
                                  alignment: AlignmentDirectional(0.0, 1.0),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.6,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 16.0, 8.0, 16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AuthUserStreamWidget(
                                            builder: (context) =>
                                                FutureBuilder<ApiCallResponse>(
                                              future:
                                                  (_model.apiRequestCompleter2 ??=
                                                          Completer<
                                                              ApiCallResponse>()
                                                            ..complete(
                                                                DadosPostsCall
                                                                    .call(
                                                              filterColumn:
                                                                  'post_id',
                                                              filterValue:
                                                                  _model.id,
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
                                                            )))
                                                      .future,
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
                                                final columnDadosPostsResponse =
                                                    snapshot.data!;

                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, 0.0),
                                                      child:
                                                          FlutterFlowIconButton(
                                                        borderRadius: 8.0,
                                                        buttonSize: 50.0,
                                                        fillColor:
                                                            Color(0x00141414),
                                                        icon: Icon(
                                                          Icons.close_sharp,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 28.0,
                                                        ),
                                                        onPressed: () async {
                                                          _model.comentario =
                                                              false;
                                                          safeSetState(() {});
                                                        },
                                                      ),
                                                    ),
                                                    SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          if (getJsonField(
                                                                columnDadosPostsResponse
                                                                    .jsonBody,
                                                                r'''$.comentarios''',
                                                              ) !=
                                                              null)
                                                            Builder(
                                                              builder:
                                                                  (context) {
                                                                final comentarios =
                                                                    getJsonField(
                                                                  DadosPostsCall
                                                                      .post(
                                                                    columnDadosPostsResponse
                                                                        .jsonBody,
                                                                  )?.firstOrNull,
                                                                  r'''$.comments''',
                                                                ).toList();

                                                                return ListView
                                                                    .separated(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  itemCount:
                                                                      comentarios
                                                                          .length,
                                                                  separatorBuilder: (_,
                                                                          __) =>
                                                                      SizedBox(
                                                                          height:
                                                                              10.0),
                                                                  itemBuilder:
                                                                      (context,
                                                                          comentariosIndex) {
                                                                    final comentariosItem =
                                                                        comentarios[
                                                                            comentariosIndex];
                                                                    return Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                      child:
                                                                          RichText(
                                                                        textScaler:
                                                                            MediaQuery.of(context).textScaler,
                                                                        text:
                                                                            TextSpan(
                                                                          children: [
                                                                            TextSpan(
                                                                              text: getJsonField(
                                                                                comentariosItem,
                                                                                r'''$.comentario''',
                                                                              ).toString(),
                                                                              style: TextStyle(),
                                                                            )
                                                                          ],
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
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
                      tabletLandscape: false,
                      desktop: false,
                    ))
                      Flexible(
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if ((_model.temconta == true) &&
                                        _model.loaded)
                                      Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 280.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 24.0, 24.0, 24.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FutureBuilder<ApiCallResponse>(
                                                future: CronogramaCall.call(
                                                  filterColumn: 'cliente',
                                                  filterValue: _model.nomeconta,
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
                                                  final rowCronogramaResponse =
                                                      snapshot.data!;

                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      FlutterFlowIconButton(
                                                        borderRadius: 8.0,
                                                        buttonSize: 50.0,
                                                        fillColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryBackground,
                                                        icon: Icon(
                                                          Icons.menu,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 30.0,
                                                        ),
                                                        onPressed: () async {
                                                          scaffoldKey
                                                              .currentState!
                                                              .openDrawer();
                                                        },
                                                      ),
                                                      if (!functions.vernullcom(
                                                          getJsonField(
                                                        rowCronogramaResponse
                                                            .jsonBody,
                                                        r'''$''',
                                                      ))!)
                                                        FlutterFlowIconButton(
                                                          borderRadius: 8.0,
                                                          buttonSize: 50.0,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          icon: Icon(
                                                            Icons
                                                                .schedule_sharp,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 30.0,
                                                          ),
                                                          onPressed: () async {
                                                            context.pushNamed(
                                                                CronogramaWidget
                                                                    .routeName);
                                                          },
                                                        ),
                                                    ],
                                                  );
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
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40.0),
                                                    ),
                                                    child: Container(
                                                      width: 80.0,
                                                      height: 80.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40.0),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40.0),
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
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
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
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .oswald(
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
                                                                fontSize: 24.0,
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
                                                                    maxChars:
                                                                        120,
                                                                    replacement:
                                                                        '…',
                                                                  ),
                                                          maxLines: 3,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyLarge
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .oswald(
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
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'uttvej0a' /* Seguidores */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
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
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .oswald(
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
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'lj8zol65' /* Posts */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
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
                                                    ],
                                                  ),
                                                  if (_model.contaselecionada
                                                          ?.plataforma ==
                                                      'instagram')
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
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
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .oswald(
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
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'qjoeqmij' /* Seguindo */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
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
                                        width:
                                            MediaQuery.sizeOf(context).width *
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  22.0, 24.0, 22.0, 24.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'dch5jz1b' /* Resultados da página */,
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
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
                                              Material(
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
                                                                  0.0, 0.0),
                                                          child: Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              '2lt1jgvf' /* Seleção de período */,
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
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              disabledColor: Colors
                                                                  .transparent,
                                                              disabledIconColor:
                                                                  Colors
                                                                      .transparent,
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_back_ios_sharp,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 25.0,
                                                              ),
                                                              onPressed: !functions
                                                                      .bolrecuopost(
                                                                          getJsonField(
                                                                            (_model.dadospostbackend?.jsonBody ??
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
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              )} - ${dateTimeFormat(
                                                                "d/M",
                                                                FFAppState()
                                                                    .DataFinalMes,
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              )}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    font: GoogleFonts
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
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              disabledColor: Colors
                                                                  .transparent,
                                                              disabledIconColor:
                                                                  Colors
                                                                      .transparent,
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_forward_ios_sharp,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 25.0,
                                                              ),
                                                              onPressed: !functions
                                                                      .bolavancopost(
                                                                          getJsonField(
                                                                            (_model.dadospostbackend?.jsonBody ??
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
                                                                          FFAppState().DataInicioMes =
                                                                              functions.aumentardatainicio(FFAppState().DataInicioMes);
                                                                          FFAppState().DataInicioMesAnterior =
                                                                              functions.aumentardatainicio(FFAppState().DataInicioMesAnterior);
                                                                          safeSetState(
                                                                              () {});
                                                                        }),
                                                                        Future(
                                                                            () async {
                                                                          FFAppState().DataFinalMes =
                                                                              functions.aumentardatafinal(FFAppState().DataFinalMes);
                                                                          FFAppState().DataFinalMesAnterior =
                                                                              functions.aumentardatafinal(FFAppState().DataFinalMesAnterior);
                                                                          safeSetState(
                                                                              () {});
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
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Material(
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
                                                                    'ciq919d7' /* Dados descritivos */,
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
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child:
                                                                      FlutterFlowDropDown<
                                                                          String>(
                                                                    controller: _model
                                                                            .dropDownValueController3 ??=
                                                                        FormFieldController<
                                                                            String>(
                                                                      _model.dropDownValue3 ??=
                                                                          'Media',
                                                                    ),
                                                                    options: List<
                                                                        String>.from([
                                                                      'Media',
                                                                      'Soma'
                                                                    ]),
                                                                    optionLabels: [
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'svauu0pp' /* Média */,
                                                                      ),
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        '84bpbsl2' /* Soma */,
                                                                      )
                                                                    ],
                                                                    onChanged: (val) =>
                                                                        safeSetState(() =>
                                                                            _model.dropDownValue3 =
                                                                                val),
                                                                    width:
                                                                        100.0,
                                                                    height:
                                                                        30.0,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    icon: Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down_rounded,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    elevation:
                                                                        2.0,
                                                                    borderColor:
                                                                        Colors
                                                                            .transparent,
                                                                    borderWidth:
                                                                        0.0,
                                                                    borderRadius:
                                                                        8.0,
                                                                    margin: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    hidesUnderline:
                                                                        true,
                                                                    isOverButton:
                                                                        false,
                                                                    isSearchable:
                                                                        false,
                                                                    isMultiSelect:
                                                                        false,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Flexible(
                                                                    child:
                                                                        FFButtonWidget(
                                                                      onPressed:
                                                                          () async {
                                                                        _model.selectedtype =
                                                                            'IMAGE';
                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      text: FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        '71cs9v4f' /* Imagem */,
                                                                      ),
                                                                      options:
                                                                          FFButtonOptions(
                                                                        width:
                                                                            200.0,
                                                                        height:
                                                                            30.0,
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                        iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        color: _model.selectedtype ==
                                                                                'IMAGE'
                                                                            ? FlutterFlowTheme.of(context).primary
                                                                            : FlutterFlowTheme.of(context).primaryBackground,
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              font: GoogleFonts.oswald(
                                                                                fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                              color: _model.selectedtype == 'IMAGE' ? FlutterFlowTheme.of(context).primaryBackground : FlutterFlowTheme.of(context).primary,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                            ),
                                                                        elevation:
                                                                            0.0,
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          width:
                                                                              2.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(40.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child:
                                                                        FFButtonWidget(
                                                                      onPressed:
                                                                          () async {
                                                                        _model.selectedtype =
                                                                            'CAROUSEL_ALBUM';
                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      text: FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'u3j3gwue' /* Carrossel */,
                                                                      ),
                                                                      options:
                                                                          FFButtonOptions(
                                                                        width:
                                                                            200.0,
                                                                        height:
                                                                            30.0,
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                        iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        color: _model.selectedtype ==
                                                                                'CAROUSEL_ALBUM'
                                                                            ? FlutterFlowTheme.of(context).primary
                                                                            : FlutterFlowTheme.of(context).primaryBackground,
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              font: GoogleFonts.oswald(
                                                                                fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                              color: _model.selectedtype == 'CAROUSEL_ALBUM' ? FlutterFlowTheme.of(context).primaryBackground : FlutterFlowTheme.of(context).primary,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                            ),
                                                                        elevation:
                                                                            0.0,
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          width:
                                                                              2.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(40.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child:
                                                                        FFButtonWidget(
                                                                      onPressed:
                                                                          () async {
                                                                        _model.selectedtype =
                                                                            'VIDEO';
                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      text: FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'b6d335im' /* Vídeo */,
                                                                      ),
                                                                      options:
                                                                          FFButtonOptions(
                                                                        width:
                                                                            200.0,
                                                                        height:
                                                                            30.0,
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                        iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        color: _model.selectedtype ==
                                                                                'VIDEO'
                                                                            ? FlutterFlowTheme.of(context).primary
                                                                            : FlutterFlowTheme.of(context).primaryBackground,
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              font: GoogleFonts.oswald(
                                                                                fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                              color: _model.selectedtype == 'VIDEO' ? FlutterFlowTheme.of(context).primaryBackground : FlutterFlowTheme.of(context).primary,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                            ),
                                                                        elevation:
                                                                            0.0,
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          width:
                                                                              2.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(40.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        5.0)),
                                                              ),
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
                                                                            _model.dropDownValue3 == 'Soma'
                                                                                ? formatNumber(
                                                                                    functions.somadisplaypost(
                                                                                        getJsonField(
                                                                                          (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                          r'''$''',
                                                                                          true,
                                                                                        ),
                                                                                        'reach',
                                                                                        FFAppState().DataInicioMes!,
                                                                                        FFAppState().DataFinalMes!,
                                                                                        _model.selectedtype),
                                                                                    formatType: FormatType.compact,
                                                                                  )
                                                                                : formatNumber(
                                                                                    functions.mediadisplaypost(
                                                                                        getJsonField(
                                                                                          (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                          r'''$''',
                                                                                          true,
                                                                                        ),
                                                                                        'reach',
                                                                                        FFAppState().DataInicioMes!,
                                                                                        FFAppState().DataFinalMes!,
                                                                                        _model.selectedtype),
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
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '6wm47bfe' /* Alcance */,
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
                                                                            _model.dropDownValue3 == 'Soma'
                                                                                ? formatNumber(
                                                                                    functions.somadisplaypost(
                                                                                        getJsonField(
                                                                                          (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                          r'''$''',
                                                                                          true,
                                                                                        ),
                                                                                        'views',
                                                                                        FFAppState().DataInicioMes!,
                                                                                        FFAppState().DataFinalMes!,
                                                                                        _model.selectedtype),
                                                                                    formatType: FormatType.compact,
                                                                                  )
                                                                                : formatNumber(
                                                                                    functions.mediadisplaypost(
                                                                                        getJsonField(
                                                                                          (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                          r'''$''',
                                                                                          true,
                                                                                        ),
                                                                                        'views',
                                                                                        FFAppState().DataInicioMes!,
                                                                                        FFAppState().DataFinalMes!,
                                                                                        _model.selectedtype),
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
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'rp1j4gvy' /* Visualizações */,
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
                                                                            _model.dropDownValue3 == 'Soma'
                                                                                ? formatNumber(
                                                                                    functions.somadisplaypost(
                                                                                        getJsonField(
                                                                                          (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                          r'''$''',
                                                                                          true,
                                                                                        ),
                                                                                        'like_count',
                                                                                        FFAppState().DataInicioMes!,
                                                                                        FFAppState().DataFinalMes!,
                                                                                        _model.selectedtype),
                                                                                    formatType: FormatType.compact,
                                                                                  )
                                                                                : formatNumber(
                                                                                    functions.mediadisplaypost(
                                                                                        getJsonField(
                                                                                          (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                          r'''$''',
                                                                                          true,
                                                                                        ),
                                                                                        'like_count',
                                                                                        FFAppState().DataInicioMes!,
                                                                                        FFAppState().DataFinalMes!,
                                                                                        _model.selectedtype),
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
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'kht8vyxd' /* Likes */,
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
                                                                            _model.dropDownValue3 == 'Soma'
                                                                                ? formatNumber(
                                                                                    functions.somadisplaypost(
                                                                                        getJsonField(
                                                                                          (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                          r'''$''',
                                                                                          true,
                                                                                        ),
                                                                                        'comments_count',
                                                                                        FFAppState().DataInicioMes!,
                                                                                        FFAppState().DataFinalMes!,
                                                                                        _model.selectedtype),
                                                                                    formatType: FormatType.compact,
                                                                                  )
                                                                                : formatNumber(
                                                                                    functions.mediadisplaypost(
                                                                                        getJsonField(
                                                                                          (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                          r'''$''',
                                                                                          true,
                                                                                        ),
                                                                                        'comments_count',
                                                                                        FFAppState().DataInicioMes!,
                                                                                        FFAppState().DataFinalMes!,
                                                                                        _model.selectedtype),
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
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '87cheee8' /* Comentários */,
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
                                                                            _model.dropDownValue3 == 'Soma'
                                                                                ? formatNumber(
                                                                                    functions.somadisplaypost(
                                                                                        getJsonField(
                                                                                          (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                          r'''$''',
                                                                                          true,
                                                                                        ),
                                                                                        'total_interactions',
                                                                                        FFAppState().DataInicioMes!,
                                                                                        FFAppState().DataFinalMes!,
                                                                                        _model.selectedtype),
                                                                                    formatType: FormatType.compact,
                                                                                  )
                                                                                : formatNumber(
                                                                                    functions.mediadisplaypost(
                                                                                        getJsonField(
                                                                                          (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                          r'''$''',
                                                                                          true,
                                                                                        ),
                                                                                        'total_interactions',
                                                                                        FFAppState().DataInicioMes!,
                                                                                        FFAppState().DataFinalMes!,
                                                                                        _model.selectedtype),
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
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '5gwlo8zm' /* Engajamento */,
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
                                                                            _model.dropDownValue3 == 'Soma'
                                                                                ? formatNumber(
                                                                                    functions.somadisplaypost(
                                                                                        getJsonField(
                                                                                          (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                          r'''$''',
                                                                                          true,
                                                                                        ),
                                                                                        'shares',
                                                                                        FFAppState().DataInicioMes!,
                                                                                        FFAppState().DataFinalMes!,
                                                                                        _model.selectedtype),
                                                                                    formatType: FormatType.compact,
                                                                                  )
                                                                                : formatNumber(
                                                                                    functions.mediadisplaypost(
                                                                                        getJsonField(
                                                                                          (_model.dadospostbackend?.jsonBody ?? ''),
                                                                                          r'''$''',
                                                                                          true,
                                                                                        ),
                                                                                        'shares',
                                                                                        FFAppState().DataInicioMes!,
                                                                                        FFAppState().DataFinalMes!,
                                                                                        _model.selectedtype),
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
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'exxd8paz' /* Compartilhamentos */,
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
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Material(
                                                      color: Colors.transparent,
                                                      elevation: 2.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  0.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  0.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  16.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  16.0),
                                                        ),
                                                      ),
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    16.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    16.0),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      20.0,
                                                                      20.0,
                                                                      20.0,
                                                                      10.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
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
                                                                      'v0qwdghp' /* Melhores Posts */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.oswald(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
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
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child: FlutterFlowDropDown<
                                                                        String>(
                                                                      controller: _model
                                                                              .dropDownValueController4 ??=
                                                                          FormFieldController<
                                                                              String>(
                                                                        _model.dropDownValue4 ??=
                                                                            'reach',
                                                                      ),
                                                                      options: List<
                                                                          String>.from([
                                                                        'reach',
                                                                        'views',
                                                                        'like_count',
                                                                        'comments_count',
                                                                        'total_interactions',
                                                                        'shares'
                                                                      ]),
                                                                      optionLabels: [
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '1mp2smxv' /* Alcance */,
                                                                        ),
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'w3pioped' /* Impressões */,
                                                                        ),
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'ialu6u76' /* Likes */,
                                                                        ),
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'cs7xjay1' /* Visualizações */,
                                                                        ),
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'ze8jpdvq' /* Engajamento */,
                                                                        ),
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'chjpsd6r' /* Compartilhamentos */,
                                                                        )
                                                                      ],
                                                                      onChanged:
                                                                          (val) =>
                                                                              safeSetState(() => _model.dropDownValue4 = val),
                                                                      width:
                                                                          150.0,
                                                                      height:
                                                                          30.0,
                                                                      textStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .keyboard_arrow_down_rounded,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        size:
                                                                            24.0,
                                                                      ),
                                                                      fillColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primaryBackground,
                                                                      elevation:
                                                                          2.0,
                                                                      borderColor:
                                                                          Colors
                                                                              .transparent,
                                                                      borderWidth:
                                                                          0.0,
                                                                      borderRadius:
                                                                          8.0,
                                                                      margin: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      hidesUnderline:
                                                                          true,
                                                                      isOverButton:
                                                                          false,
                                                                      isSearchable:
                                                                          false,
                                                                      isMultiSelect:
                                                                          false,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 10.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 780.0,
                                                      child: Builder(
                                                        builder: (context) {
                                                          final listaposts = functions
                                                                  .listaposts(
                                                                      getJsonField(
                                                                        (_model.dadospostbackend?.jsonBody ??
                                                                            ''),
                                                                        r'''$''',
                                                                        true,
                                                                      )!,
                                                                      FFAppState().DataInicioMes!,
                                                                      FFAppState().DataFinalMes!,
                                                                      _model.dropDownValue4)
                                                                  ?.toList() ??
                                                              [];

                                                          return Container(
                                                            width:
                                                                double.infinity,
                                                            height: 780.0,
                                                            child: Stack(
                                                              children: [
                                                                PageView
                                                                    .builder(
                                                                  controller: _model
                                                                          .pageViewController2 ??=
                                                                      PageController(
                                                                          initialPage: max(
                                                                              0,
                                                                              min(0, listaposts.length - 1))),
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  itemCount:
                                                                      listaposts
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          listapostsIndex) {
                                                                    final listapostsItem =
                                                                        listaposts[
                                                                            listapostsIndex];
                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Material(
                                                                          color:
                                                                              Colors.transparent,
                                                                          elevation:
                                                                              2.0,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(16.0),
                                                                              bottomRight: Radius.circular(16.0),
                                                                              topLeft: Radius.circular(0.0),
                                                                              topRight: Radius.circular(0.0),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 1.0,
                                                                            height:
                                                                                750.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(16.0),
                                                                                bottomRight: Radius.circular(16.0),
                                                                                topLeft: Radius.circular(0.0),
                                                                                topRight: Radius.circular(0.0),
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    FlutterFlowMediaDisplay(
                                                                                      path: getJsonField(
                                                                                        listapostsItem,
                                                                                        r'''$.media_url''',
                                                                                      ).toString(),
                                                                                      imageBuilder: (path) => ClipRRect(
                                                                                        borderRadius: BorderRadius.circular(0.0),
                                                                                        child: Image.network(
                                                                                          path,
                                                                                          width: MediaQuery.sizeOf(context).width * 3.7,
                                                                                          height: 462.0,
                                                                                          fit: BoxFit.fitWidth,
                                                                                        ),
                                                                                      ),
                                                                                      videoPlayerBuilder: (path) => FlutterFlowVideoPlayer(
                                                                                        path: path,
                                                                                        width: 370.0,
                                                                                        height: 462.0,
                                                                                        autoPlay: false,
                                                                                        looping: true,
                                                                                        showControls: true,
                                                                                        allowFullScreen: true,
                                                                                        allowPlaybackSpeedMenu: false,
                                                                                      ),
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                                                                                        child: Text(
                                                                                          getJsonField(
                                                                                            listapostsItem,
                                                                                            r'''$.caption''',
                                                                                          ).toString().maybeHandleOverflow(
                                                                                                maxChars: 130,
                                                                                                replacement: '…',
                                                                                              ),
                                                                                          maxLines: 3,
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
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
                                                                                      ),
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 10.0)),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(0.0, 1.0),
                                                                                        child: Row(
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
                                                                                                        getJsonField(
                                                                                                          listapostsItem,
                                                                                                          r'''$.reach''',
                                                                                                        ).toString(),
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
                                                                                                    ],
                                                                                                  ),
                                                                                                  Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      '9ytx93a5' /* Alcance */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodySmall.override(
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
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        getJsonField(
                                                                                                          listapostsItem,
                                                                                                          r'''$.views''',
                                                                                                        ).toString(),
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
                                                                                                    ],
                                                                                                  ),
                                                                                                  Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      '414eb5oe' /* Visualizações */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodySmall.override(
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
                                                                                      ),
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(0.0, 1.0),
                                                                                        child: Row(
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
                                                                                                        getJsonField(
                                                                                                          listapostsItem,
                                                                                                          r'''$.like_count''',
                                                                                                        ).toString(),
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
                                                                                                    ],
                                                                                                  ),
                                                                                                  Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      'ghxolcn7' /* Likes */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodySmall.override(
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
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        getJsonField(
                                                                                                          listapostsItem,
                                                                                                          r'''$.comments_count''',
                                                                                                        ).toString(),
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
                                                                                                    ],
                                                                                                  ),
                                                                                                  Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      'c0fc1kp7' /* Comentários */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodySmall.override(
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
                                                                                      ),
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(0.0, 1.0),
                                                                                        child: Row(
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
                                                                                                        getJsonField(
                                                                                                          listapostsItem,
                                                                                                          r'''$.total_interactions''',
                                                                                                        ).toString(),
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
                                                                                                    ],
                                                                                                  ),
                                                                                                  Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      'aghf5k1j' /* Engajamento */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodySmall.override(
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
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        getJsonField(
                                                                                                          listapostsItem,
                                                                                                          r'''$.shares''',
                                                                                                        ).toString(),
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
                                                                                                    ],
                                                                                                  ),
                                                                                                  Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      'oraa9v83' /* Compartilhamentos */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodySmall.override(
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
                                                                                      ),
                                                                                      InkWell(
                                                                                        splashColor: Colors.transparent,
                                                                                        focusColor: Colors.transparent,
                                                                                        hoverColor: Colors.transparent,
                                                                                        highlightColor: Colors.transparent,
                                                                                        onTap: () async {
                                                                                          _model.comentario = true;
                                                                                          _model.id = getJsonField(
                                                                                            listapostsItem,
                                                                                            r'''$.post_id''',
                                                                                          ).toString();
                                                                                          safeSetState(() {});
                                                                                          safeSetState(() => _model.apiRequestCompleter1 = null);
                                                                                          await _model.waitForApiRequestCompleted1();
                                                                                        },
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'l0rckq06' /* Ver todos os comentários */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(0.0, 0.0),
                                                                                        child: Text(
                                                                                          getJsonField(
                                                                                            listapostsItem,
                                                                                            r'''$.post_timestamp''',
                                                                                          ).toString(),
                                                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
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
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 10.0)),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          1.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            5.0),
                                                                    child: smooth_page_indicator
                                                                        .SmoothPageIndicator(
                                                                      controller: _model
                                                                              .pageViewController2 ??=
                                                                          PageController(
                                                                              initialPage: max(0, min(0, listaposts.length - 1))),
                                                                      count: listaposts
                                                                          .length,
                                                                      axisDirection:
                                                                          Axis.horizontal,
                                                                      onDotClicked:
                                                                          (i) async {
                                                                        await _model
                                                                            .pageViewController2!
                                                                            .animateToPage(
                                                                          i,
                                                                          duration:
                                                                              Duration(milliseconds: 500),
                                                                          curve:
                                                                              Curves.ease,
                                                                        );
                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      effect: smooth_page_indicator
                                                                          .SlideEffect(
                                                                        spacing:
                                                                            8.0,
                                                                        radius:
                                                                            8.0,
                                                                        dotWidth:
                                                                            8.0,
                                                                        dotHeight:
                                                                            8.0,
                                                                        dotColor:
                                                                            FlutterFlowTheme.of(context).accent1,
                                                                        activeDotColor:
                                                                            FlutterFlowTheme.of(context).primary,
                                                                        paintStyle:
                                                                            PaintingStyle.fill,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 10.0)),
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
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                1.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(32.0),
                                                topRight: Radius.circular(32.0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      22.0, 24.0, 22.0, 24.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'qh0bwsnn' /* Conecte sua conta */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineSmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .oswald(
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
                                                              Color(0xFF14181C),
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
                                                      '3a9iwk9o' /* Para adicionar uma conta do In... */,
                                                    ),
                                                    textAlign: TextAlign.center,
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
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
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
                                                                    24.0,
                                                                    24.0,
                                                                    24.0,
                                                                    24.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'xk5z6w1i' /* Ao conectar sua conta do Faceb... */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyLarge
                                                                  .override(
                                                                    font: GoogleFonts
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
                                                                  MainAxisSize
                                                                      .max,
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
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        '0q9ctvdi' /* insights da página e posts */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          12.0)),
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
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'mtpdqgbh' /* comentários */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          12.0)),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height:
                                                                      16.0)),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 24.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      _model.authCode =
                                                          await actions
                                                              .loginWithFacebook();

                                                      safeSetState(() {});
                                                    },
                                                    text: FFLocalizations.of(
                                                            context)
                                                        .getText(
                                                      'qjbnq8qj' /* Conectar Conta */,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      height: 48.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      textStyle:
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
                                                                color: Colors
                                                                    .white,
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
                                                      elevation: 3.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              28.0),
                                                    ),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 24.0)),
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
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            height: 100.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(32.0),
                                                topRight: Radius.circular(32.0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      22.0, 24.0, 22.0, 24.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'hfokqzdt' /* Aguarde a conexão da sua conta */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineSmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .oswald(
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
                                                              Color(0xFF14181C),
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
                                                      'scewnpoe' /* Entre em contato com a equipe ... */,
                                                    ),
                                                    textAlign: TextAlign.center,
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
                                                    text: FFLocalizations.of(
                                                            context)
                                                        .getText(
                                                      '3hqmwjeg' /* Contatar Equipe */,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      height: 48.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      textStyle:
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
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
                                                      elevation: 3.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              28.0),
                                                    ),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 24.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (_model.comentario)
                                Align(
                                  alignment: AlignmentDirectional(0.0, 1.0),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.6,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 16.0, 8.0, 16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AuthUserStreamWidget(
                                            builder: (context) =>
                                                FutureBuilder<ApiCallResponse>(
                                              future:
                                                  (_model.apiRequestCompleter1 ??=
                                                          Completer<
                                                              ApiCallResponse>()
                                                            ..complete(
                                                                DadosPostsCall
                                                                    .call(
                                                              filterColumn:
                                                                  'post_id',
                                                              filterValue:
                                                                  _model.id,
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
                                                            )))
                                                      .future,
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
                                                final columnDadosPostsResponse =
                                                    snapshot.data!;

                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, 0.0),
                                                      child:
                                                          FlutterFlowIconButton(
                                                        borderRadius: 8.0,
                                                        buttonSize: 50.0,
                                                        fillColor:
                                                            Color(0x00141414),
                                                        icon: Icon(
                                                          Icons.close_sharp,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 28.0,
                                                        ),
                                                        onPressed: () async {
                                                          _model.comentario =
                                                              false;
                                                          safeSetState(() {});
                                                        },
                                                      ),
                                                    ),
                                                    SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          if (getJsonField(
                                                                columnDadosPostsResponse
                                                                    .jsonBody,
                                                                r'''$.comentarios''',
                                                              ) !=
                                                              null)
                                                            Builder(
                                                              builder:
                                                                  (context) {
                                                                final comentarios =
                                                                    getJsonField(
                                                                  DadosPostsCall
                                                                      .post(
                                                                    columnDadosPostsResponse
                                                                        .jsonBody,
                                                                  )?.firstOrNull,
                                                                  r'''$.comments''',
                                                                ).toList();

                                                                return ListView
                                                                    .separated(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  itemCount:
                                                                      comentarios
                                                                          .length,
                                                                  separatorBuilder: (_,
                                                                          __) =>
                                                                      SizedBox(
                                                                          height:
                                                                              10.0),
                                                                  itemBuilder:
                                                                      (context,
                                                                          comentariosIndex) {
                                                                    final comentariosItem =
                                                                        comentarios[
                                                                            comentariosIndex];
                                                                    return Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                      child:
                                                                          RichText(
                                                                        textScaler:
                                                                            MediaQuery.of(context).textScaler,
                                                                        text:
                                                                            TextSpan(
                                                                          children: [
                                                                            TextSpan(
                                                                              text: getJsonField(
                                                                                comentariosItem,
                                                                                r'''$.comentario''',
                                                                              ).toString(),
                                                                              style: TextStyle(),
                                                                            )
                                                                          ],
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
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
