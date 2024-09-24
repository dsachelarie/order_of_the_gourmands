import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../models/category_recipe.dart';
import '../breakpoints.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../models/recipe.dart';
import '../providers.dart';

class RecipeListScreen extends ConsumerStatefulWidget {
  const RecipeListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends ConsumerState<RecipeListScreen> {
  static const _pageSize = 20;

  final PagingController<int, Recipe> _pagingController =
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
      List<Recipe> recipes = ref.watch(recipesProvider);
      List<Recipe> filteredRecipes = [];
      List<CategoryRecipe> categoriesRecipes =
          ref.watch(recipeCategoryProvider);
      Map<String, dynamic> filters = ref.watch(recipeFilterProvider);

      if (filters.containsKey("name")) {
        filteredRecipes = recipes.where((recipe) {
          for (String seq in filters["name"]) {
            if (recipe.name.toLowerCase().contains(seq)) {
              return true;
            }
          }

          return false;
        }).toList();
      } else if (filters.containsKey("category_id")) {
        categoriesRecipes = categoriesRecipes
            .where((categoryRecipe) =>
                categoryRecipe.categoryId == filters["category_id"])
            .toList();

        filteredRecipes = recipes.where((recipe) {
          for (CategoryRecipe categoryRecipe in categoriesRecipes) {
            if (categoryRecipe.recipeId == recipe.id) {
              return true;
            }
          }

          return false;
        }).toList();
      } else if (filters.containsKey("creator_id")) {
        filteredRecipes = recipes
            .where((recipe) => recipe.creatorId == filters["creator_id"])
            .toList();
      } else if (filters.containsKey("favorite_of")) {
        filteredRecipes = recipes
            .where(
                (recipe) => recipe.favoriteOf.contains(filters["favorite_of"]))
            .toList();
      }

      final newItems = filteredRecipes.skip(pageKey).take(_pageSize).toList();
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

  Widget _buildRecipeItem(BuildContext context, WidgetRef ref, Recipe recipe) {
    bool starPressed = ref.watch(userProvider).value != null &&
        recipe.favoriteOf.contains(ref.watch(userProvider).value!.uid);

    return Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0),
        child: ElevatedButton(
            onPressed: () {
              ref.watch(activeRecipeIdProvider.notifier).update((state) =>
                  state = ref
                      .watch(recipesProvider)
                      .where((selectedRecipe) => selectedRecipe.id == recipe.id)
                      .first
                      .id);

              Navigator.pushNamed(context, '/recipe/');
            },
            child: Row(children: [
              Text(recipe.name),
              const Spacer(),
              IconButton(
                  icon: Stack(children: [
                    if (starPressed)
                      const Icon(Icons.star, color: Colors.yellow),
                    const Icon(Icons.star_border),
                  ]),
                  onPressed: ref.watch(userProvider).value == null
                      ? null
                      : () {
                          List favoriteOf = recipe.favoriteOf;

                          if (starPressed) {
                            favoriteOf
                                .remove(ref.watch(userProvider).value!.uid);
                          } else {
                            favoriteOf.add(ref.watch(userProvider).value!.uid);
                          }

                          ref.watch(recipesProvider.notifier).updateRecipe(
                              recipe.id, {"favorite_of": favoriteOf});

                          setState(() {});
                        }),
              Text("${recipe.favoriteOf.length}")
            ])));
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (MediaQuery.of(context).size.width <= Breakpoints.md) {
      body = PagedListView<int, Recipe>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Recipe>(
            itemBuilder: (context, recipe, index) =>
                _buildRecipeItem(context, ref, recipe),
          ));
    } else if (MediaQuery.of(context).size.width <= Breakpoints.lg) {
      body = PagedGridView<int, Recipe>(
          pagingController: _pagingController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 8,
          ),
          builderDelegate: PagedChildBuilderDelegate<Recipe>(
            itemBuilder: (context, recipe, index) =>
                _buildRecipeItem(context, ref, recipe),
          ));
    } else {
      body = PagedGridView<int, Recipe>(
          pagingController: _pagingController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 16 / 3,
          ),
          builderDelegate: PagedChildBuilderDelegate<Recipe>(
            itemBuilder: (context, recipe, index) =>
                _buildRecipeItem(context, ref, recipe),
          ));
    }

    return SafeArea(
        child: Scaffold(
            appBar: const TopBarWidget(),
            body: body,
            bottomNavigationBar: const BottomBarWidget()));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
