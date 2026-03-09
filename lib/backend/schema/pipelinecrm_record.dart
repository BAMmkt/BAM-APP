import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PipelinecrmRecord extends FirestoreRecord {
  PipelinecrmRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "colunas" field.
  List<String>? _colunas;
  List<String> get colunas => _colunas ?? const [];
  bool hasColunas() => _colunas != null;

  // "related_id" field.
  String? _relatedId;
  String get relatedId => _relatedId ?? '';
  bool hasRelatedId() => _relatedId != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "tiposcamposadicionais" field.
  List<String>? _tiposcamposadicionais;
  List<String> get tiposcamposadicionais => _tiposcamposadicionais ?? const [];
  bool hasTiposcamposadicionais() => _tiposcamposadicionais != null;

  // "responsavel" field.
  List<ContascconvidadasStruct>? _responsavel;
  List<ContascconvidadasStruct> get responsavel => _responsavel ?? const [];
  bool hasResponsavel() => _responsavel != null;

  void _initializeFields() {
    _colunas = getDataList(snapshotData['colunas']);
    _relatedId = snapshotData['related_id'] as String?;
    _userId = snapshotData['user_id'] as String?;
    _tiposcamposadicionais = getDataList(snapshotData['tiposcamposadicionais']);
    _responsavel = getStructList(
      snapshotData['responsavel'],
      ContascconvidadasStruct.fromMap,
    );
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('pipelinecrm');

  static Stream<PipelinecrmRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PipelinecrmRecord.fromSnapshot(s));

  static Future<PipelinecrmRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PipelinecrmRecord.fromSnapshot(s));

  static PipelinecrmRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PipelinecrmRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PipelinecrmRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PipelinecrmRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PipelinecrmRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PipelinecrmRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPipelinecrmRecordData({
  String? relatedId,
  String? userId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'related_id': relatedId,
      'user_id': userId,
    }.withoutNulls,
  );

  return firestoreData;
}

class PipelinecrmRecordDocumentEquality implements Equality<PipelinecrmRecord> {
  const PipelinecrmRecordDocumentEquality();

  @override
  bool equals(PipelinecrmRecord? e1, PipelinecrmRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.colunas, e2?.colunas) &&
        e1?.relatedId == e2?.relatedId &&
        e1?.userId == e2?.userId &&
        listEquality.equals(
            e1?.tiposcamposadicionais, e2?.tiposcamposadicionais) &&
        listEquality.equals(e1?.responsavel, e2?.responsavel);
  }

  @override
  int hash(PipelinecrmRecord? e) => const ListEquality().hash([
        e?.colunas,
        e?.relatedId,
        e?.userId,
        e?.tiposcamposadicionais,
        e?.responsavel
      ]);

  @override
  bool isValidKey(Object? o) => o is PipelinecrmRecord;
}
