import 'package:flutter/material.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  DateTime? _DataInicioMes = DateTime.fromMillisecondsSinceEpoch(946748940000);
  DateTime? get DataInicioMes => _DataInicioMes;
  set DataInicioMes(DateTime? value) {
    _DataInicioMes = value;
  }

  DateTime? _DataFinalMes = DateTime.fromMillisecondsSinceEpoch(949341000000);
  DateTime? get DataFinalMes => _DataFinalMes;
  set DataFinalMes(DateTime? value) {
    _DataFinalMes = value;
  }

  DateTime? _DataInicioMesAnterior;
  DateTime? get DataInicioMesAnterior => _DataInicioMesAnterior;
  set DataInicioMesAnterior(DateTime? value) {
    _DataInicioMesAnterior = value;
  }

  DateTime? _DataFinalMesAnterior;
  DateTime? get DataFinalMesAnterior => _DataFinalMesAnterior;
  set DataFinalMesAnterior(DateTime? value) {
    _DataFinalMesAnterior = value;
  }

  List<String> _genero = ['M', 'F'];
  List<String> get genero => _genero;
  set genero(List<String> value) {
    _genero = value;
  }

  void addToGenero(String value) {
    genero.add(value);
  }

  void removeFromGenero(String value) {
    genero.remove(value);
  }

  void removeAtIndexFromGenero(int index) {
    genero.removeAt(index);
  }

  void updateGeneroAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    genero[index] = updateFn(_genero[index]);
  }

  void insertAtIndexInGenero(int index, String value) {
    genero.insert(index, value);
  }

  List<String> _faixaetariagoogle = [
    '18-24',
    '25-34',
    '35-44',
    '45-54',
    '55-64',
    '65+',
    'Indefinido'
  ];
  List<String> get faixaetariagoogle => _faixaetariagoogle;
  set faixaetariagoogle(List<String> value) {
    _faixaetariagoogle = value;
  }

  void addToFaixaetariagoogle(String value) {
    faixaetariagoogle.add(value);
  }

  void removeFromFaixaetariagoogle(String value) {
    faixaetariagoogle.remove(value);
  }

  void removeAtIndexFromFaixaetariagoogle(int index) {
    faixaetariagoogle.removeAt(index);
  }

  void updateFaixaetariagoogleAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    faixaetariagoogle[index] = updateFn(_faixaetariagoogle[index]);
  }

  void insertAtIndexInFaixaetariagoogle(int index, String value) {
    faixaetariagoogle.insert(index, value);
  }

  List<String> _diadasemana = [
    'Segunda',
    'Terça',
    'Quarta',
    'Quinta',
    'Sexta',
    'Sabado',
    'Domingo'
  ];
  List<String> get diadasemana => _diadasemana;
  set diadasemana(List<String> value) {
    _diadasemana = value;
  }

  void addToDiadasemana(String value) {
    diadasemana.add(value);
  }

  void removeFromDiadasemana(String value) {
    diadasemana.remove(value);
  }

  void removeAtIndexFromDiadasemana(int index) {
    diadasemana.removeAt(index);
  }

  void updateDiadasemanaAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    diadasemana[index] = updateFn(_diadasemana[index]);
  }

  void insertAtIndexInDiadasemana(int index, String value) {
    diadasemana.insert(index, value);
  }

  List<int> _dds = [1, 2, 3, 4, 5, 6, 7];
  List<int> get dds => _dds;
  set dds(List<int> value) {
    _dds = value;
  }

  void addToDds(int value) {
    dds.add(value);
  }

  void removeFromDds(int value) {
    dds.remove(value);
  }

  void removeAtIndexFromDds(int index) {
    dds.removeAt(index);
  }

  void updateDdsAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    dds[index] = updateFn(_dds[index]);
  }

  void insertAtIndexInDds(int index, int value) {
    dds.insert(index, value);
  }

  DateTime? _DataInicioMesAnteriorAntes;
  DateTime? get DataInicioMesAnteriorAntes => _DataInicioMesAnteriorAntes;
  set DataInicioMesAnteriorAntes(DateTime? value) {
    _DataInicioMesAnteriorAntes = value;
  }

  DateTime? _DataFinalMesAnteriorAntes;
  DateTime? get DataFinalMesAnteriorAntes => _DataFinalMesAnteriorAntes;
  set DataFinalMesAnteriorAntes(DateTime? value) {
    _DataFinalMesAnteriorAntes = value;
  }

  List<String> _basichistorico = ['Ligação', 'Reunião', 'Anotação', 'Email'];
  List<String> get basichistorico => _basichistorico;
  set basichistorico(List<String> value) {
    _basichistorico = value;
  }

  void addToBasichistorico(String value) {
    basichistorico.add(value);
  }

  void removeFromBasichistorico(String value) {
    basichistorico.remove(value);
  }

  void removeAtIndexFromBasichistorico(int index) {
    basichistorico.removeAt(index);
  }

  void updateBasichistoricoAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    basichistorico[index] = updateFn(_basichistorico[index]);
  }

  void insertAtIndexInBasichistorico(int index, String value) {
    basichistorico.insert(index, value);
  }

  List<String> _basicpipeline = [
    'Novo Lead',
    'Primeiro Contato',
    'Negociação',
    'Venda'
  ];
  List<String> get basicpipeline => _basicpipeline;
  set basicpipeline(List<String> value) {
    _basicpipeline = value;
  }

  void addToBasicpipeline(String value) {
    basicpipeline.add(value);
  }

  void removeFromBasicpipeline(String value) {
    basicpipeline.remove(value);
  }

  void removeAtIndexFromBasicpipeline(int index) {
    basicpipeline.removeAt(index);
  }

  void updateBasicpipelineAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    basicpipeline[index] = updateFn(_basicpipeline[index]);
  }

  void insertAtIndexInBasicpipeline(int index, String value) {
    basicpipeline.insert(index, value);
  }
}
