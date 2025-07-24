import 'package:flutter_app_test/data/datasources/remote/api_service.dart';
import 'package:flutter_app_test/data/datasources/remote/mock_dio_client.dart';
import 'package:flutter_app_test/data/datasources/remote/mock_product_api.dart';
import 'package:flutter_app_test/data/product/ds/product_ds.dart';
import 'package:get_it/get_it.dart';

import '../../domain/repositories/product/product_repository.dart';
import '../../presentation/product/cubit/product_cubit.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  DependencyInjection._();

  static Future<void> initialize() async {
    // Datasource/API
    getIt
      /// Api Service
      ..registerLazySingleton<ApiService>(ApiService.new)
      /// Data sources
      ..registerLazySingleton<ProductDataSource>(ProductDataSourceImp.new)
      /// Repository
      ..registerLazySingleton<ProductRepository>(ProductRepositoryImpl.new)
      /// Mock Dio Client
      ..registerLazySingleton<MockDioClient>(MockDioClient.new)
      ..registerLazySingleton<MockProductApi>(MockProductApi.new)
      /// Cubits & BLoCs & State
      ..registerLazySingleton<ProductCubit>(ProductCubit.new)
      ..registerLazySingleton<ProductState>(ProductState.new);
  }
}
