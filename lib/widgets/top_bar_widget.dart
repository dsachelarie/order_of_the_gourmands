import 'dart:math';
import 'package:flutter/material.dart';

class TopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final TextEditingController controller;
  final double buttonWidth;

  TopBarWidget({super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        controller = TextEditingController(),
        buttonWidth = 150.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(actions: [
      SizedBox(
          width: min(500, MediaQuery.of(context).size.width - buttonWidth),
          child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                  hintText: 'Search recipes', border: OutlineInputBorder()))),
      SizedBox(
          width: buttonWidth,
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton.icon(
                  icon: const Icon(Icons.search_outlined),
                  label: const Text("Search"),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/recipe-list/'))))
    ]);
  }
}
