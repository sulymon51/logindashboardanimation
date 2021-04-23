// To parse this JSON data, do
//
//     final riderhisTory = riderhisToryFromJson(jsonString);

import 'dart:convert';

List<RiderhisTory> riderhisToryFromJson(String str) => List<RiderhisTory>.from(json.decode(str).map((x) => RiderhisTory.fromMap(x)));

String riderhisToryToJson(List<RiderhisTory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class RiderhisTory {
    String id;
    String userid;
    String details;
    String amount;
    String walletBalance;
    String bal;
    String status;
    DateTime date;

    RiderhisTory({
        this.id,
        this.userid,
        this.details,
        this.amount,
        this.walletBalance,
        this.bal,
        this.status,
        this.date,
    });

    factory RiderhisTory.fromMap(Map<String, dynamic> json) => RiderhisTory(
        id: json["id"],
        userid: json["userid"],
        details: json["details"],
        amount: json["amount"],
        walletBalance: json["wallet_balance"],
        bal: json["bal"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "userid": userid,
        "details": details,
        "amount": amount,
        "wallet_balance": walletBalance,
        "bal": bal,
        "status": status,
        "date": date.toIso8601String(),
    };
}
