import 'dart:convert';
import 'package:flutter/services.dart';

class MockDioClient {
  Future<List<Map<String, dynamic>>> getList(String assetPath) async {
    final jsonStr = await rootBundle.loadString(assetPath);
    final List<dynamic> data = json.decode(jsonStr);
    return data.cast<Map<String, dynamic>>();
  }
}
