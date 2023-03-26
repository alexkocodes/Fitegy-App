// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenges_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ChallengesRecord> _$challengesRecordSerializer =
    new _$ChallengesRecordSerializer();

class _$ChallengesRecordSerializer
    implements StructuredSerializer<ChallengesRecord> {
  @override
  final Iterable<Type> types = const [ChallengesRecord, _$ChallengesRecord];
  @override
  final String wireName = 'ChallengesRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, ChallengesRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.details;
    if (value != null) {
      result
        ..add('details')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.createBy;
    if (value != null) {
      result
        ..add('create_by')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.activeParticipants;
    if (value != null) {
      result
        ..add('active_participants')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.invitedParticipants;
    if (value != null) {
      result
        ..add('invited_participants')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.comments;
    if (value != null) {
      result
        ..add('comments')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.colorScheme;
    if (value != null) {
      result
        ..add('color_scheme')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.originalReference;
    if (value != null) {
      result
        ..add('original_reference')
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
  ChallengesRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChallengesRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'details':
          result.details = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'create_by':
          result.createBy = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'active_participants':
          result.activeParticipants.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'invited_participants':
          result.invitedParticipants.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'comments':
          result.comments = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'color_scheme':
          result.colorScheme = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'original_reference':
          result.originalReference = serializers.deserialize(value,
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

class _$ChallengesRecord extends ChallengesRecord {
  @override
  final String? title;
  @override
  final String? details;
  @override
  final DateTime? createdAt;
  @override
  final DocumentReference<Object?>? createBy;
  @override
  final BuiltList<DocumentReference<Object?>>? activeParticipants;
  @override
  final BuiltList<DocumentReference<Object?>>? invitedParticipants;
  @override
  final String? status;
  @override
  final String? comments;
  @override
  final String? id;
  @override
  final int? colorScheme;
  @override
  final DocumentReference<Object?>? originalReference;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$ChallengesRecord(
          [void Function(ChallengesRecordBuilder)? updates]) =>
      (new ChallengesRecordBuilder()..update(updates))._build();

  _$ChallengesRecord._(
      {this.title,
      this.details,
      this.createdAt,
      this.createBy,
      this.activeParticipants,
      this.invitedParticipants,
      this.status,
      this.comments,
      this.id,
      this.colorScheme,
      this.originalReference,
      this.ffRef})
      : super._();

  @override
  ChallengesRecord rebuild(void Function(ChallengesRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChallengesRecordBuilder toBuilder() =>
      new ChallengesRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChallengesRecord &&
        title == other.title &&
        details == other.details &&
        createdAt == other.createdAt &&
        createBy == other.createBy &&
        activeParticipants == other.activeParticipants &&
        invitedParticipants == other.invitedParticipants &&
        status == other.status &&
        comments == other.comments &&
        id == other.id &&
        colorScheme == other.colorScheme &&
        originalReference == other.originalReference &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, details.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, createBy.hashCode);
    _$hash = $jc(_$hash, activeParticipants.hashCode);
    _$hash = $jc(_$hash, invitedParticipants.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, comments.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, colorScheme.hashCode);
    _$hash = $jc(_$hash, originalReference.hashCode);
    _$hash = $jc(_$hash, ffRef.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChallengesRecord')
          ..add('title', title)
          ..add('details', details)
          ..add('createdAt', createdAt)
          ..add('createBy', createBy)
          ..add('activeParticipants', activeParticipants)
          ..add('invitedParticipants', invitedParticipants)
          ..add('status', status)
          ..add('comments', comments)
          ..add('id', id)
          ..add('colorScheme', colorScheme)
          ..add('originalReference', originalReference)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class ChallengesRecordBuilder
    implements Builder<ChallengesRecord, ChallengesRecordBuilder> {
  _$ChallengesRecord? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _details;
  String? get details => _$this._details;
  set details(String? details) => _$this._details = details;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DocumentReference<Object?>? _createBy;
  DocumentReference<Object?>? get createBy => _$this._createBy;
  set createBy(DocumentReference<Object?>? createBy) =>
      _$this._createBy = createBy;

  ListBuilder<DocumentReference<Object?>>? _activeParticipants;
  ListBuilder<DocumentReference<Object?>> get activeParticipants =>
      _$this._activeParticipants ??=
          new ListBuilder<DocumentReference<Object?>>();
  set activeParticipants(
          ListBuilder<DocumentReference<Object?>>? activeParticipants) =>
      _$this._activeParticipants = activeParticipants;

  ListBuilder<DocumentReference<Object?>>? _invitedParticipants;
  ListBuilder<DocumentReference<Object?>> get invitedParticipants =>
      _$this._invitedParticipants ??=
          new ListBuilder<DocumentReference<Object?>>();
  set invitedParticipants(
          ListBuilder<DocumentReference<Object?>>? invitedParticipants) =>
      _$this._invitedParticipants = invitedParticipants;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _comments;
  String? get comments => _$this._comments;
  set comments(String? comments) => _$this._comments = comments;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  int? _colorScheme;
  int? get colorScheme => _$this._colorScheme;
  set colorScheme(int? colorScheme) => _$this._colorScheme = colorScheme;

  DocumentReference<Object?>? _originalReference;
  DocumentReference<Object?>? get originalReference =>
      _$this._originalReference;
  set originalReference(DocumentReference<Object?>? originalReference) =>
      _$this._originalReference = originalReference;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  ChallengesRecordBuilder() {
    ChallengesRecord._initializeBuilder(this);
  }

  ChallengesRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _details = $v.details;
      _createdAt = $v.createdAt;
      _createBy = $v.createBy;
      _activeParticipants = $v.activeParticipants?.toBuilder();
      _invitedParticipants = $v.invitedParticipants?.toBuilder();
      _status = $v.status;
      _comments = $v.comments;
      _id = $v.id;
      _colorScheme = $v.colorScheme;
      _originalReference = $v.originalReference;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChallengesRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChallengesRecord;
  }

  @override
  void update(void Function(ChallengesRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChallengesRecord build() => _build();

  _$ChallengesRecord _build() {
    _$ChallengesRecord _$result;
    try {
      _$result = _$v ??
          new _$ChallengesRecord._(
              title: title,
              details: details,
              createdAt: createdAt,
              createBy: createBy,
              activeParticipants: _activeParticipants?.build(),
              invitedParticipants: _invitedParticipants?.build(),
              status: status,
              comments: comments,
              id: id,
              colorScheme: colorScheme,
              originalReference: originalReference,
              ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'activeParticipants';
        _activeParticipants?.build();
        _$failedField = 'invitedParticipants';
        _invitedParticipants?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ChallengesRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
