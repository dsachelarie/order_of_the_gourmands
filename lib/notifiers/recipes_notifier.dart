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
    final notes = snapshot.docs.map((doc) {
      return Recipe.fromFirestore(doc.data(), doc.id);
    }).toList();

    state = notes;
  }

  void addRecipe(
      String name, Map<String, String> ingredients, List<String> steps) async {
    final recipeData = Recipe('', name, ingredients, steps).toFirestore();
    final recipeRef = await _firestore.collection('recipes').add(recipeData);
    final recipe = Recipe.fromFirestore(recipeData, recipeRef.id);

    state = [...state, recipe];
  }

  void deleteRecipe(String id) async {
    await _firestore.collection('recipes').doc(id).delete();

    state = state.where((recipe) => recipe.id != id).toList();
  }
}
