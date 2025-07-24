import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_test/app/theme/app_colors.dart';
import 'package:flutter_app_test/core/utils/images_util.dart';
import 'package:flutter_app_test/data/product/model/product_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onPress;

  const ProductCard({super.key, required this.product, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final imagePath = product.images.isNotEmpty ? product.images.first : null;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 2,
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: AspectRatio(
                aspectRatio: 1.15,
                child: Hero(
                  tag: 'product-image-${product.id}',
                  child: _buildProductImage(imagePath),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.labelLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${product.price.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ".")}đ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Tồn kho: ${product.stockQuantity}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String? path) {
    if (path == null || path.isEmpty) {
      return const Center(child: Icon(Icons.image_not_supported, size: 40));
    }

    if (isNetworkImage(path)) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image, size: 40)),
      );
    }

    return Image.file(
      File(path),
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image, size: 40)),
    );
  }
}
