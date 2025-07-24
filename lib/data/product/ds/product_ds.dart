import 'package:flutter_app_test/app/di/di.dart';
import 'package:flutter_app_test/data/datasources/remote/mock_product_api.dart';
import 'package:flutter_app_test/data/models/category_model.dart';
import 'package:flutter_app_test/data/product/model/product_model.dart';

part 'product_ds_imp.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> fetch();
  Future<List<CategoryModel>> fetchCategories();

  Future<ProductModel> detail(String id);
}
