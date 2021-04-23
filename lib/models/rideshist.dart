// To parse this JSON data, do
//
//     final rideZhist = rideZhistFromJson(jsonString);

import 'dart:convert';

List<RideZhist> rideZhistFromJson(String str) => List<RideZhist>.from(json.decode(str).map((x) => RideZhist.fromMap(x)));

String rideZhistToJson(List<RideZhist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class RideZhist {
    String id;
    String rideId;
    String driverName;
    String time;
    String date;
    String startName;
    String destName;
    String seats;
    String cost;

    RideZhist({
        this.id,
        this.rideId,
        this.driverName,
        this.time,
        this.date,
        this.startName,
        this.destName,
        this.seats,
        this.cost,
    });

    factory RideZhist.fromMap(Map<String, dynamic> json) => RideZhist(
        id: json["id"],
        rideId: json["ride_id"],
        driverName: json["driver_name"],
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
        "time": time,
        "date": date,
        "start_name": startName,
        "dest_name": destName,
        "seats": seats,
        "cost": cost,
    };
}
