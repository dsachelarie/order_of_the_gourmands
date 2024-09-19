import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/ingredient_tuple.dart';
import '../../providers.dart';

class AddRecipeButton extends ConsumerWidget {
  const AddRecipeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
        icon: const Icon(Icons.add_outlined),
        label: const Text("Add recipe"),
        onPressed: ref.watch(userProvider).value == null
            ? null
            : () {
                ref
                    .watch(recipeEditProvider.notifier)
                    .update((state) => state = {
                          "id": "",
                          "name": "",
                          "ingredients": [IngredientTuple("", "")],
                          "steps": [""],
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
