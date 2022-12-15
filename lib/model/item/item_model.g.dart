// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ItemModel _$$_ItemModelFromJson(Map<String, dynamic> json) => _$_ItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      createdAt: json['createdAt'] as int? ?? 0,
      latitude: json['latitude'] as String? ?? '',
      longitude: json['longitude'] as String? ?? '',
      scope: json['scope'] as String? ?? '',
      description: json['description'] as String? ?? '',
      radius: json['radius'] as int? ?? 0,
      userId: json['userId'] as String? ?? '',
      file: FileModel.fromJson(json['file'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ItemModelToJson(_$_ItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createdAt': instance.createdAt,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'scope': instance.scope,
      'description': instance.description,
      'radius': instance.radius,
      'userId': instance.userId,
      'file': instance.file,
    };
