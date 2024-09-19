import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/ingredient_tuple.dart';
import '../../models/recipe.dart';
import '../../providers.dart';

class EditRecipeButton extends ConsumerWidget {
  final Recipe recipe;

  const EditRecipeButton(this.recipe, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
        icon: const Icon(Icons.edit_outlined),
        label: const Text("Edit recipe"),
        onPressed: () {
          ref.watch(recipeEditProvider.notifier).update((state) => state = {
                "id": recipe.id,
                "name": recipe.name,
                "ingredients": recipe.ingredients.entries
                    .map((ingredient) =>
                        IngredientTuple(ingredient.key, ingredient.value))
                    .toList(),
                "steps": recipe.steps,
                "categories": [],
                "additional_categories": []
              });

          ref
              .watch(formValidationProvider.notifier)
              .update((state) => state = true);

          Navigator.pushNamed(context, '/recipe-edit/');
        });
  }
}
