class WalletDTO {
  String? currencyAbbreviation;
  String? currencyName;
  double? quantity;

  WalletDTO({
    this.currencyAbbreviation,
    this.currencyName,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      if (currencyAbbreviation != null)
        'currencyAbbreviation': currencyAbbreviation,
      if (currencyName != null) 'currencyName': currencyName,
      if (quantity != null) 'quantity': quantity.toString(),
    };
  }

  factory WalletDTO.fromMap(Map<String, dynamic> map) {
    return WalletDTO(
      currencyAbbreviation: map['currencyAbbreviation'],
      currencyName: map['currencyName'],
      quantity: double.parse(map['quantity']),
    );
  }
}
