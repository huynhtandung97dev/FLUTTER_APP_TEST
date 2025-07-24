// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorModel _$ErrorModelFromJson(Map<String, dynamic> json) => ErrorModel(
      json['type'] as String? ?? 'unknown',
      (json['errors'] as List<dynamic>?)
          ?.map((e) => ErrorsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ErrorModelToJson(ErrorModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'errors': instance.errors,
    };

ErrorsModel _$ErrorsModelFromJson(Map<String, dynamic> json) => ErrorsModel(
      json['code'] as String?,
      json['detail'] as String?,
      json['attr'] as String?,
    );

Map<String, dynamic> _$ErrorsModelToJson(ErrorsModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'detail': instance.detail,
      'attr': instance.attr,
    };
