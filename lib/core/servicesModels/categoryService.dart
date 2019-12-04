import 'package:carwashapp/core/models/categoryModel.dart';
import 'package:carwashapp/core/services/categoryApi.dart';
import 'package:carwashapp/locator.dart';
import 'package:flutter/material.dart';

class CategoryService extends ChangeNotifier {
  CategoryApi _api = locator<CategoryApi>();

  List<Category> categories;

  Future<Category> getCategoryById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Category.fromMap(doc.data, doc.documentID);
  }

  Future<Category> updateCategory(Category data, String id) async {
    await _api.updateDocument(id, data.toJson());
    return data;
  }

  Future<void> addCategory(Category data) async {
    await _api.addDocument(data.toJson());
  }

  Future<List<Category>> fetchMainCategories() async {
    var result = await _api.getDataMainCategoriesCollection();
    categories = result.documents
        .map((doc) => Category.fromMap(doc.data, doc.documentID))
        .toList();
    return categories;
  }

  Future<List<Category>> fetchCategories() async {
    var result = await _api.getDataCollection();
    categories = result.documents
        .map((doc) => Category.fromMap(doc.data, doc.documentID))
        .toList();
    return categories;
  }
}
