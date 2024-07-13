class HistoricDTO {
  final DateTime? date;
  final String? type;
  final String? currencyName;
  final String? currencyAbbreviation;
  final double? value;
  final double? quantity;
  HistoricDTO({
    this.date,
    this.type,
    this.currencyName,
    this.currencyAbbreviation,
    this.value,
    this.quantity,
  });

  factory HistoricDTO.fromMap(Map<String, dynamic> map) {
    return HistoricDTO(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      type: map['type'],
      currencyName: map['currencyName'],
      currencyAbbreviation: map['currencyAbbreviation'],
      value: map['value'],
      quantity: double.parse(map['quantity']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (date != null) 'date': date?.millisecondsSinceEpoch,
      if (type != null) 'type': type,
      if (currencyName != null) 'currencyName': currencyName,
      if (currencyAbbreviation != null)
        'currencyAbbreviation': currencyAbbreviation,
      if (value != null) 'value': value,
      if (quantity != null) 'quantity': quantity.toString(),
    };
  }
}
