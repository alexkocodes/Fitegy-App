import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'challenges_record.g.dart';

abstract class ChallengesRecord
    implements Built<ChallengesRecord, ChallengesRecordBuilder> {
  static Serializer<ChallengesRecord> get serializer =>
      _$challengesRecordSerializer;

  String? get title;

  String? get details;

  @BuiltValueField(wireName: 'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: 'create_by')
  DocumentReference? get createBy;

  @BuiltValueField(wireName: 'active_participants')
  BuiltList<DocumentReference>? get activeParticipants;

  @BuiltValueField(wireName: 'invited_participants')
  BuiltList<DocumentReference>? get invitedParticipants;

  String? get status;

  @BuiltValueField(wireName: 'color_scheme')
  String? get colorScheme;

  String? get comments;

  String? get id;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  DocumentReference get parentReference => reference.parent.parent!;

  static void _initializeBuilder(ChallengesRecordBuilder builder) => builder
    ..title = ''
    ..details = ''
    ..activeParticipants = ListBuilder()
    ..invitedParticipants = ListBuilder()
    ..status = ''
    ..colorScheme = ''
    ..comments = ''
    ..id = '';

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('challenges')
          : FirebaseFirestore.instance.collectionGroup('challenges');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('challenges').doc();

  static Stream<ChallengesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<ChallengesRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  ChallengesRecord._();
  factory ChallengesRecord([void Function(ChallengesRecordBuilder) updates]) =
      _$ChallengesRecord;

  static ChallengesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createChallengesRecordData({
  String? title,
  String? details,
  DateTime? createdAt,
  DocumentReference? createBy,
  String? status,
  String? colorScheme,
  String? comments,
  String? id,
}) {
  final firestoreData = serializers.toFirestore(
    ChallengesRecord.serializer,
    ChallengesRecord(
      (c) => c
        ..title = title
        ..details = details
        ..createdAt = createdAt
        ..createBy = createBy
        ..activeParticipants = null
        ..invitedParticipants = null
        ..status = status
        ..colorScheme = colorScheme
        ..comments = comments
        ..id = id,
    ),
  );

  return firestoreData;
}
