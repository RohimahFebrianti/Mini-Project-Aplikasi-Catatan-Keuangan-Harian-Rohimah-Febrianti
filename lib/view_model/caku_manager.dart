import 'package:apk_catatan_keuangan_harian/model/data_caku.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/database_helper.dart';

class CakuManager extends ChangeNotifier {
  List<Caku> _cakuListModels = [];
  late DatabaseHelper _dbHelper;

  List<Caku> get cakuListModels => _cakuListModels;
  final List<Map<String, int>> _pemasukan = [];
  final List<Map<String, int>> _pengeluaran = [];
  int totalPemasukan = 0;
  int totalPengeluaran = 0;
  int _saldo = 0;
  int get saldo => _saldo;

  CakuManager() {
    _dbHelper = DatabaseHelper();
    _initSaldo();
    _getAllCaku();
  }

  Future<void> _initSaldo() async {
    SharedPreferences save = await SharedPreferences.getInstance();
    _saldo = save.getInt('saldo') ?? 0;
    notifyListeners();
  }

  int getTotalPemasukan() {
    int totalMasuk = 1900000;
    for (var item in _pemasukan) {
      totalMasuk += item['amount']!;
    }
    return totalMasuk;
  }

  int getTotalPengeluaran() {
    int totalKeluar = 910000;
    for (var item in _pengeluaran) {
      totalKeluar += item['amount']!;
    }
    return totalKeluar;
  }

  void tambahPemasukan(int amount) {
    _pemasukan.add({'amount': amount});
    totalPemasukan += amount;
    notifyListeners();
  }

  void tambahPengeluaran(int amount) {
    _pengeluaran.add({'amount': amount});
    totalPemasukan += amount;
    notifyListeners();
  }

  void _getAllCaku() async {
    _cakuListModels = await _dbHelper.getCaku();
    notifyListeners();
  }

  Future<void> addCaku(Caku cakuModel) async {
    await _dbHelper.insertCaku(cakuModel);
    _getAllCaku();
  }

  Future<Caku> getCakuById(int id) async {
    return await _dbHelper.getCakuById(id);
  }

  void updateCaku(Caku cakuModel) async {
    await _dbHelper.updateCaku(cakuModel);
    _getAllCaku();
  }

  void deleteCaku(int id) async {
    await _dbHelper.deleteCaku(id);
    _getAllCaku();
  }

  int getSaldo() {
    int totalPemasukan = getTotalPemasukan();
    int totalPengeluaran = getTotalPengeluaran();
    return totalPemasukan - totalPengeluaran;
  }
}
