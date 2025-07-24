import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_test/app/theme/app_colors.dart';
import 'package:flutter_app_test/core/utils/screenutil_extension.dart';
import 'package:flutter_app_test/data/product/model/product_model.dart';

class SearchBarWithOverlay extends StatefulWidget {
  // final TextEditingController controller;
  final List<ProductModel> allProducts;
  final Function(String query) onSearchChanged;
  final Function(ProductModel) onProductSelected;

  const SearchBarWithOverlay({
    super.key,
    // required this.controller,
    required this.allProducts,
    required this.onSearchChanged,
    required this.onProductSelected,
  });

  @override
  State<SearchBarWithOverlay> createState() => _SearchBarWithOverlayState();
}

class _SearchBarWithOverlayState extends State<SearchBarWithOverlay> {
  final TextEditingController _controller = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<ProductModel> _searchResults = [];

  void _showOverlay() {
    _hideOverlay();
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            width: MediaQuery.of(context).size.width - 24.w,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, 48.h),
              child: Material(
                elevation: 4,
                child: SingleChildScrollView(
                  child: ListView.builder(
                    primary: false,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final product = _searchResults[index];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Builder(
                            builder: (context) {
                              final url = product.images.first;
                              final isLocal = !url.startsWith('http') && !url.startsWith('https');
                              if (isLocal) {
                                return Image.file(
                                  File(url),
                                  width: 48.w,
                                  height: 48.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.broken_image, size: 48.w, color: Colors.grey);
                                  },
                                );
                              } else {
                                return Image.network(
                                  url,
                                  width: 48.w,
                                  height: 48.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.broken_image, size: 48.w, color: Colors.grey);
                                  },
                                );
                              }
                            },
                          ),
                        ),
                        title: Text(product.name),
                        onTap: () {
                          FocusManager.instance.primaryFocus!.unfocus();
                          _controller.clear();
                          _hideOverlay();
                          widget.onProductSelected(product);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
    );
    overlay.insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _updateSearch(String query) {
    widget.onSearchChanged(query);
    if (query.isEmpty) {
      _hideOverlay();
      return;
    }

    final filtered =
        widget.allProducts
            .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    setState(() {
      _searchResults = filtered;
    });

    _showOverlay();
  }

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.onPrimary,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: TextFormField(
          controller: _controller,
          onChanged: _updateSearch,
          decoration: InputDecoration(
            hintText: 'Tìm sản phẩm...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          ),
        ),
      ),
    );
  }
}
