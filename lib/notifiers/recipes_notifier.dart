import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/recipe.dart';

class RecipesNotifier extends StateNotifier<List<Recipe>> {
  RecipesNotifier() : super([]) {
    _fetchRecipes();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _fetchRecipes() async {
    final snapshot = await _firestore.collection('recipes').get();
    final recipes = snapshot.docs.map((doc) {
      return Recipe.fromFirestore(doc.data(), doc.id);
    }).toList();

    state = recipes;
  }

  Future<String> addRecipe(String name, Map<String, String> ingredients,
      List<String> steps, String creatorId) async {
    final recipeData =
        Recipe('', name, ingredients, steps, creatorId, []).toFirestore();
    final recipeRef = await _firestore.collection('recipes').add(recipeData);
    final recipe = Recipe.fromFirestore(recipeData, recipeRef.id);

    state = [...state, recipe];

    return recipe.id;
  }

  void deleteRecipe(String id) async {
    await _firestore.collection('recipes').doc(id).delete();

    state = state.where((recipe) => recipe.id != id).toList();
  }

  void updateRecipe(String id, Map<String, dynamic> fields) async {
    await _firestore.collection('recipes').doc(id).update(fields);

    int recipeIndex = state.indexWhere((recipe) => recipe.id == id);

    final doc = await _firestore.collection('recipes').doc(id).get();

    if (doc.exists) {
      final recipe = Recipe.fromFirestore(doc.data()!, id);

      state = [
        ...state.sublist(0, recipeIndex),
        recipe,
        ...state.sublist(recipeIndex + 1)
      ];
    }
  }
}
