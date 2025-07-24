import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_test/core/utils/screenutil_extension.dart';
import 'package:flutter_app_test/presentation/product/cubit/product_cubit.dart';
import 'package:flutter_app_test/presentation/product/widgets/category_chip_list.dart';
import 'package:flutter_app_test/presentation/product/widgets/product_card.dart';
import 'package:flutter_app_test/presentation/product/widgets/searchbar_with_overlay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<ProductCubit>().searchByName(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('danh sách sản phẩm')),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            final products =
                state.filteredProducts.isEmpty ? state.products : state.filteredProducts;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProductCubit>().fetchProducts();
              },
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    expandedHeight: 110.h,
                    pinned: true,
                    floating: false,
                    snap: false,
                    // title: const Text('Danh sách sản phẩm'),
                    flexibleSpace: FlexibleSpaceBar(centerTitle: true),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(56.h),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        child: Column(
                          children: [
                            SearchBarWithOverlay(
                              allProducts: state.searchProducts,
                              onSearchChanged: _onSearchChanged,
                              onProductSelected: (product) {
                                FocusScope.of(context).unfocus();
                                context.pushNamed(
                                  'productDetail',
                                  pathParameters: {'id': product.id},
                                );
                              },
                            ),
                            SizedBox(height: 8.h),
                            CategoryChipList(
                              categories: state.categories,
                              selectedIndex: state.selectedCategoryIndex,
                              onChipSelected: (index) {
                                if (index == 0) {
                                  context.read<ProductCubit>().fetchProducts();
                                } else {
                                  context.read<ProductCubit>().filterByCategory(index);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  if (state.status.isInProgress)
                    SliverFillRemaining(child: Center(child: CircularProgressIndicator())),

                  if (products.isEmpty)
                    SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'Không có sản phẩm nào',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    )
                  else
                    SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final product = products[index];
                        return Padding(
                          padding: EdgeInsets.all(8.w),
                          child: ProductCard(
                            product: product,
                            onPress: () {
                              // context.read<ProductCubit>().detailProduct(product.id);
                              context.pushNamed(
                                'productDetail',
                                pathParameters: {'id': product.id},
                              );
                            },
                          ),
                        );
                      }, childCount: products.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.w,
                        crossAxisSpacing: 8.h,
                        childAspectRatio: 0.75,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          key: const Key('add_product_button'),
          onPressed: () => context.pushNamed('productFormCreate'),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
