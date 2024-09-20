import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import '../models/category.dart';
import './buttons/edit_recipe_category_button.dart';
import './other_components/recipe_edit_text_field.dart';
import '../models/ingredient_tuple.dart';

abstract class RecipeEditBodyWidget extends ConsumerWidget {
  final List<Widget> ingredientsWidgets;
  final List<Widget> stepsWidgets;
  final List<Widget> categoriesWidgets;
  final List<IngredientTuple> ingredientsControllers;
  final List<TextEditingController> stepsControllers;
  final List<TextEditingController> newCategoriesControllers;
  final TextEditingController recipeNameController;

  RecipeEditBodyWidget({super.key})
      : recipeNameController = TextEditingController(),
        ingredientsWidgets = [],
        stepsWidgets = [],
        categoriesWidgets = [],
        ingredientsControllers = [],
        stepsControllers = [],
        newCategoriesControllers = [];

  void clearWidgets() {
    ingredientsWidgets.clear();
    stepsWidgets.clear();
    categoriesWidgets.clear();
    ingredientsControllers.clear();
    stepsControllers.clear();
    newCategoriesControllers.clear();
  }

  void buildIngredientsWidgets(Map<String, dynamic> recipeInfo) {
    for (int i = 0; i < recipeInfo["ingredients"].length; i++) {
      ingredientsControllers.add(
          IngredientTuple(TextEditingController(), TextEditingController()));
      ingredientsControllers[i].name.text = recipeInfo["ingredients"][i].name;
      ingredientsControllers[i].value.text = recipeInfo["ingredients"][i].value;
      ingredientsWidgets.add(Row(children: [
        RecipeEditTextField(ingredientsControllers[i].name),
        const Spacer(),
        const Text("\u2190 name : quantity \u2192"),
        const Spacer(),
        RecipeEditTextField(ingredientsControllers[i].value)
      ]));
    }
  }

  void buildStepsWidgets(Map<String, dynamic> recipeInfo) {
    for (int i = 0; i < recipeInfo["steps"].length; i++) {
      stepsControllers.add(TextEditingController());
      stepsControllers[i].text = recipeInfo["steps"][i];
      stepsWidgets.add(RecipeEditTextField(stepsControllers[i]));
    }
  }

  void buildCategoriesWidgets(Map<String, dynamic> recipeInfo, WidgetRef ref) {
    for (Category category in ref.watch(categoriesProvider)) {
      bool chosenCategory = recipeInfo["categories"].contains(category.id);

      categoriesWidgets.add(Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: EditRecipeCategoryButton(
              chosenCategory,
              category,
              recipeNameController,
              ingredientsControllers,
              stepsControllers,
              newCategoriesControllers,
              recipeInfo)));
    }

    for (int i = 0; i < recipeInfo["additional_categories"].length; i++) {
      newCategoriesControllers.add(
          TextEditingController(text: recipeInfo["additional_categories"][i]));
      categoriesWidgets.add(RecipeEditTextField(newCategoriesControllers.last));
    }
  }
}
