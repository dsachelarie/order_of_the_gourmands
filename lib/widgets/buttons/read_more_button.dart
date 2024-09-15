import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';

class ReadMoreButton extends ConsumerWidget {
  final int recipeIndex;

  const ReadMoreButton(this.recipeIndex, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        ref
            .watch(activeRecipeIndexProvider.notifier)
            .update((state) => recipeIndex);
        Navigator.pushNamed(context, '/recipe/');
      },
      child: const Text("Read more"),
    );
  }
}
