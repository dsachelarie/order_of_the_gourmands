import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/ingredient_tuple.dart';
import '../../providers.dart';

class EditRecipeAddButton extends ConsumerWidget {
  final String text;
  final String addTo;
  final TextEditingController recipeNameController;
  final List<IngredientTuple> ingredientsControllers;
  final List<TextEditingController> stepsControllers;
  final List<TextEditingController> newCategoriesControllers;
  final Map<String, dynamic> recipeInfo;

  const EditRecipeAddButton(
      this.text,
      this.addTo,
      this.recipeNameController,
      this.ingredientsControllers,
      this.stepsControllers,
      this.newCategoriesControllers,
      this.recipeInfo,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
        ),
        icon: const Icon(Icons.add_outlined),
        label: Text(text),
        onPressed: () {
          switch (addTo) {
            case "ingredients":
              ingredientsControllers.add(IngredientTuple(
                  TextEditingController(), TextEditingController()));
              break;
            case "steps":
              stepsControllers.add(TextEditingController());
              break;
            case "new_categories":
              newCategoriesControllers.add(TextEditingController());
              break;
          }

          ref.watch(recipeEditProvider.notifier).update((state) => state = {
                "name": recipeNameController.text,
                "ingredients": ingredientsControllers
                    .map((controllerTuple) => IngredientTuple(
                        controllerTuple.name.text, controllerTuple.value.text))
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
