// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FriendsRecord> _$friendsRecordSerializer =
    new _$FriendsRecordSerializer();

class _$FriendsRecordSerializer implements StructuredSerializer<FriendsRecord> {
  @override
  final Iterable<Type> types = const [FriendsRecord, _$FriendsRecord];
  @override
  final String wireName = 'FriendsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, FriendsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.displayName;
    if (value != null) {
      result
        ..add('display_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.photoUrl;
    if (value != null) {
      result
        ..add('photo_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.firstName;
    if (value != null) {
      result
        ..add('first_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lastName;
    if (value != null) {
      result
        ..add('last_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emoji;
    if (value != null) {
      result
        ..add('emoji')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.username;
    if (value != null) {
      result
        ..add('username')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.uid;
    if (value != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  FriendsRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FriendsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'display_name':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'photo_url':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'first_name':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'last_name':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'emoji':
          result.emoji = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$FriendsRecord extends FriendsRecord {
  @override
  final String? displayName;
  @override
  final String? photoUrl;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? emoji;
  @override
  final String? username;
  @override
  final DocumentReference<Object?>? uid;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$FriendsRecord([void Function(FriendsRecordBuilder)? updates]) =>
      (new FriendsRecordBuilder()..update(updates))._build();

  _$FriendsRecord._(
      {this.displayName,
      this.photoUrl,
      this.firstName,
      this.lastName,
      this.emoji,
      this.username,
      this.uid,
      this.ffRef})
      : super._();

  @override
  FriendsRecord rebuild(void Function(FriendsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FriendsRecordBuilder toBuilder() => new FriendsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FriendsRecord &&
        displayName == other.displayName &&
        photoUrl == other.photoUrl &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        emoji == other.emoji &&
        username == other.username &&
        uid == other.uid &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, photoUrl.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, emoji.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, ffRef.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FriendsRecord')
          ..add('displayName', displayName)
          ..add('photoUrl', photoUrl)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('emoji', emoji)
          ..add('username', username)
          ..add('uid', uid)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class FriendsRecordBuilder
    implements Builder<FriendsRecord, FriendsRecordBuilder> {
  _$FriendsRecord? _$v;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _emoji;
  String? get emoji => _$this._emoji;
  set emoji(String? emoji) => _$this._emoji = emoji;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  DocumentReference<Object?>? _uid;
  DocumentReference<Object?>? get uid => _$this._uid;
  set uid(DocumentReference<Object?>? uid) => _$this._uid = uid;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  FriendsRecordBuilder() {
    FriendsRecord._initializeBuilder(this);
  }

  FriendsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _displayName = $v.displayName;
      _photoUrl = $v.photoUrl;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _emoji = $v.emoji;
      _username = $v.username;
      _uid = $v.uid;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FriendsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FriendsRecord;
  }

  @override
  void update(void Function(FriendsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FriendsRecord build() => _build();

  _$FriendsRecord _build() {
    final _$result = _$v ??
        new _$FriendsRecord._(
            displayName: displayName,
            photoUrl: photoUrl,
            firstName: firstName,
            lastName: lastName,
            emoji: emoji,
            username: username,
            uid: uid,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
