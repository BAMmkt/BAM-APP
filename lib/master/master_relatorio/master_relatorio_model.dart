import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'master_relatorio_widget.dart' show MasterRelatorioWidget;
import 'package:flutter/material.dart';

class MasterRelatorioModel extends FlutterFlowModel<MasterRelatorioWidget> {
  ///  Local state fields for this page.

  bool dropdown = false;

  bool temconta = false;

  bool loaded = false;

  bool semestrategia = false;

  bool editmode = false;

  String? relatorio;

  String? metas;

  String? sugestoescont;

  String? metasanteriores;

  bool masterinsta = false;

  bool mastermeta = false;

  bool mastergoogle = false;

  List<ContasRecord> listacontamaster = [];
  void addToListacontamaster(ContasRecord item) => listacontamaster.add(item);
  void removeFromListacontamaster(ContasRecord item) =>
      listacontamaster.remove(item);
  void removeAtIndexFromListacontamaster(int index) =>
      listacontamaster.removeAt(index);
  void insertAtIndexInListacontamaster(int index, ContasRecord item) =>
      listacontamaster.insert(index, item);
  void updateListacontamasterAtIndex(
          int index, Function(ContasRecord) updateFn) =>
      listacontamaster[index] = updateFn(listacontamaster[index]);

  List<String> listacontas = [];
  void addToListacontas(String item) => listacontas.add(item);
  void removeFromListacontas(String item) => listacontas.remove(item);
  void removeAtIndexFromListacontas(int index) => listacontas.removeAt(index);
  void insertAtIndexInListacontas(int index, String item) =>
      listacontas.insert(index, item);
  void updateListacontasAtIndex(int index, Function(String) updateFn) =>
      listacontas[index] = updateFn(listacontas[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in master-relatorio widget.
  int? numcontasusuario;
  // Stores action output result for [Backend Call - API (Dados Estrategia)] action in master-relatorio widget.
  ApiCallResponse? dadosmensaisbackend;
  // Stores action output result for [Custom Action - coletaultimodia] action in master-relatorio widget.
  DateTime? ultimodia;
  // Stores action output result for [Custom Action - coletaprimeirodia] action in master-relatorio widget.
  DateTime? primeirodia;
  // Stores action output result for [Custom Action - iniciomesanterior] action in master-relatorio widget.
  DateTime? primeirodiaanterior;
  // Stores action output result for [Custom Action - finalmesanterior] action in master-relatorio widget.
  DateTime? ultimodiaanterior;
  // Stores action output result for [Firestore Query - Query a collection] action in master-relatorio widget.
  ContasRecord? contaselecionada;
  // Stores action output result for [Firestore Query - Query a collection] action in master-relatorio widget.
  ContasRecord? contamaster;
  // Stores action output result for [Firestore Query - Query a collection] action in master-relatorio widget.
  ContasMasterRecord? contamasterrelacao;
  // Stores action output result for [Backend Call - Read Document] action in master-relatorio widget.
  ContasRecord? loopconta;
  // Stores action output result for [Backend Call - API (Dados Formulario master)] action in master-relatorio widget.
  ApiCallResponse? dadosformulario;
  // Model for menu component.
  late MenuModel menuModel;
  // State field(s) for relatoriogeral widget.
  FocusNode? relatoriogeralFocusNode;
  TextEditingController? relatoriogeralTextController;
  String? Function(BuildContext, String?)?
      relatoriogeralTextControllerValidator;
  // State field(s) for metaanterioresgeral widget.
  FocusNode? metaanterioresgeralFocusNode;
  TextEditingController? metaanterioresgeralTextController;
  String? Function(BuildContext, String?)?
      metaanterioresgeralTextControllerValidator;
  // State field(s) for metasfuturasgeral widget.
  FocusNode? metasfuturasgeralFocusNode;
  TextEditingController? metasfuturasgeralTextController;
  String? Function(BuildContext, String?)?
      metasfuturasgeralTextControllerValidator;
  // State field(s) for acoesunificadasgeral widget.
  FocusNode? acoesunificadasgeralFocusNode;
  TextEditingController? acoesunificadasgeralTextController;
  String? Function(BuildContext, String?)?
      acoesunificadasgeralTextControllerValidator;
  // State field(s) for sazonalidadeeoportunidades widget.
  FocusNode? sazonalidadeeoportunidadesFocusNode;
  TextEditingController? sazonalidadeeoportunidadesTextController;
  String? Function(BuildContext, String?)?
      sazonalidadeeoportunidadesTextControllerValidator;
  // State field(s) for googleralatoriodepalavraschave widget.
  FocusNode? googleralatoriodepalavraschaveFocusNode;
  TextEditingController? googleralatoriodepalavraschaveTextController;
  String? Function(BuildContext, String?)?
      googleralatoriodepalavraschaveTextControllerValidator;
  // State field(s) for otimizacoespalavraschave widget.
  FocusNode? otimizacoespalavraschaveFocusNode;
  TextEditingController? otimizacoespalavraschaveTextController;
  String? Function(BuildContext, String?)?
      otimizacoespalavraschaveTextControllerValidator;
  // State field(s) for googleoportunidadepalavraschave widget.
  FocusNode? googleoportunidadepalavraschaveFocusNode;
  TextEditingController? googleoportunidadepalavraschaveTextController;
  String? Function(BuildContext, String?)?
      googleoportunidadepalavraschaveTextControllerValidator;
  // State field(s) for palavraschavenegativacao widget.
  FocusNode? palavraschavenegativacaoFocusNode;
  TextEditingController? palavraschavenegativacaoTextController;
  String? Function(BuildContext, String?)?
      palavraschavenegativacaoTextControllerValidator;
  // State field(s) for sugestoesajusteleilao widget.
  FocusNode? sugestoesajusteleilaoFocusNode;
  TextEditingController? sugestoesajusteleilaoTextController;
  String? Function(BuildContext, String?)?
      sugestoesajusteleilaoTextControllerValidator;
  // State field(s) for relatoriodemografico widget.
  FocusNode? relatoriodemograficoFocusNode;
  TextEditingController? relatoriodemograficoTextController;
  String? Function(BuildContext, String?)?
      relatoriodemograficoTextControllerValidator;
  // State field(s) for descobertasexternas widget.
  FocusNode? descobertasexternasFocusNode;
  TextEditingController? descobertasexternasTextController;
  String? Function(BuildContext, String?)?
      descobertasexternasTextControllerValidator;
  // State field(s) for relatoriocriativo widget.
  FocusNode? relatoriocriativoFocusNode;
  TextEditingController? relatoriocriativoTextController;
  String? Function(BuildContext, String?)?
      relatoriocriativoTextControllerValidator;
  // State field(s) for sugestoesotimizacaocriativos widget.
  FocusNode? sugestoesotimizacaocriativosFocusNode;
  TextEditingController? sugestoesotimizacaocriativosTextController;
  String? Function(BuildContext, String?)?
      sugestoesotimizacaocriativosTextControllerValidator;
  // State field(s) for sugestoesnovoscriativos widget.
  FocusNode? sugestoesnovoscriativosFocusNode;
  TextEditingController? sugestoesnovoscriativosTextController;
  String? Function(BuildContext, String?)?
      sugestoesnovoscriativosTextControllerValidator;
  // State field(s) for relatoriogoogle widget.
  FocusNode? relatoriogoogleFocusNode;
  TextEditingController? relatoriogoogleTextController;
  String? Function(BuildContext, String?)?
      relatoriogoogleTextControllerValidator;
  // State field(s) for metasanterioresgoogle widget.
  FocusNode? metasanterioresgoogleFocusNode;
  TextEditingController? metasanterioresgoogleTextController;
  String? Function(BuildContext, String?)?
      metasanterioresgoogleTextControllerValidator;
  // State field(s) for metasfuturasgoogle widget.
  FocusNode? metasfuturasgoogleFocusNode;
  TextEditingController? metasfuturasgoogleTextController;
  String? Function(BuildContext, String?)?
      metasfuturasgoogleTextControllerValidator;
  // State field(s) for organicorelatoriodeconteudo widget.
  FocusNode? organicorelatoriodeconteudoFocusNode;
  TextEditingController? organicorelatoriodeconteudoTextController;
  String? Function(BuildContext, String?)?
      organicorelatoriodeconteudoTextControllerValidator;
  // State field(s) for analisemelhorespost widget.
  FocusNode? analisemelhorespostFocusNode;
  TextEditingController? analisemelhorespostTextController;
  String? Function(BuildContext, String?)?
      analisemelhorespostTextControllerValidator;
  // State field(s) for relatoriodesentimento widget.
  FocusNode? relatoriodesentimentoFocusNode;
  TextEditingController? relatoriodesentimentoTextController;
  String? Function(BuildContext, String?)?
      relatoriodesentimentoTextControllerValidator;
  // State field(s) for sugestoesdeconteudo widget.
  FocusNode? sugestoesdeconteudoFocusNode;
  TextEditingController? sugestoesdeconteudoTextController;
  String? Function(BuildContext, String?)?
      sugestoesdeconteudoTextControllerValidator;
  // State field(s) for organicorelatorioaudiencia widget.
  FocusNode? organicorelatorioaudienciaFocusNode;
  TextEditingController? organicorelatorioaudienciaTextController;
  String? Function(BuildContext, String?)?
      organicorelatorioaudienciaTextControllerValidator;
  // State field(s) for alinhamentodemografico widget.
  FocusNode? alinhamentodemograficoFocusNode;
  TextEditingController? alinhamentodemograficoTextController;
  String? Function(BuildContext, String?)?
      alinhamentodemograficoTextControllerValidator;
  // State field(s) for organicomelhoresperiodos widget.
  FocusNode? organicomelhoresperiodosFocusNode;
  TextEditingController? organicomelhoresperiodosTextController;
  String? Function(BuildContext, String?)?
      organicomelhoresperiodosTextControllerValidator;
  // State field(s) for organicoauditoriadefrequencia widget.
  FocusNode? organicoauditoriadefrequenciaFocusNode;
  TextEditingController? organicoauditoriadefrequenciaTextController;
  String? Function(BuildContext, String?)?
      organicoauditoriadefrequenciaTextControllerValidator;
  // State field(s) for organicorelatorio widget.
  FocusNode? organicorelatorioFocusNode;
  TextEditingController? organicorelatorioTextController;
  String? Function(BuildContext, String?)?
      organicorelatorioTextControllerValidator;
  // State field(s) for organicommetasanteriores widget.
  FocusNode? organicommetasanterioresFocusNode;
  TextEditingController? organicommetasanterioresTextController;
  String? Function(BuildContext, String?)?
      organicommetasanterioresTextControllerValidator;
  // State field(s) for organicometasfuturas widget.
  FocusNode? organicometasfuturasFocusNode;
  TextEditingController? organicometasfuturasTextController;
  String? Function(BuildContext, String?)?
      organicometasfuturasTextControllerValidator;
  // State field(s) for metaadsrelatoriocriativo widget.
  FocusNode? metaadsrelatoriocriativoFocusNode;
  TextEditingController? metaadsrelatoriocriativoTextController;
  String? Function(BuildContext, String?)?
      metaadsrelatoriocriativoTextControllerValidator;
  // State field(s) for melhorescriativos widget.
  FocusNode? melhorescriativosFocusNode;
  TextEditingController? melhorescriativosTextController;
  String? Function(BuildContext, String?)?
      melhorescriativosTextControllerValidator;
  // State field(s) for metasugestoescriativos widget.
  FocusNode? metasugestoescriativosFocusNode;
  TextEditingController? metasugestoescriativosTextController;
  String? Function(BuildContext, String?)?
      metasugestoescriativosTextControllerValidator;
  // State field(s) for relatoriodecampanha widget.
  FocusNode? relatoriodecampanhaFocusNode;
  TextEditingController? relatoriodecampanhaTextController;
  String? Function(BuildContext, String?)?
      relatoriodecampanhaTextControllerValidator;
  // State field(s) for metaadsmelhoresconjuntos widget.
  FocusNode? metaadsmelhoresconjuntosFocusNode;
  TextEditingController? metaadsmelhoresconjuntosTextController;
  String? Function(BuildContext, String?)?
      metaadsmelhoresconjuntosTextControllerValidator;
  // State field(s) for TextFieldmetaadsriscoseoportunidades widget.
  FocusNode? textFieldmetaadsriscoseoportunidadesFocusNode;
  TextEditingController? textFieldmetaadsriscoseoportunidadesTextController;
  String? Function(BuildContext, String?)?
      textFieldmetaadsriscoseoportunidadesTextControllerValidator;
  // State field(s) for metaadssugerstoesdeacao widget.
  FocusNode? metaadssugerstoesdeacaoFocusNode;
  TextEditingController? metaadssugerstoesdeacaoTextController;
  String? Function(BuildContext, String?)?
      metaadssugerstoesdeacaoTextControllerValidator;
  // State field(s) for metaadsrelatorio widget.
  FocusNode? metaadsrelatorioFocusNode;
  TextEditingController? metaadsrelatorioTextController;
  String? Function(BuildContext, String?)?
      metaadsrelatorioTextControllerValidator;
  // State field(s) for metaadsmetasanteriores widget.
  FocusNode? metaadsmetasanterioresFocusNode;
  TextEditingController? metaadsmetasanterioresTextController;
  String? Function(BuildContext, String?)?
      metaadsmetasanterioresTextControllerValidator;
  // State field(s) for metaadsmetasfuturas widget.
  FocusNode? metaadsmetasfuturasFocusNode;
  TextEditingController? metaadsmetasfuturasTextController;
  String? Function(BuildContext, String?)?
      metaadsmetasfuturasTextControllerValidator;
  // State field(s) for RatingBar widget.
  double? ratingBarValue;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController40;
  String? Function(BuildContext, String?)? textController40Validator;
  // Stores action output result for [Backend Call - API (avaliar relatorio)] action in Button widget.
  ApiCallResponse? apiResultmwx;
  // Stores action output result for [Backend Call - API (resetar relatorio)] action in Icon widget.
  ApiCallResponse? apiResultrvb;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? authCode;
  // Stores action output result for [Backend Call - API (Editar Relatorio)] action in Button widget.
  ApiCallResponse? apiResult8mp;

  @override
  void initState(BuildContext context) {
    menuModel = createModel(context, () => MenuModel());
  }

  @override
  void dispose() {
    menuModel.dispose();
    relatoriogeralFocusNode?.dispose();
    relatoriogeralTextController?.dispose();

    metaanterioresgeralFocusNode?.dispose();
    metaanterioresgeralTextController?.dispose();

    metasfuturasgeralFocusNode?.dispose();
    metasfuturasgeralTextController?.dispose();

    acoesunificadasgeralFocusNode?.dispose();
    acoesunificadasgeralTextController?.dispose();

    sazonalidadeeoportunidadesFocusNode?.dispose();
    sazonalidadeeoportunidadesTextController?.dispose();

    googleralatoriodepalavraschaveFocusNode?.dispose();
    googleralatoriodepalavraschaveTextController?.dispose();

    otimizacoespalavraschaveFocusNode?.dispose();
    otimizacoespalavraschaveTextController?.dispose();

    googleoportunidadepalavraschaveFocusNode?.dispose();
    googleoportunidadepalavraschaveTextController?.dispose();

    palavraschavenegativacaoFocusNode?.dispose();
    palavraschavenegativacaoTextController?.dispose();

    sugestoesajusteleilaoFocusNode?.dispose();
    sugestoesajusteleilaoTextController?.dispose();

    relatoriodemograficoFocusNode?.dispose();
    relatoriodemograficoTextController?.dispose();

    descobertasexternasFocusNode?.dispose();
    descobertasexternasTextController?.dispose();

    relatoriocriativoFocusNode?.dispose();
    relatoriocriativoTextController?.dispose();

    sugestoesotimizacaocriativosFocusNode?.dispose();
    sugestoesotimizacaocriativosTextController?.dispose();

    sugestoesnovoscriativosFocusNode?.dispose();
    sugestoesnovoscriativosTextController?.dispose();

    relatoriogoogleFocusNode?.dispose();
    relatoriogoogleTextController?.dispose();

    metasanterioresgoogleFocusNode?.dispose();
    metasanterioresgoogleTextController?.dispose();

    metasfuturasgoogleFocusNode?.dispose();
    metasfuturasgoogleTextController?.dispose();

    organicorelatoriodeconteudoFocusNode?.dispose();
    organicorelatoriodeconteudoTextController?.dispose();

    analisemelhorespostFocusNode?.dispose();
    analisemelhorespostTextController?.dispose();

    relatoriodesentimentoFocusNode?.dispose();
    relatoriodesentimentoTextController?.dispose();

    sugestoesdeconteudoFocusNode?.dispose();
    sugestoesdeconteudoTextController?.dispose();

    organicorelatorioaudienciaFocusNode?.dispose();
    organicorelatorioaudienciaTextController?.dispose();

    alinhamentodemograficoFocusNode?.dispose();
    alinhamentodemograficoTextController?.dispose();

    organicomelhoresperiodosFocusNode?.dispose();
    organicomelhoresperiodosTextController?.dispose();

    organicoauditoriadefrequenciaFocusNode?.dispose();
    organicoauditoriadefrequenciaTextController?.dispose();

    organicorelatorioFocusNode?.dispose();
    organicorelatorioTextController?.dispose();

    organicommetasanterioresFocusNode?.dispose();
    organicommetasanterioresTextController?.dispose();

    organicometasfuturasFocusNode?.dispose();
    organicometasfuturasTextController?.dispose();

    metaadsrelatoriocriativoFocusNode?.dispose();
    metaadsrelatoriocriativoTextController?.dispose();

    melhorescriativosFocusNode?.dispose();
    melhorescriativosTextController?.dispose();

    metasugestoescriativosFocusNode?.dispose();
    metasugestoescriativosTextController?.dispose();

    relatoriodecampanhaFocusNode?.dispose();
    relatoriodecampanhaTextController?.dispose();

    metaadsmelhoresconjuntosFocusNode?.dispose();
    metaadsmelhoresconjuntosTextController?.dispose();

    textFieldmetaadsriscoseoportunidadesFocusNode?.dispose();
    textFieldmetaadsriscoseoportunidadesTextController?.dispose();

    metaadssugerstoesdeacaoFocusNode?.dispose();
    metaadssugerstoesdeacaoTextController?.dispose();

    metaadsrelatorioFocusNode?.dispose();
    metaadsrelatorioTextController?.dispose();

    metaadsmetasanterioresFocusNode?.dispose();
    metaadsmetasanterioresTextController?.dispose();

    metaadsmetasfuturasFocusNode?.dispose();
    metaadsmetasfuturasTextController?.dispose();

    textFieldFocusNode?.dispose();
    textController40?.dispose();
  }
}
