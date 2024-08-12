class Recipe {
  final String id;
  final String name;
  final Map<String, String> ingredients;
  final List<String> steps;

  Recipe(this.id, this.name, this.ingredients, this.steps);

  factory Recipe.fromFirestore(Map<String, dynamic> data, String id) {
    return Recipe(
        id,
        data['name'],
        Map<String, String>.from(data['ingredients'] as Map<String, dynamic>),
        List<String>.from(data['steps'] as List<dynamic>));
  }

  Map<String, dynamic> toFirestore() {
    return {'name': name, 'ingredients': ingredients, 'steps': steps};
  }
}
