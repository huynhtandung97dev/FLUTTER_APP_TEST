import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_test/app/theme/app_colors.dart';
import 'package:flutter_app_test/data/models/category_model.dart';
import 'package:flutter_app_test/data/product/model/product_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController stockController;
  final String? selectedCategoryId;
  final List<CategoryModel> categories;

  final void Function(String?) onCategoryChanged;

  final List<String> imagePaths;
  final VoidCallback onPickImage;
  final void Function(int) onRemoveImage;

  final VoidCallback onSubmit;

  final ProductModel? product;

  const ProductForm({
    super.key,
    required this.formKey,
    required this.onCategoryChanged,
    required this.imagePaths,
    required this.onPickImage,
    required this.onRemoveImage,
    required this.onSubmit,
    this.product,
    required this.nameController,
    required this.descriptionController,
    required this.priceController,
    required this.stockController,
    this.selectedCategoryId,
    required this.categories,
  });

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: widget.nameController,
            decoration: const InputDecoration(labelText: 'Tên sản phẩm'),
            validator: (v) => v == null || v.isEmpty ? 'Không được để trống' : null,
          ),
          TextFormField(
            controller: widget.descriptionController,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Mô tả'),
            validator: (v) => v == null || v.isEmpty ? 'Không được để trống' : null,
          ),
          TextFormField(
            controller: widget.priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Giá (VNĐ)'),
            validator: (v) {
              final val = int.tryParse(v ?? '');
              if (val == null || val <= 0 || val % 1000 != 0) {
                return 'Phải là bội số 1000 và lớn hơn 0';
              }
              return null;
            },
          ),
          TextFormField(
            controller: widget.stockController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Tồn kho'),
            validator: (v) {
              final val = int.tryParse(v ?? '');
              if (val == null || val < 0 || val > 10000) {
                return 'Tồn kho từ 0 đến 10000';
              }
              return null;
            },
          ),
          DropdownButtonFormField<String>(
            value: widget.selectedCategoryId,
            hint: const Text('Chọn danh mục'),
            items:
                widget.categories.map((cat) {
                  return DropdownMenuItem<String>(value: cat.id, child: Text(cat.name));
                }).toList(),
            onChanged: widget.onCategoryChanged,
            validator: (val) => val == null ? 'Vui lòng chọn danh mục' : null,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Ảnh sản phẩm:'),
              IconButton(
                onPressed: widget.imagePaths.length >= 5 ? null : widget.onPickImage,
                icon: const Icon(Icons.add_photo_alternate),
              ),
            ],
          ),
          Wrap(
            spacing: 8,
            children:
                widget.imagePaths.asMap().entries.map((entry) {
                  final index = entry.key;
                  final path = entry.value;
                  final isLocal = !path.startsWith('http') && !path.startsWith('https');
                  if (isLocal) {
                    return Stack(
                      children: [
                        Image.file(File(path), width: 96.0.w, height: 96.0.h, fit: BoxFit.cover),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                            onTap: () => widget.onRemoveImage(index),
                            child: CircleAvatar(
                              radius: 16.0.r,
                              backgroundColor: AppColors.error,
                              child: Icon(Icons.close, size: 16.0.w, color: AppColors.onPrimary),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Stack(
                      children: [
                        Image.network(path, width: 96.0.w, height: 96.0.h, fit: BoxFit.cover),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                            onTap: () => widget.onRemoveImage(index),
                            child: CircleAvatar(
                              radius: 16.0.r,
                              backgroundColor: AppColors.error,
                              child: Icon(Icons.close, size: 16.0.w, color: AppColors.onPrimary),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }).toList(),
          ),
          24.0.h.verticalSpace,
          ElevatedButton(onPressed: widget.onSubmit, child: const Text('Lưu sản phẩm')),
        ],
      ),
    );
  }
}
