// domain/repositories/product_repository.dart
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app_test/app/di/di.dart';
import 'package:flutter_app_test/core/error/network_exception.dart';
import 'package:flutter_app_test/core/model/failure.dart';
import 'package:flutter_app_test/data/models/category_model.dart';
import 'package:flutter_app_test/data/product/ds/product_ds.dart';
import 'package:flutter_app_test/data/product/model/product_model.dart';

part 'product_repository_impl.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> getProducts();
  Future<Either<Failure, List<CategoryModel>>> getCategories();

  Future<Either<Failure, ProductModel>> getDetailProduct(String id);
}
