import 'dart:convert';

List<AlridezModel> alridezModelFromJson(String str) => List<AlridezModel>.from(json.decode(str).map((x) => AlridezModel.fromMap(x)));

String alridezModelToJson(List<AlridezModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class AlridezModel {
    String id;
    String driverId;
    String driverName;
    String driverNumber;
    String driverImage;
    String carNumber;
    String carPic;
    String carModel;
    String carColor;
    String city;
    String startLat;
    String startLan;
    String startName;
    String destLat;
    String destLan;
    String destName;
    String liveLat;
    String liveLan;
    String seatNo;
    String seatCost;
    String bookedSeats;
    String time;
    String date;
    String music;
    String ac;
    String smoking;
    String status;
    String rating;

    AlridezModel({
        this.id,
        this.driverId,
        this.driverName,
        this.driverNumber,
        this.driverImage,
        this.carNumber,
        this.carPic,
        this.carModel,
        this.carColor,
        this.city,
        this.startLat,
        this.startLan,
        this.startName,
        this.destLat,
        this.destLan,
        this.destName,
        this.liveLat,
        this.liveLan,
        this.seatNo,
        this.seatCost,
        this.bookedSeats,
        this.time,
        this.date,
        this.music,
        this.ac,
        this.smoking,
        this.status,
        this.rating,
    });

    factory AlridezModel.fromMap(Map<String, dynamic> json) => AlridezModel(
        id: json["id"],
        driverId: json["driver_id"],
        driverName: json["driver_name"],
        driverNumber: json["driver_number"],
        driverImage: json["driver_image"],
        carNumber: json["car_number"],
        carPic: json["car_pic"],
        carModel: json["car_model"],
        carColor: json["car_color"],
        city: json["city"],
        startLat: json["start_lat"],
        startLan: json["start_lan"],
        startName: json["start_name"],
        destLat: json["dest_lat"],
        destLan: json["dest_lan"],
        destName: json["dest_name"],
        liveLat: json["live_lat"],
        liveLan: json["live_lan"],
        seatNo: json["seat_no"],
        seatCost: json["seat_cost"],
        bookedSeats: json["booked_seats"],
        time: json["time"],
        date: json["date"],
        music: json["music"],
        ac: json["ac"],
        smoking: json["smoking"],
        status: json["status"],
        rating: json["rating"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "driver_id": driverId,
        "driver_name": driverName,
        "driver_number": driverNumber,
        "driver_image": driverImage,
        "car_number": carNumber,
        "car_pic": carPic,
        "car_model": carModel,
        "car_color": carColor,
        "city": city,
        "start_lat": startLat,
        "start_lan": startLan,
        "start_name": startName,
        "dest_lat": destLat,
        "dest_lan": destLan,
        "dest_name": destName,
        "live_lat": liveLat,
        "live_lan": liveLan,
        "seat_no": seatNo,
        "seat_cost": seatCost,
        "booked_seats": bookedSeats,
        "time": time,
        "date": date,
        "music": music,
        "ac": ac,
        "smoking": smoking,
        "status": status,
        "rating": rating,
    };
}
