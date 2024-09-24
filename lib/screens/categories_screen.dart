import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../widgets/buttons/category_button.dart';
import '../models/category.dart';
import '../providers.dart';
import '../breakpoints.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/top_bar_widget.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  static const _pageSize = 20;

  final PagingController<int, Category> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          ref.watch(categoriesProvider).skip(pageKey).take(_pageSize).toList();
      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Widget _buildRecipeItem(
      BuildContext context, WidgetRef ref, Category category) {
    return SizedBox(height: 150.0, child: CategoryButton(category));
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (MediaQuery.of(context).size.width <= Breakpoints.md) {
      body = PagedGridView<int, Category>(
          pagingController: _pagingController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: MediaQuery.of(context).size.width / 150.0,
          ),
          builderDelegate: PagedChildBuilderDelegate<Category>(
            itemBuilder: (context, category, index) =>
                _buildRecipeItem(context, ref, category),
          ));
    } else if (MediaQuery.of(context).size.width <= Breakpoints.lg) {
      body = PagedGridView<int, Category>(
          pagingController: _pagingController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width / 2 / 150.0,
          ),
          builderDelegate: PagedChildBuilderDelegate<Category>(
            itemBuilder: (context, category, index) =>
                _buildRecipeItem(context, ref, category),
          ));
    } else {
      body = PagedGridView<int, Category>(
          pagingController: _pagingController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: MediaQuery.of(context).size.width / 3 / 150.0,
          ),
          builderDelegate: PagedChildBuilderDelegate<Category>(
            itemBuilder: (context, category, index) =>
                _buildRecipeItem(context, ref, category),
          ));
    }

    return SafeArea(
        child: Scaffold(
            appBar: const TopBarWidget(),
            body: body,
            bottomNavigationBar: const BottomBarWidget()));
  }
}
