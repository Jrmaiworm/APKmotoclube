import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'divisao_record.g.dart';

abstract class DivisaoRecord
    implements Built<DivisaoRecord, DivisaoRecordBuilder> {
  static Serializer<DivisaoRecord> get serializer => _$divisaoRecordSerializer;

  @nullable
  String get nome;

  @nullable
  LatLng get geo;

  @nullable
  String get endereco;

  @nullable
  String get diretor;

  @nullable
  String get foto;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(DivisaoRecordBuilder builder) => builder
    ..nome = ''
    ..endereco = ''
    ..diretor = ''
    ..foto = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Divisao');

  static Stream<DivisaoRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<DivisaoRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  DivisaoRecord._();
  factory DivisaoRecord([void Function(DivisaoRecordBuilder) updates]) =
      _$DivisaoRecord;

  static DivisaoRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createDivisaoRecordData({
  String nome,
  LatLng geo,
  String endereco,
  String diretor,
  String foto,
}) =>
    serializers.toFirestore(
        DivisaoRecord.serializer,
        DivisaoRecord((d) => d
          ..nome = nome
          ..geo = geo
          ..endereco = endereco
          ..diretor = diretor
          ..foto = foto));
