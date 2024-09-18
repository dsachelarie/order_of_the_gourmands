import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/category.dart';
import '../../providers.dart';

class CategoryButton extends ConsumerWidget {
  final Category category;

  const CategoryButton(this.category, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
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
        ]))));
  }
}
