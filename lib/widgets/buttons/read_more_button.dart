import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';

class ReadMoreButton extends ConsumerWidget {
  final String recipeId;

  const ReadMoreButton(this.recipeId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        ref.watch(activeRecipeIdProvider.notifier).update((state) => recipeId);
        Navigator.pushNamed(context, '/recipe/');
      },
      child: const Text("Read more"),
    );
  }
}
