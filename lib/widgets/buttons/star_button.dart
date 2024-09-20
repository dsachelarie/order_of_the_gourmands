import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/recipe.dart';
import '../../providers.dart';

class StarButton extends ConsumerWidget {
  final bool starPressed;
  final Recipe recipe;

  const StarButton(this.starPressed, this.recipe, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        icon: Stack(children: [
          if (starPressed) const Icon(Icons.star, color: Colors.yellow),
          const Icon(Icons.star_border),
        ]),
        onPressed: ref.watch(userProvider).value == null
            ? null
            : () {
                List favoriteOf = recipe.favoriteOf;

                if (starPressed) {
                  favoriteOf.remove(ref.watch(userProvider).value!.uid);
                } else {
                  favoriteOf.add(ref.watch(userProvider).value!.uid);
                }

                ref
                    .watch(recipesProvider.notifier)
                    .updateRecipe(recipe.id, {"favorite_of": favoriteOf});
              });
  }
}
