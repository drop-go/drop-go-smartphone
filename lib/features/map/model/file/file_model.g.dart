// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FileModel _$$_FileModelFromJson(Map<String, dynamic> json) => _$_FileModel(
      fileName: json['fileName'] as String,
      dataURI: json['dataURI'] as String? ?? '',
      extension: json['extension'] as String? ?? '',
      type: json['type'] as String? ?? '',
    );

Map<String, dynamic> _$$_FileModelToJson(_$_FileModel instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'dataURI': instance.dataURI,
      'extension': instance.extension,
      'type': instance.type,
    };
