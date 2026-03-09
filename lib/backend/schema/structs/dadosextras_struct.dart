// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class DadosextrasStruct extends FFFirebaseStruct {
  DadosextrasStruct({
    String? titulo,
    String? valor,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _titulo = titulo,
        _valor = valor,
        super(firestoreUtilData);

  // "titulo" field.
  String? _titulo;
  String get titulo => _titulo ?? '';
  set titulo(String? val) => _titulo = val;

  bool hasTitulo() => _titulo != null;

  // "valor" field.
  String? _valor;
  String get valor => _valor ?? '';
  set valor(String? val) => _valor = val;

  bool hasValor() => _valor != null;

  static DadosextrasStruct fromMap(Map<String, dynamic> data) =>
      DadosextrasStruct(
        titulo: data['titulo'] as String?,
        valor: data['valor'] as String?,
      );

  static DadosextrasStruct? maybeFromMap(dynamic data) => data is Map
      ? DadosextrasStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'titulo': _titulo,
        'valor': _valor,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'titulo': serializeParam(
          _titulo,
          ParamType.String,
        ),
        'valor': serializeParam(
          _valor,
          ParamType.String,
        ),
      }.withoutNulls;

  static DadosextrasStruct fromSerializableMap(Map<String, dynamic> data) =>
      DadosextrasStruct(
        titulo: deserializeParam(
          data['titulo'],
          ParamType.String,
          false,
        ),
        valor: deserializeParam(
          data['valor'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DadosextrasStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DadosextrasStruct &&
        titulo == other.titulo &&
        valor == other.valor;
  }

  @override
  int get hashCode => const ListEquality().hash([titulo, valor]);
}

DadosextrasStruct createDadosextrasStruct({
  String? titulo,
  String? valor,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DadosextrasStruct(
      titulo: titulo,
      valor: valor,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DadosextrasStruct? updateDadosextrasStruct(
  DadosextrasStruct? dadosextras, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    dadosextras
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDadosextrasStructData(
  Map<String, dynamic> firestoreData,
  DadosextrasStruct? dadosextras,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (dadosextras == null) {
    return;
  }
  if (dadosextras.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && dadosextras.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final dadosextrasData =
      getDadosextrasFirestoreData(dadosextras, forFieldValue);
  final nestedData =
      dadosextrasData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = dadosextras.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDadosextrasFirestoreData(
  DadosextrasStruct? dadosextras, [
  bool forFieldValue = false,
]) {
  if (dadosextras == null) {
    return {};
  }
  final firestoreData = mapToFirestore(dadosextras.toMap());

  // Add any Firestore field values
  dadosextras.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDadosextrasListFirestoreData(
  List<DadosextrasStruct>? dadosextrass,
) =>
    dadosextrass?.map((e) => getDadosextrasFirestoreData(e, true)).toList() ??
    [];
