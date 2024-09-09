import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/recipe_service.dart';
import '../../models/recipe.dart';
import '../../providers.dart';

class LargeRecipeBodyWidget extends ConsumerWidget {
  const LargeRecipeBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Recipe recipe = ref.watch(activeRecipeProvider);

    return Row(children: [
      Expanded(
          child: ListView(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 32,
                  right: MediaQuery.of(context).size.width / 32,
                  top: MediaQuery.of(context).size.height / 32),
              children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Center(
                    child: Text(recipe.name,
                        style: const TextStyle(
                            fontSize: 30.0, color: Colors.brown)))),
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
            const Placeholder(color: Colors.brown)
          ])),
      Expanded(
          child: ListView(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 32,
                  right: MediaQuery.of(context).size.width / 32,
                  top: MediaQuery.of(context).size.height / 32),
              children: [
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
                      padding: EdgeInsets.only(right: 10.0),
                      child: Text("${0}")),
                ]),
              ]),
            ]),
            const Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: Text("Ingredients:",
                        style:
                            TextStyle(fontSize: 20.0, color: Colors.brown)))),
            Column(
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
          ]))
    ]);
  }
}
