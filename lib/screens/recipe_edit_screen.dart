import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/top_bar_widget.dart';

class RecipeEditScreen extends ConsumerWidget {
  final TextEditingController recipeNameController;

  RecipeEditScreen({super.key})
      : recipeNameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TextEditingController> ingredientsControllers = [];
    List<TextEditingController> stepsControllers = [];
    Map<String, dynamic> recipeInfo = ref.watch(recipeEditProvider);
    int i = 0;

    for (;
        i < recipeInfo["ingredients"].length && i < recipeInfo["steps"].length;
        i++) {
      ingredientsControllers.add(TextEditingController());
      stepsControllers.add(TextEditingController());
    }

    if (recipeInfo["ingredients"].length > recipeInfo["steps"].length) {
      for (; i < recipeInfo["ingredients"].length; i++) {
        ingredientsControllers.add(TextEditingController());
      }
    } else {
      for (; i < recipeInfo["steps"].length; i++) {
        ingredientsControllers.add(TextEditingController());
      }
    }

    List<Widget> ingredientsWidgets = [];
    List<Widget> stepsWidgets = [];

    for (i = 0; i < recipeInfo["ingredients"].length; i++) {
      ingredientsControllers[i].text = recipeInfo["ingredients"][i];
      ingredientsWidgets.add(TextField(controller: ingredientsControllers[i]));
    }

    for (i = 0; i < recipeInfo["steps"].length; i++) {
      stepsControllers[i].text = recipeInfo["steps"][i];
      ingredientsWidgets.add(TextField(controller: stepsControllers[i]));
    }

    return SafeArea(
        child: Scaffold(
            appBar: const TopBarWidget(),
            body: Column(children: [
              ListView(children: [
                const Text("Recipe name",
                    style: TextStyle(fontSize: 20.0, color: Colors.brown)),
                TextField(
                    controller: recipeNameController,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder())),
                const Text("Ingredients",
                    style: TextStyle(fontSize: 20.0, color: Colors.brown)),
                ...ingredientsWidgets,
                ElevatedButton.icon(
                    icon: const Icon(Icons.add_outlined),
                    label: const Text("Add ingredient"),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(left: 5.0),
                        shape: const CircleBorder(),
                        minimumSize: const Size(50.0, 50.0)),
                    onPressed: () {
                      print("1");
                    }),
                const Text("Steps",
                    style: TextStyle(fontSize: 20.0, color: Colors.brown)),
                ...stepsWidgets,
                ElevatedButton.icon(
                    icon: const Icon(Icons.add_outlined),
                    label: const Text("Add cooking step"),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(left: 5.0),
                        shape: const CircleBorder(),
                        minimumSize: const Size(50.0, 50.0)),
                    onPressed: () {
                      print("1");
                    })
              ]),
              ElevatedButton(
                  child: const Text("Submit"), onPressed: () => print("1"))
            ]),
            bottomNavigationBar: const BottomBarWidget()));
  }
}
