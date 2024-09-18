import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/buttons/category_button.dart';
import '../models/category.dart';
import '../providers.dart';
import '../breakpoints.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/top_bar_widget.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget body;

    List<Widget> categoriesWidgets = [];

    for (Category category in ref.watch(categoriesProvider)) {
      categoriesWidgets
          .add(SizedBox(height: 150.0, child: CategoryButton(category)));
    }

    if (MediaQuery.of(context).size.width <= Breakpoints.md) {
      body = GridView.count(
          crossAxisCount: 1,
          childAspectRatio: MediaQuery.of(context).size.width / 150.0,
          children: categoriesWidgets);
    } else if (MediaQuery.of(context).size.width <= Breakpoints.lg) {
      body = GridView.count(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width / 2 / 150.0,
          children: categoriesWidgets);
    } else {
      body = GridView.count(
          crossAxisCount: 3,
          childAspectRatio: MediaQuery.of(context).size.width / 3 / 150.0,
          children: categoriesWidgets);
    }

    return SafeArea(
        child: Scaffold(
            appBar: const TopBarWidget(),
            body: body,
            bottomNavigationBar: const BottomBarWidget()));
  }
}
