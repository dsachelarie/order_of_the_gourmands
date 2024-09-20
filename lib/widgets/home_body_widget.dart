import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './buttons/category_button.dart';
import '../services/categories_service.dart';
import '../models/category.dart';

abstract class HomeBodyWidget extends ConsumerWidget {
  const HomeBodyWidget({super.key});

  List<Widget> buildCategoriesWidgets(WidgetRef ref) {
    List<Widget> categoriesWidgets = [];

    for (Category category in CategoriesService.getMostPopularCategories(ref)) {
      categoriesWidgets
          .add(SizedBox(height: 150.0, child: CategoryButton(category)));
    }

    return categoriesWidgets;
  }
}
