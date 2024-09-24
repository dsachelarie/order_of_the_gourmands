import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          while (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          ref.watch(recipesProvider.notifier).deleteRecipe(recipeId);

          List<CategoryRecipe> categoriesRecipes =
              ref.watch(recipeCategoryProvider);
          List<dynamic> toDelete = categoriesRecipes
              .where((recipeCategory) => recipeCategory.recipeId == recipeId)
              .toList();

          for (CategoryRecipe categoryRecipe in toDelete) {
            if (categoriesRecipes
                    .where((recipeCategory) =>
                        recipeCategory.categoryId == categoryRecipe.categoryId)
                    .length ==
                1) {
              ref
                  .watch(categoriesProvider.notifier)
                  .deleteCategory(categoryRecipe.categoryId);
            }

            ref
                .watch(recipeCategoryProvider.notifier)
                .deleteCategoryRecipe(categoryRecipe.id);
          }
        });
  }
}
