import 'package:flutter/material.dart';
import '../breakpoints.dart';
import './large_widgets/large_top_bar_widget.dart';
import './medium_widgets/medium_top_bar_widget.dart';
import './small_widgets/small_top_bar_widget.dart';

class TopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const TopBarWidget({super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width <= Breakpoints.md) {
      return SmallTopBarWidget();
    } else if (MediaQuery.of(context).size.width <= Breakpoints.lg) {
      return MediumTopBarWidget();
    } else {
      return LargeTopBarWidget();
    }
  }
}
