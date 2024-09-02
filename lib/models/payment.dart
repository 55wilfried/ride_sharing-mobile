class Payment {
  final double amount;
  final String method;

  Payment({required this.amount, required this.method});

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'method': method,
  };

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    amount: json['amount'],
    method: json['method'],
  );
}
