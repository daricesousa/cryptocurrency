import 'package:cryptocurrency/app/models/currency_model.dart';

class HistoricModel {
  final DateTime date;
  final String type;
  final CurrencyModel currency;
  final double value;
  final double quantity;
  HistoricModel({
    required this.date,
    required this.type,
    required this.currency,
    required this.value,
    required this.quantity,
  });
}
