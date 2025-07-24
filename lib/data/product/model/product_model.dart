import 'package:equatable/equatable.dart';
import 'package:flutter_app_test/domain/entities/product_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final int price;
  @JsonKey(name: 'stock')
  final int stockQuantity;
  final String categoryId;
  final List<String> images;

  const ProductModel({
    this.id = '',
    this.name = '',
    this.description = '',
    this.price = 0,
    this.stockQuantity = 0,
    this.categoryId = '',
    this.images = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      stockQuantity: entity.stockQuantity,
      categoryId: entity.categoryId,
      images: entity.images,
    );
  }

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  List<Object?> get props => [id, name, description, price, stockQuantity, categoryId, images];
}
