import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/large_widgets/large_recipe_body_widget.dart';
import '../widgets/medium_widgets/medium_recipe_body_widget.dart';
import '../widgets/small_widgets/small_recipe_body_widget.dart';
import '../breakpoints.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/top_bar_widget.dart';

class RecipeScreen extends ConsumerWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget body;

    if (MediaQuery.of(context).size.width <= Breakpoints.md) {
      body = const SmallRecipeBodyWidget();
    } else if (MediaQuery.of(context).size.width <= Breakpoints.lg) {
      body = const MediumRecipeBodyWidget();
    } else {
      body = const LargeRecipeBodyWidget();
    }

    return SafeArea(
        child: Scaffold(
            appBar: const TopBarWidget(),
            body: body,
            bottomNavigationBar: const BottomBarWidget()));
  }
}
