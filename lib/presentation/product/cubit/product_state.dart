part of 'product_cubit.dart';

class ProductState extends Equatable {
  final List<ProductModel> products;
  final List<ProductModel> filteredProducts;
  final List<ProductModel> searchProducts;
  final ProductModel? selectedProduct;
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  final int selectedCategoryIndex;
  final String searchQuery;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  const ProductState({
    this.products = const [],
    this.filteredProducts = const [],
    this.searchProducts = const [],
    this.selectedProduct,
    this.categories = const [],
    this.selectedCategory,
    this.selectedCategoryIndex = 0,
    this.searchQuery = '',
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  ProductState copyWith({
    List<ProductModel>? products,
    List<ProductModel>? filteredProducts,
    List<ProductModel>? searchProducts,
    ProductModel? selectedProduct,
    List<CategoryModel>? categories,
    CategoryModel? selectedCategory,
    int? selectedCategoryIndex,
    String? searchQuery,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return ProductState(
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      searchProducts: searchProducts ?? this.searchProducts,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    products,
    filteredProducts,
    searchProducts,
    selectedProduct,
    categories,
    selectedCategory,
    selectedCategoryIndex,
    searchQuery,
    status,
    errorMessage,
  ];
}
