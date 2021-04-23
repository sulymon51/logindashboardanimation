// To parse this JSON data, do
//
//     final requestDridez = requestDridezFromJson(jsonString);

import 'dart:convert';

List<RequestDridez> requestDridezFromJson(String str) => List<RequestDridez>.from(json.decode(str).map((x) => RequestDridez.fromMap(x)));

String requestDridezToJson(List<RequestDridez> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class RequestDridez {
    final String id;
    final String shareRideId;
    final String rideId;
    final String rideName;
    final String rideNumber;
    final String seatNo;
    final String bookedSeats;
    final String cost;
    final String status;
    final String driverId;
    final String driverName;
    final String driverNumber;
    final String driverImage;
    final String rating;
    final String carModel;
    final String carColor;
    final String carNumber;
    final String carPic;
    final String startLat;
    final String startLan;
    final String startName;
    final String destLat;
    final String destLan;
    final String destName;
    final String date;
    final String time;
    final String ac;
    final String music;
    final String smoking;
    final String requestStatus;
    final String rideStarted;

    RequestDridez({
        this.id,
        this.shareRideId,
        this.rideId,
        this.rideName,
        this.rideNumber,
        this.seatNo,
        this.bookedSeats,
        this.cost,
        this.status,
        this.driverId,
        this.driverName,
        this.driverNumber,
        this.driverImage,
        this.rating,
        this.carModel,
        this.carColor,
        this.carNumber,
        this.carPic,
        this.startLat,
        this.startLan,
        this.startName,
        this.destLat,
        this.destLan,
        this.destName,
        this.date,
        this.time,
        this.ac,
        this.music,
        this.smoking,
        this.requestStatus,
        this.rideStarted,
    });

    factory RequestDridez.fromMap(Map<String, dynamic> json) => RequestDridez(
        id: json["id"],
        shareRideId: json["share_ride_id"],
        rideId: json["ride_id"],
        rideName: json["ride_name"],
        rideNumber: json["ride_number"],
        seatNo: json["seat_no"],
        bookedSeats: json["booked_seats"],
        cost: json["cost"],
        status: json["status"],
        driverId: json["driver_id"],
        driverName: json["driver_name"],
        driverNumber: json["driver_number"],
        driverImage: json["driver_image"],
        rating: json["rating"],
        carModel: json["car_model"],
        carColor: json["car_color"],
        carNumber: json["car_number"],
        carPic: json["car_pic"],
        startLat: json["start_lat"],
        startLan: json["start_lan"],
        startName: json["start_name"],
        destLat: json["dest_lat"],
        destLan: json["dest_lan"],
        destName: json["dest_name"],
        date: json["date"],
        time: json["time"],
        ac: json["ac"],
        music: json["music"],
        smoking: json["smoking"],
        requestStatus: json["request_status"],
        rideStarted: json["ride_started"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "share_ride_id": shareRideId,
        "ride_id": rideId,
        "ride_name": rideName,
        "ride_number": rideNumber,
        "seat_no": seatNo,
        "booked_seats": bookedSeats,
        "cost": cost,
        "status": status,
        "driver_id": driverId,
        "driver_name": driverName,
        "driver_number": driverNumber,
        "driver_image": driverImage,
        "rating": rating,
        "car_model": carModel,
        "car_color": carColor,
        "car_number": carNumber,
        "car_pic": carPic,
        "start_lat": startLat,
        "start_lan": startLan,
        "start_name": startName,
        "dest_lat": destLat,
        "dest_lan": destLan,
        "dest_name": destName,
        "date": date,
        "time": time,
        "ac": ac,
        "music": music,
        "smoking": smoking,
        "request_status": requestStatus,
        "ride_started": rideStarted,
    };
}
