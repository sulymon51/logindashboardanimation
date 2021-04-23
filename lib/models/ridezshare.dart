// To parse this JSON data, do
//
//     final ridezshare = ridezshareFromJson(jsonString);

import 'dart:convert';

Ridezshare ridezshareFromJson(String str) => Ridezshare.fromMap(json.decode(str));

String ridezshareToJson(Ridezshare data) => json.encode(data.toMap());

class Ridezshare {
    String success;
    String message;
    int total;
    List<Datum> data;

    Ridezshare({
        this.success,
        this.message,
        this.total,
        this.data,
    });

    factory Ridezshare.fromMap(Map<String, dynamic> json) => Ridezshare(
        success: json["success"],
        message: json["message"],
        total: json["total"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "total": total,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class Datum {
    String id;
    String driverId;
    String driverName;
    String driverNumber;
    String carNumber;
    String carModel;
    String carColor;
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

    Datum({
        this.id,
        this.driverId,
        this.driverName,
        this.driverNumber,
        this.carNumber,
        this.carModel,
        this.carColor,
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

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        driverId: json["driver_id"],
        driverName: json["driver_name"],
        driverNumber: json["driver_number"],
        carNumber: json["car_number"],
        carModel: json["car_model"],
        carColor: json["car_color"],
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
        "car_number": carNumber,
        "car_model": carModel,
        "car_color": carColor,
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
