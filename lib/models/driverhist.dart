import 'dart:convert';

List<DriverHistory> driverHistoryFromJson(String str) => List<DriverHistory>.from(json.decode(str).map((x) => DriverHistory.fromMap(x)));

String driverHistoryToJson(List<DriverHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class DriverHistory {
    String id;
    String driverId;
    String name;
    String time;
    String date;
    String startName;
    String destName;
    String cost;
    String seats;

    DriverHistory({
        this.id,
        this.driverId,
        this.name,
        this.time,
        this.date,
        this.startName,
        this.destName,
        this.cost,
        this.seats,
    });

    factory DriverHistory.fromMap(Map<String, dynamic> json) => DriverHistory(
        id: json["id"],
        driverId: json["driver_id"],
        name: json["name"],
        time: json["time"],
        date: json["date"],
        startName: json["start_name"],
        destName: json["dest_name"],
        cost: json["cost"],
        seats: json["seats"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "driver_id": driverId,
        "name": name,
        "time": time,
        "date": date,
        "start_name": startName,
        "dest_name": destName,
        "cost": cost,
        "seats": seats,
    };
}
