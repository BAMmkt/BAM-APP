import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/organico/botaocomentario/botaocomentario_widget.dart';
import '/organico/crono/crono_widget.dart';
import '/index.dart';
import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cronograma_model.dart';
export 'cronograma_model.dart';

class CronogramaWidget extends StatefulWidget {
  const CronogramaWidget({super.key});

  static String routeName = 'cronograma';
  static String routePath = '/cronograma';

  @override
  State<CronogramaWidget> createState() => _CronogramaWidgetState();
}

class _CronogramaWidgetState extends State<CronogramaWidget> {
  late CronogramaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CronogramaModel());

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
          _model.master = true;
          safeSetState(() {});
          _model.contamaster = await queryContasRecordOnce(
            queryBuilder: (contasRecord) => contasRecord
                .where(
                  'idconta',
                  isEqualTo: valueOrDefault(
                      currentUserDocument?.idcontaselecionada, ''),
                )
                .where(
                  'userid',
                  isEqualTo:
                      valueOrDefault<bool>(currentUserDocument?.admin, false)
                          ? currentUserUid
                          : valueOrDefault(currentUserDocument?.lenderId, ''),
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
              _model.nomecliente = _model.loopconta!.nome;
              _model.idconta = _model.loopconta!.idconta;
              _model.idref = _model.loopconta?.reference;
              safeSetState(() {});
            }
          }
        }
        _model.contaselecionada = await queryContasRecordOnce(
          queryBuilder: (contasRecord) => contasRecord.where(
            'idconta',
            isEqualTo: valueOrDefault(currentUserDocument?.type, '') == 'master'
                ? _model.idconta
                : valueOrDefault(currentUserDocument?.idcontaselecionada, ''),
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        if (!(valueOrDefault(currentUserDocument?.nomecontaselecionada, '') !=
                '')) {
          context.goNamed(HomeWidget.routeName);
        }
        if ('instagram' == _model.contaselecionada?.plataforma ? true : false) {
          _model.dadosatuaisinsta = await DadosAtuaisInstaCall.call(
            accountId: valueOrDefault(currentUserDocument?.type, '') == 'master'
                ? _model.idconta
                : valueOrDefault(currentUserDocument?.idcontaselecionada, ''),
          );

          if ((_model.dadosatuaisinsta?.succeeded ?? true)) {
            if (_model.master) {
              if (_model.nomecliente ==
                  getJsonField(
                    (_model.dadosatuaisinsta?.jsonBody ?? ''),
                    r'''$.username''',
                  ).toString()) {
                _model.name = _model.nomecliente;
                safeSetState(() {});
              } else {
                await _model.idref!.update(createContasRecordData(
                  nome: getJsonField(
                    (_model.dadosatuaisinsta?.jsonBody ?? ''),
                    r'''$.username''',
                  ).toString(),
                ));
              }
            } else {
              if (_model.contaselecionada?.nome ==
                  getJsonField(
                    (_model.dadosatuaisinsta?.jsonBody ?? ''),
                    r'''$.username''',
                  ).toString()) {
                _model.name = _model.contaselecionada?.nome;
                safeSetState(() {});
              } else {
                await _model.contaselecionada!.reference
                    .update(createContasRecordData(
                  nome: getJsonField(
                    (_model.dadosatuaisinsta?.jsonBody ?? ''),
                    r'''$.username''',
                  ).toString(),
                ));
              }
            }
          }
        } else {
          _model.dadosatuaisface = await DadosAtuaisInstaCall.call(
            accountId: valueOrDefault(currentUserDocument?.type, '') == 'master'
                ? _model.idconta
                : valueOrDefault(currentUserDocument?.idcontaselecionada, ''),
          );

          if ((_model.dadosatuaisface?.succeeded ?? true)) {
            if (_model.master) {
              if (_model.nomecliente ==
                  getJsonField(
                    (_model.dadosatuaisface?.jsonBody ?? ''),
                    r'''$.username''',
                  ).toString()) {
                _model.name = _model.nomecliente;
                safeSetState(() {});
              } else {
                await _model.idref!.update(createContasRecordData(
                  nome: getJsonField(
                    (_model.dadosatuaisface?.jsonBody ?? ''),
                    r'''$.username''',
                  ).toString(),
                ));
              }
            } else {
              if (_model.contaselecionada?.nome ==
                  getJsonField(
                    (_model.dadosatuaisface?.jsonBody ?? ''),
                    r'''$.username''',
                  ).toString()) {
                _model.name = _model.contaselecionada?.nome;
                safeSetState(() {});
              } else {
                await _model.contaselecionada!.reference
                    .update(createContasRecordData(
                  nome: getJsonField(
                    (_model.dadosatuaisface?.jsonBody ?? ''),
                    r'''$.username''',
                  ).toString(),
                ));
              }
            }
          }
        }

        _model.loaded = true;
        safeSetState(() {});
      }
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryBackground,
              size: 30.0,
            ),
            onPressed: () async {
              context.pushNamed(HomeWidget.routeName);
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'gebk9k0i' /* Cronograma */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.oswald(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: Visibility(
          visible:
              (valueOrDefault(
                              currentUserDocument?.nomecontaselecionada, '') !=
                          '') &&
                  _model.loaded,
          child: AuthUserStreamWidget(
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (responsiveVisibility(
                  context: context,
                  tabletLandscape: false,
                  desktop: false,
                ))
                  Expanded(
                    child: Stack(
                      children: [
                        FutureBuilder<ApiCallResponse>(
                          future: (_model.apiRequestCompleter2 ??=
                                  Completer<ApiCallResponse>()
                                    ..complete(CronogramaCall.call(
                                      filterColumn: 'cliente',
                                      filterValue: _model.master
                                          ? _model.nomecliente
                                          : valueOrDefault(
                                              currentUserDocument
                                                  ?.nomecontaselecionada,
                                              ''),
                                    )))
                              .future,
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Image.asset(
                                '',
                              );
                            }
                            final listViewCronogramaResponse = snapshot.data!;

                            return Builder(
                              builder: (context) {
                                final cronograma = getJsonField(
                                  listViewCronogramaResponse.jsonBody,
                                  r'''$''',
                                ).toList();

                                return RefreshIndicator(
                                  color: FlutterFlowTheme.of(context).primary,
                                  onRefresh: () async {
                                    safeSetState(() =>
                                        _model.apiRequestCompleter2 = null);
                                    await _model.waitForApiRequestCompleted2();
                                  },
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount: cronograma.length,
                                    itemBuilder: (context, cronogramaIndex) {
                                      final cronogramaItem =
                                          cronograma[cronogramaIndex];
                                      return Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      8.0, 16.0, 8.0, 16.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 40.0,
                                                        height: 40.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          child: Image.network(
                                                            getJsonField(
                                                              (_model.dadosatuaisinsta
                                                                      ?.jsonBody ??
                                                                  ''),
                                                              r'''$.profile_picture_url''',
                                                            ).toString(),
                                                            width: 40.0,
                                                            height: 40.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        getJsonField(
                                                          (_model.dadosatuaisinsta
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.name''',
                                                        ).toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 12.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 393.0,
                                              height: 491.0,
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: wrapWithModel(
                                                  model: _model.cronoModels1
                                                      .getModel(
                                                    getJsonField(
                                                      cronogramaItem,
                                                      r'''$.nome''',
                                                    ).toString(),
                                                    cronogramaIndex,
                                                  ),
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: CronoWidget(
                                                    key: Key(
                                                      'Keyayd_${getJsonField(
                                                        cronogramaItem,
                                                        r'''$.nome''',
                                                      ).toString()}',
                                                    ),
                                                    parameter1: getJsonField(
                                                      cronogramaItem,
                                                      r'''$.imagem''',
                                                      true,
                                                    )!,
                                                    parameter2: getJsonField(
                                                      cronogramaItem,
                                                      r'''$.imagem''',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      8.0, 16.0, 8.0, 16.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      if ('0' ==
                                                          getJsonField(
                                                            cronogramaItem,
                                                            r'''$.aprovado''',
                                                          ).toString())
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            _model.like =
                                                                await AprovacaocronogramaCall
                                                                    .call(
                                                              idpost:
                                                                  getJsonField(
                                                                cronogramaItem,
                                                                r'''$.id''',
                                                              ).toString(),
                                                            );

                                                            safeSetState(() =>
                                                                _model.apiRequestCompleter2 =
                                                                    null);
                                                            await _model
                                                                .waitForApiRequestCompleted2();

                                                            safeSetState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 28.0,
                                                          ),
                                                        ),
                                                      if ('1' ==
                                                          getJsonField(
                                                            cronogramaItem,
                                                            r'''$.aprovado''',
                                                          ).toString())
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            _model.unlike =
                                                                await AprovacaocronogramaCall
                                                                    .call(
                                                              idpost:
                                                                  getJsonField(
                                                                cronogramaItem,
                                                                r'''$.id''',
                                                              ).toString(),
                                                            );

                                                            safeSetState(() =>
                                                                _model.apiRequestCompleter2 =
                                                                    null);
                                                            await _model
                                                                .waitForApiRequestCompleted2();

                                                            safeSetState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .favorite_sharp,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            size: 28.0,
                                                          ),
                                                        ),
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          _model.comentario =
                                                              true;
                                                          _model.idcomentario =
                                                              getJsonField(
                                                            cronogramaItem,
                                                            r'''$.id''',
                                                          ).toString();
                                                          safeSetState(() {});
                                                          safeSetState(() =>
                                                              _model.apiRequestCompleter1 =
                                                                  null);
                                                          await _model
                                                              .waitForApiRequestCompleted1();
                                                        },
                                                        child: Icon(
                                                          Icons
                                                              .chat_bubble_outline_rounded,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 28.0,
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                  Icon(
                                                    Icons.bookmark_border,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 28.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        8.0, 8.0, 8.0, 16.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        RichText(
                                                          textScaler:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .textScaler,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    getJsonField(
                                                                  cronogramaItem,
                                                                  r'''$.cliente''',
                                                                ).toString(),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              TextSpan(
                                                                text: FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  't3k1epk4' /*   */,
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
                                                              TextSpan(
                                                                text:
                                                                    getJsonField(
                                                                  cronogramaItem,
                                                                  r'''$.legenda''',
                                                                ).toString(),
                                                                style:
                                                                    TextStyle(),
                                                              )
                                                            ],
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
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        _model.comentario =
                                                            true;
                                                        _model.idcomentario =
                                                            getJsonField(
                                                          cronogramaItem,
                                                          r'''$.id''',
                                                        ).toString();
                                                        safeSetState(() {});
                                                        safeSetState(() => _model
                                                                .apiRequestCompleter1 =
                                                            null);
                                                        await _model
                                                            .waitForApiRequestCompleted1();
                                                      },
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '0pg1jqw0' /* Ver todos os comentários */,
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
                                                      ),
                                                    ),
                                                    Text(
                                                      getJsonField(
                                                        cronogramaItem,
                                                        r'''$.data_lancamento''',
                                                      ).toString(),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .override(
                                                                font:
                                                                    GoogleFonts
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
                                                                fontSize: 12.0,
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
                                                  ].divide(
                                                      SizedBox(height: 4.0)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        if (_model.comentario)
                          Align(
                            alignment: AlignmentDirectional(0.0, 1.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 0.6,
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
                                    FutureBuilder<ApiCallResponse>(
                                      future: (_model.apiRequestCompleter1 ??=
                                              Completer<ApiCallResponse>()
                                                ..complete(CronogramaCall.call(
                                                  filterColumn: 'id',
                                                  filterValue:
                                                      _model.idcomentario,
                                                )))
                                          .future,
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        final columnCronogramaResponse =
                                            snapshot.data!;

                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, 0.0),
                                              child: FlutterFlowIconButton(
                                                borderRadius: 8.0,
                                                buttonSize: 50.0,
                                                fillColor: Color(0x00141414),
                                                icon: Icon(
                                                  Icons.close_sharp,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 28.0,
                                                ),
                                                onPressed: () async {
                                                  _model.comentario = false;
                                                  safeSetState(() {});
                                                },
                                              ),
                                            ),
                                            SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  if (getJsonField(
                                                        CronogramaCall
                                                            .cronograma(
                                                          columnCronogramaResponse
                                                              .jsonBody,
                                                        )?.firstOrNull,
                                                        r'''$.comentarios''',
                                                      ) !=
                                                      null)
                                                    Builder(
                                                      builder: (context) {
                                                        final comentarios =
                                                            getJsonField(
                                                          CronogramaCall
                                                              .cronograma(
                                                            columnCronogramaResponse
                                                                .jsonBody,
                                                          )?.firstOrNull,
                                                          r'''$.comentarios''',
                                                        ).toList();

                                                        return ListView
                                                            .separated(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount: comentarios
                                                              .length,
                                                          separatorBuilder: (_,
                                                                  __) =>
                                                              SizedBox(
                                                                  height: 10.0),
                                                          itemBuilder: (context,
                                                              comentariosIndex) {
                                                            final comentariosItem =
                                                                comentarios[
                                                                    comentariosIndex];
                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child:
                                                                      RichText(
                                                                    textScaler:
                                                                        MediaQuery.of(context)
                                                                            .textScaler,
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              getJsonField(
                                                                            comentariosItem,
                                                                            r'''$.usuario''',
                                                                          ).toString(),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            'enerhffk' /*   */,
                                                                          ),
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
                                                                        TextSpan(
                                                                          text:
                                                                              getJsonField(
                                                                            comentariosItem,
                                                                            r'''$.comentario''',
                                                                          ).toString(),
                                                                          style:
                                                                              TextStyle(),
                                                                        )
                                                                      ],
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
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ),
                                                                if (getJsonField(
                                                                      comentariosItem,
                                                                      r'''$.date''',
                                                                    ) !=
                                                                    null)
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            1.0,
                                                                            0.0),
                                                                    child:
                                                                        RichText(
                                                                      textScaler:
                                                                          MediaQuery.of(context)
                                                                              .textScaler,
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                getJsonField(
                                                                              comentariosItem,
                                                                              r'''$.date''',
                                                                            ).toString(),
                                                                            style:
                                                                                TextStyle(),
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
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                  ),
                                                              ],
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
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 200.0,
                                            child: TextFormField(
                                              controller: _model.textController,
                                              focusNode:
                                                  _model.textFieldFocusNode,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                hintText:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'xd76ysrc' /* Insira seu comentário */,
                                                ),
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                              cursorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              validator: _model
                                                  .textControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                        FlutterFlowIconButton(
                                          buttonSize: 40.0,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          icon: Icon(
                                            Icons.arrow_upward,
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            size: 24.0,
                                          ),
                                          onPressed: () async {
                                            if (_model.textController.text !=
                                                '') {
                                              _model.apiResultufm =
                                                  await EnviocomentarioCall
                                                      .call(
                                                id: _model.idcomentario,
                                                comentario:
                                                    _model.textController.text,
                                                usuario: currentUserDisplayName,
                                              );

                                              safeSetState(() {
                                                _model.textController?.clear();
                                              });
                                              safeSetState(() => _model
                                                  .apiRequestCompleter1 = null);
                                              await _model
                                                  .waitForApiRequestCompleted1();
                                            }

                                            safeSetState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                if (responsiveVisibility(
                  context: context,
                  phone: false,
                  tablet: false,
                ))
                  Expanded(
                    child: FutureBuilder<ApiCallResponse>(
                      future: (_model.apiRequestCompleter3 ??=
                              Completer<ApiCallResponse>()
                                ..complete(CronogramaCall.call(
                                  filterColumn: 'cliente',
                                  filterValue: _model.master
                                      ? _model.nomecliente
                                      : valueOrDefault(
                                          currentUserDocument
                                              ?.nomecontaselecionada,
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
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        final pageViewCronogramaResponse = snapshot.data!;

                        return Builder(
                          builder: (context) {
                            final cronocomp = getJsonField(
                              pageViewCronogramaResponse.jsonBody,
                              r'''$''',
                            ).toList();

                            return Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 1.0,
                              child: PageView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _model.pageViewController ??=
                                    PageController(
                                        initialPage: max(
                                            0, min(0, cronocomp.length - 1))),
                                scrollDirection: Axis.horizontal,
                                itemCount: cronocomp.length,
                                itemBuilder: (context, cronocompIndex) {
                                  final cronocompItem =
                                      cronocomp[cronocompIndex];
                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Container(
                                          width: 1440.0,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.9,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              FlutterFlowIconButton(
                                                borderRadius: 8.0,
                                                buttonSize: 80.0,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                icon: Icon(
                                                  Icons.arrow_back,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 50.0,
                                                ),
                                                onPressed: () async {
                                                  await _model
                                                      .pageViewController
                                                      ?.previousPage(
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.ease,
                                                  );
                                                },
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: 648.0,
                                                  height: 810.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: wrapWithModel(
                                                    model: _model.cronoModels2
                                                        .getModel(
                                                      getJsonField(
                                                        cronocompItem,
                                                        r'''$.nome''',
                                                      ).toString(),
                                                      cronocompIndex,
                                                    ),
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child: CronoWidget(
                                                      key: Key(
                                                        'Keyo68_${getJsonField(
                                                          cronocompItem,
                                                          r'''$.nome''',
                                                        ).toString()}',
                                                      ),
                                                      parameter1: getJsonField(
                                                        cronocompItem,
                                                        r'''$.imagem''',
                                                        true,
                                                      )!,
                                                      parameter2: getJsonField(
                                                        cronocompItem,
                                                        r'''$.imagem''',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 26.0, 8.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Flexible(
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          40.0,
                                                                      height:
                                                                          40.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20.0),
                                                                      ),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20.0),
                                                                        child: Image
                                                                            .network(
                                                                          getJsonField(
                                                                            (_model.dadosatuaisinsta?.jsonBody ??
                                                                                ''),
                                                                            r'''$.profile_picture_url''',
                                                                          ).toString(),
                                                                          width:
                                                                              50.0,
                                                                          height:
                                                                              50.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      getJsonField(
                                                                        (_model.dadosatuaisinsta?.jsonBody ??
                                                                            ''),
                                                                        r'''$.name''',
                                                                      ).toString(),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          12.0)),
                                                                ),
                                                              ),
                                                              Divider(
                                                                thickness: 2.0,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                              ),
                                                              Flexible(
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          40.0,
                                                                      height:
                                                                          40.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20.0),
                                                                      ),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20.0),
                                                                        child: Image
                                                                            .network(
                                                                          getJsonField(
                                                                            (_model.dadosatuaisinsta?.jsonBody ??
                                                                                ''),
                                                                            r'''$.profile_picture_url''',
                                                                          ).toString(),
                                                                          width:
                                                                              50.0,
                                                                          height:
                                                                              50.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          RichText(
                                                                        textScaler:
                                                                            MediaQuery.of(context).textScaler,
                                                                        text:
                                                                            TextSpan(
                                                                          children: [
                                                                            TextSpan(
                                                                              text: getJsonField(
                                                                                cronocompItem,
                                                                                r'''$.cliente''',
                                                                              ).toString(),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            TextSpan(
                                                                              text: FFLocalizations.of(context).getText(
                                                                                'olan7ttt' /*   */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            TextSpan(
                                                                              text: getJsonField(
                                                                                cronocompItem,
                                                                                r'''$.legenda''',
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
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          12.0)),
                                                                ),
                                                              ),
                                                              if (getJsonField(
                                                                    cronocompItem,
                                                                    r'''$.comentarios''',
                                                                  ) !=
                                                                  null)
                                                                Flexible(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            52.0,
                                                                            20.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final comentarios =
                                                                            getJsonField(
                                                                          cronocompItem,
                                                                          r'''$.comentarios''',
                                                                        ).toList();

                                                                        return ListView
                                                                            .separated(
                                                                          padding:
                                                                              EdgeInsets.zero,
                                                                          primary:
                                                                              false,
                                                                          shrinkWrap:
                                                                              true,
                                                                          scrollDirection:
                                                                              Axis.vertical,
                                                                          itemCount:
                                                                              comentarios.length,
                                                                          separatorBuilder: (_, __) =>
                                                                              SizedBox(height: 10.0),
                                                                          itemBuilder:
                                                                              (context, comentariosIndex) {
                                                                            final comentariosItem =
                                                                                comentarios[comentariosIndex];
                                                                            return Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Align(
                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                  child: RichText(
                                                                                    textScaler: MediaQuery.of(context).textScaler,
                                                                                    text: TextSpan(
                                                                                      children: [
                                                                                        TextSpan(
                                                                                          text: getJsonField(
                                                                                            comentariosItem,
                                                                                            r'''$.usuario''',
                                                                                          ).toString(),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                        TextSpan(
                                                                                          text: FFLocalizations.of(context).getText(
                                                                                            'b3ck3si3' /*   */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                        TextSpan(
                                                                                          text: getJsonField(
                                                                                            comentariosItem,
                                                                                            r'''$.comentario''',
                                                                                          ).toString(),
                                                                                          style: TextStyle(),
                                                                                        )
                                                                                      ],
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    textAlign: TextAlign.start,
                                                                                  ),
                                                                                ),
                                                                                if (getJsonField(
                                                                                      comentariosItem,
                                                                                      r'''$.date''',
                                                                                    ) !=
                                                                                    null)
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(1.0, 0.0),
                                                                                    child: RichText(
                                                                                      textScaler: MediaQuery.of(context).textScaler,
                                                                                      text: TextSpan(
                                                                                        children: [
                                                                                          TextSpan(
                                                                                            text: getJsonField(
                                                                                              comentariosItem,
                                                                                              r'''$.date''',
                                                                                            ).toString(),
                                                                                            style: TextStyle(),
                                                                                          )
                                                                                        ],
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                      textAlign: TextAlign.start,
                                                                                    ),
                                                                                  ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      8.0,
                                                                      8.0,
                                                                      8.0,
                                                                      16.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Divider(
                                                                thickness: 2.0,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        16.0,
                                                                        0.0,
                                                                        16.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        if ('0' ==
                                                                            getJsonField(
                                                                              cronocompItem,
                                                                              r'''$.aprovado''',
                                                                            ).toString())
                                                                          InkWell(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            focusColor:
                                                                                Colors.transparent,
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () async {
                                                                              _model.likepc = await AprovacaocronogramaCall.call(
                                                                                idpost: getJsonField(
                                                                                  cronocompItem,
                                                                                  r'''$.id''',
                                                                                ).toString(),
                                                                              );

                                                                              safeSetState(() => _model.apiRequestCompleter3 = null);
                                                                              await _model.waitForApiRequestCompleted3();

                                                                              safeSetState(() {});
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.favorite_border,
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              size: 28.0,
                                                                            ),
                                                                          ),
                                                                        if ('1' ==
                                                                            getJsonField(
                                                                              cronocompItem,
                                                                              r'''$.aprovado''',
                                                                            ).toString())
                                                                          InkWell(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            focusColor:
                                                                                Colors.transparent,
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () async {
                                                                              _model.unlikepc = await AprovacaocronogramaCall.call(
                                                                                idpost: getJsonField(
                                                                                  cronocompItem,
                                                                                  r'''$.id''',
                                                                                ).toString(),
                                                                              );

                                                                              safeSetState(() => _model.apiRequestCompleter3 = null);
                                                                              await _model.waitForApiRequestCompleted3();

                                                                              safeSetState(() {});
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.favorite_sharp,
                                                                              color: FlutterFlowTheme.of(context).error,
                                                                              size: 28.0,
                                                                            ),
                                                                          ),
                                                                      ].divide(SizedBox(
                                                                              width: 16.0)),
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .bookmark_border,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      size:
                                                                          28.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text(
                                                                getJsonField(
                                                                  cronocompItem,
                                                                  r'''$.data_lancamento''',
                                                                ).toString(),
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
                                                                      fontSize:
                                                                          12.0,
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
                                                              wrapWithModel(
                                                                model: _model
                                                                    .botaocomentarioModels
                                                                    .getModel(
                                                                  getJsonField(
                                                                    cronocompItem,
                                                                    r'''$.id''',
                                                                  ).toString(),
                                                                  cronocompIndex,
                                                                ),
                                                                updateCallback: () =>
                                                                    safeSetState(
                                                                        () {}),
                                                                child:
                                                                    BotaocomentarioWidget(
                                                                  key: Key(
                                                                    'Keyrpi_${getJsonField(
                                                                      cronocompItem,
                                                                      r'''$.id''',
                                                                    ).toString()}',
                                                                  ),
                                                                  paremeter1:
                                                                      getJsonField(
                                                                    cronocompItem,
                                                                    r'''$.id''',
                                                                  ).toString(),
                                                                  click:
                                                                      () async {
                                                                    safeSetState(() =>
                                                                        _model.apiRequestCompleter3 =
                                                                            null);
                                                                    await _model
                                                                        .waitForApiRequestCompleted3();
                                                                  },
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 4.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 20.0)),
                                                  ),
                                                ),
                                              ),
                                              FlutterFlowIconButton(
                                                borderRadius: 8.0,
                                                buttonSize: 80.0,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                icon: Icon(
                                                  Icons.arrow_forward,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 50.0,
                                                ),
                                                onPressed: () async {
                                                  await _model
                                                      .pageViewController
                                                      ?.nextPage(
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.ease,
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
