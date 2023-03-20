import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'friends_record.g.dart';

abstract class FriendsRecord
    implements Built<FriendsRecord, FriendsRecordBuilder> {
  static Serializer<FriendsRecord> get serializer => _$friendsRecordSerializer;

  @BuiltValueField(wireName: 'display_name')
  String? get displayName;

  @BuiltValueField(wireName: 'photo_url')
  String? get photoUrl;

  @BuiltValueField(wireName: 'first_name')
  String? get firstName;

  @BuiltValueField(wireName: 'last_name')
  String? get lastName;

  String? get emoji;

  String? get username;

  DocumentReference? get uid;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  DocumentReference get parentReference => reference.parent.parent!;

  static void _initializeBuilder(FriendsRecordBuilder builder) => builder
    ..displayName = ''
    ..photoUrl = ''
    ..firstName = ''
    ..lastName = ''
    ..emoji = ''
    ..username = '';

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('friends')
          : FirebaseFirestore.instance.collectionGroup('friends');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('friends').doc();

  static Stream<FriendsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<FriendsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  FriendsRecord._();
  factory FriendsRecord([void Function(FriendsRecordBuilder) updates]) =
      _$FriendsRecord;

  static FriendsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createFriendsRecordData({
  String? displayName,
  String? photoUrl,
  String? firstName,
  String? lastName,
  String? emoji,
  String? username,
  DocumentReference? uid,
}) {
  final firestoreData = serializers.toFirestore(
    FriendsRecord.serializer,
    FriendsRecord(
      (f) => f
        ..displayName = displayName
        ..photoUrl = photoUrl
        ..firstName = firstName
        ..lastName = lastName
        ..emoji = emoji
        ..username = username
        ..uid = uid,
    ),
  );

  return firestoreData;
}
