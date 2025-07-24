import 'package:flutter/material.dart';
import 'package:flutter_app_test/app/app.dart';
import 'package:flutter_app_test/app/di/di.dart';
import 'package:flutter_app_test/domain/entities/product_entity.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  // init Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ProductEntityAdapter());
  // ignore: unused_local_variable
  var box = await Hive.openBox('mybox');

  // Initialize Dependency injection
  await DependencyInjection.initialize();
  runApp(const MyApp());
}
