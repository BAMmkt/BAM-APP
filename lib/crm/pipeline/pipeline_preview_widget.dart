import '/app_state.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PipelinePreviewWidget extends StatefulWidget {
  const PipelinePreviewWidget({super.key});

  static String routeName = 'pipelinePreview';
  static String routePath = '/pipelinePreview';

  @override
  State<PipelinePreviewWidget> createState() => _PipelinePreviewWidgetState();
}

class _PipelinePreviewWidgetState extends State<PipelinePreviewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    final mediaQueryData = MediaQuery.of(context);

    const columns = <String>[
      'Black Friday',
      'Prospecção',
      '1º Contato',
      'Qualificação do Lead',
    ];

    final Map<String, List<_PreviewLead>> leadsByColumn = {
      'Black Friday': [],
      'Prospecção': [
        _PreviewLead(
          name: 'Lucia Alves',
          email: 'lucia.alves@example.com',
          value: 0,
          date: DateTime(2024, 10, 1),
        ),
        _PreviewLead(
          name: 'ELIZABETH MIDORI FRAGOSO ROCHA',
          email: 'elizabeth.midori@example.com',
          value: 0,
          date: DateTime(2024, 10, 1),
        ),
      ],
      '1º Contato': [
        _PreviewLead(
          name: 'Marcos Vinicius da Silva',
          email: 'marcos.vinicius@example.com',
          value: 0,
          date: DateTime(2024, 10, 2),
        ),
        _PreviewLead(
          name: 'Susan',
          email: 'susan@example.com',
          value: 0,
          date: DateTime(2024, 10, 2),
        ),
      ],
      'Qualificação do Lead': [
        _PreviewLead(
          name: 'Rosangela',
          email: 'rosangela@example.com',
          value: 0,
          date: DateTime(2024, 10, 3),
        ),
        _PreviewLead(
          name: 'Regiane',
          email: 'regiane@example.com',
          value: 0,
          date: DateTime(2024, 10, 3),
        ),
        _PreviewLead(
          name: 'Carla',
          email: 'carla@example.com',
          value: 0,
          date: DateTime(2024, 10, 3),
        ),
      ],
    };

    return MediaQuery(
      data: mediaQueryData.copyWith(
        textScaler: TextScaler.linear(mediaQueryData.textScaleFactor * 0.9),
      ),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: Container(
          width: MediaQuery.sizeOf(context).width * 0.66,
          child: Drawer(
            elevation: 16.0,
            child: WebViewAware(
              child: MenuWidget(),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          elevation: 0.0,
          leading: FlutterFlowIconButton(
            borderRadius: 8.0,
            buttonSize: 40.0,
            icon: Icon(
              Icons.menu,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () => scaffoldKey.currentState?.openDrawer(),
          ),
          title: Text(
            'Pipeline (preview)',
            style: FlutterFlowTheme.of(context).headlineSmall.override(
                  font: GoogleFonts.oswald(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                ),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: Icon(
                Icons.filter_list_rounded,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
              tooltip: 'Filtros',
              onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
            ),
            IconButton(
              icon: Icon(
                Icons.filter_alt_rounded,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
              tooltip: 'Gerenciar campos',
              onPressed: () {},
            ),
          ],
        ),
        endDrawer: Drawer(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  22.0, 24.0, 22.0, 24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filtros',
                      style:
                          FlutterFlowTheme.of(context).titleMedium.override(
                                font: GoogleFonts.oswald(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                              ),
                    ),
                    const SizedBox(height: 8.0),
                    Align(
                      alignment: AlignmentDirectional(1.0, 0.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                        tooltip: 'Fechar filtros',
                        onPressed: () => Navigator.of(context).maybePop(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Wrap(
                      spacing: 15.0,
                      runSpacing: 20.0,
                      children: [
                        _FilterField(
                          label: 'Nome da negociação',
                          width: 200.0,
                        ),
                        _FilterField(
                          label: 'Email da negociação',
                          width: 200.0,
                        ),
                        _FilterDropdown(
                          label: 'Responsável',
                          width: 200.0,
                        ),
                        _RangeField(
                          label: 'Valor total',
                          width: 100.0,
                        ),
                        _RangeField(
                          label: 'Data de criação',
                          width: 100.0,
                        ),
                        _RangeField(
                          label: 'Data fechamento',
                          width: 100.0,
                        ),
                        _RangeField(
                          label: 'Data última movimentação',
                          width: 100.0,
                        ),
                        _FilterField(
                          label: 'Campo Personalizado',
                          width: 260.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(22.0, 0.0, 22.0, 24.0),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: columns.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 20.0),
                  itemBuilder: (context, index) {
                    final columnName = columns[index];
                    final columnLeads = leadsByColumn[columnName] ?? const [];

                    return Container(
                      width: MediaQuery.sizeOf(context).width * 0.2,
                      decoration: BoxDecoration(
                        color:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              columnName,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              'Valor da etapa R\$ 0,00',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            const SizedBox(height: 10.0),
                            Expanded(
                              child: ListView.separated(
                                padding: EdgeInsets.zero,
                                itemCount: columnLeads.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 10.0),
                                itemBuilder: (context, leadIndex) {
                                  final lead = columnLeads[leadIndex];

                                  return Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            lead.name,
                                            style: FlutterFlowTheme.of(context)
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 18.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          const SizedBox(height: 7.0),
                                          Text(
                                            lead.email,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
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
                                                      .primaryText,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          const SizedBox(height: 16.0),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'R\$ ${lead.value.toStringAsFixed(2)}',
                                                style:
                                                    FlutterFlowTheme.of(context)
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
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                              Text(
                                                dateTimeFormat(
                                                  'yMd',
                                                  lead.date,
                                                  locale:
                                                      FFLocalizations.of(
                                                              context)
                                                          .languageCode,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
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
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewLead {
  final String name;
  final String email;
  final double value;
  final DateTime date;

  const _PreviewLead({
    required this.name,
    required this.email,
    required this.value,
    required this.date,
  });
}

class _FilterField extends StatelessWidget {
  const _FilterField({
    required this.label,
    required this.width,
  });

  final String label;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontStyle:
                      FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
                fontSize: 18.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          width: width,
          child: TextFormField(
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primaryText,
                  width: 1.0,
                ),
              ),
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  letterSpacing: 0.0,
                ),
          ),
        ),
      ],
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({
    required this.label,
    required this.width,
  });

  final String label;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontStyle:
                      FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
                fontSize: 18.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          width: width,
          child: InputDecorator(
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primaryText,
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selecionar',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                      ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RangeField extends StatelessWidget {
  const _RangeField({
    required this.label,
    required this.width,
  });

  final String label;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontStyle:
                      FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
                fontSize: 18.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            SizedBox(
              width: width,
              child: TextFormField(
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryText,
                      width: 1.0,
                    ),
                  ),
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .fontStyle,
                      ),
                      letterSpacing: 0.0,
                    ),
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
              child: Text('até'),
            ),
            SizedBox(
              width: width,
              child: TextFormField(
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryText,
                      width: 1.0,
                    ),
                  ),
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .fontStyle,
                      ),
                      letterSpacing: 0.0,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
