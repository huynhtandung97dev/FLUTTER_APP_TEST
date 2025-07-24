// lib/data/datasources/remote/mock_product_api.dart
import 'package:flutter_app_test/app/di/di.dart';
import 'package:flutter_app_test/data/models/category_model.dart';
import 'package:flutter_app_test/data/product/model/product_model.dart';

import 'mock_dio_client.dart';

class MockProductApi {
  final dioClient = getIt<MockDioClient>();

  Future<List<ProductModel>> getProducts() async {
    final data = await dioClient.getList('assets/mock/api/products.json');
    return data.map(ProductModel.fromJson).toList();
  }

  Future<List<CategoryModel>> getCategories() async {
    final data = await dioClient.getList('assets/mock/api/categories.json');
    return data.map(CategoryModel.fromJson).toList();
  }

  Future<ProductModel> getDetailProduct(String id) async {
    final data = await dioClient.getList('assets/mock/api/products.json');
    final list = data.map((e) => ProductModel.fromJson(e)).toList();

    final product = list.firstWhere((e) => e.id == id);

    return product;
  }
}
