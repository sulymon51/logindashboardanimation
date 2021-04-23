import 'dart:convert';

List<ProfilePic> profilePicFromJson(String str) => List<ProfilePic>.from(json.decode(str).map((x) => ProfilePic.fromMap(x)));

String profilePicToJson(List<ProfilePic> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ProfilePic {
    String id;
    String type;
    String name;
    String fatherName;
    dynamic gender;
    dynamic dob;
    String email;
    String number;
    String password;
    String referralId;
    dynamic refferdBy;
    String city;
    String carModel;
    String carNumber;
    String carColor;
    dynamic licenseNumber;
    dynamic nic;
    String walletBalance;
    dynamic address;
    String profilePic;
    String photoPath;
    dynamic document1;
    dynamic document2;
    dynamic licensePic;
    dynamic nic1;
    dynamic nic2;
    String status;
    String modifier;
    dynamic rating;
    String tokenId;

    ProfilePic({
        this.id,
        this.type,
        this.name,
        this.fatherName,
        this.gender,
        this.dob,
        this.email,
        this.number,
        this.password,
        this.referralId,
        this.refferdBy,
        this.city,
        this.carModel,
        this.carNumber,
        this.carColor,
        this.licenseNumber,
        this.nic,
        this.walletBalance,
        this.address,
        this.profilePic,
        this.photoPath,
        this.document1,
        this.document2,
        this.licensePic,
        this.nic1,
        this.nic2,
        this.status,
        this.modifier,
        this.rating,
        this.tokenId,
    });

    factory ProfilePic.fromMap(Map<String, dynamic> json) => ProfilePic(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        fatherName: json["father_name"],
        gender: json["gender"],
        dob: json["dob"],
        email: json["email"],
        number: json["number"],
        password: json["password"],
        referralId: json["referral_id"],
        refferdBy: json["refferd_by"],
        city: json["city"],
        carModel: json["car_model"],
        carNumber: json["car_number"],
        carColor: json["car_color"],
        licenseNumber: json["license_number"],
        nic: json["nic"],
        walletBalance: json["wallet_balance"],
        address: json["address"],
        profilePic: json["profile_pic"],
        photoPath: json["photo_path"],
        document1: json["document_1"],
        document2: json["document_2"],
        licensePic: json["license_pic"],
        nic1: json["nic_1"],
        nic2: json["nic_2"],
        status: json["status"],
        modifier: json["modifier"],
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
        "referral_id": referralId,
        "refferd_by": refferdBy,
        "city": city,
        "car_model": carModel,
        "car_number": carNumber,
        "car_color": carColor,
        "license_number": licenseNumber,
        "nic": nic,
        "wallet_balance": walletBalance,
        "address": address,
        "profile_pic": profilePic,
        "photo_path": photoPath,
        "document_1": document1,
        "document_2": document2,
        "license_pic": licensePic,
        "nic_1": nic1,
        "nic_2": nic2,
        "status": status,
        "modifier": modifier,
        "rating": rating,
        "token_id": tokenId,
    };
}
