import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      widgets.add(ElevatedButton(
          onPressed: () {
            ref
                .watch(activeCategoryProvider.notifier)
                .update((state) => state = category);
            Navigator.pushNamed(context, '/recipe-list/');
          },
          child: Text(category.name)));
    }

    return Scaffold(
        appBar: const TopBarWidget(),
        body: ListView(children: widgets),
        bottomNavigationBar: const BottomBarWidget());
  }
}
