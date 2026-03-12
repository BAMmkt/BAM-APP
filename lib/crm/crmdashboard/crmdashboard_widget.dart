import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'crmdashboard_model.dart';
export 'crmdashboard_model.dart';

class CrmdashboardWidget extends StatefulWidget {
  const CrmdashboardWidget({super.key});

  static String routeName = 'crmdashboard';
  static String routePath = '/crmdashboard';

  @override
  State<CrmdashboardWidget> createState() => _CrmdashboardWidgetState();
}

class _CrmdashboardWidgetState extends State<CrmdashboardWidget> {
  late CrmdashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CrmdashboardModel());

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
        _model.colunaspipeline = await queryPipelinecrmRecordOnce(
          queryBuilder: (pipelinecrmRecord) => pipelinecrmRecord
              .where(
                'related_id',
                isEqualTo:
                    valueOrDefault(currentUserDocument?.idcontaselecionada, ''),
              )
              .where(
                'user_id',
                isEqualTo:
                    valueOrDefault<bool>(currentUserDocument?.admin, false)
                        ? currentUserUid
                        : valueOrDefault(currentUserDocument?.lenderId, ''),
              ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);

        _model.dataFinal = DateTime.now();
        _model.dataInicio = DateTime.now().subtract(const Duration(days: 30));
        _model.loaded = true;
        safeSetState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  // ── Classification helpers ──
  bool _isVenda(CrmLeadsTesteRecord lead) {
    final col = _model.colunaspipeline?.colunaVenda ?? '';
    if (col.isNotEmpty) return lead.status == col;
    final lower = lead.status.toLowerCase();
    return lower.contains('vend') ||
        lower.contains('won') ||
        lower.contains('ganho');
  }

  bool _isPerda(CrmLeadsTesteRecord lead) {
    final col = _model.colunaspipeline?.colunaPerdido ?? '';
    if (col.isNotEmpty) return lead.status == col;
    final lower = lead.status.toLowerCase();
    return lower.contains('perd') || lower.contains('lost');
  }

  // ── Helper: filter leads by date range and responsável ──
  List<CrmLeadsTesteRecord> _filteredLeads(
      List<CrmLeadsTesteRecord> allLeads) {
    return allLeads.where((lead) {
      if (_model.responsavelValue != null &&
          _model.responsavelValue!.isNotEmpty &&
          _model.responsavelValue != 'Todos') {
        final selected = _model.colunaspipeline?.responsavel
            .firstWhereOrNull((r) => r.nome == _model.responsavelValue);
        if (selected != null) {
          if (lead.responsavel != selected.userId) return false;
        }
      }
      if (_model.dataInicio != null && lead.dataEntrada != null) {
        if (lead.dataEntrada!.isBefore(_model.dataInicio!)) return false;
      }
      if (_model.dataFinal != null && lead.dataEntrada != null) {
        if (lead.dataEntrada!
            .isAfter(_model.dataFinal!.add(const Duration(days: 1)))) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  // ── Helper: get vendor names from pipeline config ──
  List<String> _getResponsavelNames() {
    final names = <String>['Todos'];
    final list = _model.colunaspipeline?.responsavel ?? [];
    for (final r in list) {
      if (r.nome.isNotEmpty) names.add(r.nome);
    }
    return names;
  }

  // ── Helper: map userId → name ──
  String _getResponsavelName(String userId) {
    if (userId.isEmpty) return '-';
    final list = _model.colunaspipeline?.responsavel ?? [];
    final match = list.firstWhereOrNull((r) => r.userId == userId);
    return match?.nome ?? userId;
  }

  // ── Helper: group leads by day for line chart ──
  Map<String, Map<String, int>> _groupByDay(List<CrmLeadsTesteRecord> leads) {
    final map = <String, Map<String, int>>{};
    if (_model.dataInicio == null || _model.dataFinal == null) return map;

    var current = DateTime(
        _model.dataInicio!.year, _model.dataInicio!.month, _model.dataInicio!.day);
    final end = DateTime(
        _model.dataFinal!.year, _model.dataFinal!.month, _model.dataFinal!.day);

    while (!current.isAfter(end)) {
      final key = dateTimeFormat("d/M", current);
      map[key] = {'criadas': 0, 'vendidas': 0, 'perdidas': 0};
      current = current.add(const Duration(days: 1));
    }

    for (final lead in leads) {
      if (lead.dataEntrada == null) continue;
      final key = dateTimeFormat("d/M", lead.dataEntrada!);
      if (map.containsKey(key)) {
        map[key]!['criadas'] = (map[key]!['criadas'] ?? 0) + 1;
      }
      if (lead.dataDeFechamento != null) {
        final closeKey = dateTimeFormat("d/M", lead.dataDeFechamento!);
        if (map.containsKey(closeKey)) {
          if (_isVenda(lead)) {
            map[closeKey]!['vendidas'] = (map[closeKey]!['vendidas'] ?? 0) + 1;
          } else if (_isPerda(lead)) {
            map[closeKey]!['perdidas'] = (map[closeKey]!['perdidas'] ?? 0) + 1;
          }
        }
      }
    }
    return map;
  }

  // ── Helper: group deal values by day for bar chart ──
  Map<String, Map<String, double>> _groupValuesByDay(
      List<CrmLeadsTesteRecord> leads) {
    final map = <String, Map<String, double>>{};
    if (_model.dataInicio == null || _model.dataFinal == null) return map;

    var current = DateTime(
        _model.dataInicio!.year, _model.dataInicio!.month, _model.dataInicio!.day);
    final end = DateTime(
        _model.dataFinal!.year, _model.dataFinal!.month, _model.dataFinal!.day);

    while (!current.isAfter(end)) {
      final key = dateTimeFormat("d/M", current);
      map[key] = {'vendido': 0.0, 'perdido': 0.0};
      current = current.add(const Duration(days: 1));
    }

    for (final lead in leads) {
      if (lead.dataDeFechamento == null) continue;
      final key = dateTimeFormat("d/M", lead.dataDeFechamento!);
      if (!map.containsKey(key)) continue;
      if (_isVenda(lead)) {
        map[key]!['vendido'] =
            (map[key]!['vendido'] ?? 0) + lead.valorNegociacao;
      } else if (_isPerda(lead)) {
        map[key]!['perdido'] =
            (map[key]!['perdido'] ?? 0) + lead.valorNegociacao;
      }
    }
    return map;
  }

  // ── Helper: count leads by pipeline column (uses lead.status) ──
  Map<String, int> _countByColumn(
      List<CrmLeadsTesteRecord> leads, List<String> columns) {
    final map = <String, int>{};
    for (final col in columns) {
      map[col] = leads.where((l) => l.status == col).length;
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return AuthUserStreamWidget(
      builder: (context) => StreamBuilder<List<CrmLeadsTesteRecord>>(
        stream: queryCrmLeadsTesteRecord(
          queryBuilder: (crmLeadsTesteRecord) => crmLeadsTesteRecord
              .where(
                'related_id',
                isEqualTo:
                    valueOrDefault(currentUserDocument?.idcontaselecionada, ''),
              )
              .where(
                'user_id',
                isEqualTo:
                    valueOrDefault<bool>(currentUserDocument?.admin, false)
                        ? currentUserUid
                        : valueOrDefault(currentUserDocument?.lenderId, ''),
              ),
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor:
                  FlutterFlowTheme.of(context).primaryBackground,
              body: Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
              ),
            );
          }

          final allLeads = snapshot.data!;
          final leads = _filteredLeads(allLeads);
          final responsavelNames = _getResponsavelNames();

          // ── KPI Computations ──
          final totalCriadas = leads.length;
          final totalVendidas = leads.where(_isVenda).length;
          final totalPerdidas = leads.where(_isPerda).length;

          final valorVendido = leads
              .where(_isVenda)
              .fold(0.0, (sum, l) => sum + l.valorNegociacao);
          final valorPerdido = leads
              .where(_isPerda)
              .fold(0.0, (sum, l) => sum + l.valorNegociacao);

          final ticketMedio =
              totalVendidas > 0 ? valorVendido / totalVendidas : 0.0;

          final vendidasWithDates = leads
              .where(_isVenda)
              .where((l) =>
                  l.dataEntrada != null && l.dataDeFechamento != null)
              .toList();
          final avgDaysVenda = vendidasWithDates.isNotEmpty
              ? vendidasWithDates.fold<int>(
                      0,
                      (s, l) =>
                          s +
                          l.dataDeFechamento!
                              .difference(l.dataEntrada!)
                              .inDays) /
                  vendidasWithDates.length
              : 0.0;

          // ── Chart Data ──
          final dailyData = _groupByDay(leads);
          final dailyLabels = dailyData.keys.toList();
          final criadasByDay =
              dailyData.values.map((v) => v['criadas']!.toDouble()).toList();
          final vendidasByDay =
              dailyData.values.map((v) => v['vendidas']!.toDouble()).toList();
          final perdidasByDay =
              dailyData.values.map((v) => v['perdidas']!.toDouble()).toList();

          final dailyValues = _groupValuesByDay(leads);
          final valueLabels = dailyValues.keys.toList();
          final vendidoByDay =
              dailyValues.values.map((v) => v['vendido']!).toList();
          final perdidoByDay =
              dailyValues.values.map((v) => v['perdido']!).toList();

          // ── Pipeline columns ──
          final columns =
              _model.colunaspipeline?.colunas.toList() ?? [];
          final columnCounts = _countByColumn(leads, columns);

          // ── Status distribution for pie chart ──
          final statusMap = <String, int>{};
          for (final lead in leads) {
            final s = lead.status.isNotEmpty ? lead.status : 'Sem status';
            statusMap[s] = (statusMap[s] ?? 0) + 1;
          }
          final rawLabels = statusMap.keys.toList();
          final rawValues =
              statusMap.values.map((v) => v.toDouble()).toList();

          // Pie chart: max 5 slices, rest grouped as "Outros"
          final pieThemeColors = <Color>[
            FlutterFlowTheme.of(context).primary,
            FlutterFlowTheme.of(context).warning,
            FlutterFlowTheme.of(context).error,
            const Color(0xFF731DD8),
            const Color(0xFFFF982B),
          ];

          List<String> pieLabels;
          List<double> pieValues;
          List<Color> pieColors;
          if (rawLabels.length <= 5) {
            pieLabels = rawLabels;
            pieValues = rawValues;
            pieColors = pieThemeColors.sublist(0, rawLabels.length);
          } else {
            pieLabels = rawLabels.take(5).toList()..add('Outros');
            pieValues = rawValues.take(5).toList()
              ..add(rawValues.skip(5).fold(0.0, (a, b) => a + b));
            pieColors = pieThemeColors.toList()
              ..add(const Color(0xFFFFFFFF));
          }

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor:
                  FlutterFlowTheme.of(context).primaryBackground,
              drawer: Container(
                width: MediaQuery.sizeOf(context).width * 0.66,
                child: Drawer(
                  elevation: 16.0,
                  child: WebViewAware(
                    child: wrapWithModel(
                      model: _model.menuModel,
                      updateCallback: () => safeSetState(() {}),
                      child: const MenuWidget(),
                    ),
                  ),
                ),
              ),
              body: SafeArea(
                top: true,
                child: Stack(
                  children: [
                    !_model.loaded
                    ? Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Header ──
                            Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 112.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 24.0, 24.0, 24.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        FlutterFlowIconButton(
                                          borderRadius: 8.0,
                                          buttonSize: 50.0,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          icon: Icon(
                                            Icons.menu,
                                            color:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            size: 30.0,
                                          ),
                                          onPressed: () {
                                            scaffoldKey.currentState!
                                                .openDrawer();
                                          },
                                        ),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Dashboard CRM',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .oswald(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          fontSize: 20.0,
                                                        ),
                                              ),
                                              Text(
                                                valueOrDefault(
                                                    currentUserDocument
                                                        ?.nomecontaselecionada,
                                                    ''),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ].divide(const SizedBox(width: 20.0)),
                                    ),
                                  ].divide(const SizedBox(height: 15.0)),
                                ),
                              ),
                            ),

                            // ── Main Content ──
                            Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(32.0),
                                  topRight: Radius.circular(32.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // ── Filters Row ──
                                    Wrap(
                                      spacing: 12.0,
                                      runSpacing: 12.0,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        // Vendedor dropdown (shows names)
                                        Container(
                                          width: MediaQuery.sizeOf(context)
                                                      .width <
                                                  600
                                              ? MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.43
                                              : 220.0,
                                          decoration: BoxDecoration(
                                            color:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .responsavelValueController ??=
                                                FormFieldController<String>(
                                                    null),
                                            options: responsavelNames,
                                            onChanged: (val) {
                                              safeSetState(() {
                                                _model.responsavelValue = val;
                                              });
                                            },
                                            width: double.infinity,
                                            height: 44.0,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.inter(),
                                                    ),
                                            hintText: 'Vendedor',
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
                                                    .primaryBackground,
                                            elevation: 0.0,
                                            borderColor: Colors.transparent,
                                            borderWidth: 0.0,
                                            borderRadius: 12.0,
                                            margin: const EdgeInsetsDirectional
                                                .fromSTEB(
                                                12.0, 0.0, 12.0, 0.0),
                                            hidesUnderline: true,
                                            isSearchable: false,
                                            isMultiSelect: false,
                                          ),
                                        ),

                                        // Date range display
                                        Container(
                                          width: MediaQuery.sizeOf(context)
                                                      .width <
                                                  600
                                              ? MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.43
                                              : 280.0,
                                          height: 48.0,
                                          decoration: BoxDecoration(
                                            color:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                FlutterFlowIconButton(
                                                  borderRadius: 8.0,
                                                  buttonSize: 36.0,
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_back_ios_sharp,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 16.0,
                                                  ),
                                                  onPressed: () {
                                                    safeSetState(() {
                                                      _model.dataInicio =
                                                          _model.dataInicio!
                                                              .subtract(
                                                                  const Duration(
                                                                      days:
                                                                          30));
                                                      _model.dataFinal =
                                                          _model.dataFinal!
                                                              .subtract(
                                                                  const Duration(
                                                                      days:
                                                                          30));
                                                    });
                                                  },
                                                ),
                                                Flexible(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      final picked =
                                                          await showDateRangePicker(
                                                        context: context,
                                                        useRootNavigator: false,
                                                        firstDate:
                                                            DateTime(2020),
                                                        lastDate:
                                                            DateTime.now()
                                                                .add(
                                                                    const Duration(
                                                                        days:
                                                                            365)),
                                                        initialDateRange:
                                                            DateTimeRange(
                                                          start: _model
                                                              .dataInicio!,
                                                          end: _model
                                                              .dataFinal!,
                                                        ),
                                                        builder:
                                                            (context, child) {
                                                          return Theme(
                                                            data: Theme.of(
                                                                    context)
                                                                .copyWith(
                                                              colorScheme:
                                                                  ColorScheme
                                                                      .light(
                                                                primary: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                onPrimary: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                surface: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child:
                                                                  ConstrainedBox(
                                                                constraints:
                                                                    const BoxConstraints(
                                                                  maxWidth:
                                                                      400.0,
                                                                  maxHeight:
                                                                      600.0,
                                                                ),
                                                                child: child!,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                      if (picked != null) {
                                                        safeSetState(() {
                                                          _model.dataInicio =
                                                              picked.start;
                                                          _model.dataFinal =
                                                              picked.end;
                                                        });
                                                      }
                                                    },
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .calendar_today,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              size: 16.0,
                                                            ),
                                                            const SizedBox(
                                                                width: 6.0),
                                                            Text(
                                                              '${dateTimeFormat("d/M/y", _model.dataInicio)} - ${dateTimeFormat("d/M/y", _model.dataFinal)}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                    fontSize:
                                                                        13.0,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                FlutterFlowIconButton(
                                                  borderRadius: 8.0,
                                                  buttonSize: 36.0,
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_forward_ios_sharp,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 16.0,
                                                  ),
                                                  onPressed: () {
                                                    safeSetState(() {
                                                      _model.dataInicio =
                                                          _model.dataInicio!
                                                              .add(
                                                                  const Duration(
                                                                      days:
                                                                          30));
                                                      _model.dataFinal =
                                                          _model.dataFinal!
                                                              .add(
                                                                  const Duration(
                                                                      days:
                                                                          30));
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        // Settings gear button
                                        if (_model.colunaspipeline != null &&
                                            columns.isNotEmpty)
                                          FlutterFlowIconButton(
                                            borderRadius: 8.0,
                                            buttonSize: 48.0,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            icon: Icon(
                                              Icons.settings,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 22.0,
                                            ),
                                            onPressed: () {
                                              safeSetState(() {
                                                _model.showConfig =
                                                    !_model.showConfig;
                                              });
                                            },
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0),

                                    // ── KPI Cards (horizontal scroll) ──
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          _buildKpiCard(
                                            context,
                                            label: 'Negociações criadas',
                                            value: '$totalCriadas',
                                            color: FlutterFlowTheme.of(context)
                                                .warning,
                                            textColor: const Color(0xFF14181B),
                                          ),
                                          const SizedBox(width: 12.0),
                                          _buildKpiCard(
                                            context,
                                            label: 'Negociações vendidas',
                                            value: '$totalVendidas',
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                          ),
                                          const SizedBox(width: 12.0),
                                          _buildKpiCard(
                                            context,
                                            label: 'Negociações perdidas',
                                            value: '$totalPerdidas',
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            textColor: const Color(0xFF14181B),
                                          ),
                                          const SizedBox(width: 12.0),
                                          _buildKpiCard(
                                            context,
                                            label: 'Valor vendido',
                                            value:
                                                'R\$ ${_formatCurrency(valorVendido)}',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            textColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                          ),
                                          const SizedBox(width: 12.0),
                                          _buildKpiCard(
                                            context,
                                            label: 'Ticket médio',
                                            value:
                                                'R\$ ${_formatCurrency(ticketMedio)}',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            textColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                          ),
                                          const SizedBox(width: 12.0),
                                          _buildKpiCard(
                                            context,
                                            label: 'Valor perdido',
                                            value:
                                                'R\$ ${_formatCurrency(valorPerdido)}',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            textColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                          ),
                                          const SizedBox(width: 12.0),
                                          _buildKpiCard(
                                            context,
                                            label: 'Tempo médio até a venda',
                                            value:
                                                '${avgDaysVenda.round()} dias',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            textColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24.0),

                                    // ── Line Chart ──
                                    _buildChartCard(
                                      context,
                                      title:
                                          'Negociações criadas, vendidas e perdidas',
                                      child: dailyLabels.isEmpty
                                          ? _buildEmptyChart(context)
                                          : SizedBox(
                                              width:
                                                  MediaQuery.sizeOf(context)
                                                          .width *
                                                      1.0,
                                              height: 250.0,
                                              child: FlutterFlowLineChart(
                                                data: [
                                                  FFLineChartData(
                                                    xData: List.generate(
                                                        dailyLabels.length,
                                                        (i) => i),
                                                    yData: criadasByDay,
                                                    settings:
                                                        LineChartBarData(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .warning,
                                                      barWidth: 2.0,
                                                      isCurved: true,
                                                      preventCurveOverShooting:
                                                          true,
                                                      dotData: const FlDotData(
                                                          show: false),
                                                      belowBarData:
                                                          BarAreaData(
                                                        show: false,
                                                      ),
                                                    ),
                                                  ),
                                                  FFLineChartData(
                                                    xData: List.generate(
                                                        dailyLabels.length,
                                                        (i) => i),
                                                    yData: vendidasByDay,
                                                    settings:
                                                        LineChartBarData(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      barWidth: 2.0,
                                                      isCurved: true,
                                                      preventCurveOverShooting:
                                                          true,
                                                      dotData: const FlDotData(
                                                          show: false),
                                                      belowBarData:
                                                          BarAreaData(
                                                        show: false,
                                                      ),
                                                    ),
                                                  ),
                                                  FFLineChartData(
                                                    xData: List.generate(
                                                        dailyLabels.length,
                                                        (i) => i),
                                                    yData: perdidasByDay,
                                                    settings:
                                                        LineChartBarData(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      barWidth: 2.0,
                                                      isCurved: true,
                                                      preventCurveOverShooting:
                                                          true,
                                                      dotData: const FlDotData(
                                                          show: false),
                                                      belowBarData:
                                                          BarAreaData(
                                                        show: false,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                chartStylingInfo:
                                                    ChartStylingInfo(
                                                  enableTooltip: true,
                                                  tooltipBackgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  showBorder: false,
                                                  showGrid: true,
                                                ),
                                                axisBounds:
                                                    const AxisBounds(),
                                                xAxisLabelInfo:
                                                    const AxisLabelInfo(
                                                  reservedSize: 20.0,
                                                ),
                                                yAxisLabelInfo:
                                                    AxisLabelInfo(
                                                  showLabels: true,
                                                  labelTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(),
                                                            fontSize: 10.0,
                                                          ),
                                                  reservedSize: 32.0,
                                                ),
                                              ),
                                            ),
                                      legend: [
                                        _buildLegendItem(
                                            context,
                                            'Criadas',
                                            FlutterFlowTheme.of(context)
                                                .warning),
                                        _buildLegendItem(
                                            context,
                                            'Vendidas',
                                            FlutterFlowTheme.of(context)
                                                .primary),
                                        _buildLegendItem(
                                            context,
                                            'Perdidas',
                                            FlutterFlowTheme.of(context)
                                                .error),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0),

                                    // ── Bar Chart: Valores das negociações ──
                                    _buildChartCard(
                                      context,
                                      title: 'Valores das negociações',
                                      child: valueLabels.isEmpty
                                          ? _buildEmptyChart(context)
                                          : SizedBox(
                                              width:
                                                  MediaQuery.sizeOf(context)
                                                          .width *
                                                      1.0,
                                              height: 250.0,
                                              child: FlutterFlowBarChart(
                                                barData: [
                                                  FFBarChartData(
                                                    yData: vendidoByDay,
                                                    color:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                  ),
                                                  FFBarChartData(
                                                    yData: perdidoByDay,
                                                    color:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .error,
                                                  ),
                                                ],
                                                xLabels: valueLabels,
                                                stacked: true,
                                                barWidth: 16.0,
                                                barBorderRadius:
                                                    BorderRadius.circular(
                                                        6.0),
                                                barSpace: 0.0,
                                                groupSpace: 8.0,
                                                alignment:
                                                    BarChartAlignment
                                                        .spaceBetween,
                                                chartStylingInfo:
                                                    ChartStylingInfo(
                                                  enableTooltip: true,
                                                  tooltipBackgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  showBorder: false,
                                                ),
                                                axisBounds:
                                                    const AxisBounds(),
                                                xAxisLabelInfo:
                                                    AxisLabelInfo(
                                                  showLabels: true,
                                                  labelTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(),
                                                            fontSize: 9.0,
                                                          ),
                                                  reservedSize: 20.0,
                                                ),
                                                yAxisLabelInfo:
                                                    AxisLabelInfo(
                                                  showLabels: true,
                                                  labelTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(),
                                                            fontSize: 10.0,
                                                          ),
                                                  reservedSize: 50.0,
                                                ),
                                              ),
                                            ),
                                      legend: [
                                        _buildLegendItem(
                                            context,
                                            'Valor vendido',
                                            FlutterFlowTheme.of(context)
                                                .primary),
                                        _buildLegendItem(
                                            context,
                                            'Valor perdido',
                                            FlutterFlowTheme.of(context)
                                                .error),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0),

                                    // ── Row: Pie (40%) + Pipeline Bar (60%) ──
                                    Wrap(
                                      spacing: 20.0,
                                      runSpacing: 20.0,
                                      children: [
                                        // Pie Chart (40%)
                                        _buildChartCard(
                                          context,
                                          title: 'Distribuição por status',
                                          fixedHeight: 420.0,
                                          titleGap: 10.0,
                                          fixedWidth:
                                              MediaQuery.sizeOf(context)
                                                          .width <
                                                      600
                                                  ? MediaQuery.sizeOf(context)
                                                          .width -
                                                      40
                                                  : (MediaQuery.sizeOf(context)
                                                              .width -
                                                          80) *
                                                      0.4,
                                          child: pieValues.isEmpty
                                              ? _buildEmptyChart(context)
                                              : Column(
                                                  children: [
                                                    Expanded(
                                                      child:
                                                          FlutterFlowPieChart(
                                                        data: FFPieChartData(
                                                          values: pieValues,
                                                          colors: pieColors,
                                                          radius: [100.0],
                                                          borderColor: [
                                                            const Color(
                                                                0x00000000)
                                                          ],
                                                        ),
                                                        donutHoleRadius:
                                                            45.0,
                                                        donutHoleColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
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
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  fontSize:
                                                                      11.0,
                                                                ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        height: 10.0),
                                                    Wrap(
                                                      spacing: 12.0,
                                                      runSpacing: 8.0,
                                                      children:
                                                          List.generate(
                                                        pieLabels.length,
                                                        (i) =>
                                                            _buildLegendItem(
                                                          context,
                                                          '${pieLabels[i]} (${pieValues[i].toInt()})',
                                                          pieColors[i],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),

                                        // Funnel Bar Chart (60%)
                                        if (columns.isNotEmpty)
                                          _buildChartCard(
                                            context,
                                            title:
                                                'Negociações por etapa do funil',
                                            fixedHeight: 420.0,
                                            fixedWidth:
                                                MediaQuery.sizeOf(context)
                                                            .width <
                                                        600
                                                    ? MediaQuery.sizeOf(
                                                                context)
                                                            .width -
                                                        40
                                                    : (MediaQuery.sizeOf(
                                                                    context)
                                                                .width -
                                                            80) *
                                                        0.6,
                                            child: columnCounts.isEmpty
                                                ? _buildEmptyChart(context)
                                                : SizedBox(
                                                    width: double.infinity,
                                                    child:
                                                        FlutterFlowBarChart(
                                                      barData: [
                                                        FFBarChartData(
                                                          yData: columnCounts
                                                              .values
                                                              .map((v) => v
                                                                  .toDouble())
                                                              .toList(),
                                                          color:
                                                              FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .primary,
                                                        ),
                                                      ],
                                                      xLabels: columnCounts
                                                          .keys
                                                          .toList(),
                                                      barWidth: 24.0,
                                                      barBorderRadius:
                                                          BorderRadius
                                                              .circular(
                                                                  8.0),
                                                      barSpace: 0.0,
                                                      groupSpace: 12.0,
                                                      alignment:
                                                          BarChartAlignment
                                                              .spaceBetween,
                                                      chartStylingInfo:
                                                          ChartStylingInfo(
                                                        enableTooltip: true,
                                                        tooltipBackgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                        showBorder: false,
                                                      ),
                                                      axisBounds:
                                                          const AxisBounds(),
                                                      xAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .inter(),
                                                                  fontSize:
                                                                      9.0,
                                                                ),
                                                        reservedSize: 28.0,
                                                      ),
                                                      yAxisLabelInfo:
                                                          AxisLabelInfo(
                                                        showLabels: true,
                                                        labelTextStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .inter(),
                                                                  fontSize:
                                                                      10.0,
                                                                ),
                                                        reservedSize: 32.0,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0),

                                    // ── Table: Top leads by value ──
                                    _buildChartCard(
                                      context,
                                      title: 'Top negociações por valor',
                                      child: _buildTopLeadsTable(
                                          context, leads),
                                    ),
                                    const SizedBox(height: 24.0),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    // ── Config overlay ──
                    if (_model.showConfig &&
                        _model.colunaspipeline != null &&
                        columns.isNotEmpty)
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: () {
                            safeSetState(() {
                              _model.showConfig = false;
                            });
                          },
                          child: Container(
                            color: Colors.black54,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {},
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    width: 340.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius:
                                          BorderRadius.circular(16.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Text(
                                                'Configuração de status',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .titleMedium
                                                    .override(
                                                      font: GoogleFonts.oswald(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      fontSize: 16.0,
                                                    ),
                                              ),
                                              FlutterFlowIconButton(
                                                borderRadius: 8.0,
                                                buttonSize: 36.0,
                                                icon: Icon(
                                                  Icons.close,
                                                  color:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  size: 20.0,
                                                ),
                                                onPressed: () {
                                                  safeSetState(() {
                                                    _model.showConfig =
                                                        false;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            'Defina quais colunas do pipeline representam venda e perda:',
                                            style: FlutterFlowTheme.of(
                                                    context)
                                                .bodySmall
                                                .override(
                                                  font: GoogleFonts.inter(),
                                                  color:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                ),
                                          ),
                                          const SizedBox(height: 16.0),
                                          Text(
                                            'Coluna de venda',
                                            style: FlutterFlowTheme.of(
                                                    context)
                                                .bodySmall
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.w600,
                                                  ),
                                                  fontSize: 12.0,
                                                ),
                                          ),
                                          const SizedBox(height: 6.0),
                                          FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .colunaVendaController ??=
                                                FormFieldController<
                                                    String>(_model
                                                        .colunaspipeline
                                                        ?.colunaVenda
                                                        .isNotEmpty ==
                                                    true
                                                ? _model.colunaspipeline!
                                                    .colunaVenda
                                                : null),
                                            options: columns,
                                            onChanged: (val) async {
                                              if (val != null) {
                                                await _model
                                                    .colunaspipeline!
                                                    .reference
                                                    .update(
                                                  createPipelinecrmRecordData(
                                                    colunaVenda: val,
                                                  ),
                                                );
                                                _model.colunaspipeline =
                                                    await PipelinecrmRecord
                                                        .getDocumentOnce(
                                                            _model
                                                                .colunaspipeline!
                                                                .reference);
                                                safeSetState(() {});
                                              }
                                            },
                                            width: double.infinity,
                                            height: 44.0,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      font:
                                                          GoogleFonts.inter(),
                                                    ),
                                            hintText: 'Selecione...',
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
                                                    .primaryBackground,
                                            elevation: 0.0,
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                            borderWidth: 1.0,
                                            borderRadius: 12.0,
                                            margin:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    12.0, 0.0, 12.0, 0.0),
                                            hidesUnderline: true,
                                            isSearchable: false,
                                            isMultiSelect: false,
                                          ),
                                          const SizedBox(height: 16.0),
                                          Text(
                                            'Coluna de perda',
                                            style: FlutterFlowTheme.of(
                                                    context)
                                                .bodySmall
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.w600,
                                                  ),
                                                  fontSize: 12.0,
                                                ),
                                          ),
                                          const SizedBox(height: 6.0),
                                          FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .colunaPerdidoController ??=
                                                FormFieldController<
                                                    String>(_model
                                                        .colunaspipeline
                                                        ?.colunaPerdido
                                                        .isNotEmpty ==
                                                    true
                                                ? _model.colunaspipeline!
                                                    .colunaPerdido
                                                : null),
                                            options: columns,
                                            onChanged: (val) async {
                                              if (val != null) {
                                                await _model
                                                    .colunaspipeline!
                                                    .reference
                                                    .update(
                                                  createPipelinecrmRecordData(
                                                    colunaPerdido: val,
                                                  ),
                                                );
                                                _model.colunaspipeline =
                                                    await PipelinecrmRecord
                                                        .getDocumentOnce(
                                                            _model
                                                                .colunaspipeline!
                                                                .reference);
                                                safeSetState(() {});
                                              }
                                            },
                                            width: double.infinity,
                                            height: 44.0,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      font:
                                                          GoogleFonts.inter(),
                                                    ),
                                            hintText: 'Selecione...',
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
                                                    .primaryBackground,
                                            elevation: 0.0,
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                            borderWidth: 1.0,
                                            borderRadius: 12.0,
                                            margin:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    12.0, 0.0, 12.0, 0.0),
                                            hidesUnderline: true,
                                            isSearchable: false,
                                            isMultiSelect: false,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── KPI Card Widget ──
  Widget _buildKpiCard(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
    required Color textColor,
    bool hasInfo = false,
  }) {
    final cardWidth = MediaQuery.sizeOf(context).width < 600
        ? (MediaQuery.sizeOf(context).width - 52) / 2
        : 180.0;
    return Material(
      color: Colors.transparent,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      label,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                            ),
                            color: textColor.withValues(alpha: 0.7),
                            fontSize: 12.0,
                          ),
                    ),
                  ),
                  if (hasInfo)
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Icon(
                        Icons.info_outline,
                        color: textColor.withValues(alpha: 0.4),
                        size: 14.0,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                value,
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      font: GoogleFonts.oswald(fontWeight: FontWeight.w600),
                      color: textColor,
                      fontSize: 24.0,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Chart Card Container ──
  Widget _buildChartCard(
    BuildContext context, {
    required String title,
    required Widget child,
    List<Widget>? legend,
    double? fixedWidth,
    double? fixedHeight,
    double titleGap = 16.0,
  }) {
    return Material(
      color: Colors.transparent,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: fixedWidth ?? MediaQuery.sizeOf(context).width * 1.0,
        height: fixedHeight,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: fixedHeight != null
                ? MainAxisSize.max
                : MainAxisSize.min,
            children: [
              Text(
                title,
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      font: GoogleFonts.oswald(fontWeight: FontWeight.w600),
                      fontSize: 16.0,
                    ),
              ),
              SizedBox(height: titleGap),
              if (fixedHeight != null)
                Expanded(child: child)
              else
                child,
              if (legend != null) ...[
                const SizedBox(height: 12.0),
                Wrap(
                  spacing: 16.0,
                  runSpacing: 8.0,
                  children: legend,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ── Legend Item ──
  Widget _buildLegendItem(BuildContext context, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: FlutterFlowTheme.of(context).bodySmall.override(
                font: GoogleFonts.inter(),
                fontSize: 12.0,
              ),
        ),
      ],
    );
  }

  // ── Empty chart placeholder ──
  Widget _buildEmptyChart(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: Center(
        child: Text(
          'Sem dados no período selecionado',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(),
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
        ),
      ),
    );
  }

  // ── Top Leads Table ──
  Widget _buildTopLeadsTable(
      BuildContext context, List<CrmLeadsTesteRecord> leads) {
    var filtered = List<CrmLeadsTesteRecord>.from(leads);
    if (_model.filtrarPerdidos) {
      filtered = filtered.where((l) => !_isPerda(l)).toList();
    }
    filtered.sort((a, b) => b.valorNegociacao.compareTo(a.valorNegociacao));
    final top = filtered.take(10).toList();

    if (top.isEmpty) return _buildEmptyChart(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Checkbox to filter perdidos
        Row(
          children: [
            SizedBox(
              width: 24.0,
              height: 24.0,
              child: Checkbox(
                value: _model.filtrarPerdidos,
                activeColor: FlutterFlowTheme.of(context).primary,
                onChanged: (val) {
                  safeSetState(() {
                    _model.filtrarPerdidos = val ?? false;
                  });
                },
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              'Ocultar perdidos',
              style: FlutterFlowTheme.of(context).bodySmall.override(
                    font: GoogleFonts.inter(),
                    fontSize: 12.0,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        // Header
        Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Nome',
                    style:
                        FlutterFlowTheme.of(context).bodySmall.override(
                              font: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600),
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              fontSize: 12.0,
                            ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Status',
                    style:
                        FlutterFlowTheme.of(context).bodySmall.override(
                              font: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600),
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              fontSize: 12.0,
                            ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Valor',
                    textAlign: TextAlign.right,
                    style:
                        FlutterFlowTheme.of(context).bodySmall.override(
                              font: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600),
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              fontSize: 12.0,
                            ),
                  ),
                ),
                if (MediaQuery.sizeOf(context).width > 600)
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Responsável',
                      textAlign: TextAlign.right,
                      style: FlutterFlowTheme.of(context)
                          .bodySmall
                          .override(
                            font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600),
                            color: FlutterFlowTheme.of(context)
                                .primaryBackground,
                            fontSize: 12.0,
                          ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        // Rows
        ...top.asMap().entries.map((entry) {
          final i = entry.key;
          final lead = entry.value;
          return Container(
            decoration: BoxDecoration(
              color: i.isEven
                  ? FlutterFlowTheme.of(context).secondaryBackground
                  : FlutterFlowTheme.of(context).primaryBackground,
              borderRadius: i == top.length - 1
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    )
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0, vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      lead.nome,
                      style: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            font: GoogleFonts.inter(),
                            fontSize: 13.0,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: _getStatusColor(context, lead),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        lead.status.isNotEmpty ? lead.status : '-',
                        style: FlutterFlowTheme.of(context)
                            .bodySmall
                            .override(
                              font: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500),
                              fontSize: 11.0,
                              color:
                                  FlutterFlowTheme.of(context)
                                      .primaryText,
                            ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'R\$ ${_formatCurrency(lead.valorNegociacao)}',
                      textAlign: TextAlign.right,
                      style: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600),
                            fontSize: 13.0,
                          ),
                    ),
                  ),
                  if (MediaQuery.sizeOf(context).width > 600)
                    Expanded(
                      flex: 2,
                      child: Text(
                        _getResponsavelName(lead.responsavel),
                        textAlign: TextAlign.right,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              font: GoogleFonts.inter(),
                              fontSize: 13.0,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Color _getStatusColor(BuildContext context, CrmLeadsTesteRecord lead) {
    if (_isVenda(lead)) {
      return FlutterFlowTheme.of(context).primary;
    } else if (_isPerda(lead)) {
      return FlutterFlowTheme.of(context).error;
    }
    return FlutterFlowTheme.of(context).primaryBackground;
  }

  String _formatCurrency(double value) {
    if (value == 0) return '0,00';
    final parts = value.toStringAsFixed(2).split('.');
    final intPart = parts[0];
    final decPart = parts[1];
    final buffer = StringBuffer();
    int count = 0;
    for (int i = intPart.length - 1; i >= 0; i--) {
      buffer.write(intPart[i]);
      count++;
      if (count % 3 == 0 && i > 0 && intPart[i - 1] != '-') {
        buffer.write('.');
      }
    }
    return '${buffer.toString().split('').reversed.join()},$decPart';
  }
}
