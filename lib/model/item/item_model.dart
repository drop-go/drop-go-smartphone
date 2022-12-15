// ignore: unused_import
import 'package:drop_go_smartphone/model/item/file/file_model.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
class ItemModel with _$ItemModel {
  const factory ItemModel({
    required String id,
    required String title,
    @Default(0) int createdAt,
    @Default('') String latitude,
    @Default('') String longitude,
    @Default('') String scope,
    @Default('') String description,
    @Default(0) int radius,
    @Default('') String userId,
    required FileModel file,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
}
