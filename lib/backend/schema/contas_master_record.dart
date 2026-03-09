import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContasMasterRecord extends FirestoreRecord {
  ContasMasterRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_id" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  // "nome" field.
  String? _nome;
  String get nome => _nome ?? '';
  bool hasNome() => _nome != null;

  // "contas_id" field.
  DocumentReference? _contasId;
  DocumentReference? get contasId => _contasId;
  bool hasContasId() => _contasId != null;

  // "contasconectadas" field.
  List<DocumentReference>? _contasconectadas;
  List<DocumentReference> get contasconectadas => _contasconectadas ?? const [];
  bool hasContasconectadas() => _contasconectadas != null;

  // "useridstring" field.
  String? _useridstring;
  String get useridstring => _useridstring ?? '';
  bool hasUseridstring() => _useridstring != null;

  void _initializeFields() {
    _userId = snapshotData['user_id'] as DocumentReference?;
    _nome = snapshotData['nome'] as String?;
    _contasId = snapshotData['contas_id'] as DocumentReference?;
    _contasconectadas = getDataList(snapshotData['contasconectadas']);
    _useridstring = snapshotData['useridstring'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('contas_master');

  static Stream<ContasMasterRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ContasMasterRecord.fromSnapshot(s));

  static Future<ContasMasterRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ContasMasterRecord.fromSnapshot(s));

  static ContasMasterRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ContasMasterRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ContasMasterRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ContasMasterRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ContasMasterRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ContasMasterRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createContasMasterRecordData({
  DocumentReference? userId,
  String? nome,
  DocumentReference? contasId,
  String? useridstring,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_id': userId,
      'nome': nome,
      'contas_id': contasId,
      'useridstring': useridstring,
    }.withoutNulls,
  );

  return firestoreData;
}

class ContasMasterRecordDocumentEquality
    implements Equality<ContasMasterRecord> {
  const ContasMasterRecordDocumentEquality();

  @override
  bool equals(ContasMasterRecord? e1, ContasMasterRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userId == e2?.userId &&
        e1?.nome == e2?.nome &&
        e1?.contasId == e2?.contasId &&
        listEquality.equals(e1?.contasconectadas, e2?.contasconectadas) &&
        e1?.useridstring == e2?.useridstring;
  }

  @override
  int hash(ContasMasterRecord? e) => const ListEquality().hash(
      [e?.userId, e?.nome, e?.contasId, e?.contasconectadas, e?.useridstring]);

  @override
  bool isValidKey(Object? o) => o is ContasMasterRecord;
}
