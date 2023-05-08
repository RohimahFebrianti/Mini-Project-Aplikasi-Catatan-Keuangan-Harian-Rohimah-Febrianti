import 'package:apk_catatan_keuangan_harian/model/data_category.dart';
import 'package:flutter/material.dart';
import '../helper/database_helper.dart';

class CategoryManager extends ChangeNotifier {
  List<Categoryes> _categoryModels = [];
  late DatabaseHelper _dbHelper;

  List<Categoryes> get categoryModels => _categoryModels;

  CategoryManager() {
    _dbHelper = DatabaseHelper();
    _getAllCategory();
  }

  void _getAllCategory() async {
    _categoryModels = await _dbHelper.getCategory();
    notifyListeners();
  }

  Future<void> addCategory(Categoryes categoryModel) async {
    await _dbHelper.insertCategory(categoryModel);
    _getAllCategory();
  }

  Future<Categoryes> getCategoryById(int id) async {
    return await _dbHelper.getCategoryById(id);
  }

  void updateCategory(Categoryes categoryModel) async {
    await _dbHelper.updateCategory(categoryModel);
    _getAllCategory();
  }

  void deleteCategory(int id) async {
    await _dbHelper.deleteCategory(id);
    _getAllCategory();
  }
}
