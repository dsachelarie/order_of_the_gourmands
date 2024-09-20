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

  static bool checkRecipeInfoSoundness(Map<String, dynamic> recipeInfo) {
    return recipeInfo.containsKey("ingredients") &&
        !recipeInfo["ingredients"].isEmpty &&
        recipeInfo.containsKey("steps") &&
        !recipeInfo["steps"].isEmpty &&
        recipeInfo.containsKey("categories") &&
        recipeInfo.containsKey("name") &&
        recipeInfo.containsKey("id") &&
        recipeInfo.containsKey("additional_categories");
  }
}
