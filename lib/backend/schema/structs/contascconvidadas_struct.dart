// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ContascconvidadasStruct extends FFFirebaseStruct {
  ContascconvidadasStruct({
    String? userId,
    String? nome,
    bool? permission,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _userId = userId,
        _nome = nome,
        _permission = permission,
        super(firestoreUtilData);

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "Nome" field.
  String? _nome;
  String get nome => _nome ?? '';
  set nome(String? val) => _nome = val;

  bool hasNome() => _nome != null;

  // "Permission" field.
  bool? _permission;
  bool get permission => _permission ?? false;
  set permission(bool? val) => _permission = val;

  bool hasPermission() => _permission != null;

  static ContascconvidadasStruct fromMap(Map<String, dynamic> data) =>
      ContascconvidadasStruct(
        userId: data['user_id'] as String?,
        nome: data['Nome'] as String?,
        permission: data['Permission'] as bool?,
      );

  static ContascconvidadasStruct? maybeFromMap(dynamic data) => data is Map
      ? ContascconvidadasStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'user_id': _userId,
        'Nome': _nome,
        'Permission': _permission,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'user_id': serializeParam(
          _userId,
          ParamType.String,
        ),
        'Nome': serializeParam(
          _nome,
          ParamType.String,
        ),
        'Permission': serializeParam(
          _permission,
          ParamType.bool,
        ),
      }.withoutNulls;

  static ContascconvidadasStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ContascconvidadasStruct(
        userId: deserializeParam(
          data['user_id'],
          ParamType.String,
          false,
        ),
        nome: deserializeParam(
          data['Nome'],
          ParamType.String,
          false,
        ),
        permission: deserializeParam(
          data['Permission'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'ContascconvidadasStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ContascconvidadasStruct &&
        userId == other.userId &&
        nome == other.nome &&
        permission == other.permission;
  }

  @override
  int get hashCode => const ListEquality().hash([userId, nome, permission]);
}

ContascconvidadasStruct createContascconvidadasStruct({
  String? userId,
  String? nome,
  bool? permission,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ContascconvidadasStruct(
      userId: userId,
      nome: nome,
      permission: permission,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ContascconvidadasStruct? updateContascconvidadasStruct(
  ContascconvidadasStruct? contascconvidadas, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    contascconvidadas
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addContascconvidadasStructData(
  Map<String, dynamic> firestoreData,
  ContascconvidadasStruct? contascconvidadas,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (contascconvidadas == null) {
    return;
  }
  if (contascconvidadas.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && contascconvidadas.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final contascconvidadasData =
      getContascconvidadasFirestoreData(contascconvidadas, forFieldValue);
  final nestedData =
      contascconvidadasData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = contascconvidadas.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getContascconvidadasFirestoreData(
  ContascconvidadasStruct? contascconvidadas, [
  bool forFieldValue = false,
]) {
  if (contascconvidadas == null) {
    return {};
  }
  final firestoreData = mapToFirestore(contascconvidadas.toMap());

  // Add any Firestore field values
  contascconvidadas.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getContascconvidadasListFirestoreData(
  List<ContascconvidadasStruct>? contascconvidadass,
) =>
    contascconvidadass
        ?.map((e) => getContascconvidadasFirestoreData(e, true))
        .toList() ??
    [];
