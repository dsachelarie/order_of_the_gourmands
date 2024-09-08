import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import '../services/categories_service.dart';
import '../breakpoints.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/top_bar_widget.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  void _navigateToRecipeList(BuildContext context) {
    Navigator.pushNamed(context, '/recipe-list/');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget body;

    if (MediaQuery.of(context).size.width <= Breakpoints.md) {
      body = GridView.count(
          crossAxisCount: 1,
          childAspectRatio: MediaQuery.of(context).size.width / 150.0,
          children: CategoriesService.getCategoriesList(
              ref.watch(categoriesProvider),
              () => _navigateToRecipeList(context),
              ref));
    } else if (MediaQuery.of(context).size.width <= Breakpoints.lg) {
      body = GridView.count(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width / 2 / 150.0,
          children: CategoriesService.getCategoriesList(
              ref.watch(categoriesProvider),
              () => _navigateToRecipeList(context),
              ref));
    } else {
      body = GridView.count(
          crossAxisCount: 4,
          childAspectRatio: MediaQuery.of(context).size.width / 4 / 150.0,
          children: CategoriesService.getCategoriesList(
              ref.watch(categoriesProvider),
              () => _navigateToRecipeList(context),
              ref));
    }

    return SafeArea(
        child: Scaffold(
            appBar: const TopBarWidget(),
            body: body,
            bottomNavigationBar: const BottomBarWidget()));
  }
}
