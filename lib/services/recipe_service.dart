import 'package:flutter/material.dart';
import 'package:order_of_the_gourmands/models/ingredient_tuple.dart';

class RecipeService {
  static String getTruncatedRecipeSteps(
      List<String> steps, int truncationThreshold) {
    String concatenatedSteps = steps.reduce((a, b) => "$a\n\n$b");

    if (concatenatedSteps.length < truncationThreshold) {
      return concatenatedSteps;
    }

    return "${concatenatedSteps.substring(0, truncationThreshold)}...";
  }

  static List<Widget> getIngredientsList(Map<String, String> ingredients) {
    List<Widget> widgets = [];

    for (String ingredient in ingredients.keys) {
      if (ingredients[ingredient]!.isEmpty) {
        widgets.add(Center(child: Text(ingredient)));
      } else {
        widgets.add(
            Center(child: Text("$ingredient: ${ingredients[ingredient]}")));
      }
    }

    return widgets;
  }

  static List<Widget> getStepsList(List<String> steps) {
    List<Widget> widgets = [];

    for (String step in steps) {
      widgets.add(Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text("\u2022 $step")));
    }

    return widgets;
  }

  static bool formIsValid(String name, List<IngredientTuple> ingredients,
      List<String> steps, List<String> additionalCategories) {
    return name != "" &&
        ingredients
            .where(
                (ingredient) => ingredient.name == "" || ingredient.value == "")
            .isEmpty &&
        steps.where((step) => step == "").isEmpty &&
        additionalCategories.where((category) => category == "").isEmpty;
  }
}
