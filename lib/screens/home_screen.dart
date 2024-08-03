import 'package:flutter/material.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/bottom_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const TopBarWidget()),
            body: const Text("1"),
            bottomNavigationBar: const BottomBarWidget()));
  }
}
