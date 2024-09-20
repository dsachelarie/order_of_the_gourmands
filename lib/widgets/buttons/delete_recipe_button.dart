import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/category.dart';
import '../../models/category_recipe.dart';
import '../../providers.dart';

class DeleteRecipeButton extends ConsumerWidget {
  final String recipeId;

  const DeleteRecipeButton(this.recipeId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
        icon: const Icon(Icons.delete_outline_outlined),
        label: const Text("Delete recipe"),
        onPressed: () {
          Navigator.pop(context);

          ref.watch(recipesProvider.notifier).deleteRecipe(recipeId);

          List<dynamic> toDelete = ref
              .watch(recipeCategoryProvider)
              .where((recipeCategory) => recipeCategory.recipeId == recipeId)
              .toList();

          for (CategoryRecipe categoryRecipe in toDelete) {
            ref
                .watch(recipeCategoryProvider.notifier)
                .deleteCategoryRecipe(categoryRecipe.id);
          }

          List<CategoryRecipe> categoriesRecipes =
              ref.watch(recipeCategoryProvider);
          List<Category> categories = ref.watch(categoriesProvider);

          for (Category category in categories) {
            if (categoriesRecipes
                .where((categoryRecipe) =>
                    categoryRecipe.categoryId == category.id)
                .isEmpty) {
              ref
                  .watch(categoriesProvider.notifier)
                  .deleteCategory(category.id);
            }
          }
        });
  }
}
