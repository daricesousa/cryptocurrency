import 'dart:collection';

import 'package:cryptocurrency/app/models/currency_model.dart';
import 'package:flutter/material.dart';

class FavoritesRepository extends ChangeNotifier {
  final List<CurrencyModel> _list = [];
  UnmodifiableListView<CurrencyModel> get list => UnmodifiableListView(_list);

  void saveAll(List<CurrencyModel> currencyList) {
    for (var currency in currencyList) {
      if (!list.contains(currency)) {
        _list.add(currency);
      }
    }
    notifyListeners();
  }

  void remove(CurrencyModel currency) {
    _list.remove(currency);
    notifyListeners();
  }
}
