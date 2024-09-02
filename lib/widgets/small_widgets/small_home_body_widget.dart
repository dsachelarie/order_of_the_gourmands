import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/recipe.dart';
import '../../services/home_service.dart';
import '../../models/category.dart';
import '../../providers/providers.dart';

class SmallHomeBodyWidget extends ConsumerWidget {
  const SmallHomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Category> selectedCategories =
        HomeService.getMostPopularCategories(ref);
    List<Recipe> recipes = ref.watch(recipesProvider);
    List<Widget> categoriesWidgets = [];
    Recipe randomRecipe = recipes[Random().nextInt(recipes.length)];

    for (Category category in selectedCategories) {
      categoriesWidgets.add(SizedBox(
          height: 150.0,
          child: TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0))),
              onPressed: () {
                ref
                    .watch(recipeFilterProvider.notifier)
                    .update((state) => state = {"category_id": category.id});

                Navigator.pushNamed(context, '/recipe-list/');
              },
              child: SizedBox.expand(
                  child: Card(
                      child: Column(children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: Text(category.name)),
                const SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Placeholder(color: Colors.brown)))
              ]))))));
    }

    return Column(children: [
      const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text("Order of the Gourmands",
              style: TextStyle(fontSize: 30.0, color: Colors.brown))),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(children: [
          Row(children: [
            ElevatedButton.icon(
                icon: const Icon(Icons.add_outlined),
                label: const Text("Add recipe"),
                onPressed: ref.watch(userProvider).value == null
                    ? null
                    : () async {
                        print("1");
                      }),
            ElevatedButton.icon(
                icon: const Icon(Icons.star_outline_outlined),
                label: const Text("Favorites"),
                onPressed: ref.watch(userProvider).value == null
                    ? null
                    : () async {
                        print("1");
                      })
          ]),
          ref.watch(userProvider).value == null
              ? const Text("Please log in")
              : const Text("")
        ]),
      ]),
      Expanded(
          child: ListView(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 8,
                  right: MediaQuery.of(context).size.width / 8,
                  top: MediaQuery.of(context).size.height / 16),
              children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Card(
                    child: ListTile(
                        title: Text(randomRecipe.name),
                        subtitle: Text(HomeService.getTruncatedRecipeSteps(
                            randomRecipe.steps)),
                        trailing: TextButton(
                            child: const Text("Read more"),
                            onPressed: () => print("1"))))),
            const Center(
                child: Text("Categories with most recipes:",
                    style: TextStyle(fontSize: 20.0, color: Colors.brown))),
            Column(children: categoriesWidgets),
            Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: ElevatedButton.icon(
                    icon: const Icon(Icons.add_outlined),
                    label: const Text("More recipe categories"),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/categories/')))
          ]))
    ]);
  }
}
