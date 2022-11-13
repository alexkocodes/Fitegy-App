import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'invited_challenges_record.g.dart';

abstract class InvitedChallengesRecord
    implements Built<InvitedChallengesRecord, InvitedChallengesRecordBuilder> {
  static Serializer<InvitedChallengesRecord> get serializer =>
      _$invitedChallengesRecordSerializer;

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

  static void _initializeBuilder(InvitedChallengesRecordBuilder builder) =>
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
          ? parent.collection('invited_challenges')
          : FirebaseFirestore.instance.collectionGroup('invited_challenges');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('invited_challenges').doc();

  static Stream<InvitedChallengesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<InvitedChallengesRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  InvitedChallengesRecord._();
  factory InvitedChallengesRecord(
          [void Function(InvitedChallengesRecordBuilder) updates]) =
      _$InvitedChallengesRecord;

  static InvitedChallengesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createInvitedChallengesRecordData({
  String? title,
  String? details,
  DateTime? createdAt,
  DocumentReference? createBy,
  String? status,
  String? colorScheme,
  String? comments,
}) {
  final firestoreData = serializers.toFirestore(
    InvitedChallengesRecord.serializer,
    InvitedChallengesRecord(
      (i) => i
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
