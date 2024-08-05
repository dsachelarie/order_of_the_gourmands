import 'package:flutter/material.dart';
import '../breakpoints.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/small_home_body_widget.dart';
import '../widgets/medium_home_body_widget.dart';
import '../widgets/large_home_body_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget bodyWidget;

    if (MediaQuery.of(context).size.width <= Breakpoints.sm) {
      bodyWidget = SmallHomeBodyWidget();
    } else if (MediaQuery.of(context).size.width <= Breakpoints.md) {
      bodyWidget = MediumHomeBodyWidget();
    } else {
      bodyWidget = LargeHomeBodyWidget();
    }

    return SafeArea(
        child: Scaffold(
            appBar: const TopBarWidget(),
            body: bodyWidget,
            bottomNavigationBar: const BottomBarWidget()));
  }
}
