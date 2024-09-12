import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';

class MyRecipesButton extends ConsumerWidget {
  const MyRecipesButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
        icon: const Icon(Icons.folder_outlined),
        label: const Text("My recipes"),
        onPressed: ref.watch(userProvider).value == null
            ? null
            : () {
                ref.watch(recipeFilterProvider.notifier).update((state) =>
                    state = {"creator_id": ref.watch(userProvider).value!.uid});

                Navigator.pushNamed(context, '/recipe-list/');
              });
  }
}
