class AccountDTO {
  final double balance;

  AccountDTO({
    required this.balance,
  });

  factory AccountDTO.fromMap(Map<String, dynamic> map) {
    return AccountDTO(
      balance: map['balance'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'balance': balance,
    };
  }
}
