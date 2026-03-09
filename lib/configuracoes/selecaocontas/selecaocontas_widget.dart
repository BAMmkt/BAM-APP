import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'selecaocontas_model.dart';
export 'selecaocontas_model.dart';

class SelecaocontasWidget extends StatefulWidget {
  const SelecaocontasWidget({
    super.key,
    String? code,
    String? authcode,
  })  : this.code = code ?? 'NULL',
        this.authcode = authcode ?? 'NULL';

  final String code;
  final String authcode;

  static String routeName = 'selecaocontas';
  static String routePath = '/selecaocontas';

  @override
  State<SelecaocontasWidget> createState() => _SelecaocontasWidgetState();
}

class _SelecaocontasWidgetState extends State<SelecaocontasWidget> {
  late SelecaocontasModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelecaocontasModel());

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

      if (widget.code != 'NULL') {
        _model.buscacontas = await ContasCall.call(
          userId: currentUserReference?.id,
          authCode: widget.code,
        );

        if ((_model.buscacontas?.succeeded ?? true)) {
          _model.contasdousuario = await queryContasRecordOnce(
            queryBuilder: (contasRecord) => contasRecord.where(
              'usuario',
              isEqualTo: currentUserReference,
            ),
          );
          _model.loaded = true;
          _model.meta = true;
          safeSetState(() {});
        }
      } else {
        _model.buscacontasgoogle = await ContasGoogleCall.call(
          userId: currentUserReference?.id,
          authCode: widget.authcode,
        );

        if ((_model.buscacontas?.succeeded ?? true)) {
          _model.contasdousuariogoogle = await queryContasRecordOnce(
            queryBuilder: (contasRecord) => contasRecord.where(
              'usuario',
              isEqualTo: currentUserReference,
            ),
          );
          _model.loaded = true;
          _model.google = true;
          safeSetState(() {});
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            buttonSize: 48.0,
            icon: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () async {
              context.pushNamed(ConfiguracoesWidget.routeName);
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              '36fgendm' /* Selecionar Contas */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.oswald(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        primary: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
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
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16.0),
                                    bottomRight: Radius.circular(16.0),
                                    topLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(0.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 24.0, 24.0, 24.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'u46f6ih7' /* contas conectadas */,
                                            ),
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
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
                                          Text(
                                            'xx/xx restantes',
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
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
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'pt16esyp' /* Selecione as contas abaixo que... */,
                                        ),
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .fontStyle,
                                            ),
                                      ),
                                      if (_model.meta)
                                        SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              if (_model.loaded)
                                                Builder(
                                                  builder: (context) {
                                                    final contaslista =
                                                        functions
                                                                .filtrarcontas(
                                                                    getJsonField(
                                                                      (_model.buscacontas
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                      r'''$.clientes''',
                                                                      true,
                                                                    ),
                                                                    _model
                                                                        .contasdousuario
                                                                        ?.toList())
                                                                ?.toList() ??
                                                            [];

                                                    return ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      primary: false,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          contaslista.length,
                                                      itemBuilder: (context,
                                                          contaslistaIndex) {
                                                        final contaslistaItem =
                                                            contaslista[
                                                                contaslistaIndex];
                                                        return Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                if (FFAppConstants
                                                                        .Instagram ==
                                                                    getJsonField(
                                                                      contaslistaItem,
                                                                      r'''$.platform''',
                                                                    ).toString())
                                                                  FaIcon(
                                                                    FontAwesomeIcons
                                                                        .instagram,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    size: 30.0,
                                                                  ),
                                                                if (FFAppConstants
                                                                        .Facebook ==
                                                                    getJsonField(
                                                                      contaslistaItem,
                                                                      r'''$.platform''',
                                                                    ).toString())
                                                                  Icon(
                                                                    Icons
                                                                        .facebook,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    size: 30.0,
                                                                  ),
                                                                if (FFAppConstants
                                                                        .MetaAds ==
                                                                    getJsonField(
                                                                      contaslistaItem,
                                                                      r'''$.platform''',
                                                                    ).toString())
                                                                  Icon(
                                                                    FFIcons
                                                                        .kmeta,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    size: 30.0,
                                                                  ),
                                                                Text(
                                                                  getJsonField(
                                                                    contaslistaItem,
                                                                    r'''$.username''',
                                                                  ).toString(),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        fontSize:
                                                                            18.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 10.0)),
                                                            ),
                                                            Theme(
                                                              data: ThemeData(
                                                                checkboxTheme:
                                                                    CheckboxThemeData(
                                                                  visualDensity:
                                                                      VisualDensity
                                                                          .compact,
                                                                  materialTapTargetSize:
                                                                      MaterialTapTargetSize
                                                                          .shrinkWrap,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0),
                                                                  ),
                                                                ),
                                                                unselectedWidgetColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                              ),
                                                              child: Checkbox(
                                                                value: _model
                                                                        .checkboxValueMap1[
                                                                    contaslistaItem] ??= false,
                                                                onChanged:
                                                                    (newValue) async {
                                                                  safeSetState(() =>
                                                                      _model.checkboxValueMap1[
                                                                              contaslistaItem] =
                                                                          newValue!);
                                                                  if (newValue!) {
                                                                    _model.addToContasselecionadas(
                                                                        getJsonField(
                                                                      contaslistaItem,
                                                                      r'''$.account_id''',
                                                                    ).toString());
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.removeFromContasselecionadas(
                                                                        getJsonField(
                                                                      contaslistaItem,
                                                                      r'''$.account_id''',
                                                                    ).toString());
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                },
                                                                side: (FlutterFlowTheme.of(context)
                                                                            .alternate !=
                                                                        null)
                                                                    ? BorderSide(
                                                                        width:
                                                                            2,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .alternate,
                                                                      )
                                                                    : null,
                                                                activeColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                checkColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  _model.contasenviadas =
                                                      await AccountIdsCall.call(
                                                    accountIdList: _model
                                                        .contasselecionadas,
                                                    userId: currentUserUid,
                                                  );

                                                  while (_model.loopadd! <
                                                      _model.contasselecionadas
                                                          .length) {
                                                    var contasRecordReference =
                                                        ContasRecord.collection
                                                            .doc();
                                                    await contasRecordReference
                                                        .set(
                                                            createContasRecordData(
                                                      nome: getJsonField(
                                                        _model
                                                            .checkboxCheckedItems1
                                                            .where((e) =>
                                                                _model
                                                                    .contasselecionadas
                                                                    .elementAtOrNull(
                                                                        _model
                                                                            .loopadd!) ==
                                                                getJsonField(
                                                                  e,
                                                                  r'''$.account_id''',
                                                                ).toString())
                                                            .toList()
                                                            .firstOrNull,
                                                        r'''$.username''',
                                                      ).toString(),
                                                      usuario:
                                                          currentUserReference,
                                                      plataforma: getJsonField(
                                                        _model
                                                            .checkboxCheckedItems1
                                                            .where((e) =>
                                                                _model
                                                                    .contasselecionadas
                                                                    .elementAtOrNull(
                                                                        _model
                                                                            .loopadd!) ==
                                                                getJsonField(
                                                                  e,
                                                                  r'''$.account_id''',
                                                                ).toString())
                                                            .toList()
                                                            .firstOrNull,
                                                        r'''$.platform''',
                                                      ).toString(),
                                                      idconta: _model
                                                          .contasselecionadas
                                                          .elementAtOrNull(
                                                              _model.loopadd!),
                                                      userid: currentUserUid,
                                                    ));
                                                    _model.apiResult13d = ContasRecord
                                                        .getDocumentFromData(
                                                            createContasRecordData(
                                                              nome:
                                                                  getJsonField(
                                                                _model
                                                                    .checkboxCheckedItems1
                                                                    .where((e) =>
                                                                        _model.contasselecionadas.elementAtOrNull(_model.loopadd!) ==
                                                                        getJsonField(
                                                                          e,
                                                                          r'''$.account_id''',
                                                                        ).toString())
                                                                    .toList()
                                                                    .firstOrNull,
                                                                r'''$.username''',
                                                              ).toString(),
                                                              usuario:
                                                                  currentUserReference,
                                                              plataforma:
                                                                  getJsonField(
                                                                _model
                                                                    .checkboxCheckedItems1
                                                                    .where((e) =>
                                                                        _model.contasselecionadas.elementAtOrNull(_model.loopadd!) ==
                                                                        getJsonField(
                                                                          e,
                                                                          r'''$.account_id''',
                                                                        ).toString())
                                                                    .toList()
                                                                    .firstOrNull,
                                                                r'''$.platform''',
                                                              ).toString(),
                                                              idconta: _model
                                                                  .contasselecionadas
                                                                  .elementAtOrNull(
                                                                      _model
                                                                          .loopadd!),
                                                              userid:
                                                                  currentUserUid,
                                                            ),
                                                            contasRecordReference);
                                                    unawaited(
                                                      () async {
                                                        _model.envioconta =
                                                            await AdicionarNovoCall
                                                                .call(
                                                          userId:
                                                              currentUserUid,
                                                          accountId: _model
                                                              .contasselecionadas
                                                              .elementAtOrNull(
                                                                  _model
                                                                      .loopadd!),
                                                          username:
                                                              getJsonField(
                                                            _model
                                                                .checkboxCheckedItems1
                                                                .where((e) =>
                                                                    _model
                                                                        .contasselecionadas
                                                                        .elementAtOrNull(
                                                                            _model.loopadd!) ==
                                                                    getJsonField(
                                                                      e,
                                                                      r'''$.account_id''',
                                                                    ).toString())
                                                                .toList()
                                                                .firstOrNull,
                                                            r'''$.username''',
                                                          ).toString(),
                                                          accessToken:
                                                              getJsonField(
                                                            _model
                                                                .checkboxCheckedItems1
                                                                .where((e) =>
                                                                    _model
                                                                        .contasselecionadas
                                                                        .elementAtOrNull(
                                                                            _model.loopadd!) ==
                                                                    getJsonField(
                                                                      e,
                                                                      r'''$.account_id''',
                                                                    ).toString())
                                                                .toList()
                                                                .firstOrNull,
                                                            r'''$.access_token''',
                                                          ).toString(),
                                                          platform:
                                                              getJsonField(
                                                            _model
                                                                .checkboxCheckedItems1
                                                                .where((e) =>
                                                                    _model
                                                                        .contasselecionadas
                                                                        .elementAtOrNull(
                                                                            _model.loopadd!) ==
                                                                    getJsonField(
                                                                      e,
                                                                      r'''$.account_id''',
                                                                    ).toString())
                                                                .toList()
                                                                .firstOrNull,
                                                            r'''$.platform''',
                                                          ).toString(),
                                                        );
                                                      }(),
                                                    );
                                                    _model.loopadd =
                                                        _model.loopadd! + 1;
                                                    safeSetState(() {});
                                                  }

                                                  await currentUserReference!
                                                      .update(
                                                          createUsersRecordData(
                                                    idcontaselecionada: _model
                                                        .contasselecionadas
                                                        .elementAtOrNull(0),
                                                    nomecontaselecionada: _model
                                                        .contasdousuario
                                                        ?.where((e) =>
                                                            _model
                                                                .contasselecionadas
                                                                .elementAtOrNull(
                                                                    0) ==
                                                            e.idconta)
                                                        .toList()
                                                        .elementAtOrNull(0)
                                                        ?.nome,
                                                    type: _model.contasdousuario
                                                        ?.where((e) =>
                                                            e.idconta ==
                                                            _model
                                                                .contasselecionadas
                                                                .elementAtOrNull(
                                                                    0))
                                                        .toList()
                                                        .elementAtOrNull(0)
                                                        ?.plataforma,
                                                  ));

                                                  context.pushNamed(
                                                      HomeWidget.routeName);

                                                  safeSetState(() {});
                                                },
                                                text:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  '9b4w5zpn' /* Adicionar contas selecionadas */,
                                                ),
                                                options: FFButtonOptions(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
                                                  height: 48.0,
                                                  padding: EdgeInsets.all(8.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        font:
                                                            GoogleFonts.oswald(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                  elevation: 0.0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          24.0),
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 16.0)),
                                          ),
                                        ),
                                      if (_model.google)
                                        SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              if (_model.loaded)
                                                Builder(
                                                  builder: (context) {
                                                    final contaslista =
                                                        functions
                                                                .filtrarcontas(
                                                                    getJsonField(
                                                                      (_model.buscacontas
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                      r'''$.clientes''',
                                                                      true,
                                                                    ),
                                                                    _model
                                                                        .contasdousuario
                                                                        ?.toList())
                                                                ?.toList() ??
                                                            [];

                                                    return ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      primary: false,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          contaslista.length,
                                                      itemBuilder: (context,
                                                          contaslistaIndex) {
                                                        final contaslistaItem =
                                                            contaslista[
                                                                contaslistaIndex];
                                                        return Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                FaIcon(
                                                                  FontAwesomeIcons
                                                                      .google,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  size: 30.0,
                                                                ),
                                                                Text(
                                                                  getJsonField(
                                                                    contaslistaItem,
                                                                    r'''$.username''',
                                                                  ).toString(),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        fontSize:
                                                                            18.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 10.0)),
                                                            ),
                                                            Theme(
                                                              data: ThemeData(
                                                                checkboxTheme:
                                                                    CheckboxThemeData(
                                                                  visualDensity:
                                                                      VisualDensity
                                                                          .compact,
                                                                  materialTapTargetSize:
                                                                      MaterialTapTargetSize
                                                                          .shrinkWrap,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0),
                                                                  ),
                                                                ),
                                                                unselectedWidgetColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                              ),
                                                              child: Checkbox(
                                                                value: _model
                                                                        .checkboxValueMap2[
                                                                    contaslistaItem] ??= false,
                                                                onChanged:
                                                                    (newValue) async {
                                                                  safeSetState(() =>
                                                                      _model.checkboxValueMap2[
                                                                              contaslistaItem] =
                                                                          newValue!);
                                                                  if (newValue!) {
                                                                    _model.addToContasselecionadas(
                                                                        getJsonField(
                                                                      contaslistaItem,
                                                                      r'''$.account_id''',
                                                                    ).toString());
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.removeFromContasselecionadas(
                                                                        getJsonField(
                                                                      contaslistaItem,
                                                                      r'''$.account_id''',
                                                                    ).toString());
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                },
                                                                side: (FlutterFlowTheme.of(context)
                                                                            .alternate !=
                                                                        null)
                                                                    ? BorderSide(
                                                                        width:
                                                                            2,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .alternate,
                                                                      )
                                                                    : null,
                                                                activeColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                checkColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  _model.contasenviadasgoogle =
                                                      await AccountIdsCall.call(
                                                    accountIdList: _model
                                                        .contasselecionadas,
                                                    userId: currentUserUid,
                                                  );

                                                  while (_model.loopadd! <
                                                      _model.contasselecionadas
                                                          .length) {
                                                    var contasRecordReference =
                                                        ContasRecord.collection
                                                            .doc();
                                                    await contasRecordReference
                                                        .set(
                                                            createContasRecordData(
                                                      nome: getJsonField(
                                                        _model
                                                            .checkboxCheckedItems2
                                                            .where((e) =>
                                                                _model
                                                                    .contasselecionadas
                                                                    .elementAtOrNull(
                                                                        _model
                                                                            .loopadd!) ==
                                                                getJsonField(
                                                                  e,
                                                                  r'''$.account_id''',
                                                                ).toString())
                                                            .toList()
                                                            .firstOrNull,
                                                        r'''$.username''',
                                                      ).toString(),
                                                      usuario:
                                                          currentUserReference,
                                                      plataforma: getJsonField(
                                                        _model
                                                            .checkboxCheckedItems2
                                                            .where((e) =>
                                                                _model
                                                                    .contasselecionadas
                                                                    .elementAtOrNull(
                                                                        _model
                                                                            .loopadd!) ==
                                                                getJsonField(
                                                                  e,
                                                                  r'''$.account_id''',
                                                                ).toString())
                                                            .toList()
                                                            .firstOrNull,
                                                        r'''$.platform''',
                                                      ).toString(),
                                                      idconta: _model
                                                          .contasselecionadas
                                                          .elementAtOrNull(
                                                              _model.loopadd!),
                                                    ));
                                                    _model.apiResult13dgoogle =
                                                        ContasRecord.getDocumentFromData(
                                                            createContasRecordData(
                                                              nome:
                                                                  getJsonField(
                                                                _model
                                                                    .checkboxCheckedItems2
                                                                    .where((e) =>
                                                                        _model.contasselecionadas.elementAtOrNull(_model.loopadd!) ==
                                                                        getJsonField(
                                                                          e,
                                                                          r'''$.account_id''',
                                                                        ).toString())
                                                                    .toList()
                                                                    .firstOrNull,
                                                                r'''$.username''',
                                                              ).toString(),
                                                              usuario:
                                                                  currentUserReference,
                                                              plataforma:
                                                                  getJsonField(
                                                                _model
                                                                    .checkboxCheckedItems2
                                                                    .where((e) =>
                                                                        _model.contasselecionadas.elementAtOrNull(_model.loopadd!) ==
                                                                        getJsonField(
                                                                          e,
                                                                          r'''$.account_id''',
                                                                        ).toString())
                                                                    .toList()
                                                                    .firstOrNull,
                                                                r'''$.platform''',
                                                              ).toString(),
                                                              idconta: _model
                                                                  .contasselecionadas
                                                                  .elementAtOrNull(
                                                                      _model
                                                                          .loopadd!),
                                                            ),
                                                            contasRecordReference);
                                                    unawaited(
                                                      () async {
                                                        _model.enviocontagoogle =
                                                            await AdicionarNovoCall
                                                                .call(
                                                          userId:
                                                              currentUserUid,
                                                          accountId: _model
                                                              .contasselecionadas
                                                              .elementAtOrNull(
                                                                  _model
                                                                      .loopadd!),
                                                          username:
                                                              getJsonField(
                                                            _model
                                                                .checkboxCheckedItems2
                                                                .where((e) =>
                                                                    _model
                                                                        .contasselecionadas
                                                                        .elementAtOrNull(
                                                                            _model.loopadd!) ==
                                                                    getJsonField(
                                                                      e,
                                                                      r'''$.account_id''',
                                                                    ).toString())
                                                                .toList()
                                                                .firstOrNull,
                                                            r'''$.username''',
                                                          ).toString(),
                                                          accessToken:
                                                              getJsonField(
                                                            _model
                                                                .checkboxCheckedItems2
                                                                .where((e) =>
                                                                    _model
                                                                        .contasselecionadas
                                                                        .elementAtOrNull(
                                                                            _model.loopadd!) ==
                                                                    getJsonField(
                                                                      e,
                                                                      r'''$.account_id''',
                                                                    ).toString())
                                                                .toList()
                                                                .firstOrNull,
                                                            r'''$.refresh_token''',
                                                          ).toString(),
                                                          platform:
                                                              getJsonField(
                                                            _model
                                                                .checkboxCheckedItems2
                                                                .where((e) =>
                                                                    _model
                                                                        .contasselecionadas
                                                                        .elementAtOrNull(
                                                                            _model.loopadd!) ==
                                                                    getJsonField(
                                                                      e,
                                                                      r'''$.account_id''',
                                                                    ).toString())
                                                                .toList()
                                                                .firstOrNull,
                                                            r'''$.platform''',
                                                          ).toString(),
                                                        );
                                                      }(),
                                                    );
                                                    _model.loopadd =
                                                        _model.loopadd! + 1;
                                                    safeSetState(() {});
                                                  }

                                                  await currentUserReference!
                                                      .update(
                                                          createUsersRecordData(
                                                    idcontaselecionada: _model
                                                        .contasselecionadas
                                                        .elementAtOrNull(0),
                                                    nomecontaselecionada: _model
                                                        .contasdousuario
                                                        ?.where((e) =>
                                                            _model
                                                                .contasselecionadas
                                                                .elementAtOrNull(
                                                                    0) ==
                                                            e.idconta)
                                                        .toList()
                                                        .elementAtOrNull(0)
                                                        ?.nome,
                                                  ));

                                                  context.pushNamed(
                                                      HomeWidget.routeName);

                                                  safeSetState(() {});
                                                },
                                                text:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'w8dol088' /* Adicionar contas selecionadas */,
                                                ),
                                                options: FFButtonOptions(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
                                                  height: 48.0,
                                                  padding: EdgeInsets.all(8.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        font:
                                                            GoogleFonts.oswald(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                  elevation: 0.0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          24.0),
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 16.0)),
                                          ),
                                        ),
                                    ].divide(SizedBox(height: 16.0)),
                                  ),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(height: 24.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
