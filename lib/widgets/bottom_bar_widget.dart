import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/recipe.dart';
import '../providers/providers.dart';

class BottomBarWidget extends ConsumerWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Recipe> recipes = ref.watch(recipesProvider);

    return Column(mainAxisSize: MainAxisSize.min, children: [
      const Divider(
        height: 1,
        color: Colors.brown,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
            padding:
                const EdgeInsets.only(right: 10.0, bottom: 10.0, top: 10.0),
            child: ElevatedButton.icon(
                icon: const Icon(Icons.home_outlined),
                label: const Text("Home"),
                onPressed: () => Navigator.pushNamed(context, '/'))),
        Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
            child: ElevatedButton.icon(
                icon: const Icon(Icons.text_snippet_outlined),
                label: const Text("Random recipe"),
                onPressed: recipes.isEmpty
                    ? null
                    : () {
                        ref.watch(activeRecipeProvider.notifier).update(
                            (state) =>
                                recipes[Random().nextInt(recipes.length)]);
                        Navigator.pushNamed(context, '/recipe/');
                      })),
        Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 10.0, top: 10.0),
            child: ElevatedButton.icon(
                icon: const Icon(Icons.category_outlined),
                label: const Text("Recipe categories"),
                onPressed: () => Navigator.pushNamed(context, '/categories/')))
      ])
    ]);
  }
}
