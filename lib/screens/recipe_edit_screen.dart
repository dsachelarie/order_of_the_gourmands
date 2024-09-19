import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ingredient_tuple.dart';
import '../services/recipe_service.dart';
import '../models/category.dart';
import '../widgets/other_components/recipe_edit_text_field.dart';
import '../providers.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/top_bar_widget.dart';

class RecipeEditScreen extends ConsumerWidget {
  const RecipeEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, dynamic> recipeInfo = ref.watch(recipeEditProvider);
    List<Category> categories = ref.watch(categoriesProvider);

    if (!recipeInfo.containsKey("ingredients") ||
        recipeInfo["ingredients"].isEmpty ||
        !recipeInfo.containsKey("steps") ||
        recipeInfo["steps"].isEmpty ||
        !recipeInfo.containsKey("categories") ||
        !recipeInfo.containsKey("name") ||
        !recipeInfo.containsKey("id") ||
        !recipeInfo.containsKey("additional_categories")) {
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
    List<IngredientTuple> ingredientsControllers = [];
    List<TextEditingController> stepsControllers = [];
    List<TextEditingController> newCategoriesControllers = [];
    TextEditingController recipeNameController =
        TextEditingController(text: recipeInfo["name"]);

    for (int i = 0; i < recipeInfo["ingredients"].length; i++) {
      ingredientsControllers.add(
          IngredientTuple(TextEditingController(), TextEditingController()));
      ingredientsControllers[i].name.text = recipeInfo["ingredients"][i].name;
      ingredientsControllers[i].value.text = recipeInfo["ingredients"][i].value;
      ingredientsWidgets.add(Row(children: [
        RecipeEditTextField(ingredientsControllers[i].name),
        const Spacer(),
        const Text("\u2190 name : quantity \u2192"),
        const Spacer(),
        RecipeEditTextField(ingredientsControllers[i].value)
      ]));
    }

    for (int i = 0; i < recipeInfo["steps"].length; i++) {
      stepsControllers.add(TextEditingController());
      stepsControllers[i].text = recipeInfo["steps"][i];
      stepsWidgets.add(RecipeEditTextField(stepsControllers[i]));
    }

    List<Widget> categoriesWidgets = [];

    for (Category category in categories) {
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
                              .map((controllerTuple) => IngredientTuple(
                                  controllerTuple.name.text,
                                  controllerTuple.value.text))
                              .toList(),
                          "steps": stepsControllers
                              .map((controller) => controller.text)
                              .toList(),
                          "id": recipeInfo["id"],
                          "categories": recipeInfo["categories"],
                          "additional_categories":
                              recipeInfo["additional_categories"]
                        });
              },
              child: Row(children: [
                Text(category.name),
                const Spacer(),
                if (chosenCategory) const Icon(Icons.check)
              ]))));
    }

    for (int i = 0; i < recipeInfo["additional_categories"].length; i++) {
      newCategoriesControllers.add(
          TextEditingController(text: recipeInfo["additional_categories"][i]));
      categoriesWidgets.add(RecipeEditTextField(newCategoriesControllers.last));
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
                          ingredientsControllers.add(IngredientTuple(
                              TextEditingController(),
                              TextEditingController()));

                          ref
                              .watch(recipeEditProvider.notifier)
                              .update((state) => state = {
                                    "name": recipeNameController.text,
                                    "ingredients": ingredientsControllers
                                        .map((controllerTuple) =>
                                            IngredientTuple(
                                                controllerTuple.name.text,
                                                controllerTuple.value.text))
                                        .toList(),
                                    "steps": stepsControllers
                                        .map((controller) => controller.text)
                                        .toList(),
                                    "id": recipeInfo["id"],
                                    "categories": recipeInfo["categories"],
                                    "additional_categories":
                                        newCategoriesControllers
                                            .map(
                                                (controller) => controller.text)
                                            .toList()
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
                                        .map((controllerTuple) =>
                                            IngredientTuple(
                                                controllerTuple.name.text,
                                                controllerTuple.value.text))
                                        .toList(),
                                    "steps": stepsControllers
                                        .map((controller) => controller.text)
                                        .toList(),
                                    "id": recipeInfo["id"],
                                    "categories": recipeInfo["categories"],
                                    "additional_categories":
                                        newCategoriesControllers
                                            .map(
                                                (controller) => controller.text)
                                            .toList()
                                  });
                        }),
                    const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text("Categories",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.brown))),
                    ...categoriesWidgets,
                    Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: ElevatedButton.icon(
                            icon: const Icon(Icons.add_outlined),
                            label: const Text("New category"),
                            onPressed: () {
                              newCategoriesControllers
                                  .add(TextEditingController());

                              ref
                                  .watch(recipeEditProvider.notifier)
                                  .update((state) => state = {
                                        "name": recipeNameController.text,
                                        "ingredients": ingredientsControllers
                                            .map((controllerTuple) =>
                                                IngredientTuple(
                                                    controllerTuple.name.text,
                                                    controllerTuple.value.text))
                                            .toList(),
                                        "steps": stepsControllers
                                            .map(
                                                (controller) => controller.text)
                                            .toList(),
                                        "id": recipeInfo["id"],
                                        "categories": recipeInfo["categories"],
                                        "additional_categories":
                                            newCategoriesControllers
                                                .map((controller) =>
                                                    controller.text)
                                                .toList()
                                      });
                            }))
                  ])),
              Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                      child: const Text("Submit"),
                      onPressed: () {
                        bool formIsValid = RecipeService.formIsValid(
                            recipeNameController.text,
                            ingredientsControllers
                                .map((controllerTuple) => IngredientTuple(
                                    controllerTuple.name.text,
                                    controllerTuple.value.text))
                                .toList(),
                            stepsControllers
                                .map((controller) => controller.text)
                                .toList(),
                            newCategoriesControllers
                                .map((controller) => controller.text)
                                .toList());

                        if (formIsValid && recipeInfo["id"] != "") {
                          ref
                              .watch(recipesProvider.notifier)
                              .updateRecipe(recipeInfo["id"], {
                            "name": recipeNameController.text,
                            "ingredients": {
                              for (var controllerTuple
                                  in ingredientsControllers)
                                controllerTuple.name.text:
                                    controllerTuple.value.text
                            },
                            "steps": stepsControllers
                                .map((controller) => controller.text)
                                .toList()
                          });

                          ref
                              .watch(formValidationProvider.notifier)
                              .update((state) => state = true);

                          Navigator.pop(context);
                        } else if (formIsValid) {
                          ref.watch(recipesProvider.notifier).addRecipe(
                              recipeNameController.text,
                              {
                                for (var controllerTuple
                                    in ingredientsControllers)
                                  controllerTuple.name.text:
                                      controllerTuple.value.text
                              },
                              stepsControllers
                                  .map((controller) => controller.text)
                                  .toList(),
                              ref.watch(userProvider).value!.uid);

                          ref
                              .watch(formValidationProvider.notifier)
                              .update((state) => state = true);

                          Navigator.pop(context);
                        } else {
                          ref
                              .watch(formValidationProvider.notifier)
                              .update((state) => state = false);

                          ref
                              .watch(recipeEditProvider.notifier)
                              .update((state) => state = {
                                    "name": recipeNameController.text,
                                    "ingredients": ingredientsControllers
                                        .map((controllerTuple) =>
                                            IngredientTuple(
                                                controllerTuple.name.text,
                                                controllerTuple.value.text))
                                        .toList(),
                                    "steps": stepsControllers
                                        .map((controller) => controller.text)
                                        .toList(),
                                    "id": recipeInfo["id"],
                                    "categories": recipeInfo["categories"],
                                    "additional_categories":
                                        newCategoriesControllers
                                            .map(
                                                (controller) => controller.text)
                                            .toList()
                                  });
                        }
                      })),
              ref.watch(formValidationProvider)
                  ? const Text("")
                  : const Text("Fields cannot be left empty")
            ]),
            bottomNavigationBar: const BottomBarWidget()));
  }
}
