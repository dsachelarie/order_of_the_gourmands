import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class RecipeBodyWidget extends ConsumerWidget {
  const RecipeBodyWidget({super.key});

  List<Widget> buildIngredientsWidgets(Map<String, String> ingredients) {
    List<Widget> ingredientsWidgets = [];
    List<String> keys = ingredients.keys.toList();

    keys.sort();

    for (String ingredient in keys) {
      if (ingredients[ingredient]!.isEmpty) {
        ingredientsWidgets.add(Center(child: Text(ingredient)));
      } else {
        ingredientsWidgets.add(
            Center(child: Text("$ingredient: ${ingredients[ingredient]}")));
      }
    }

    return ingredientsWidgets;
  }

  List<Widget> buildStepsWidgets(List<String> steps) {
    List<Widget> stepsWidgets = [];

    for (String step in steps) {
      stepsWidgets.add(Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text("\u2022 $step")));
    }

    return stepsWidgets;
  }
}
