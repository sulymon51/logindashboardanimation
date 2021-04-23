// To parse this JSON data, do
//
//     final walletHIstory = walletHIstoryFromJson(jsonString);

import 'dart:convert';

List<WalletHIstory> walletHIstoryFromJson(String str) => List<WalletHIstory>.from(json.decode(str).map((x) => WalletHIstory.fromMap(x)));

String walletHIstoryToJson(List<WalletHIstory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class WalletHIstory {
    String userid;
    String details;
    String amount;
    String walletBalance;
    String status;
    DateTime date;

    WalletHIstory({
        this.userid,
        this.details,
        this.amount,
        this.walletBalance,
        this.status,
        this.date,
    });

    factory WalletHIstory.fromMap(Map<String, dynamic> json) => WalletHIstory(
        userid: json["userid"],
        details: json["details"],
        amount: json["amount"],
        walletBalance: json["wallet_balance"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toMap() => {
        "userid": userid,
        "details": details,
        "amount": amount,
        "wallet_balance": walletBalance,
        "status": status,
        "date": date.toIso8601String(),
    };
}
