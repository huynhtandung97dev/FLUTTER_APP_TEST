part of 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource _ds = getIt<ProductDataSource>();
  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final data = await _ds.fetch();
      return Right(data);
    } on DioException catch (e) {
      final ex = NetworkException.getDioException(e);
      return Left(NetworkFailure(ex));
    } catch (e, stackTrace) {
      log('🐞Error: $e', stackTrace: stackTrace);
      return Left(NetworkFailure(const NetworkException.unexpectedError()));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getDetailProduct(String id) async {
    try {
      final data = await _ds.detail(id);
      return Right(data);
    } on DioException catch (e) {
      final ex = NetworkException.getDioException(e);
      return Left(NetworkFailure(ex));
    } catch (e, stackTrace) {
      log('🐞Error: $e', stackTrace: stackTrace);
      return Left(NetworkFailure(const NetworkException.unexpectedError()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final data = await _ds.fetchCategories();
      return Right(data);
    } on DioException catch (e) {
      final ex = NetworkException.getDioException(e);
      return Left(NetworkFailure(ex));
    } catch (e, stackTrace) {
      log('🐞Error: $e', stackTrace: stackTrace);
      return Left(NetworkFailure(const NetworkException.unexpectedError()));
    }
  }
}
