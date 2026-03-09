import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContasRecord extends FirestoreRecord {
  ContasRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "nome" field.
  String? _nome;
  String get nome => _nome ?? '';
  bool hasNome() => _nome != null;

  // "usuario" field.
  DocumentReference? _usuario;
  DocumentReference? get usuario => _usuario;
  bool hasUsuario() => _usuario != null;

  // "idconta" field.
  String? _idconta;
  String get idconta => _idconta ?? '';
  bool hasIdconta() => _idconta != null;

  // "plataforma" field.
  String? _plataforma;
  String get plataforma => _plataforma ?? '';
  bool hasPlataforma() => _plataforma != null;

  // "oculto" field.
  bool? _oculto;
  bool get oculto => _oculto ?? false;
  bool hasOculto() => _oculto != null;

  // "userid" field.
  String? _userid;
  String get userid => _userid ?? '';
  bool hasUserid() => _userid != null;

  void _initializeFields() {
    _nome = snapshotData['nome'] as String?;
    _usuario = snapshotData['usuario'] as DocumentReference?;
    _idconta = snapshotData['idconta'] as String?;
    _plataforma = snapshotData['plataforma'] as String?;
    _oculto = snapshotData['oculto'] as bool?;
    _userid = snapshotData['userid'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('contas');

  static Stream<ContasRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ContasRecord.fromSnapshot(s));

  static Future<ContasRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ContasRecord.fromSnapshot(s));

  static ContasRecord fromSnapshot(DocumentSnapshot snapshot) => ContasRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ContasRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ContasRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ContasRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ContasRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createContasRecordData({
  String? nome,
  DocumentReference? usuario,
  String? idconta,
  String? plataforma,
  bool? oculto,
  String? userid,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'nome': nome,
      'usuario': usuario,
      'idconta': idconta,
      'plataforma': plataforma,
      'oculto': oculto,
      'userid': userid,
    }.withoutNulls,
  );

  return firestoreData;
}

class ContasRecordDocumentEquality implements Equality<ContasRecord> {
  const ContasRecordDocumentEquality();

  @override
  bool equals(ContasRecord? e1, ContasRecord? e2) {
    return e1?.nome == e2?.nome &&
        e1?.usuario == e2?.usuario &&
        e1?.idconta == e2?.idconta &&
        e1?.plataforma == e2?.plataforma &&
        e1?.oculto == e2?.oculto &&
        e1?.userid == e2?.userid;
  }

  @override
  int hash(ContasRecord? e) => const ListEquality().hash(
      [e?.nome, e?.usuario, e?.idconta, e?.plataforma, e?.oculto, e?.userid]);

  @override
  bool isValidKey(Object? o) => o is ContasRecord;
}
