class RecipeService {
  static String getTruncatedRecipeSteps(
      List<String> steps, int truncationThreshold) {
    String concatenatedSteps = steps.reduce((a, b) => "$a\n\n$b");

    if (concatenatedSteps.length < truncationThreshold) {
      return concatenatedSteps;
    }

    return "${concatenatedSteps.substring(0, truncationThreshold)}...";
  }
}
