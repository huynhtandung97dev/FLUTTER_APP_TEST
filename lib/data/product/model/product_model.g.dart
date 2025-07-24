// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  description: json['description'] as String? ?? '',
  price: (json['price'] as num?)?.toInt() ?? 0,
  stockQuantity: (json['stock'] as num?)?.toInt() ?? 0,
  categoryId: json['categoryId'] as String? ?? '',
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'stock': instance.stockQuantity,
  'categoryId': instance.categoryId,
  'images': instance.images,
};
