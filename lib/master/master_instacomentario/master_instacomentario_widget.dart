import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/loading/loading_widget.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
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
import 'master_instacomentario_model.dart';
export 'master_instacomentario_model.dart';

class MasterInstacomentarioWidget extends StatefulWidget {
  const MasterInstacomentarioWidget({super.key});

  static String routeName = 'master-instacomentario';
  static String routePath = '/masterinstacomentario';

  @override
  State<MasterInstacomentarioWidget> createState() =>
      _MasterInstacomentarioWidgetState();
}

class _MasterInstacomentarioWidgetState
    extends State<MasterInstacomentarioWidget> {
  late MasterInstacomentarioModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MasterInstacomentarioModel());

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
              _model.idconta = '';
              safeSetState(() {});
              _model.dadospostbackend = await DadosComentariosCall.call(
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
                    isEqualTo: _model.loopconta?.idconta,
                  ),
                  singleRecord: true,
                ).then((s) => s.firstOrNull);
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
                                                          fontSize: 28.0,
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
                                                          fontSize: 16.0,
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
                                                        fontSize: 32.0,
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
                                                    '0u1jfvqy' /* Seguidores */,
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
                                                        fontSize: 18.0,
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
                                                        fontSize: 32.0,
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
                                                    'c53eogf4' /* Posts */,
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
                                                        fontSize: 18.0,
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
                                                          fontSize: 32.0,
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
                                                      'kyzdap65' /* Seguindo */,
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
                                                          fontSize: 18.0,
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
                                          ].divide(SizedBox(width: 26.0)),
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
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (valueOrDefault<bool>(
                                                currentUserDocument?.admin,
                                                false))
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, -1.0),
                                                child: AuthUserStreamWidget(
                                                  builder: (context) => InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      _model.apiResultrvbpc =
                                                          await ResetarComentarioCall
                                                              .call(
                                                        relatedId: valueOrDefault(
                                                            currentUserDocument
                                                                ?.idcontaselecionada,
                                                            ''),
                                                        userId: currentUserUid,
                                                      );

                                                      if ((_model.apiResultrvbpc
                                                              ?.succeeded ??
                                                          true)) {
                                                        context.goNamed(
                                                            HomeWidget
                                                                .routeName);
                                                      }

                                                      safeSetState(() {});
                                                    },
                                                    child: Icon(
                                                      Icons.replay,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 30.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '0taelylq' /* Resultados da página */,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 28.0,
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
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
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
                                                        0.35,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
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
                                                                '6lsr7z12' /* Seleção de período */,
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
                                                                fillColor: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                disabledColor:
                                                                    Colors
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
                                                                onPressed: !functions.bolrecuo(
                                                                        getJsonField(
                                                                          (_model.dadospostbackend?.jsonBody ??
                                                                              ''),
                                                                          r'''$''',
                                                                          true,
                                                                        )!,
                                                                        FFAppState().DataInicioMes!)
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
                                                                            safeSetState(() {});
                                                                          }),
                                                                          Future(
                                                                              () async {
                                                                            FFAppState().DataFinalMes =
                                                                                functions.reduzirdatafinal(FFAppState().DataFinalMes);
                                                                            FFAppState().DataFinalMesAnterior =
                                                                                functions.reduzirdatafinal(FFAppState().DataFinalMesAnterior);
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
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .headlineMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .headlineMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          24.0,
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
                                                                borderRadius:
                                                                    8.0,
                                                                buttonSize:
                                                                    40.0,
                                                                fillColor: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                disabledColor:
                                                                    Colors
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
                                                                onPressed: !functions.bolavanco(
                                                                        getJsonField(
                                                                          (_model.dadospostbackend?.jsonBody ??
                                                                              ''),
                                                                          r'''$''',
                                                                          true,
                                                                        )!,
                                                                        FFAppState().DataFinalMes!)!
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
                                                                            safeSetState(() {});
                                                                          }),
                                                                          Future(
                                                                              () async {
                                                                            FFAppState().DataFinalMes =
                                                                                functions.aumentardatafinal(FFAppState().DataFinalMes);
                                                                            FFAppState().DataFinalMesAnterior =
                                                                                functions.aumentardatafinal(FFAppState().DataFinalMesAnterior);
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
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Builder(
                                                                builder:
                                                                    (context) {
                                                                  final analisecomentarios =
                                                                      getJsonField(
                                                                    functions.filtrorelatorio(
                                                                        getJsonField(
                                                                          (_model.dadospostbackend?.jsonBody ??
                                                                              ''),
                                                                          r'''$''',
                                                                          true,
                                                                        ),
                                                                        FFAppState().DataInicioMes,
                                                                        FFAppState().DataFinalMes),
                                                                    r'''$.analise''',
                                                                  ).toList();

                                                                  return ListView
                                                                      .builder(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    primary:
                                                                        false,
                                                                    shrinkWrap:
                                                                        true,
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    itemCount:
                                                                        analisecomentarios
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            analisecomentariosIndex) {
                                                                      final analisecomentariosItem =
                                                                          analisecomentarios[
                                                                              analisecomentariosIndex];
                                                                      return Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children:
                                                                            [
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              if ('positive' ==
                                                                                  getJsonField(
                                                                                    analisecomentariosItem,
                                                                                    r'''$.cluster''',
                                                                                  ).toString())
                                                                                FaIcon(
                                                                                  FontAwesomeIcons.solidSmile,
                                                                                  color: FlutterFlowTheme.of(context).success,
                                                                                  size: 40.0,
                                                                                ),
                                                                              if ('neutral' ==
                                                                                  getJsonField(
                                                                                    analisecomentariosItem,
                                                                                    r'''$.cluster''',
                                                                                  ).toString())
                                                                                FaIcon(
                                                                                  FontAwesomeIcons.solidMeh,
                                                                                  color: FlutterFlowTheme.of(context).warning,
                                                                                  size: 40.0,
                                                                                ),
                                                                              if ('negative' ==
                                                                                  getJsonField(
                                                                                    analisecomentariosItem,
                                                                                    r'''$.cluster''',
                                                                                  ).toString())
                                                                                FaIcon(
                                                                                  FontAwesomeIcons.solidFrown,
                                                                                  color: Color(0xFFF25A07),
                                                                                  size: 40.0,
                                                                                ),
                                                                              if ('others' ==
                                                                                  getJsonField(
                                                                                    analisecomentariosItem,
                                                                                    r'''$.cluster''',
                                                                                  ).toString())
                                                                                FaIcon(
                                                                                  FontAwesomeIcons.solidMehBlank,
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  size: 40.0,
                                                                                ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  getJsonField(
                                                                                    analisecomentariosItem,
                                                                                    r'''$.count''',
                                                                                  ).toString(),
                                                                                  style: FlutterFlowTheme.of(context).displaySmall.override(
                                                                                        font: GoogleFonts.oswald(
                                                                                          fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                        fontSize: 26.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Text(
                                                                            getJsonField(
                                                                              analisecomentariosItem,
                                                                              r'''$.analise''',
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
                                                                        ].divide(SizedBox(height: 10.0)),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 10.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 20.0)),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Material(
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
                                                        0.61,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
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
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          AuthUserStreamWidget(
                                                            builder: (context) =>
                                                                FlutterFlowWebView(
                                                              content: valueOrDefault<
                                                                          bool>(
                                                                      currentUserDocument
                                                                          ?.dark,
                                                                      false)
                                                                  ? getJsonField(
                                                                      functions.filtrorelatorio(
                                                                          getJsonField(
                                                                            (_model.dadospostbackend?.jsonBody ??
                                                                                ''),
                                                                            r'''$''',
                                                                            true,
                                                                          ),
                                                                          FFAppState().DataInicioMes,
                                                                          FFAppState().DataFinalMes),
                                                                      r'''$.html_pagina_dark''',
                                                                    ).toString()
                                                                  : getJsonField(
                                                                      functions.filtrorelatorio(
                                                                          getJsonField(
                                                                            (_model.dadospostbackend?.jsonBody ??
                                                                                ''),
                                                                            r'''$''',
                                                                            true,
                                                                          ),
                                                                          FFAppState().DataInicioMes,
                                                                          FFAppState().DataFinalMes),
                                                                      r'''$.html_pagina''',
                                                                    ).toString(),
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  1.0,
                                                              height: 700.0,
                                                              verticalScroll:
                                                                  false,
                                                              horizontalScroll:
                                                                  false,
                                                              html: true,
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 10.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 20.0)),
                                        ),
                                      ].divide(SizedBox(height: 24.0)),
                                    ),
                                  ),
                                ),
                              if ((_model.temconta == false) &&
                                  (_model.loaded == true))
                                Expanded(
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height:
                                        MediaQuery.sizeOf(context).height * 1.0,
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
                                            FFLocalizations.of(context).getText(
                                              'oqoe7946' /* Conecte sua conta */,
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
                                            FFLocalizations.of(context).getText(
                                              'chei4wfp' /* Para adicionar uma conta do In... */,
                                            ),
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
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
                                                        24.0, 24.0, 24.0, 24.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'kr2hsrkx' /* Ao conectar sua conta do Faceb... */,
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
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                            ),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
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
                                                              MainAxisSize.max,
                                                          children: [
                                                            Icon(
                                                              Icons.data_usage,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              size: 24.0,
                                                            ),
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'avzpk3cm' /* insights da página e posts */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
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
                                                          ].divide(SizedBox(
                                                              width: 12.0)),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            FaIcon(
                                                              FontAwesomeIcons
                                                                  .commentDots,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              size: 24.0,
                                                            ),
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'dtz6n7sr' /* comentários */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
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
                                              _model.authCodepc = await actions
                                                  .loginWithFacebook();

                                              safeSetState(() {});
                                            },
                                            text: FFLocalizations.of(context)
                                                .getText(
                                              '00als6a4' /* Conectar Conta */,
                                            ),
                                            options: FFButtonOptions(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              height: 48.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.oswald(
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
                                                        color: Colors.white,
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
                                                    'gsum6eme' /* Seguidores */,
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
                                                    'b0db1qtb' /* Posts */,
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
                                                      '3ag1dnez' /* Seguindo */,
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
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (valueOrDefault<bool>(
                                                currentUserDocument?.admin,
                                                false))
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, -1.0),
                                                child: AuthUserStreamWidget(
                                                  builder: (context) => InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      _model.apiResultrvb =
                                                          await ResetarComentarioCall
                                                              .call(
                                                        relatedId: valueOrDefault(
                                                            currentUserDocument
                                                                ?.idcontaselecionada,
                                                            ''),
                                                        userId: currentUserUid,
                                                      );

                                                      if ((_model.apiResultrvb
                                                              ?.succeeded ??
                                                          true)) {
                                                        context.goNamed(
                                                            HomeWidget
                                                                .routeName);
                                                      }

                                                      safeSetState(() {});
                                                    },
                                                    child: Icon(
                                                      Icons.replay,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 30.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'jawzmp2f' /* Resultados da página */,
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
                                                    color: FlutterFlowTheme.of(
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
                                          ],
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
                                                        'qkd1abng' /* Seleção de período */,
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
                                                                      (_model.dadospostbackend
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
                                                                      (_model.dadospostbackend
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
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 2.0,
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
                                                      .fromSTEB(20.0, 20.0,
                                                          20.0, 20.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      AuthUserStreamWidget(
                                                        builder: (context) =>
                                                            FlutterFlowWebView(
                                                          content: valueOrDefault<
                                                                      bool>(
                                                                  currentUserDocument
                                                                      ?.dark,
                                                                  false)
                                                              ? getJsonField(
                                                                  functions.filtrorelatorio(
                                                                      getJsonField(
                                                                        (_model.dadospostbackend?.jsonBody ??
                                                                            ''),
                                                                        r'''$''',
                                                                        true,
                                                                      ),
                                                                      FFAppState().DataInicioMes,
                                                                      FFAppState().DataFinalMes),
                                                                  r'''$.html_pagina_dark''',
                                                                ).toString()
                                                              : getJsonField(
                                                                  functions.filtrorelatorio(
                                                                      getJsonField(
                                                                        (_model.dadospostbackend?.jsonBody ??
                                                                            ''),
                                                                        r'''$''',
                                                                        true,
                                                                      ),
                                                                      FFAppState().DataInicioMes,
                                                                      FFAppState().DataFinalMes),
                                                                  r'''$.html_pagina''',
                                                                ).toString(),
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  1.0,
                                                          height: 700.0,
                                                          verticalScroll: false,
                                                          horizontalScroll:
                                                              false,
                                                          html: true,
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 10.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 2.0,
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
                                                      .fromSTEB(20.0, 20.0,
                                                          20.0, 20.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Builder(
                                                        builder: (context) {
                                                          final analisecomentarios =
                                                              getJsonField(
                                                            functions
                                                                .filtrorelatorio(
                                                                    getJsonField(
                                                                      (_model.dadospostbackend
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                      r'''$''',
                                                                      true,
                                                                    ),
                                                                    FFAppState()
                                                                        .DataInicioMes,
                                                                    FFAppState()
                                                                        .DataFinalMes),
                                                            r'''$.analise''',
                                                          ).toList();

                                                          return ListView
                                                              .builder(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                analisecomentarios
                                                                    .length,
                                                            itemBuilder: (context,
                                                                analisecomentariosIndex) {
                                                              final analisecomentariosItem =
                                                                  analisecomentarios[
                                                                      analisecomentariosIndex];
                                                              return Column(
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
                                                                    children: [
                                                                      if ('positive' ==
                                                                          getJsonField(
                                                                            analisecomentariosItem,
                                                                            r'''$.cluster''',
                                                                          ).toString())
                                                                        FaIcon(
                                                                          FontAwesomeIcons
                                                                              .solidSmile,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).success,
                                                                          size:
                                                                              30.0,
                                                                        ),
                                                                      if ('neutral' ==
                                                                          getJsonField(
                                                                            analisecomentariosItem,
                                                                            r'''$.cluster''',
                                                                          ).toString())
                                                                        FaIcon(
                                                                          FontAwesomeIcons
                                                                              .solidMeh,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).warning,
                                                                          size:
                                                                              30.0,
                                                                        ),
                                                                      if ('negative' ==
                                                                          getJsonField(
                                                                            analisecomentariosItem,
                                                                            r'''$.cluster''',
                                                                          ).toString())
                                                                        FaIcon(
                                                                          FontAwesomeIcons
                                                                              .solidFrown,
                                                                          color:
                                                                              Color(0xFFF25A07),
                                                                          size:
                                                                              30.0,
                                                                        ),
                                                                      if ('others' ==
                                                                          getJsonField(
                                                                            analisecomentariosItem,
                                                                            r'''$.cluster''',
                                                                          ).toString())
                                                                        FaIcon(
                                                                          FontAwesomeIcons
                                                                              .solidMehBlank,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          size:
                                                                              30.0,
                                                                        ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          getJsonField(
                                                                            analisecomentariosItem,
                                                                            r'''$.count''',
                                                                          ).toString(),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .displaySmall
                                                                              .override(
                                                                                font: GoogleFonts.oswald(
                                                                                  fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 22.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    getJsonField(
                                                                      analisecomentariosItem,
                                                                      r'''$.analise''',
                                                                    ).toString(),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          fontSize:
                                                                              14.0,
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
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 10.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 24.0)),
                                    ),
                                  ),
                                ),
                              if ((_model.temconta == false) &&
                                  (_model.loaded == true))
                                Expanded(
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height:
                                        MediaQuery.sizeOf(context).height * 1.0,
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
                                            FFLocalizations.of(context).getText(
                                              '89e44iot' /* Conecte sua conta */,
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
                                            FFLocalizations.of(context).getText(
                                              'm4d3ku9t' /* Para adicionar uma conta do In... */,
                                            ),
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
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
                                                        24.0, 24.0, 24.0, 24.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'jk0myxv5' /* Ao conectar sua conta do Faceb... */,
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
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                            ),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
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
                                                              MainAxisSize.max,
                                                          children: [
                                                            Icon(
                                                              Icons.data_usage,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              size: 24.0,
                                                            ),
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'b9csdi0u' /* insights da página e posts */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
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
                                                          ].divide(SizedBox(
                                                              width: 12.0)),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            FaIcon(
                                                              FontAwesomeIcons
                                                                  .commentDots,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              size: 24.0,
                                                            ),
                                                            Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'rue4y29u' /* comentários */,
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
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
                                              'uqz1294y' /* Conectar Conta */,
                                            ),
                                            options: FFButtonOptions(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              height: 48.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.oswald(
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
                                                        color: Colors.white,
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
