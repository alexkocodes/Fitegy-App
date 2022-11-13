import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'active_challenges_record.g.dart';

abstract class ActiveChallengesRecord
    implements Built<ActiveChallengesRecord, ActiveChallengesRecordBuilder> {
  static Serializer<ActiveChallengesRecord> get serializer =>
      _$activeChallengesRecordSerializer;

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

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  DocumentReference get parentReference => reference.parent.parent!;

  static void _initializeBuilder(ActiveChallengesRecordBuilder builder) =>
      builder
        ..title = ''
        ..details = ''
        ..activeParticipants = ListBuilder()
        ..invitedParticipants = ListBuilder()
        ..status = ''
        ..colorScheme = ''
        ..comments = '';

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('active_challenges')
          : FirebaseFirestore.instance.collectionGroup('active_challenges');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('active_challenges').doc();

  static Stream<ActiveChallengesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<ActiveChallengesRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  ActiveChallengesRecord._();
  factory ActiveChallengesRecord(
          [void Function(ActiveChallengesRecordBuilder) updates]) =
      _$ActiveChallengesRecord;

  static ActiveChallengesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createActiveChallengesRecordData({
  String? title,
  String? details,
  DateTime? createdAt,
  DocumentReference? createBy,
  String? status,
  String? colorScheme,
  String? comments,
}) {
  final firestoreData = serializers.toFirestore(
    ActiveChallengesRecord.serializer,
    ActiveChallengesRecord(
      (a) => a
        ..title = title
        ..details = details
        ..createdAt = createdAt
        ..createBy = createBy
        ..activeParticipants = null
        ..invitedParticipants = null
        ..status = status
        ..colorScheme = colorScheme
        ..comments = comments,
    ),
  );

  return firestoreData;
}
