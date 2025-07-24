import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_app_test/data/models/category_model.dart';
import 'package:flutter_app_test/data/product/model/product_model.dart';

class ApiService {
  static Future<List<ProductModel>> getProducts() async {
    final jsonStr = await rootBundle.loadString('assets/mock/products.json');
    final List data = json.decode(jsonStr);
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }

  static Future<List<CategoryModel>> getCategories() async {
    final jsonStr = await rootBundle.loadString('assets/mock/categories.json');
    final List data = json.decode(jsonStr);
    return data.map((e) => CategoryModel.fromJson(e)).toList();
  }
}
