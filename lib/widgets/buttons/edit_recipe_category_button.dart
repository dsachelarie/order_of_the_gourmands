import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/category.dart';
import '../../models/ingredient_tuple.dart';
import '../../providers.dart';

class EditRecipeCategoryButton extends ConsumerWidget {
  final bool chosenCategory;
  final Category category;
  final TextEditingController recipeNameController;
  final List<IngredientTuple> ingredientsControllers;
  final List<TextEditingController> stepsControllers;
  final List<TextEditingController> newCategoriesControllers;
  final Map<String, dynamic> recipeInfo;

  const EditRecipeCategoryButton(
      this.chosenCategory,
      this.category,
      this.recipeNameController,
      this.ingredientsControllers,
      this.stepsControllers,
      this.newCategoriesControllers,
      this.recipeInfo,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () {
          if (chosenCategory) {
            recipeInfo["categories"].remove(category.id);
          } else {
            recipeInfo["categories"].add(category.id);
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
                "additional_categories": recipeInfo["additional_categories"]
              });
        },
        child: Row(children: [
          Text(category.name),
          const Spacer(),
          if (chosenCategory) const Icon(Icons.check)
        ]));
  }
}
