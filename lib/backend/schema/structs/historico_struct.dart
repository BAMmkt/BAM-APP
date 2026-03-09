// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class HistoricoStruct extends FFFirebaseStruct {
  HistoricoStruct({
    DateTime? dataDeEntrada,
    String? texto,
    String? tipo,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _dataDeEntrada = dataDeEntrada,
        _texto = texto,
        _tipo = tipo,
        super(firestoreUtilData);

  // "data_de_entrada" field.
  DateTime? _dataDeEntrada;
  DateTime? get dataDeEntrada => _dataDeEntrada;
  set dataDeEntrada(DateTime? val) => _dataDeEntrada = val;

  bool hasDataDeEntrada() => _dataDeEntrada != null;

  // "texto" field.
  String? _texto;
  String get texto => _texto ?? '';
  set texto(String? val) => _texto = val;

  bool hasTexto() => _texto != null;

  // "tipo" field.
  String? _tipo;
  String get tipo => _tipo ?? '';
  set tipo(String? val) => _tipo = val;

  bool hasTipo() => _tipo != null;

  static HistoricoStruct fromMap(Map<String, dynamic> data) => HistoricoStruct(
        dataDeEntrada: data['data_de_entrada'] as DateTime?,
        texto: data['texto'] as String?,
        tipo: data['tipo'] as String?,
      );

  static HistoricoStruct? maybeFromMap(dynamic data) => data is Map
      ? HistoricoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'data_de_entrada': _dataDeEntrada,
        'texto': _texto,
        'tipo': _tipo,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'data_de_entrada': serializeParam(
          _dataDeEntrada,
          ParamType.DateTime,
        ),
        'texto': serializeParam(
          _texto,
          ParamType.String,
        ),
        'tipo': serializeParam(
          _tipo,
          ParamType.String,
        ),
      }.withoutNulls;

  static HistoricoStruct fromSerializableMap(Map<String, dynamic> data) =>
      HistoricoStruct(
        dataDeEntrada: deserializeParam(
          data['data_de_entrada'],
          ParamType.DateTime,
          false,
        ),
        texto: deserializeParam(
          data['texto'],
          ParamType.String,
          false,
        ),
        tipo: deserializeParam(
          data['tipo'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'HistoricoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is HistoricoStruct &&
        dataDeEntrada == other.dataDeEntrada &&
        texto == other.texto &&
        tipo == other.tipo;
  }

  @override
  int get hashCode => const ListEquality().hash([dataDeEntrada, texto, tipo]);
}

HistoricoStruct createHistoricoStruct({
  DateTime? dataDeEntrada,
  String? texto,
  String? tipo,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    HistoricoStruct(
      dataDeEntrada: dataDeEntrada,
      texto: texto,
      tipo: tipo,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

HistoricoStruct? updateHistoricoStruct(
  HistoricoStruct? historico, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    historico
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addHistoricoStructData(
  Map<String, dynamic> firestoreData,
  HistoricoStruct? historico,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (historico == null) {
    return;
  }
  if (historico.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && historico.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final historicoData = getHistoricoFirestoreData(historico, forFieldValue);
  final nestedData = historicoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = historico.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getHistoricoFirestoreData(
  HistoricoStruct? historico, [
  bool forFieldValue = false,
]) {
  if (historico == null) {
    return {};
  }
  final firestoreData = mapToFirestore(historico.toMap());

  // Add any Firestore field values
  historico.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getHistoricoListFirestoreData(
  List<HistoricoStruct>? historicos,
) =>
    historicos?.map((e) => getHistoricoFirestoreData(e, true)).toList() ?? [];
