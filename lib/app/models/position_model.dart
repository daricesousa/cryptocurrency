// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cryptocurrency/app/models/currency_model.dart';

class PositionModel {
  CurrencyModel currency;
  double quantity;

  PositionModel({
    required this.currency,
    required this.quantity,
  });
}
