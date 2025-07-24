import 'package:flutter_app_test/app/router/app_page_transition.dart';
import 'package:flutter_app_test/data/product/model/product_model.dart';
import 'package:flutter_app_test/presentation/product/screens/product_detail_screen.dart';
import 'package:flutter_app_test/presentation/product/screens/product_form_screen.dart';
import 'package:flutter_app_test/presentation/product/screens/product_list_screen.dart';
import 'package:flutter_app_test/presentation/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', name: 'splash', builder: (context, state) => SplashScreen()),
    GoRoute(
      path: '/products',
      name: 'productList',
      pageBuilder:
          (context, state) =>
              AppPageTransition.build(key: state.pageKey, child: const ProductListScreen()),
      routes: [
        GoRoute(
          path: 'detail/:id',
          name: 'productDetail',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ProductDetailScreen(productId: id);
          },
        ),
        GoRoute(
          path: 'form',
          name: 'productFormCreate',
          pageBuilder: (context, state) {
            return AppPageTransition.build(
              key: state.pageKey,
              child: ProductFormScreen(productId: null),
            );
          },
        ),
        GoRoute(
          path: 'form/:id',
          name: 'productFormEdit',
          pageBuilder: (context, state) {
            final id = state.pathParameters['id']!;
            return AppPageTransition.build(
              key: state.pageKey,
              child: ProductFormScreen(productId: id),
            );
          },
        ),
      ],
    ),
  ],
);
