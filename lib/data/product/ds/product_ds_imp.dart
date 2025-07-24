part of 'product_ds.dart';

class ProductDataSourceImp extends ProductDataSource {
  // final _dio = getIt<DioClient>();
  final _api = getIt<MockProductApi>();
  @override
  Future<List<ProductModel>> fetch() async {
    final List<ProductModel> response = await _api.getProducts();

    return response;
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    final List<CategoryModel> response = await _api.getCategories();

    return response;
  }

  @override
  Future<ProductModel> detail(String id) async {
    final ProductModel response = await _api.getDetailProduct(id);

    return response;
  }
}
