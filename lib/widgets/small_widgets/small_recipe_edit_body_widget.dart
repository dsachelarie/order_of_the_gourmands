import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../recipe_edit_body_widget.dart';
import '../buttons/edit_recipe_submit_button.dart';
import '../buttons/edit_recipe_remove_button.dart';
import '../buttons/edit_recipe_add_button.dart';
import '../../services/recipe_service.dart';
import '../other_components/recipe_edit_text_field.dart';
import '../../providers.dart';

class SmallRecipeEditBodyWidget extends RecipeEditBodyWidget {
  SmallRecipeEditBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, dynamic> recipeInfo = ref.watch(recipeEditProvider);

    if (!RecipeService.checkRecipeInfoSoundness(recipeInfo)) {
      return const Center(
          child: Text("Something went wrong",
              style: TextStyle(fontSize: 20.0, color: Colors.brown)));
    }

    recipeNameController.text = recipeInfo["name"];

    clearWidgets();
    buildIngredientsWidgets(recipeInfo, 125.0);
    buildStepsWidgets(recipeInfo);
    buildCategoriesWidgets(recipeInfo, ref);

    return Column(children: [
      Expanded(
          child: ListView(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 2 - 200.0,
                  right: MediaQuery.of(context).size.width / 2 - 200.0,
                  top: 50.0),
              children: [
            const Text("Recipe name",
                style: TextStyle(fontSize: 20.0, color: Colors.brown)),
            RecipeEditTextField(recipeNameController),
            const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text("Ingredients",
                    style: TextStyle(fontSize: 20.0, color: Colors.brown))),
            ...ingredientsWidgets,
            Row(children: [
              Expanded(
                  child: EditRecipeRemoveButton(
                      "Remove ingredient",
                      "ingredients",
                      recipeNameController,
                      ingredientsControllers,
                      stepsControllers,
                      newCategoriesControllers,
                      recipeInfo)),
              Expanded(
                  child: EditRecipeAddButton(
                      "Add ingredient",
                      "ingredients",
                      recipeNameController,
                      ingredientsControllers,
                      stepsControllers,
                      newCategoriesControllers,
                      recipeInfo))
            ]),
            const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text("Cooking steps",
                    style: TextStyle(fontSize: 20.0, color: Colors.brown))),
            ...stepsWidgets,
            Row(children: [
              Expanded(
                  child: EditRecipeRemoveButton(
                      "Remove step",
                      "steps",
                      recipeNameController,
                      ingredientsControllers,
                      stepsControllers,
                      newCategoriesControllers,
                      recipeInfo)),
              Expanded(
                  child: EditRecipeAddButton(
                      "Add step",
                      "steps",
                      recipeNameController,
                      ingredientsControllers,
                      stepsControllers,
                      newCategoriesControllers,
                      recipeInfo))
            ]),
            const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text("Categories",
                    style: TextStyle(fontSize: 20.0, color: Colors.brown))),
            ...categoriesWidgets,
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(children: [
                Expanded(
                    child: EditRecipeRemoveButton(
                        "Remove category",
                        "new_categories",
                        recipeNameController,
                        ingredientsControllers,
                        stepsControllers,
                        newCategoriesControllers,
                        recipeInfo)),
                Expanded(
                    child: EditRecipeAddButton(
                        "Add category",
                        "new_categories",
                        recipeNameController,
                        ingredientsControllers,
                        stepsControllers,
                        newCategoriesControllers,
                        recipeInfo))
              ]),
            )
          ])),
      Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: EditRecipeSubmitButton(
              recipeNameController,
              ingredientsControllers,
              stepsControllers,
              newCategoriesControllers,
              recipeInfo)),
      ref.watch(formValidationProvider)
          ? const Text("")
          : const Text("Fields cannot be left empty")
    ]);
  }
}
