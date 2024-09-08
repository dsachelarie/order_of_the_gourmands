class Recipe {
  final String id;
  final String name;
  final Map<String, String> ingredients;
  final List<String> steps;
  final String creatorId;
  final List<String> favoriteOf;

  Recipe(this.id, this.name, this.ingredients, this.steps, this.creatorId,
      this.favoriteOf);

  factory Recipe.fromFirestore(Map<String, dynamic> data, String id) {
    return Recipe(
        id,
        data['name'],
        Map<String, String>.from(data['ingredients'] as Map<String, dynamic>),
        List<String>.from(data['steps'] as List<dynamic>),
        data['creator_id'],
        data.containsKey('favorite_of')
            ? List<String>.from(data['favorite_of'] as List<dynamic>)
            : []);
  }

  factory Recipe.empty() {
    return Recipe("", "", {}, [], "", []);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'ingredients': ingredients,
      'steps': steps,
      'creator_id': creatorId,
      if (favoriteOf.isNotEmpty) 'favorite_of': favoriteOf
    };
  }
}
