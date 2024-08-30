import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../models/recipe.dart';
import '../providers/providers.dart';

class RecipeListScreen extends ConsumerWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Recipe> recipes = ref.watch(recipesProvider);
    List<String> seqs = ref.watch(recipeFilterProvider);
    List<Widget> widgets = [];

    for (Recipe recipe in recipes) {
      for (String seq in seqs) {
        if (recipe.name.toLowerCase().contains(seq)) {
          widgets.add(ElevatedButton(
              onPressed: () {
                ref
                    .watch(activeRecipeProvider.notifier)
                    .update((state) => state = recipe);
                Navigator.pushNamed(context, '/recipe/');
              },
              child: Text(recipe.name)));

          break;
        }
      }
    }

    return Scaffold(
        appBar: const TopBarWidget(),
        body: ListView(children: widgets),
        bottomNavigationBar: const BottomBarWidget());
  }
}
