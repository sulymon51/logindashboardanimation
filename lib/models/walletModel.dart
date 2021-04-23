// To parse this JSON data, do
//
//     final wallet = walletFromJson(jsonString);

import 'dart:convert';

List<Wallet> walletFromJson(String str) => List<Wallet>.from(json.decode(str).map((x) => Wallet.fromMap(x)));

String walletToJson(List<Wallet> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Wallet {
    The0 the0;
    String data;

    Wallet({
        this.the0,
        this.data,
    });

    factory Wallet.fromMap(Map<String, dynamic> json) => Wallet(
        the0: The0.fromMap(json["0"]),
        data: json["data"],
    );

    Map<String, dynamic> toMap() => {
        "0": the0.toMap(),
        "data": data,
    };
}

class The0 {
    String id;
    String type;
    String name;
    String fatherName;
    dynamic gender;
    dynamic dob;
    String email;
    String number;
    String password;
    dynamic city;
    dynamic carModel;
    dynamic carNumber;
    dynamic carColor;
    dynamic licenseNumber;
    dynamic nic;
    String walletBalance;
    dynamic address;
    dynamic profilePic;
    dynamic document1;
    dynamic document2;
    dynamic licensePic;
    dynamic nic1;
    dynamic nic2;
    String status;
    dynamic rating;
    dynamic tokenId;

    The0({
        this.id,
        this.type,
        this.name,
        this.fatherName,
        this.gender,
        this.dob,
        this.email,
        this.number,
        this.password,
        this.city,
        this.carModel,
        this.carNumber,
        this.carColor,
        this.licenseNumber,
        this.nic,
        this.walletBalance,
        this.address,
        this.profilePic,
        this.document1,
        this.document2,
        this.licensePic,
        this.nic1,
        this.nic2,
        this.status,
        this.rating,
        this.tokenId,
    });

    factory The0.fromMap(Map<String, dynamic> json) => The0(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        fatherName: json["father_name"],
        gender: json["gender"],
        dob: json["dob"],
        email: json["email"],
        number: json["number"],
        password: json["password"],
        city: json["city"],
        carModel: json["car_model"],
        carNumber: json["car_number"],
        carColor: json["car_color"],
        licenseNumber: json["license_number"],
        nic: json["nic"],
        walletBalance: json["wallet_balance"],
        address: json["address"],
        profilePic: json["profile_pic"],
        document1: json["document_1"],
        document2: json["document_2"],
        licensePic: json["license_pic"],
        nic1: json["nic_1"],
        nic2: json["nic_2"],
        status: json["status"],
        rating: json["rating"],
        tokenId: json["token_id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "name": name,
        "father_name": fatherName,
        "gender": gender,
        "dob": dob,
        "email": email,
        "number": number,
        "password": password,
        "city": city,
        "car_model": carModel,
        "car_number": carNumber,
        "car_color": carColor,
        "license_number": licenseNumber,
        "nic": nic,
        "wallet_balance": walletBalance,
        "address": address,
        "profile_pic": profilePic,
        "document_1": document1,
        "document_2": document2,
        "license_pic": licensePic,
        "nic_1": nic1,
        "nic_2": nic2,
        "status": status,
        "rating": rating,
        "token_id": tokenId,
    };
}
