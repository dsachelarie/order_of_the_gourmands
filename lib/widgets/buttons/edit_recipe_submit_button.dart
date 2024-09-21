import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/categories_service.dart';
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
        onPressed: () async {
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

            CategoriesService.updateCategoriesRecipes(recipeInfo, ref);

            for (TextEditingController controller in newCategoriesControllers) {
              String categoryId = await ref
                  .watch(categoriesProvider.notifier)
                  .addCategory(controller.text);

              ref
                  .watch(recipeCategoryProvider.notifier)
                  .addCategoryRecipe(recipeInfo["id"], categoryId);
            }

            ref
                .watch(formValidationProvider.notifier)
                .update((state) => state = true);

            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          } else if (formIsValid) {
            recipeInfo["id"] = await ref
                .watch(recipesProvider.notifier)
                .addRecipe(
                    recipeNameController.text,
                    {
                      for (var controllerTuple in ingredientsControllers)
                        controllerTuple.name.text: controllerTuple.value.text
                    },
                    stepsControllers
                        .map((controller) => controller.text)
                        .toList(),
                    ref.watch(userProvider).value!.uid);

            CategoriesService.addCategoriesRecipes(recipeInfo, ref);

            for (TextEditingController controller in newCategoriesControllers) {
              String categoryId = await ref
                  .watch(categoriesProvider.notifier)
                  .addCategory(controller.text);

              ref
                  .watch(recipeCategoryProvider.notifier)
                  .addCategoryRecipe(recipeInfo["id"], categoryId);
            }

            ref
                .watch(formValidationProvider.notifier)
                .update((state) => state = true);

            // ignore: use_build_context_synchronously
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
