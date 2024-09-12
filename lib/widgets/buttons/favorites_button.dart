import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';

class FavoritesButton extends ConsumerWidget {
  const FavoritesButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
        icon: const Icon(Icons.star_outline_outlined),
        label: const Text("Favorites"),
        onPressed: ref.watch(userProvider).value == null
            ? null
            : () {
                ref.watch(recipeFilterProvider.notifier).update((state) =>
                    state = {
                      "favorite_of": ref.watch(userProvider).value!.uid
                    });

                Navigator.pushNamed(context, '/recipe-list/');
              });
  }
}
