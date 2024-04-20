import 'package:cryptocurrency/app/models/currency_model.dart';

class CurrencyRepository {
  static List<CurrencyModel> table = [
    CurrencyModel(
        id: '1',
        icon: 'assets/images/currency.png',
        name: 'Cardano',
        abbreviation: 'ADA',
        price: 6.32),
    CurrencyModel(
        id: '2',
        icon: 'assets/images/currency.png',
        name: 'USD Coin',
        abbreviation: 'USDC',
        price: 5.02),
    CurrencyModel(
        id: '3',
        icon: 'assets/images/currency.png',
        name: 'Cardano',
        abbreviation: 'ADE',
        price: 6.32),
    CurrencyModel(
        id: '4',
        icon: 'images/usdcoin.png',
        name: 'USD Coin',
        abbreviation: 'USDC',
        price: 5.02),
    CurrencyModel(
        id: '5',
        icon: 'images/cardano.png',
        name: 'Cardano',
        abbreviation: 'ADA',
        price: 6.32),
    CurrencyModel(
        id: '6',
        icon: 'images/usdcoin.png',
        name: 'USD Coin',
        abbreviation: 'USDC',
        price: 5.02),
  ];
}
