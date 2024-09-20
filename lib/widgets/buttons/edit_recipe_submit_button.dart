import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/recipe_service.dart';
import '../../models/ingredient_tuple.dart';
import '../../providers.dart';

class EditRecipeSubmitButton extends ConsumerWidget {
  final TextEditingController recipeNameController;
  final List<IngredientTuple> ingredientsControllers;
  final List<TextEditingController> stepsControllers;
  final List<TextEditingController> newCategoriesControllers;
  final Map<String, dynamic> recipeInfo;

  const EditRecipeSubmitButton(
      this.recipeNameController,
      this.ingredientsControllers,
      this.stepsControllers,
      this.newCategoriesControllers,
      this.recipeInfo,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        child: const Text("Submit"),
        onPressed: () {
          bool formIsValid = RecipeService.formIsValid(
              recipeNameController.text,
              ingredientsControllers
                  .map((controllerTuple) => IngredientTuple(
                      controllerTuple.name.text, controllerTuple.value.text))
                  .toList(),
              stepsControllers.map((controller) => controller.text).toList(),
              newCategoriesControllers
                  .map((controller) => controller.text)
                  .toList());

          if (formIsValid && recipeInfo["id"] != "") {
            ref.watch(recipesProvider.notifier).updateRecipe(recipeInfo["id"], {
              "name": recipeNameController.text,
              "ingredients": {
                for (var controllerTuple in ingredientsControllers)
                  controllerTuple.name.text: controllerTuple.value.text
              },
              "steps":
                  stepsControllers.map((controller) => controller.text).toList()
            });

            for (TextEditingController controller in newCategoriesControllers) {
              ref
                  .watch(categoriesProvider.notifier)
                  .addCategory(controller.text);

              ref.watch(recipeCategoryProvider.notifier).addCategoryRecipe(
                  recipeInfo["id"],
                  ref
                      .watch(categoriesProvider)
                      .where((category) => category.name == controller.text)
                      .toList()
                      .first
                      .id);
            }

            for (String categoryName in recipeInfo["categories"]) {
              ref.watch(recipeCategoryProvider.notifier).addCategoryRecipe(
                  recipeInfo["id"],
                  ref
                      .watch(categoriesProvider)
                      .where((category) => category.name == categoryName)
                      .toList()
                      .first
                      .id);
            }

            ref
                .watch(formValidationProvider.notifier)
                .update((state) => state = true);

            Navigator.pop(context);
          } else if (formIsValid) {
            ref.watch(recipesProvider.notifier).addRecipe(
                recipeNameController.text,
                {
                  for (var controllerTuple in ingredientsControllers)
                    controllerTuple.name.text: controllerTuple.value.text
                },
                stepsControllers.map((controller) => controller.text).toList(),
                ref.watch(userProvider).value!.uid);

            for (TextEditingController controller in newCategoriesControllers) {
              ref
                  .watch(categoriesProvider.notifier)
                  .addCategory(controller.text);

              ref.watch(recipeCategoryProvider.notifier).addCategoryRecipe(
                  ref
                      .watch(recipesProvider)
                      .where(
                          (recipe) => recipe.name == recipeNameController.text)
                      .toList()
                      .first
                      .id,
                  ref
                      .watch(categoriesProvider)
                      .where((category) => category.name == controller.text)
                      .toList()
                      .first
                      .id);
            }

            for (String categoryName in recipeInfo["categories"]) {
              ref.watch(recipeCategoryProvider.notifier).addCategoryRecipe(
                  ref
                      .watch(recipesProvider)
                      .where(
                          (recipe) => recipe.name == recipeNameController.text)
                      .toList()
                      .first
                      .id,
                  ref
                      .watch(categoriesProvider)
                      .where((category) => category.name == categoryName)
                      .toList()
                      .first
                      .id);
            }

            ref
                .watch(formValidationProvider.notifier)
                .update((state) => state = true);

            Navigator.pop(context);
          } else {
            ref
                .watch(formValidationProvider.notifier)
                .update((state) => state = false);

            ref.watch(recipeEditProvider.notifier).update((state) => state = {
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
          }
        });
  }
}
