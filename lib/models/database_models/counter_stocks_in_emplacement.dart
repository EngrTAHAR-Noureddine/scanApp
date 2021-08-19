import 'dart:convert';

StocksCounter stocksCounterFromJson(String str) {
  final jsonData = json.decode(str);
  return StocksCounter.fromMap(jsonData);
}

String stocksCounterToJson(StocksCounter data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class StocksCounter {
  int? number;
  int? emplacementID;

  StocksCounter({
    this.number,
    this.emplacementID,
  });

  factory StocksCounter.fromMap(Map<String, dynamic> json) => new StocksCounter(
    number: json["COUNT(id)"],
    emplacementID: json["emplacementId"],

  );

  Map<String, dynamic> toMap() => {
    "COUNT(id)": number,
    "emplacementId": emplacementID,

  };
}

