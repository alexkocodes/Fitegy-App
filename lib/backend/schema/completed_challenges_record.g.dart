// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_challenges_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CompletedChallengesRecord> _$completedChallengesRecordSerializer =
    new _$CompletedChallengesRecordSerializer();

class _$CompletedChallengesRecordSerializer
    implements StructuredSerializer<CompletedChallengesRecord> {
  @override
  final Iterable<Type> types = const [
    CompletedChallengesRecord,
    _$CompletedChallengesRecord
  ];
  @override
  final String wireName = 'CompletedChallengesRecord';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, CompletedChallengesRecord object,
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
    value = object.colorScheme;
    if (value != null) {
      result
        ..add('color_scheme')
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
  CompletedChallengesRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CompletedChallengesRecordBuilder();

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
        case 'color_scheme':
          result.colorScheme = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'comments':
          result.comments = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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

class _$CompletedChallengesRecord extends CompletedChallengesRecord {
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
  final String? colorScheme;
  @override
  final String? comments;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$CompletedChallengesRecord(
          [void Function(CompletedChallengesRecordBuilder)? updates]) =>
      (new CompletedChallengesRecordBuilder()..update(updates))._build();

  _$CompletedChallengesRecord._(
      {this.title,
      this.details,
      this.createdAt,
      this.createBy,
      this.activeParticipants,
      this.invitedParticipants,
      this.status,
      this.colorScheme,
      this.comments,
      this.ffRef})
      : super._();

  @override
  CompletedChallengesRecord rebuild(
          void Function(CompletedChallengesRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompletedChallengesRecordBuilder toBuilder() =>
      new CompletedChallengesRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompletedChallengesRecord &&
        title == other.title &&
        details == other.details &&
        createdAt == other.createdAt &&
        createBy == other.createBy &&
        activeParticipants == other.activeParticipants &&
        invitedParticipants == other.invitedParticipants &&
        status == other.status &&
        colorScheme == other.colorScheme &&
        comments == other.comments &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, title.hashCode),
                                        details.hashCode),
                                    createdAt.hashCode),
                                createBy.hashCode),
                            activeParticipants.hashCode),
                        invitedParticipants.hashCode),
                    status.hashCode),
                colorScheme.hashCode),
            comments.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CompletedChallengesRecord')
          ..add('title', title)
          ..add('details', details)
          ..add('createdAt', createdAt)
          ..add('createBy', createBy)
          ..add('activeParticipants', activeParticipants)
          ..add('invitedParticipants', invitedParticipants)
          ..add('status', status)
          ..add('colorScheme', colorScheme)
          ..add('comments', comments)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class CompletedChallengesRecordBuilder
    implements
        Builder<CompletedChallengesRecord, CompletedChallengesRecordBuilder> {
  _$CompletedChallengesRecord? _$v;

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

  String? _colorScheme;
  String? get colorScheme => _$this._colorScheme;
  set colorScheme(String? colorScheme) => _$this._colorScheme = colorScheme;

  String? _comments;
  String? get comments => _$this._comments;
  set comments(String? comments) => _$this._comments = comments;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  CompletedChallengesRecordBuilder() {
    CompletedChallengesRecord._initializeBuilder(this);
  }

  CompletedChallengesRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _details = $v.details;
      _createdAt = $v.createdAt;
      _createBy = $v.createBy;
      _activeParticipants = $v.activeParticipants?.toBuilder();
      _invitedParticipants = $v.invitedParticipants?.toBuilder();
      _status = $v.status;
      _colorScheme = $v.colorScheme;
      _comments = $v.comments;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompletedChallengesRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CompletedChallengesRecord;
  }

  @override
  void update(void Function(CompletedChallengesRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CompletedChallengesRecord build() => _build();

  _$CompletedChallengesRecord _build() {
    _$CompletedChallengesRecord _$result;
    try {
      _$result = _$v ??
          new _$CompletedChallengesRecord._(
              title: title,
              details: details,
              createdAt: createdAt,
              createBy: createBy,
              activeParticipants: _activeParticipants?.build(),
              invitedParticipants: _invitedParticipants?.build(),
              status: status,
              colorScheme: colorScheme,
              comments: comments,
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
            r'CompletedChallengesRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
