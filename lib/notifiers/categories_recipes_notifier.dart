import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category_recipe.dart';

class CategoriesRecipesNotifier extends StateNotifier<List<CategoryRecipe>> {
  CategoriesRecipesNotifier() : super([]) {
    _fetchCategoriesRecipes();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _fetchCategoriesRecipes() async {
    final snapshot = await _firestore.collection('categories_recipes').get();
    final categoriesRecipes = snapshot.docs.map((doc) {
      return CategoryRecipe.fromFirestore(doc.data(), doc.id);
    }).toList();

    state = categoriesRecipes;
  }

  void addCategoriesRecipes(String recipeId, String categoryId) async {
    final categoryRecipeData =
        CategoryRecipe('', recipeId, categoryId).toFirestore();
    final categoryRecipeRef = await _firestore
        .collection('categories_recipes')
        .add(categoryRecipeData);
    final categoryRecipe =
        CategoryRecipe.fromFirestore(categoryRecipeData, categoryRecipeRef.id);

    state = [...state, categoryRecipe];
  }

  void deleteCategoryRecipe(String id) async {
    await _firestore.collection('categories_recipes').doc(id).delete();

    state = state.where((categoryRecipe) => categoryRecipe.id != id).toList();
  }
}
