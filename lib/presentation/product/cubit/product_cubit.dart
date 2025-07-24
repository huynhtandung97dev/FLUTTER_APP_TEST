import 'package:flutter_app_test/app/di/di.dart';
import 'package:flutter_app_test/core/error/network_exception.dart';
import 'package:flutter_app_test/core/model/failure.dart';
import 'package:flutter_app_test/data/models/category_model.dart';
import 'package:flutter_app_test/data/product/model/product_model.dart';
import 'package:flutter_app_test/domain/entities/product_entity.dart';
import 'package:flutter_app_test/domain/repositories/product/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductState());

  final _repository = getIt<ProductRepository>();

  Future<void> fetchProducts() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final dataOrFailure = await _repository.getProducts();

    dataOrFailure.fold(
      (failure) {
        final networkException = (failure as NetworkFailure).exception;
        final message = NetworkException.getErrorMessage(networkException);
        emit(state.copyWith(status: FormzSubmissionStatus.failure, errorMessage: message));
      },
      (data) {
        final box = Hive.box('mybox');

        if (box.isNotEmpty) {
          final products = box.values.toList().map((e) => ProductModel.fromEntity(e)).toList();
          emit(
            state.copyWith(
              status: FormzSubmissionStatus.success,
              products: [...products, ...data],
              searchProducts: [...products, ...data],
              selectedCategoryIndex: 0,
              filteredProducts: [],
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: FormzSubmissionStatus.success,
              products: data,
              searchProducts: data,
              selectedCategoryIndex: 0,
              filteredProducts: [],
            ),
          );
        }
      },
    );
  }

  Future<void> fetchCategories() async {
    final dataOrFailure = await _repository.getCategories();

    dataOrFailure.fold(
      (failure) {
        final networkException = (failure as NetworkFailure).exception;
        final message = NetworkException.getErrorMessage(networkException);
        emit(state.copyWith(errorMessage: message));
      },
      (data) {
        final allCategories = [const CategoryModel(id: 'all', name: 'Tất cả'), ...data];
        emit(state.copyWith(categories: allCategories));
      },
    );
  }

  Future<void> detailProduct(String id) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final box = Hive.box('mybox');
    final value = box.get(id);
    if (value != null) {
      final selected = ProductModel.fromEntity(value);
      final category = state.categories.firstWhere((e) => e.id == selected.categoryId);
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          selectedProduct: selected,
          selectedCategory: category,
        ),
      );
    } else {
      final product = state.products.firstWhere((e) => e.id == id);
      final category = state.categories.firstWhere((e) => e.id == product.categoryId);
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          selectedProduct: product,
          selectedCategory: category,
        ),
      );
    }
  }

  Future<void> deleteProduct(String id) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final deleted = state.products.where((e) => e.id != id).toList();

    final box = Hive.box('mybox');
    final exist = box.containsKey(id);
    if (exist) {
      final product = ProductModel.fromEntity(box.get(id));
      final filter =
          state.filteredProducts.where((p) => p.categoryId != product.categoryId).toList();
      box.delete(id);
      final products = box.values.toList().map((e) => ProductModel.fromEntity(e)).toList();

      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          products: [...products, ...deleted],
          filteredProducts: filter,
        ),
      );
    } else {
      final product = state.products.firstWhere((e) => e.id == id);
      final cate = state.categories.firstWhere((e) => e.id == product.categoryId);
      final filter = state.filteredProducts.where((e) => e.categoryId != cate.id);
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          products: [...deleted],
          filteredProducts: [...filter],
        ),
      );
    }
  }

  // void refresh() => fetchProducts();

  Future<void> createProduct({
    required String name,
    required String description,
    required int price,
    required int stockQuantity,
    required String categoryId,
    required List<String> assetImagePaths,
  }) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      final product = ProductEntity(
        id: const Uuid().v4(),
        name: name,
        description: description,
        price: price,
        stockQuantity: stockQuantity,
        categoryId: categoryId,
        images: assetImagePaths,
      );

      final box = Hive.box('mybox');
      await box.put(product.id, product);

      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          products: [ProductModel.fromEntity(product), ...state.products],
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> editProduct({
    required String id,
    required String name,
    required String description,
    required int price,
    required int stockQuantity,
    required String categoryId,
    required List<String> assetImagePaths,
  }) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final box = Hive.box('mybox');
    final exist = box.containsKey(id);
    if (exist) {
      final edited = ProductEntity(
        id: id,
        name: name,
        description: description,
        price: price,
        stockQuantity: stockQuantity,
        categoryId: categoryId,
        images: assetImagePaths,
      );
      await box.put(id, edited);

      final updatedList =
          state.products.map((product) {
            if (product.id == id) {
              return ProductModel.fromEntity(edited);
            }
            return product;
          }).toList();

      if (state.selectedCategory != null || state.selectedCategory!.id != 'all') {
        final filter = List<ProductModel>.from(state.filteredProducts)
          ..removeWhere((e) => e.categoryId != state.selectedCategory!.id);
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.success,
            products: updatedList,
            selectedProduct: ProductModel.fromEntity(edited),
            filteredProducts: [...filter],
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.success,
            products: updatedList,
            selectedProduct: ProductModel.fromEntity(edited),
          ),
        );
      }
    } else {
      try {
        final updatedProduct = ProductModel(
          id: id,
          name: name,
          description: description,
          price: price,
          stockQuantity: stockQuantity,
          categoryId: categoryId,
          images: [...assetImagePaths],
        );

        final updatedList =
            state.products.map((product) {
              if (product.id == id) {
                return updatedProduct;
              }
              return product;
            }).toList();

        if (state.selectedCategory != null || state.selectedCategory!.id != 'all') {
          final filter = List<ProductModel>.from(state.filteredProducts)
            ..removeWhere((e) => e.categoryId == state.selectedCategory!.id);
          emit(
            state.copyWith(
              status: FormzSubmissionStatus.success,
              products: updatedList,
              selectedProduct: updatedProduct,
              filteredProducts: [...filter],
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: FormzSubmissionStatus.success,
              products: updatedList,
              selectedProduct: updatedProduct,
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, errorMessage: e.toString()));
      }
    }
  }

  Future<void> filterByCategory(int index) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final cate = state.categories[index];
      final filter = state.products.where((p) => p.categoryId == cate.id).toList();
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          selectedCategoryIndex: index,
          selectedCategory: cate,
          filteredProducts: filter,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> reFilterByCategory() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final cate = state.selectedCategory;
      final filter = state.products.where((p) => p.categoryId == cate!.id).toList();
      emit(state.copyWith(status: FormzSubmissionStatus.success, filteredProducts: filter));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> searchByName(String query) async {
    final selectedCategory = state.categories[state.selectedCategoryIndex];
    final isAll = selectedCategory.id == 'all';

    final result =
        state.products.where((p) {
          final matchCategory = isAll || p.categoryId == selectedCategory.id;
          final matchName = p.name.toLowerCase().contains(query.toLowerCase());
          return matchCategory && matchName;
        }).toList();

    emit(state.copyWith(searchProducts: result));
  }
}
