import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category.dart';
import '../widgets/other_components/recipe_edit_text_field.dart';
import '../providers.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/top_bar_widget.dart';

class RecipeEditScreen extends ConsumerWidget {
  final TextEditingController recipeNameController;

  RecipeEditScreen({super.key})
      : recipeNameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, dynamic> recipeInfo = ref.watch(recipeEditProvider);

    if (!recipeInfo.containsKey("ingredients") ||
        recipeInfo["ingredients"].isEmpty ||
        !recipeInfo.containsKey("steps") ||
        recipeInfo["steps"].isEmpty ||
        !recipeInfo.containsKey("categories") ||
        recipeInfo["categories"].isEmpty ||
        !recipeInfo.containsKey("name") ||
        !recipeInfo.containsKey("id")) {
      return const SafeArea(
          child: Scaffold(
              appBar: TopBarWidget(),
              body: Center(
                  child: Text("Something went wrong",
                      style: TextStyle(fontSize: 20.0, color: Colors.brown))),
              bottomNavigationBar: BottomBarWidget()));
    }

    List<Widget> ingredientsWidgets = [];
    List<Widget> stepsWidgets = [];
    List<TextEditingController> ingredientsControllers = [];
    List<TextEditingController> stepsControllers = [];

    for (int i = 0; i < recipeInfo["ingredients"].length; i++) {
      ingredientsControllers.add(TextEditingController());
      ingredientsControllers[i].text = recipeInfo["ingredients"][i];
      ingredientsWidgets.add(RecipeEditTextField(ingredientsControllers[i]));
    }

    for (int i = 0; i < recipeInfo["steps"].length; i++) {
      stepsControllers.add(TextEditingController());
      stepsControllers[i].text = recipeInfo["steps"][i];
      stepsWidgets.add(RecipeEditTextField(stepsControllers[i]));
    }

    List<Widget> categoriesWidgets = [];

    for (Category category in ref.watch(categoriesProvider)) {
      bool chosenCategory = recipeInfo["categories"].contains(category.id);

      categoriesWidgets.add(Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: ElevatedButton(
              onPressed: () {
                if (chosenCategory) {
                  recipeInfo["categories"].remove(category.id);
                } else {
                  recipeInfo["categories"].add(category.id);
                }

                ref
                    .watch(recipeEditProvider.notifier)
                    .update((state) => state = {
                          "name": recipeNameController.text,
                          "ingredients": ingredientsControllers
                              .map((controller) => controller.text)
                              .toList(),
                          "steps": stepsControllers
                              .map((controller) => controller.text)
                              .toList(),
                          "id": recipeInfo["id"],
                          "categories": recipeInfo["categories"]
                        });
              },
              child: Row(children: [
                Text(category.name),
                const Spacer(),
                if (chosenCategory) const Icon(Icons.check)
              ]))));
    }

    return SafeArea(
        child: Scaffold(
            appBar: const TopBarWidget(),
            body: Column(children: [
              Expanded(
                  child: ListView(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 2 - 200.0,
                          right: MediaQuery.of(context).size.width / 2 - 200.0,
                          top: 50.0),
                      children: [
                    const Text("Recipe name",
                        style: TextStyle(fontSize: 20.0, color: Colors.brown)),
                    RecipeEditTextField(recipeNameController),
                    const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text("Ingredients",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.brown))),
                    ...ingredientsWidgets,
                    ElevatedButton.icon(
                        icon: const Icon(Icons.add_outlined),
                        label: const Text("Add ingredient"),
                        onPressed: () {
                          ingredientsControllers.add(TextEditingController());

                          ref
                              .watch(recipeEditProvider.notifier)
                              .update((state) => state = {
                                    "name": recipeNameController.text,
                                    "ingredients": ingredientsControllers
                                        .map((controller) => controller.text)
                                        .toList(),
                                    "steps": stepsControllers
                                        .map((controller) => controller.text)
                                        .toList(),
                                    "id": recipeInfo["id"],
                                    "categories": recipeInfo["categories"]
                                  });
                        }),
                    const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text("Steps",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.brown))),
                    ...stepsWidgets,
                    ElevatedButton.icon(
                        icon: const Icon(Icons.add_outlined),
                        label: const Text("Add cooking step"),
                        onPressed: () {
                          stepsControllers.add(TextEditingController());

                          ref
                              .watch(recipeEditProvider.notifier)
                              .update((state) => state = {
                                    "name": recipeNameController.text,
                                    "ingredients": ingredientsControllers
                                        .map((controller) => controller.text)
                                        .toList(),
                                    "steps": stepsControllers
                                        .map((controller) => controller.text)
                                        .toList(),
                                    "id": recipeInfo["id"],
                                    "categories": recipeInfo["categories"]
                                  });
                        }),
                    const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text("Categories",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.brown))),
                    ...categoriesWidgets
                  ])),
              Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: ElevatedButton(
                      child: const Text("Submit"),
                      onPressed: () {
                        if (recipeInfo["id"] != "") {
                          print("1");
                        } else {
                          print("2");
                        }
                      }))
            ]),
            bottomNavigationBar: const BottomBarWidget()));
  }
}
