import 'package:flutter/material.dart';
import 'package:order_of_the_gourmands/widgets/home_body_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/bottom_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
            appBar: TopBarWidget(),
            body: HomeBodyWidget(),
            bottomNavigationBar: BottomBarWidget()));
  }
}
