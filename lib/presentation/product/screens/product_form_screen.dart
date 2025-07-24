import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_test/presentation/product/cubit/product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

import '../widgets/product_form.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key, this.productId});

  final String? productId;

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _descCtrl = TextEditingController();
  TextEditingController _priceCtrl = TextEditingController();
  TextEditingController _stockCtrl = TextEditingController();

  String? _selectedCategoryId;
  final List<String> _imagePaths = [];

  Future<void> _pickImageFromDevice() async {
    final picker = ImagePicker();
    List<XFile> images = await picker.pickMultiImage();

    if (images.isNotEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      final imageFolder = Directory(p.join(dir.path, 'images'));
      if (!await imageFolder.exists()) {
        await imageFolder.create(recursive: true);
      }

      int remaining = 5 - _imagePaths.length;

      for (final picked in images.take(remaining)) {
        final copiedPath = p.join(imageFolder.path, p.basename(picked.path));
        await File(picked.path).copy(copiedPath);

        setState(() {
          _imagePaths.add(copiedPath);
        });
      }
    }
  }

  void _removeImage(int index) {
    setState(() => _imagePaths.removeAt(index));
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedCategoryId != null) {
      if (widget.productId == null) {
        context.read<ProductCubit>().createProduct(
          name: _nameCtrl.text.trim(),
          description: _descCtrl.text.trim(),
          price: int.parse(_priceCtrl.text),
          stockQuantity: int.parse(_stockCtrl.text),
          categoryId: _selectedCategoryId!,
          assetImagePaths: _imagePaths,
        );
      } else {
        context.read<ProductCubit>().editProduct(
          id: widget.productId!,
          name: _nameCtrl.text.trim(),
          description: _descCtrl.text.trim(),
          price: int.parse(_priceCtrl.text),
          stockQuantity: int.parse(_stockCtrl.text),
          categoryId: _selectedCategoryId!,
          assetImagePaths: _imagePaths,
        );
      }

      context.read<ProductCubit>().reFilterByCategory();
      context.goNamed('productList');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final product = context.read<ProductCubit>().state.selectedProduct;
    if (widget.productId != null) {
      _nameCtrl = TextEditingController(text: product?.name ?? '');
      _descCtrl = TextEditingController(text: product?.description ?? '');
      _priceCtrl = TextEditingController(text: product?.price.toString() ?? '');
      _stockCtrl = TextEditingController(text: product?.stockQuantity.toString() ?? '');
      setState(() {
        if (product!.images.isNotEmpty) {
          _imagePaths.addAll(product.images);
        }
      });
      _selectedCategoryId = product?.categoryId ?? '';
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _nameCtrl.dispose();
    _descCtrl.dispose();
    _priceCtrl.dispose();
    _stockCtrl.dispose();
    _selectedCategoryId = '';
  }

  @override
  Widget build(BuildContext context) {
    final selectedProduct = context.read<ProductCubit>().state.selectedProduct;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productId == null ? 'Thêm sản phẩm' : 'Chỉnh sửa sản phẩm'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            return ProductForm(
              formKey: _formKey,
              nameController: _nameCtrl,
              descriptionController: _descCtrl,
              priceController: _priceCtrl,
              stockController: _stockCtrl,
              selectedCategoryId: _selectedCategoryId,
              onCategoryChanged: (val) => setState(() => _selectedCategoryId = val),
              imagePaths: _imagePaths,
              onPickImage: _pickImageFromDevice,
              onRemoveImage: _removeImage,
              onSubmit: _submit,
              product: selectedProduct,
              categories: state.categories,
            );
          },
        ),
      ),
    );
  }
}
