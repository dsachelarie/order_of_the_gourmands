import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        });
  }
}
