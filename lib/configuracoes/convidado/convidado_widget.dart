import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'convidado_model.dart';
export 'convidado_model.dart';

class ConvidadoWidget extends StatefulWidget {
  const ConvidadoWidget({
    super.key,
    required this.code,
  });

  final String? code;

  static String routeName = 'convidado';
  static String routePath = '/convidado';

  @override
  State<ConvidadoWidget> createState() => _ConvidadoWidgetState();
}

class _ConvidadoWidgetState extends State<ConvidadoWidget> {
  late ConvidadoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConvidadoModel());

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

      if (valueOrDefault<bool>(currentUserDocument?.admin, false) == false) {
        context.pushNamed(HomeWidget.routeName);
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
              'p0jl95zm' /* Adicionar convidado */,
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
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
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
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '8csvft2f' /* Selecione o usuário que deseja... */,
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
                                        StreamBuilder<List<UsersRecord>>(
                                          stream: queryUsersRecord(),
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
                                            List<UsersRecord>
                                                dropDownUsersRecordList =
                                                snapshot.data!;

                                            return FlutterFlowDropDown<String>(
                                              controller: _model
                                                      .dropDownValueController ??=
                                                  FormFieldController<String>(
                                                _model.dropDownValue ??=
                                                    dropDownUsersRecordList
                                                        .firstOrNull
                                                        ?.reference
                                                        .id,
                                              ),
                                              options: List<String>.from(
                                                  dropDownUsersRecordList
                                                      .map(
                                                          (e) => e.reference.id)
                                                      .toList()),
                                              optionLabels:
                                                  dropDownUsersRecordList
                                                      .map((e) => e.email)
                                                      .toList(),
                                              onChanged: (val) async {
                                                safeSetState(() =>
                                                    _model.dropDownValue = val);
                                                _model.docref = await actions
                                                    .getDocRefFromID(
                                                  _model.dropDownValue!,
                                                );

                                                safeSetState(() {});
                                              },
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              height: 40.0,
                                              textStyle:
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
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24.0,
                                              ),
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              elevation: 2.0,
                                              borderColor: Colors.transparent,
                                              borderWidth: 0.0,
                                              borderRadius: 8.0,
                                              margin: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 0.0, 12.0, 0.0),
                                              hidesUnderline: true,
                                              isOverButton: false,
                                              isSearchable: false,
                                              isMultiSelect: false,
                                            );
                                          },
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'fziexj6p' /* Selecione as contas abaixo que... */,
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
                                        SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              StreamBuilder<List<ContasRecord>>(
                                                stream: queryContasRecord(
                                                  queryBuilder:
                                                      (contasRecord) =>
                                                          contasRecord.where(
                                                    'usuario',
                                                    isEqualTo:
                                                        currentUserReference,
                                                  ),
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
                                                  List<ContasRecord>
                                                      listViewContasRecordList =
                                                      snapshot.data!;

                                                  return ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        listViewContasRecordList
                                                            .length,
                                                    itemBuilder: (context,
                                                        listViewIndex) {
                                                      final listViewContasRecord =
                                                          listViewContasRecordList[
                                                              listViewIndex];
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
                                                                  listViewContasRecord
                                                                      .plataforma)
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
                                                                  listViewContasRecord
                                                                      .plataforma)
                                                                Icon(
                                                                  Icons
                                                                      .facebook,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  size: 30.0,
                                                                ),
                                                              if ('google' ==
                                                                  listViewContasRecord
                                                                      .plataforma)
                                                                Icon(
                                                                  FFIcons
                                                                      .klogotype2301145,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  size: 24.0,
                                                                ),
                                                              if ('meta_ads' ==
                                                                  listViewContasRecord
                                                                      .plataforma)
                                                                Icon(
                                                                  FFIcons.kmeta,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  size: 24.0,
                                                                ),
                                                              Text(
                                                                listViewContasRecord
                                                                    .nome,
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
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      fontSize:
                                                                          18.0,
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
                                                                      BorderRadius
                                                                          .circular(
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
                                                                      .checkboxValueMap[
                                                                  listViewContasRecord] ??= false,
                                                              onChanged:
                                                                  (newValue) async {
                                                                safeSetState(() =>
                                                                    _model.checkboxValueMap[
                                                                            listViewContasRecord] =
                                                                        newValue!);
                                                                if (newValue!) {
                                                                  _model.addToContasselecionadas(
                                                                      listViewContasRecord
                                                                          .idconta);
                                                                  safeSetState(
                                                                      () {});
                                                                } else {
                                                                  _model.removeFromContasselecionadas(
                                                                      listViewContasRecord
                                                                          .idconta);
                                                                  safeSetState(
                                                                      () {});
                                                                }
                                                              },
                                                              side: (FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate !=
                                                                      null)
                                                                  ? BorderSide(
                                                                      width: 2,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
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
                                                                      .info,
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
                                                  while (_model.loopadd! <
                                                      _model.contasselecionadas
                                                          .length) {
                                                    var contasRecordReference =
                                                        ContasRecord.collection
                                                            .doc();
                                                    await contasRecordReference
                                                        .set(
                                                            createContasRecordData(
                                                      nome: _model
                                                          .checkboxCheckedItems
                                                          .where((e) =>
                                                              _model
                                                                  .contasselecionadas
                                                                  .elementAtOrNull(
                                                                      _model
                                                                          .loopadd!) ==
                                                              e.idconta)
                                                          .toList()
                                                          .firstOrNull
                                                          ?.nome,
                                                      usuario: _model.docref,
                                                      plataforma: _model
                                                          .checkboxCheckedItems
                                                          .where((e) =>
                                                              _model
                                                                  .contasselecionadas
                                                                  .elementAtOrNull(
                                                                      _model
                                                                          .loopadd!) ==
                                                              e.idconta)
                                                          .toList()
                                                          .firstOrNull
                                                          ?.plataforma,
                                                      idconta: _model
                                                          .contasselecionadas
                                                          .elementAtOrNull(
                                                              _model.loopadd!),
                                                      userid: _model.docref?.id,
                                                    ));
                                                    _model.apiResult13d = ContasRecord
                                                        .getDocumentFromData(
                                                            createContasRecordData(
                                                              nome: _model
                                                                  .checkboxCheckedItems
                                                                  .where((e) =>
                                                                      _model
                                                                          .contasselecionadas
                                                                          .elementAtOrNull(
                                                                              _model.loopadd!) ==
                                                                      e.idconta)
                                                                  .toList()
                                                                  .firstOrNull
                                                                  ?.nome,
                                                              usuario:
                                                                  _model.docref,
                                                              plataforma: _model
                                                                  .checkboxCheckedItems
                                                                  .where((e) =>
                                                                      _model
                                                                          .contasselecionadas
                                                                          .elementAtOrNull(
                                                                              _model.loopadd!) ==
                                                                      e.idconta)
                                                                  .toList()
                                                                  .firstOrNull
                                                                  ?.plataforma,
                                                              idconta: _model
                                                                  .contasselecionadas
                                                                  .elementAtOrNull(
                                                                      _model
                                                                          .loopadd!),
                                                              userid: _model
                                                                  .docref?.id,
                                                            ),
                                                            contasRecordReference);
                                                    _model.loopadd =
                                                        _model.loopadd! + 1;
                                                    safeSetState(() {});
                                                  }

                                                  await _model.docref!.update(
                                                      createUsersRecordData(
                                                    idcontaselecionada: _model
                                                        .contasselecionadas
                                                        .elementAtOrNull(0),
                                                    lenderId: currentUserUid,
                                                    nomecontaselecionada: _model
                                                        .checkboxCheckedItems
                                                        .where((e) =>
                                                            _model
                                                                .contasselecionadas
                                                                .elementAtOrNull(
                                                                    0) ==
                                                            e.idconta)
                                                        .toList()
                                                        .firstOrNull
                                                        ?.nome,
                                                    type: _model
                                                        .checkboxCheckedItems
                                                        .where((e) =>
                                                            _model
                                                                .contasselecionadas
                                                                .elementAtOrNull(
                                                                    0) ==
                                                            e.idconta)
                                                        .toList()
                                                        .firstOrNull
                                                        ?.plataforma,
                                                  ));

                                                  context.pushNamed(
                                                      HomeWidget.routeName);

                                                  safeSetState(() {});
                                                },
                                                text:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'uyyeufm3' /* Adicionar contas selecionadas */,
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
            ),
          ],
        ),
      ),
    );
  }
}
