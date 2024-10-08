import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';

class MediumTopBarWidget extends ConsumerWidget {
  final TextEditingController controller;

  MediumTopBarWidget({super.key}) : controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> actions = [];

    if (ref.watch(searchActivationProvider)) {
      actions.add(SizedBox(
          width: 300.0,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                hintText: 'Search recipes',
                border: const OutlineInputBorder(),
                suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.search_outlined),
                        label: const SizedBox.shrink(),
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(left: 5.0),
                            shape: const CircleBorder(),
                            minimumSize: const Size(50.0, 50.0)),
                        onPressed: () {
                          ref.watch(recipeFilterProvider.notifier).update(
                              (state) => state = {
                                    "name": controller.text
                                        .toLowerCase()
                                        .split(RegExp(r'[^a-z]'))
                                  });

                          ref
                              .watch(searchActivationProvider.notifier)
                              .update((state) => state = false);

                          controller.clear();

                          Navigator.pushNamed(context, '/recipe-list/');
                        }))),
            onSubmitted: (String query) {
              ref.watch(recipeFilterProvider.notifier).update((state) => state =
                  {"name": query.toLowerCase().split(RegExp(r'[^a-z]'))});

              ref
                  .watch(searchActivationProvider.notifier)
                  .update((state) => state = false);

              controller.clear();

              Navigator.pushNamed(context, '/recipe-list/');
            },
          )));
    } else {
      actions.add(ElevatedButton.icon(
          icon: const Icon(Icons.search_outlined),
          label: const Text("Search recipes"),
          onPressed: () {
            ref
                .watch(searchActivationProvider.notifier)
                .update((state) => state = true);
          }));
    }

    actions.add(ref.watch(userProvider).value == null
        ? Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: ElevatedButton.icon(
                icon: const Icon(Icons.login_outlined),
                label: const Text("Login"),
                onPressed: () async {
                  await FirebaseAuth.instance.signInAnonymously();
                }))
        : Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: ElevatedButton.icon(
                icon: const Icon(Icons.logout_outlined),
                label: const Text("Logout"),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                })));

    return AppBar(
        title: Text("Order of the Gourmands",
            style: TextStyle(
                fontSize: ref.watch(searchActivationProvider) ? 20.0 : 30.0,
                color: Colors.brown)),
        actions: actions,
        bottom: ModalRoute.of(context)!.settings.name != "/"
            ? null
            : const PreferredSize(
                preferredSize: Size.fromHeight(20.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                            "An app for discovering and creating recipes.",
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.brown))))));
  }
}
