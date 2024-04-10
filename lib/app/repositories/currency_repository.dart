import 'package:cryptocurrency/app/models/currency_model.dart';

class CurrencyRepository {
  static List<CurrencyModel> table = [
    CurrencyModel(
        icon: 'assets/images/currency.png',
        name: 'Cardano',
        abbreviation: 'ADA',
        price: 6.32),
    CurrencyModel(
        icon: 'assets/images/currency.png',
        name: 'USD Coin',
        abbreviation: 'USDC',
        price: 5.02),
    CurrencyModel(
        icon: 'assets/images/currency.png',
        name: 'Cardano',
        abbreviation: 'ADA',
        price: 6.32),
    CurrencyModel(
        icon: 'images/usdcoin.png',
        name: 'USD Coin',
        abbreviation: 'USDC',
        price: 5.02),
    CurrencyModel(
        icon: 'images/cardano.png',
        name: 'Cardano',
        abbreviation: 'ADA',
        price: 6.32),
    CurrencyModel(
        icon: 'images/usdcoin.png',
        name: 'USD Coin',
        abbreviation: 'USDC',
        price: 5.02),
  ];
}
