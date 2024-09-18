import 'package:flutter/material.dart';
import './screens/recipe_edit_screen.dart';
import './screens/recipe_screen.dart';
import './screens/recipe_list_screen.dart';
import './screens/categories_screen.dart';
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
        '/recipe/': (_) => const RecipeScreen(),
        '/categories/': (_) => const CategoriesScreen(),
        '/recipe-list/': (_) => const RecipeListScreen(),
        '/recipe-edit/': (_) => RecipeEditScreen()
      },
    ),
  );
}
