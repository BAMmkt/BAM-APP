import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EstrategiaRecord extends FirestoreRecord {
  EstrategiaRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "related_id" field.
  String? _relatedId;
  String get relatedId => _relatedId ?? '';
  bool hasRelatedId() => _relatedId != null;

  // "usuario" field.
  DocumentReference? _usuario;
  DocumentReference? get usuario => _usuario;
  bool hasUsuario() => _usuario != null;

  // "datadeupdate" field.
  DateTime? _datadeupdate;
  DateTime? get datadeupdate => _datadeupdate;
  bool hasDatadeupdate() => _datadeupdate != null;

  // "descricao_da_empresa" field.
  String? _descricaoDaEmpresa;
  String get descricaoDaEmpresa => _descricaoDaEmpresa ?? '';
  bool hasDescricaoDaEmpresa() => _descricaoDaEmpresa != null;

  // "caracteristica_mais_elogiada" field.
  String? _caracteristicaMaisElogiada;
  String get caracteristicaMaisElogiada => _caracteristicaMaisElogiada ?? '';
  bool hasCaracteristicaMaisElogiada() => _caracteristicaMaisElogiada != null;

  // "adjetivos_associados" field.
  List<String>? _adjetivosAssociados;
  List<String> get adjetivosAssociados => _adjetivosAssociados ?? const [];
  bool hasAdjetivosAssociados() => _adjetivosAssociados != null;

  // "adjetivos_nao_associar" field.
  List<String>? _adjetivosNaoAssociar;
  List<String> get adjetivosNaoAssociar => _adjetivosNaoAssociar ?? const [];
  bool hasAdjetivosNaoAssociar() => _adjetivosNaoAssociar != null;

  // "faixa_etaria_media" field.
  List<String>? _faixaEtariaMedia;
  List<String> get faixaEtariaMedia => _faixaEtariaMedia ?? const [];
  bool hasFaixaEtariaMedia() => _faixaEtariaMedia != null;

  // "genero_predominante" field.
  String? _generoPredominante;
  String get generoPredominante => _generoPredominante ?? '';
  bool hasGeneroPredominante() => _generoPredominante != null;

  // "caracteristicas_interacao" field.
  List<String>? _caracteristicasInteracao;
  List<String> get caracteristicasInteracao =>
      _caracteristicasInteracao ?? const [];
  bool hasCaracteristicasInteracao() => _caracteristicasInteracao != null;

  // "segmentos_clientes" field.
  List<String>? _segmentosClientes;
  List<String> get segmentosClientes => _segmentosClientes ?? const [];
  bool hasSegmentosClientes() => _segmentosClientes != null;

  // "objetivos_comunicacao" field.
  List<String>? _objetivosComunicacao;
  List<String> get objetivosComunicacao => _objetivosComunicacao ?? const [];
  bool hasObjetivosComunicacao() => _objetivosComunicacao != null;

  // "frequencia_planejada" field.
  String? _frequenciaPlanejada;
  String get frequenciaPlanejada => _frequenciaPlanejada ?? '';
  bool hasFrequenciaPlanejada() => _frequenciaPlanejada != null;

  // "infos_adicionais" field.
  String? _infosAdicionais;
  String get infosAdicionais => _infosAdicionais ?? '';
  bool hasInfosAdicionais() => _infosAdicionais != null;

  void _initializeFields() {
    _relatedId = snapshotData['related_id'] as String?;
    _usuario = snapshotData['usuario'] as DocumentReference?;
    _datadeupdate = snapshotData['datadeupdate'] as DateTime?;
    _descricaoDaEmpresa = snapshotData['descricao_da_empresa'] as String?;
    _caracteristicaMaisElogiada =
        snapshotData['caracteristica_mais_elogiada'] as String?;
    _adjetivosAssociados = getDataList(snapshotData['adjetivos_associados']);
    _adjetivosNaoAssociar = getDataList(snapshotData['adjetivos_nao_associar']);
    _faixaEtariaMedia = getDataList(snapshotData['faixa_etaria_media']);
    _generoPredominante = snapshotData['genero_predominante'] as String?;
    _caracteristicasInteracao =
        getDataList(snapshotData['caracteristicas_interacao']);
    _segmentosClientes = getDataList(snapshotData['segmentos_clientes']);
    _objetivosComunicacao = getDataList(snapshotData['objetivos_comunicacao']);
    _frequenciaPlanejada = snapshotData['frequencia_planejada'] as String?;
    _infosAdicionais = snapshotData['infos_adicionais'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('estrategia');

  static Stream<EstrategiaRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EstrategiaRecord.fromSnapshot(s));

  static Future<EstrategiaRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EstrategiaRecord.fromSnapshot(s));

  static EstrategiaRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EstrategiaRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EstrategiaRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EstrategiaRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EstrategiaRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EstrategiaRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEstrategiaRecordData({
  String? relatedId,
  DocumentReference? usuario,
  DateTime? datadeupdate,
  String? descricaoDaEmpresa,
  String? caracteristicaMaisElogiada,
  String? generoPredominante,
  String? frequenciaPlanejada,
  String? infosAdicionais,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'related_id': relatedId,
      'usuario': usuario,
      'datadeupdate': datadeupdate,
      'descricao_da_empresa': descricaoDaEmpresa,
      'caracteristica_mais_elogiada': caracteristicaMaisElogiada,
      'genero_predominante': generoPredominante,
      'frequencia_planejada': frequenciaPlanejada,
      'infos_adicionais': infosAdicionais,
    }.withoutNulls,
  );

  return firestoreData;
}

class EstrategiaRecordDocumentEquality implements Equality<EstrategiaRecord> {
  const EstrategiaRecordDocumentEquality();

  @override
  bool equals(EstrategiaRecord? e1, EstrategiaRecord? e2) {
    const listEquality = ListEquality();
    return e1?.relatedId == e2?.relatedId &&
        e1?.usuario == e2?.usuario &&
        e1?.datadeupdate == e2?.datadeupdate &&
        e1?.descricaoDaEmpresa == e2?.descricaoDaEmpresa &&
        e1?.caracteristicaMaisElogiada == e2?.caracteristicaMaisElogiada &&
        listEquality.equals(e1?.adjetivosAssociados, e2?.adjetivosAssociados) &&
        listEquality.equals(
            e1?.adjetivosNaoAssociar, e2?.adjetivosNaoAssociar) &&
        listEquality.equals(e1?.faixaEtariaMedia, e2?.faixaEtariaMedia) &&
        e1?.generoPredominante == e2?.generoPredominante &&
        listEquality.equals(
            e1?.caracteristicasInteracao, e2?.caracteristicasInteracao) &&
        listEquality.equals(e1?.segmentosClientes, e2?.segmentosClientes) &&
        listEquality.equals(
            e1?.objetivosComunicacao, e2?.objetivosComunicacao) &&
        e1?.frequenciaPlanejada == e2?.frequenciaPlanejada &&
        e1?.infosAdicionais == e2?.infosAdicionais;
  }

  @override
  int hash(EstrategiaRecord? e) => const ListEquality().hash([
        e?.relatedId,
        e?.usuario,
        e?.datadeupdate,
        e?.descricaoDaEmpresa,
        e?.caracteristicaMaisElogiada,
        e?.adjetivosAssociados,
        e?.adjetivosNaoAssociar,
        e?.faixaEtariaMedia,
        e?.generoPredominante,
        e?.caracteristicasInteracao,
        e?.segmentosClientes,
        e?.objetivosComunicacao,
        e?.frequenciaPlanejada,
        e?.infosAdicionais
      ]);

  @override
  bool isValidKey(Object? o) => o is EstrategiaRecord;
}
