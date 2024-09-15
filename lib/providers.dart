import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/recipe.dart';
import 'models/category.dart';
import 'models/category_recipe.dart';
import 'notifiers/categories_notifier.dart';
import 'notifiers/categories_recipes_notifier.dart';
import 'notifiers/recipes_notifier.dart';

final recipesProvider = StateNotifierProvider<RecipesNotifier, List<Recipe>>(
    (_) => RecipesNotifier());

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<Category>>(
        (_) => CategoriesNotifier());

final recipeCategoryProvider =
    StateNotifierProvider<CategoriesRecipesNotifier, List<CategoryRecipe>>(
        (_) => CategoriesRecipesNotifier());

final activeRecipeIndexProvider = StateProvider<int>((_) => 0);

final recipeFilterProvider = StateProvider<Map<String, dynamic>>((_) => {});

final searchActivationProvider = StateProvider<bool>((_) => false);

final userProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final recipeEditProvider = StateProvider<Map<String, dynamic>>((_) => {});
