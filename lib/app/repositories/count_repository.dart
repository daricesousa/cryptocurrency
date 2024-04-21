import 'package:cryptocurrency/app/models/position_model.dart';
import 'package:cryptocurrency/database/headers/db.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class CountRepository extends ChangeNotifier {
  late Database db;
  final List<PositionModel> _wallet = [];
  double _balance = 0;

  List<PositionModel> get wallet => _wallet;
  double get balance => _balance;

  CountRepository() {
    _initRepository();
  }

  Future<void> _initRepository() async {
    db = await DB.instance.database;

    _getBalance();
  }

  Future<void> _getBalance() async {
    List count = await db.query('account', limit: 1);
    _balance = count.first['balance'];
    notifyListeners();
  }

  Future<void> setBalance(double value) async {
    db.update('count', {
      'balance': value,
    });
    _balance = value;
    notifyListeners();
  }
}
