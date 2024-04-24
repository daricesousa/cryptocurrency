class HistoryDTO {
  final DateTime date;
  final String type;
  final String currencyName;
  final String currencyAbbreviation;
  final double value;
  final double quantity;
  HistoryDTO({
    required this.date,
    required this.type,
    required this.currencyName,
    required this.currencyAbbreviation,
    required this.value,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'type': type,
      'currencyName': currencyName,
      'currencyAbbreviation': currencyAbbreviation,
      'value': value,
      'quantity': quantity.toString(),
    };
  }
}
