import 'package:flutter/material.dart';
import '../breakpoints.dart';
import './large_widgets/large_home_body_widget.dart';
import './medium_widgets/medium_home_body_widget.dart';
import './small_widgets/small_home_body_widget.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width <= Breakpoints.md) {
      return const SmallHomeBodyWidget();
    } else if (MediaQuery.of(context).size.width <= Breakpoints.lg) {
      return const MediumHomeBodyWidget();
    } else {
      return const LargeHomeBodyWidget();
    }
  }
}
