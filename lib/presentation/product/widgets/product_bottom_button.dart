import 'package:flutter/material.dart';
import 'package:flutter_app_test/app/theme/app_colors.dart';
import 'package:flutter_app_test/core/utils/screenutil_extension.dart';
import 'package:flutter_app_test/presentation/product/cubit/product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductBottomButton extends StatelessWidget {
  const ProductBottomButton({super.key, required this.productId, required this.onPress});

  final String productId;
  final VoidCallback onPress;

  void _confirmDelete(BuildContext context, String productId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Xác nhận xóa'),
            content: const Text('Bạn có chắc muốn xóa sản phẩm này không?'),
            actions: [
              TextButton(onPressed: () => context.pop(), child: const Text('Hủy')),
              ElevatedButton(
                onPressed: () {
                  context.read<ProductCubit>().deleteProduct(productId);
                  context.pop(); // close dialog
                  context.goNamed('productList'); // back to product list
                },
                child: const Text('Xóa'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24.w,
      right: 24.w,
      bottom: 24.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onPress,
              icon: const Icon(Icons.edit),
              label: const Text('Chỉnh sửa'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                _confirmDelete(context, productId);
              },
              icon: const Icon(Icons.delete),
              label: const Text('Xóa'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
