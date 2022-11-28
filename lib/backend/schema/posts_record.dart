import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'posts_record.g.dart';

abstract class PostsRecord implements Built<PostsRecord, PostsRecordBuilder> {
  static Serializer<PostsRecord> get serializer => _$postsRecordSerializer;

  @BuiltValueField(wireName: 'post_description')
  String? get postDescription;

  @BuiltValueField(wireName: 'post_user')
  DocumentReference? get postUser;

  @BuiltValueField(wireName: 'time_posted')
  DateTime? get timePosted;

  BuiltList<DocumentReference>? get likes;

  @BuiltValueField(wireName: 'num_comments')
  int? get numComments;

  @BuiltValueField(wireName: 'in_post_challenge')
  DocumentReference? get inPostChallenge;

  BuiltList<String>? get postImages;

  @BuiltValueField(wireName: 'location')
  String? get location;

  @BuiltValueField(wireName: 'private')
  String? get private;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  DocumentReference get parentReference => reference.parent.parent!;

  static void _initializeBuilder(PostsRecordBuilder builder) => builder
    ..postDescription = ''
    ..likes = ListBuilder()
    ..numComments = 0
    ..postImages = ListBuilder()
    ..location = ''
    ..private = "Private";

  // getting data from Firestore
  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('posts')
          : FirebaseFirestore.instance.collectionGroup('posts');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('posts').doc();

  static Stream<PostsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<PostsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  PostsRecord._();
  factory PostsRecord([void Function(PostsRecordBuilder) updates]) =
      _$PostsRecord;

  static PostsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createPostsRecordData({
  String? postDescription,
  DocumentReference? postUser,
  DateTime? timePosted,
  int? numComments,
  DocumentReference? inPostChallenge,
  String? location,
  String? private,
}) {
  final firestoreData = serializers.toFirestore(
    PostsRecord.serializer,
    PostsRecord(
      (p) => p
        ..postDescription = postDescription
        ..postUser = postUser
        ..timePosted = timePosted
        ..likes = null
        ..numComments = numComments
        ..inPostChallenge = inPostChallenge
        ..postImages = null
        ..location = location
        ..private = private,
    ),
  );

  return firestoreData;
}
