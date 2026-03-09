// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ContatoStruct extends FFFirebaseStruct {
  ContatoStruct({
    String? email,
    String? telefone,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _email = email,
        _telefone = telefone,
        super(firestoreUtilData);

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "telefone" field.
  String? _telefone;
  String get telefone => _telefone ?? '';
  set telefone(String? val) => _telefone = val;

  bool hasTelefone() => _telefone != null;

  static ContatoStruct fromMap(Map<String, dynamic> data) => ContatoStruct(
        email: data['email'] as String?,
        telefone: data['telefone'] as String?,
      );

  static ContatoStruct? maybeFromMap(dynamic data) =>
      data is Map ? ContatoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'email': _email,
        'telefone': _telefone,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'telefone': serializeParam(
          _telefone,
          ParamType.String,
        ),
      }.withoutNulls;

  static ContatoStruct fromSerializableMap(Map<String, dynamic> data) =>
      ContatoStruct(
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        telefone: deserializeParam(
          data['telefone'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ContatoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ContatoStruct &&
        email == other.email &&
        telefone == other.telefone;
  }

  @override
  int get hashCode => const ListEquality().hash([email, telefone]);
}

ContatoStruct createContatoStruct({
  String? email,
  String? telefone,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ContatoStruct(
      email: email,
      telefone: telefone,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ContatoStruct? updateContatoStruct(
  ContatoStruct? contato, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    contato
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addContatoStructData(
  Map<String, dynamic> firestoreData,
  ContatoStruct? contato,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (contato == null) {
    return;
  }
  if (contato.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && contato.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final contatoData = getContatoFirestoreData(contato, forFieldValue);
  final nestedData = contatoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = contato.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getContatoFirestoreData(
  ContatoStruct? contato, [
  bool forFieldValue = false,
]) {
  if (contato == null) {
    return {};
  }
  final firestoreData = mapToFirestore(contato.toMap());

  // Add any Firestore field values
  contato.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getContatoListFirestoreData(
  List<ContatoStruct>? contatos,
) =>
    contatos?.map((e) => getContatoFirestoreData(e, true)).toList() ?? [];
