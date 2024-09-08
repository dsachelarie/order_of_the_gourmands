import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_of_the_gourmands/services/recipe_service.dart';
import '../../models/recipe.dart';
import '../../providers.dart';

class SmallRecipeBodyWidget extends ConsumerWidget {
  const SmallRecipeBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Recipe recipe = ref.watch(activeRecipeProvider);

    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Column(children: [
          Row(children: [
            ref.watch(userProvider).value == null
                ? const Text("Please log in to add to favorites")
                : const Text(""),
            Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: IconButton(
                    icon: const Icon(Icons.star_outline_outlined),
                    onPressed: ref.watch(userProvider).value == null
                        ? null
                        : () {
                            print("1");
                          })),
            const Padding(
                padding: EdgeInsets.only(right: 10.0), child: Text("${0}")),
          ]),
        ]),
      ]),
      Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(recipe.name,
              style: const TextStyle(fontSize: 30.0, color: Colors.brown))),
      if (ref.watch(userProvider).value != null &&
          ref.watch(userProvider).value!.uid == recipe.creatorId)
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(children: [
            Row(children: [
              ElevatedButton.icon(
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text("Edit recipe"),
                  onPressed: () {
                    print("1");
                  }),
              Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ElevatedButton.icon(
                      icon: const Icon(Icons.delete_outline_outlined),
                      label: const Text("Delete recipe"),
                      onPressed: () {
                        print("1");
                      }))
            ])
          ]),
        ]),
      Expanded(
          child: ListView(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 8,
                  right: MediaQuery.of(context).size.width / 8,
                  top: MediaQuery.of(context).size.height / 16),
              children: [
            const Placeholder(color: Colors.brown),
            const Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: Text("Ingredients:",
                        style:
                            TextStyle(fontSize: 20.0, color: Colors.brown)))),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: RecipeService.getIngredientsList(recipe.ingredients)),
            const Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: Text("Cooking steps:",
                        style:
                            TextStyle(fontSize: 20.0, color: Colors.brown)))),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: RecipeService.getStepsList(recipe.steps))
          ])),
    ]);
  }
}
