import 'dart:convert';

class WaterIntake {
  final int amount;
  final DateTime time;

  WaterIntake({required this.amount, required this.time});

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'time': time.toIso8601String(),
    };
  }

  String toJson() => toMap().toString();

  static WaterIntake fromJson(String json) {
    final data = jsonDecode(json);
    return WaterIntake(
      amount: data['amount'],
      time: DateTime.parse(data['time']),
    );
  }
}
