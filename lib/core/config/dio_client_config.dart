import 'package:dio/dio.dart';
import 'package:flutter_app_test/app/config/env.dart';

class DioClient {
  DioClient() {
    _dio.options = BaseOptions(baseUrl: RemoteServiceEnv.apiUrl, contentType: 'application/json');
  }

  final Dio _dio = Dio();
  Dio get sendRequest => _dio;
}
