// To parse this JSON data, do
//
//     final riderhisTory = riderhisToryFromJson(jsonString);

import 'dart:convert';

List<RiderhisTory> riderhisToryFromJson(String str) => List<RiderhisTory>.from(json.decode(str).map((x) => RiderhisTory.fromMap(x)));

String riderhisToryToJson(List<RiderhisTory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class RiderhisTory {
    String id;
    String rideId;
    String driverName;
    String driverPic;
    String time;
    String date;
    String startName;
    String destName;
    String seats;
    String cost;

    RiderhisTory({
        this.id,
        this.rideId,
        this.driverName,
        this.driverPic,
        this.time,
        this.date,
        this.startName,
        this.destName,
        this.seats,
        this.cost,
    });

    factory RiderhisTory.fromMap(Map<String, dynamic> json) => RiderhisTory(
        id: json["id"],
        rideId: json["ride_id"],
        driverName: json["driver_name"],
        driverPic: json["driver_pic"],
        time: json["time"],
        date: json["date"],
        startName: json["start_name"],
        destName: json["dest_name"],
        seats: json["seats"],
        cost: json["cost"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "ride_id": rideId,
        "driver_name": driverName,
        "driver_pic": driverPic,
        "time": time,
        "date": date,
        "start_name": startName,
        "dest_name": destName,
        "seats": seats,
        "cost": cost,
    };
}
