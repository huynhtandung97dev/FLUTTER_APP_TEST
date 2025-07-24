import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/app/theme/app_colors.dart';
import 'package:flutter_app_test/core/utils/screenutil_extension.dart';
import 'package:flutter_app_test/presentation/product/cubit/product_cubit.dart';
import 'package:flutter_app_test/presentation/product/widgets/product_bottom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ScrollController _controller = ScrollController();
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductCubit>().detailProduct(widget.productId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _carouselController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          final product = state.selectedProduct;
          if (product == null) {
            return Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              CustomScrollView(
                controller: _controller,
                slivers: [
                  SliverAppBar(
                    leading: IconButton(
                      onPressed: () => context.pop(),
                      icon: Icon(Icons.arrow_back),
                    ),
                    expandedHeight: 296.h,
                    floating: true,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: _buildImageCarousel(
                        _carouselController,
                        product.id,
                        product.images,
                      ),
                      title: Text(
                        product.name,
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(color: AppColors.onPrimary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(height: 500.h, color: AppColors.info),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(height: 500.h, color: AppColors.info),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(height: 500.h, color: AppColors.info),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(height: 500.h, color: AppColors.info),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(height: 500.h, color: AppColors.info),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(height: 500.h, color: AppColors.info),
                      ),
                    ),
                  ),
                ],
              ),
              ProductBottomButton(
                productId: product.id,
                // onPress: () {
                //   print(context.read<ProductCubit>().state.categories);
                // },
                onPress: () {
                  context.pushNamed('productFormEdit', pathParameters: {'id': product.id});
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildImageCarousel(
    CarouselSliderController controller,
    String productId,
    List<String> images,
  ) {
    return CarouselSlider(
      carouselController: controller,
      options: CarouselOptions(
        height: double.infinity,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayAnimationDuration: Duration(milliseconds: 1500),
        autoPlayInterval: Duration(seconds: 20),
      ),
      items:
          images.map((url) {
            return Builder(
              builder: (context) {
                final isLocal = !url.startsWith('http') && !url.startsWith('https');
                return Hero(
                  tag: 'product-image-$productId',
                  child:
                      isLocal
                          ? Image.file(
                            File(url),
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __, ___) => const Center(child: Icon(Icons.broken_image)),
                          )
                          : Image.network(
                            url,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __, ___) => const Center(child: Icon(Icons.broken_image)),
                          ),
                );
              },
            );
          }).toList(),
    );
  }
}
