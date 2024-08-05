import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(createApp());
}

Widget createApp() {
  return ProviderScope(
    child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        //'/recipe/': (_) => const RecipeScreen(),
        //'/categories/': (_) => const RecipeCategoryScreen(),
        //'/list/': (_) => const RecipeListScreen(),
      },
    ),
  );
}
