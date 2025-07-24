import 'package:flutter/material.dart';
import 'package:flutter_app_test/app/theme/app_colors.dart';
import 'package:flutter_app_test/core/utils/screenutil_extension.dart';
import 'package:flutter_app_test/data/models/category_model.dart';

class CategoryChipList extends StatelessWidget {
  final List<CategoryModel> categories;
  final int selectedIndex;
  final void Function(int index) onChipSelected;

  const CategoryChipList({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onChipSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: List.generate(categories.length, (index) {
          final isSelected = index == selectedIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(categories[index].name),
              selected: isSelected,
              onSelected: (_) => onChipSelected(index),
              selectedColor: Theme.of(context).colorScheme.onSurfaceVariant,
              backgroundColor: AppColors.onPrimary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.r)),
              labelStyle: TextStyle(
                color: isSelected ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
          );
        }),
      ),
    );
  }
}
