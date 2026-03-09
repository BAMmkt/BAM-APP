import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "idcontaselecionada" field.
  String? _idcontaselecionada;
  String get idcontaselecionada => _idcontaselecionada ?? '';
  bool hasIdcontaselecionada() => _idcontaselecionada != null;

  // "admin" field.
  bool? _admin;
  bool get admin => _admin ?? false;
  bool hasAdmin() => _admin != null;

  // "dark" field.
  bool? _dark;
  bool get dark => _dark ?? false;
  bool hasDark() => _dark != null;

  // "lang" field.
  String? _lang;
  String get lang => _lang ?? '';
  bool hasLang() => _lang != null;

  // "nomecontaselecionada" field.
  String? _nomecontaselecionada;
  String get nomecontaselecionada => _nomecontaselecionada ?? '';
  bool hasNomecontaselecionada() => _nomecontaselecionada != null;

  // "lender_id" field.
  String? _lenderId;
  String get lenderId => _lenderId ?? '';
  bool hasLenderId() => _lenderId != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _idcontaselecionada = snapshotData['idcontaselecionada'] as String?;
    _admin = snapshotData['admin'] as bool?;
    _dark = snapshotData['dark'] as bool?;
    _lang = snapshotData['lang'] as String?;
    _nomecontaselecionada = snapshotData['nomecontaselecionada'] as String?;
    _lenderId = snapshotData['lender_id'] as String?;
    _type = snapshotData['type'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? idcontaselecionada,
  bool? admin,
  bool? dark,
  String? lang,
  String? nomecontaselecionada,
  String? lenderId,
  String? type,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'idcontaselecionada': idcontaselecionada,
      'admin': admin,
      'dark': dark,
      'lang': lang,
      'nomecontaselecionada': nomecontaselecionada,
      'lender_id': lenderId,
      'type': type,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.idcontaselecionada == e2?.idcontaselecionada &&
        e1?.admin == e2?.admin &&
        e1?.dark == e2?.dark &&
        e1?.lang == e2?.lang &&
        e1?.nomecontaselecionada == e2?.nomecontaselecionada &&
        e1?.lenderId == e2?.lenderId &&
        e1?.type == e2?.type;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.idcontaselecionada,
        e?.admin,
        e?.dark,
        e?.lang,
        e?.nomecontaselecionada,
        e?.lenderId,
        e?.type
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
