import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../breakpoints.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../providers/providers.dart';
import '../models/category.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Category> categories = ref.watch(categoriesProvider);
    List<Widget> widgets = [];

    for (Category category in categories) {
      widgets.add(Card(
          child: ListTile(
              leading: const SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Placeholder(color: Colors.brown))),
              title: ElevatedButton(
                  onPressed: () {
                    ref
                        .watch(recipeFilterProvider.notifier)
                        .update((state) => state = {"category": category});

                    Navigator.pushNamed(context, '/recipe-list/');
                  },
                  child: Text(category.name)))));
    }

    Widget body;

    if (MediaQuery.of(context).size.width <= Breakpoints.md) {
      body = ListView(children: widgets);
    } else if (MediaQuery.of(context).size.width <= Breakpoints.lg) {
      body = GridView.count(
          crossAxisCount: 2, childAspectRatio: 8, children: widgets);
    } else {
      body = GridView.count(
          crossAxisCount: 4, childAspectRatio: 4, children: widgets);
    }

    return Scaffold(
        appBar: const TopBarWidget(),
        body: body,
        bottomNavigationBar: const BottomBarWidget());
  }
}
