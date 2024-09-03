import 'package:flutter/material.dart';
import '../breakpoints.dart';
import '../widgets/large_widgets/large_home_body_widget.dart';
import '../widgets/medium_widgets/medium_home_body_widget.dart';
import '../widgets/small_widgets/small_home_body_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/bottom_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (MediaQuery.of(context).size.width <= Breakpoints.md) {
      body = const SmallHomeBodyWidget();
    } else if (MediaQuery.of(context).size.width <= Breakpoints.lg) {
      body = const MediumHomeBodyWidget();
    } else {
      body = const LargeHomeBodyWidget();
    }

    return SafeArea(
        child: Scaffold(
            appBar: const TopBarWidget(),
            body: body,
            bottomNavigationBar: const BottomBarWidget()));
  }
}
