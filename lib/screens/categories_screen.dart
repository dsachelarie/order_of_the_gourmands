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
      widgets.add(TextButton(
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
          ])))));
    }

    Widget body;

    if (MediaQuery.of(context).size.width <= Breakpoints.md) {
      body = GridView.count(
          crossAxisCount: 1,
          childAspectRatio: MediaQuery.of(context).size.width / 150.0,
          children: widgets);
    } else if (MediaQuery.of(context).size.width <= Breakpoints.lg) {
      body = GridView.count(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width / 2 / 150.0,
          children: widgets);
    } else {
      body = GridView.count(
          crossAxisCount: 4,
          childAspectRatio: MediaQuery.of(context).size.width / 4 / 150.0,
          children: widgets);
    }

    return Scaffold(
        appBar: const TopBarWidget(),
        body: body,
        bottomNavigationBar: const BottomBarWidget());
  }
}
