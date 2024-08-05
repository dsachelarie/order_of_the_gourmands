class CategoryRecipe {
  final String id;
  final String recipeId;
  final String categoryId;

  CategoryRecipe(this.id, this.recipeId, this.categoryId);

  factory CategoryRecipe.fromFirestore(Map<String, dynamic> data, String id) {
    return CategoryRecipe(id, data['recipe_id'], data['category_id']);
  }

  Map<String, dynamic> toFirestore() {
    return {'recipe_id': recipeId, 'category_id': categoryId};
  }
}
