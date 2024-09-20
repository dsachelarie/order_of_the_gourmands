import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/ingredient_tuple.dart';
import '../../providers.dart';

class EditRecipeRemoveButton extends ConsumerWidget {
  final String text;
  final String removeFrom;
  final TextEditingController recipeNameController;
  final List<IngredientTuple> ingredientsControllers;
  final List<TextEditingController> stepsControllers;
  final List<TextEditingController> newCategoriesControllers;
  final Map<String, dynamic> recipeInfo;

  const EditRecipeRemoveButton(
      this.text,
      this.removeFrom,
      this.recipeNameController,
      this.ingredientsControllers,
      this.stepsControllers,
      this.newCategoriesControllers,
      this.recipeInfo,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<dynamic> controllers = [];
    int lengthThreshold = 1;

    switch (removeFrom) {
      case "ingredients":
        controllers = ingredientsControllers;
        break;
      case "steps":
        controllers = stepsControllers;
        break;
      case "new_categories":
        controllers = newCategoriesControllers;
        lengthThreshold = 0;
        break;
    }

    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
            ),
          ),
        ),
        icon: const Icon(Icons.remove_outlined),
        label: Text(text),
        onPressed: controllers.length <= lengthThreshold
            ? null
            : () {
                controllers.removeLast();

                ref
                    .watch(recipeEditProvider.notifier)
                    .update((state) => state = {
                          "name": recipeNameController.text,
                          "ingredients": ingredientsControllers
                              .map((controllerTuple) => IngredientTuple(
                                  controllerTuple.name.text,
                                  controllerTuple.value.text))
                              .toList(),
                          "steps": stepsControllers
                              .map((controller) => controller.text)
                              .toList(),
                          "id": recipeInfo["id"],
                          "categories": recipeInfo["categories"],
                          "additional_categories": newCategoriesControllers
                              .map((controller) => controller.text)
                              .toList()
                        });
              });
  }
}
