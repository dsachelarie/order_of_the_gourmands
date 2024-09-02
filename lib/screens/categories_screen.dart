import 'package:flutter/material.dart';
import '../widgets/categories_body_widget.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/top_bar_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
            appBar: TopBarWidget(),
            body: CategoriesBodyWidget(),
            bottomNavigationBar: BottomBarWidget()));
  }
}
