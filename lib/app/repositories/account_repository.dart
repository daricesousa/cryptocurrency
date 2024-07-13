import 'package:cryptocurrency/app/models/currency_model.dart';
import 'package:cryptocurrency/app/models/historic_model.dart';
import 'package:cryptocurrency/app/models/position_model.dart';
import 'package:cryptocurrency/app/repositories/currency_repository.dart';
import 'package:cryptocurrency/database/headers/db.dart';
import 'package:cryptocurrency/database/headers/dto/account_dto.dart';
import 'package:cryptocurrency/database/headers/dto/historic_dto.dart';
import 'package:cryptocurrency/database/headers/dto/wallet_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class AccountRepository extends ChangeNotifier {
  late Database db;
  final List<PositionModel> _wallet = [];
  double _balance = 0;
  bool loading = true;
  final List<HistoricModel> _historic = [];

  List<PositionModel> get wallet => _wallet;
  double get balance => _balance;
  List<HistoricModel> get historic => _historic;

  AccountRepository() {
    _initRepository();
  }

  Future<void> _initRepository() async {
    db = await DB.instance.database;
    await _getBalance();
    await _getWallet();
    await _getHistoric();
    loading = false;
    notifyListeners();
  }

  Future<void> _getBalance() async {
    List count = await db.query(DBTables.account.name, limit: 1);
    _balance = AccountDTO.fromMap(count.first).balance;
    notifyListeners();
  }

  Future<void> setBalance(double value) async {
    db.update(DBTables.account.name, AccountDTO(balance: value).toMap());
    _getBalance();
  }

  Future<void> buyCurrency({
    required CurrencyModel currency,
    required double value,
  }) async {
    final quantityBuy = value / currency.price;

    await db.transaction((txn) async {
      final wallet = await txn.query(
        DBTables.wallet.name,
        where: 'currencyAbbreviation = ?',
        whereArgs: [currency.abbreviation],
      );

      if (wallet.isEmpty) {
        txn.insert(
            DBTables.wallet.name,
            WalletDTO(
              currencyAbbreviation: currency.abbreviation,
              currencyName: currency.name,
              quantity: quantityBuy,
            ).toMap());
      } else {
        final quantityCurrency = WalletDTO.fromMap(wallet.first).quantity;
        final newQuantity = (quantityCurrency ?? 0) + quantityBuy;
        txn.update(
          DBTables.wallet.name,
          WalletDTO(quantity: newQuantity).toMap(),
          where: 'currencyAbbreviation = ?',
          whereArgs: [currency.abbreviation],
        );
      }

      await txn.insert(
          DBTables.historic.name,
          HistoricDTO(
            date: DateTime.now(),
            type: 'buy',
            currencyName: currency.name,
            currencyAbbreviation: currency.abbreviation,
            value: value,
            quantity: quantityBuy,
          ).toMap());

      await txn.update(
          DBTables.account.name, AccountDTO(balance: balance - value).toMap());
    });

    _initRepository();
  }

  Future<void> _getWallet() async {
    _wallet.clear();
    List wallets = await db.query(DBTables.wallet.name);
    for (var wallet in wallets) {
      final walletDTO = WalletDTO.fromMap(wallet);
      CurrencyModel currency = CurrencyRepository.table
          .firstWhere((e) => e.abbreviation == walletDTO.currencyAbbreviation);
      final position = PositionModel(
        currency: currency,
        quantity: walletDTO.quantity ?? 0,
      );
      _wallet.add(position);
    }
  }

  Future<void> _getHistoric() async {
    _historic.clear();
    List transactions = await db.query(DBTables.historic.name);
    for (var transaction in transactions) {
      final historicDTO = HistoricDTO.fromMap(transaction);
      CurrencyModel currency = CurrencyRepository.table.firstWhere(
          (e) => e.abbreviation == historicDTO.currencyAbbreviation);
      final historicItem = HistoricModel(
        date: historicDTO.date!,
        type: historicDTO.type!,
        currency: currency,
        value: historicDTO.value!,
        quantity: historicDTO.quantity!,
      );
      _historic.add(historicItem);
    }
  }
}
