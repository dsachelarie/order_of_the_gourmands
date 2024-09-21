import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category.dart';

class CategoriesNotifier extends StateNotifier<List<Category>> {
  CategoriesNotifier() : super([]) {
    _fetchCategories();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _fetchCategories() async {
    final snapshot = await _firestore.collection('categories').get();
    final categories = snapshot.docs.map((doc) {
      return Category.fromFirestore(doc.data(), doc.id);
    }).toList();

    state = categories;
  }

  Future<String> addCategory(String name) async {
    final categoryData = Category('', name).toFirestore();
    final categoryRef =
        await _firestore.collection('categories').add(categoryData);
    final category = Category.fromFirestore(categoryData, categoryRef.id);

    state = [...state, category];

    return category.id;
  }

  void deleteCategory(String id) async {
    await _firestore.collection('categories').doc(id).delete();

    state = state.where((category) => category.id != id).toList();
  }
}
