// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventModel _$$_EventModelFromJson(Map<String, dynamic> json) =>
    _$_EventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      address: json['address'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      scope: json['scope'] as String? ?? '',
      userId: json['userId'] ?? '',
      startDate: json['startDate'] as int,
      endDate: json['endDate'] as int,
      createdAt: json['createdAt'] as int,
    );

Map<String, dynamic> _$$_EventModelToJson(_$_EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'address': instance.address,
      'imageUrl': instance.imageUrl,
      'scope': instance.scope,
      'userId': instance.userId,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'createdAt': instance.createdAt,
    };
