import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/configuracoes/loading/loading_widget.dart';
import '/configuracoes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  bool dropdown = false;

  bool temconta = false;

  bool loaded = false;

  String selectedtype = 'IMAGE';

  bool demografia = false;

  String? tipoconta;

  String? campanha;

  bool mastergoogle = false;

  bool masterinsta = false;

  bool mastermetaads = false;

  List<ContasRecord> contasmasterlist = [];
  void addToContasmasterlist(ContasRecord item) => contasmasterlist.add(item);
  void removeFromContasmasterlist(ContasRecord item) =>
      contasmasterlist.remove(item);
  void removeAtIndexFromContasmasterlist(int index) =>
      contasmasterlist.removeAt(index);
  void insertAtIndexInContasmasterlist(int index, ContasRecord item) =>
      contasmasterlist.insert(index, item);
  void updateContasmasterlistAtIndex(
          int index, Function(ContasRecord) updateFn) =>
      contasmasterlist[index] = updateFn(contasmasterlist[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in home widget.
  int? numcontasusuario;
  // Stores action output result for [Backend Call - API (Dados Mensais)] action in home widget.
  ApiCallResponse? dadospostbackend;
  // Stores action output result for [Custom Action - coletaultimodia] action in home widget.
  DateTime? ultimodia;
  // Stores action output result for [Custom Action - coletaprimeirodia] action in home widget.
  DateTime? primeirodia;
  // Stores action output result for [Custom Action - iniciomesanterior] action in home widget.
  DateTime? primeirodiaanterior;
  // Stores action output result for [Custom Action - finalmesanterior] action in home widget.
  DateTime? ultimodiaanterior;
  // Stores action output result for [Custom Action - iniciomesanterior] action in home widget.
  DateTime? primeirodiaanteriorantes;
  // Stores action output result for [Custom Action - finalmesanterior] action in home widget.
  DateTime? ultimodiaanteriorantes;
  // Stores action output result for [Backend Call - API (Dados Comentarios)] action in home widget.
  ApiCallResponse? dadoscomentario;
  // Stores action output result for [Backend Call - API (Dados Estrategia)] action in home widget.
  ApiCallResponse? dadosestrategia;
  // Stores action output result for [Firestore Query - Query a collection] action in home widget.
  ContasRecord? contaselecionada;
  // Stores action output result for [Backend Call - API (Demografia)] action in home widget.
  ApiCallResponse? demografias;
  // Stores action output result for [Backend Call - API (Dados atuais insta)] action in home widget.
  ApiCallResponse? dadosatuaisinsta;
  // Stores action output result for [Backend Call - API (Dados atuais face)] action in home widget.
  ApiCallResponse? dadosatuaisface;
  // Stores action output result for [Backend Call - API (Dados Google Campanha)] action in home widget.
  ApiCallResponse? dadospostbackendgoogle;
  // Stores action output result for [Custom Action - coletaultimodia] action in home widget.
  DateTime? ultimodiagoogle;
  // Stores action output result for [Custom Action - coletaprimeirodia] action in home widget.
  DateTime? primeirodiagoogle;
  // Stores action output result for [Custom Action - iniciomesanterior] action in home widget.
  DateTime? primeirodiaanteriorgoogle;
  // Stores action output result for [Custom Action - finalmesanterior] action in home widget.
  DateTime? ultimodiaanteriorgoogle;
  // Stores action output result for [Custom Action - iniciomesanterior] action in home widget.
  DateTime? primeirodiaanteriorantesgoogle;
  // Stores action output result for [Custom Action - finalmesanterior] action in home widget.
  DateTime? ultimodiaanteriorantesgoogle;
  // Stores action output result for [Backend Call - API (Dados Google Demografia)] action in home widget.
  ApiCallResponse? dadosdemografiagoogle;
  // Stores action output result for [Backend Call - API (Dados Google Palavras chave Mensal)] action in home widget.
  ApiCallResponse? dadospalavrachavegoogle;
  // Stores action output result for [Firestore Query - Query a collection] action in home widget.
  ContasRecord? contaselecionadagoogle;
  // Stores action output result for [Backend Call - API (Dados Ads Mensal)] action in home widget.
  ApiCallResponse? dadospostbackendmeta;
  // Stores action output result for [Custom Action - coletaultimodia] action in home widget.
  DateTime? ultimodiameta;
  // Stores action output result for [Custom Action - coletaprimeirodia] action in home widget.
  DateTime? primeirodiameta;
  // Stores action output result for [Custom Action - iniciomesanterior] action in home widget.
  DateTime? primeirodiaanteriormeta;
  // Stores action output result for [Custom Action - finalmesanterior] action in home widget.
  DateTime? ultimodiaanteriormeta;
  // Stores action output result for [Custom Action - iniciomesanterior] action in home widget.
  DateTime? primeirodiaanteriorantesmeta;
  // Stores action output result for [Custom Action - finalmesanterior] action in home widget.
  DateTime? ultimodiaanteriorantesmeta;
  // Stores action output result for [Backend Call - API (Dados Conjuntos)] action in home widget.
  ApiCallResponse? dadosconjuntometa;
  // Stores action output result for [Firestore Query - Query a collection] action in home widget.
  ContasRecord? contaselecionadameta;
  // Stores action output result for [Firestore Query - Query a collection] action in home widget.
  ContasRecord? contamaster;
  // Stores action output result for [Firestore Query - Query a collection] action in home widget.
  ContasMasterRecord? contamasterrelacao;
  // Stores action output result for [Backend Call - Read Document] action in home widget.
  ContasRecord? loopconta;
  // Stores action output result for [Backend Call - API (Dados Google Campanha)] action in home widget.
  ApiCallResponse? masterGooglecampanha;
  // Stores action output result for [Backend Call - API (Dados Google Demografia)] action in home widget.
  ApiCallResponse? masterGoogledemografia;
  // Stores action output result for [Backend Call - API (Dados Google Palavras chave Mensal)] action in home widget.
  ApiCallResponse? masterGooglepalavraschave;
  // Stores action output result for [Backend Call - API (Dados Ads Mensal)] action in home widget.
  ApiCallResponse? masterMetadadosmensais;
  // Stores action output result for [Backend Call - API (Dados Conjuntos)] action in home widget.
  ApiCallResponse? masterMetaadsconjuntos;
  // Stores action output result for [Backend Call - API (Dados Mensais)] action in home widget.
  ApiCallResponse? masterInstadadosmensais;
  // Stores action output result for [Backend Call - API (Dados Posts)] action in home widget.
  ApiCallResponse? masterInstaposts;
  // Stores action output result for [Backend Call - API (Dados Comentarios)] action in home widget.
  ApiCallResponse? masterInstacomentario;
  // Stores action output result for [Backend Call - API (Demografia)] action in home widget.
  ApiCallResponse? masterInstademografia;
  // Stores action output result for [Backend Call - API (Cronograma)] action in home widget.
  ApiCallResponse? instaCronograma;
  // Stores action output result for [Custom Action - coletaultimodia] action in home widget.
  DateTime? masterUltimodiainsta;
  // Stores action output result for [Custom Action - coletaprimeirodia] action in home widget.
  DateTime? masterPrimeirodiainsta;
  // Stores action output result for [Custom Action - iniciomesanterior] action in home widget.
  DateTime? masterPrimeirodiaanteriorinsta;
  // Stores action output result for [Custom Action - finalmesanterior] action in home widget.
  DateTime? masterUltimodiaanteriorinsta;
  // Stores action output result for [Custom Action - iniciomesanterior] action in home widget.
  DateTime? masterPrimeirodiaanteriorantesinsta;
  // Stores action output result for [Custom Action - finalmesanterior] action in home widget.
  DateTime? masterUltimodiaanteriorantesinsta;
  // Stores action output result for [Custom Action - coletaultimodia] action in home widget.
  DateTime? masterUltimodiagoogle;
  // Stores action output result for [Custom Action - coletaprimeirodia] action in home widget.
  DateTime? masterPrimeirodiagoogle;
  // Stores action output result for [Custom Action - iniciomesanterior] action in home widget.
  DateTime? masterPrimeirodiaanteriorgoogle;
  // Stores action output result for [Custom Action - finalmesanterior] action in home widget.
  DateTime? masterUltimodiaanteriorgoogle;
  // Stores action output result for [Custom Action - iniciomesanterior] action in home widget.
  DateTime? masterPrimeirodiaanteriorantesgoogle;
  // Stores action output result for [Custom Action - finalmesanterior] action in home widget.
  DateTime? masterUltimodiaanteriorantesgoogle;
  // Stores action output result for [Custom Action - coletaultimodia] action in home widget.
  DateTime? masterUltimodiametaads;
  // Stores action output result for [Custom Action - coletaprimeirodia] action in home widget.
  DateTime? masterPrimeirodiametaads;
  // Stores action output result for [Custom Action - iniciomesanterior] action in home widget.
  DateTime? masterPrimeirodiaanteriormetaads;
  // Stores action output result for [Custom Action - finalmesanterior] action in home widget.
  DateTime? masterUltimodiaanteriormetaads;
  // Stores action output result for [Custom Action - iniciomesanterior] action in home widget.
  DateTime? masterPrimeirodiaanteriorantesmetaads;
  // Stores action output result for [Custom Action - finalmesanterior] action in home widget.
  DateTime? masterUltimodiaanteriorantesmetaads;
  // Model for menu component.
  late MenuModel menuModel;
  // State field(s) for PageView widget.
  PageController? pageViewController1;

  int get pageViewCurrentIndex1 => pageViewController1 != null &&
          pageViewController1!.hasClients &&
          pageViewController1!.page != null
      ? pageViewController1!.page!.round()
      : 0;
  // State field(s) for PageView widget.
  PageController? pageViewController2;

  int get pageViewCurrentIndex2 => pageViewController2 != null &&
          pageViewController2!.hasClients &&
          pageViewController2!.page != null
      ? pageViewController2!.page!.round()
      : 0;
  // State field(s) for PageView widget.
  PageController? pageViewController3;

  int get pageViewCurrentIndex3 => pageViewController3 != null &&
          pageViewController3!.hasClients &&
          pageViewController3!.page != null
      ? pageViewController3!.page!.round()
      : 0;
  // State field(s) for PageView widget.
  PageController? pageViewController4;

  int get pageViewCurrentIndex4 => pageViewController4 != null &&
          pageViewController4!.hasClients &&
          pageViewController4!.page != null
      ? pageViewController4!.page!.round()
      : 0;
  // Stores action output result for [Custom Action - loginWithFacebook] action in Button widget.
  String? authCodemetapc;
  // Model for loading component.
  late LoadingModel loadingModel;

  @override
  void initState(BuildContext context) {
    menuModel = createModel(context, () => MenuModel());
    loadingModel = createModel(context, () => LoadingModel());
  }

  @override
  void dispose() {
    menuModel.dispose();
    loadingModel.dispose();
  }
}
