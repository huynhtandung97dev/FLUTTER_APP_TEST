import 'package:flutter/material.dart';
import 'package:flutter_app_test/app/di/di.dart';
import 'package:flutter_app_test/app/router/app_router.dart';
import 'package:flutter_app_test/app/theme/app_theme.dart';
import 'package:flutter_app_test/core/config/screenutil_config.dart';
import 'package:flutter_app_test/presentation/product/cubit/product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilConfig.init(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProductCubit>(
            create: (_) {
              final cubit =
                  getIt<ProductCubit>()
                    ..fetchProducts()
                    ..fetchCategories();
              return cubit;
            },
          ),
        ],
        child: MaterialApp.router(
          themeMode: ThemeMode.system,
          routerConfig: appRouter,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
        ),
      ),
    );
  }
}
