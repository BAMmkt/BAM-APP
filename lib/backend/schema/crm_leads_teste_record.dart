import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CrmLeadsTesteRecord extends FirestoreRecord {
  CrmLeadsTesteRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "ambiente" field.
  String? _ambiente;
  String get ambiente => _ambiente ?? '';
  bool hasAmbiente() => _ambiente != null;

  // "contato" field.
  ContatoStruct? _contato;
  ContatoStruct get contato => _contato ?? ContatoStruct();
  bool hasContato() => _contato != null;

  // "data_entrada" field.
  DateTime? _dataEntrada;
  DateTime? get dataEntrada => _dataEntrada;
  bool hasDataEntrada() => _dataEntrada != null;

  // "dados_extras" field.
  List<DadosextrasStruct>? _dadosExtras;
  List<DadosextrasStruct> get dadosExtras => _dadosExtras ?? const [];
  bool hasDadosExtras() => _dadosExtras != null;

  // "historico" field.
  List<HistoricoStruct>? _historico;
  List<HistoricoStruct> get historico => _historico ?? const [];
  bool hasHistorico() => _historico != null;

  // "nome" field.
  String? _nome;
  String get nome => _nome ?? '';
  bool hasNome() => _nome != null;

  // "related_id" field.
  String? _relatedId;
  String get relatedId => _relatedId ?? '';
  bool hasRelatedId() => _relatedId != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "valor_negociacao" field.
  double? _valorNegociacao;
  double get valorNegociacao => _valorNegociacao ?? 0.0;
  bool hasValorNegociacao() => _valorNegociacao != null;

  // "data_de_fechamento" field.
  DateTime? _dataDeFechamento;
  DateTime? get dataDeFechamento => _dataDeFechamento;
  bool hasDataDeFechamento() => _dataDeFechamento != null;

  // "data_da_ultima_movimentacao" field.
  DateTime? _dataDaUltimaMovimentacao;
  DateTime? get dataDaUltimaMovimentacao => _dataDaUltimaMovimentacao;
  bool hasDataDaUltimaMovimentacao() => _dataDaUltimaMovimentacao != null;

  // "responsavel" field.
  String? _responsavel;
  String get responsavel => _responsavel ?? '';
  bool hasResponsavel() => _responsavel != null;

  void _initializeFields() {
    _ambiente = snapshotData['ambiente'] as String?;
    _contato = snapshotData['contato'] is ContatoStruct
        ? snapshotData['contato']
        : ContatoStruct.maybeFromMap(snapshotData['contato']);
    _dataEntrada = snapshotData['data_entrada'] as DateTime?;
    _dadosExtras = getStructList(
      snapshotData['dados_extras'],
      DadosextrasStruct.fromMap,
    );
    _historico = getStructList(
      snapshotData['historico'],
      HistoricoStruct.fromMap,
    );
    _nome = snapshotData['nome'] as String?;
    _relatedId = snapshotData['related_id'] as String?;
    _status = snapshotData['status'] as String?;
    _userId = snapshotData['user_id'] as String?;
    _valorNegociacao = castToType<double>(snapshotData['valor_negociacao']);
    _dataDeFechamento = snapshotData['data_de_fechamento'] as DateTime?;
    _dataDaUltimaMovimentacao =
        snapshotData['data_da_ultima_movimentacao'] as DateTime?;
    _responsavel = snapshotData['responsavel'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('crm_leads_teste');

  static Stream<CrmLeadsTesteRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CrmLeadsTesteRecord.fromSnapshot(s));

  static Future<CrmLeadsTesteRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CrmLeadsTesteRecord.fromSnapshot(s));

  static CrmLeadsTesteRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CrmLeadsTesteRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CrmLeadsTesteRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CrmLeadsTesteRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CrmLeadsTesteRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CrmLeadsTesteRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCrmLeadsTesteRecordData({
  String? ambiente,
  ContatoStruct? contato,
  DateTime? dataEntrada,
  String? nome,
  String? relatedId,
  String? status,
  String? userId,
  double? valorNegociacao,
  DateTime? dataDeFechamento,
  DateTime? dataDaUltimaMovimentacao,
  String? responsavel,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'ambiente': ambiente,
      'contato': ContatoStruct().toMap(),
      'data_entrada': dataEntrada,
      'nome': nome,
      'related_id': relatedId,
      'status': status,
      'user_id': userId,
      'valor_negociacao': valorNegociacao,
      'data_de_fechamento': dataDeFechamento,
      'data_da_ultima_movimentacao': dataDaUltimaMovimentacao,
      'responsavel': responsavel,
    }.withoutNulls,
  );

  // Handle nested data for "contato" field.
  addContatoStructData(firestoreData, contato, 'contato');

  return firestoreData;
}

class CrmLeadsTesteRecordDocumentEquality
    implements Equality<CrmLeadsTesteRecord> {
  const CrmLeadsTesteRecordDocumentEquality();

  @override
  bool equals(CrmLeadsTesteRecord? e1, CrmLeadsTesteRecord? e2) {
    const listEquality = ListEquality();
    return e1?.ambiente == e2?.ambiente &&
        e1?.contato == e2?.contato &&
        e1?.dataEntrada == e2?.dataEntrada &&
        listEquality.equals(e1?.dadosExtras, e2?.dadosExtras) &&
        listEquality.equals(e1?.historico, e2?.historico) &&
        e1?.nome == e2?.nome &&
        e1?.relatedId == e2?.relatedId &&
        e1?.status == e2?.status &&
        e1?.userId == e2?.userId &&
        e1?.valorNegociacao == e2?.valorNegociacao &&
        e1?.dataDeFechamento == e2?.dataDeFechamento &&
        e1?.dataDaUltimaMovimentacao == e2?.dataDaUltimaMovimentacao &&
        e1?.responsavel == e2?.responsavel;
  }

  @override
  int hash(CrmLeadsTesteRecord? e) => const ListEquality().hash([
        e?.ambiente,
        e?.contato,
        e?.dataEntrada,
        e?.dadosExtras,
        e?.historico,
        e?.nome,
        e?.relatedId,
        e?.status,
        e?.userId,
        e?.valorNegociacao,
        e?.dataDeFechamento,
        e?.dataDaUltimaMovimentacao,
        e?.responsavel
      ]);

  @override
  bool isValidKey(Object? o) => o is CrmLeadsTesteRecord;
}
