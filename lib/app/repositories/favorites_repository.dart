import 'dart:collection';

import 'package:cryptocurrency/adapters/currency_hive_adapter.dart';
import 'package:cryptocurrency/app/models/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesRepository extends ChangeNotifier {
  final List<CurrencyModel> _list = [];
  UnmodifiableListView<CurrencyModel> get list => UnmodifiableListView(_list);
  late LazyBox<CurrencyModel> box;

  FavoritesRepository() {
    startRepository();
  }

  Future<void> startRepository() async {
    await _openBox();
    await _readFavorites();
  }

  Future<void> _openBox() async {
    Hive.registerAdapter(CurrencyHiveAdapter());
    box = await Hive.openLazyBox<CurrencyModel>("favorite_currencies");
  }

  Future<void> _readFavorites() async {
    final futureCurrencyList = box.keys.map((currencyHive) {
      return box.get(currencyHive);
    }).toList();

    await Future.wait(futureCurrencyList).then((value) {
      for (var e in value) {
        if (e != null) _list.add(e);
      }
    });
    notifyListeners();
  }

  void saveAll(List<CurrencyModel> currencyList) {
    for (var currency in currencyList) {
      if (!isCurrencyFavorite(currency)) {
        _list.add(currency);
        box.put(currency.abbreviation, currency);
      }
    }
    notifyListeners();
  }

  void remove(CurrencyModel currency) {
    _list.remove(currency);
    box.delete(currency.abbreviation);
    notifyListeners();
  }

  bool isCurrencyFavorite(CurrencyModel currency) {
    return _list.any((e) => e.id == currency.id);
  }
}
