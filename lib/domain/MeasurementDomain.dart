import 'dart:convert';

class MeasurementDomain {
  final String user;
  final DateTime date;
  final double? waist;
  final double? neck;
  final double? hip;
  final double? bicepsLeft;
  final double? bicepsRight;
  final double? tricepsLeft;
  final double? tricepsRight;
  final double? thighLeft;
  final double? thighRight;
  final double? calfLeft;
  final double? calfRight;
  final double? chest;
  final double? shoulder;
  final double? bodyWeight;
  final double? height;
  final double? bodyFatPercentage;
  final double? bmi;

  MeasurementDomain({
    required this.user,
    required this.date,
    this.waist,
    this.neck,
    this.hip,
    this.bicepsLeft,
    this.bicepsRight,
    this.tricepsLeft,
    this.tricepsRight,
    this.thighLeft,
    this.thighRight,
    this.calfLeft,
    this.calfRight,
    this.chest,
    this.shoulder,
    this.bodyWeight,
    this.height,
    this.bodyFatPercentage,
    this.bmi,
  });

  factory MeasurementDomain.fromJson(String str) => MeasurementDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MeasurementDomain.fromMap(Map<String, dynamic> json) => MeasurementDomain(
    user: json["user"],
    date: DateTime.parse(json["date"]),
    waist: json["waist"],
    neck: json["neck"],
    hip: json["hip"],
    bicepsLeft: json["bicepsLeft"],
    bicepsRight: json["bicepsRight"],
    tricepsLeft: json["tricepsLeft"],
    tricepsRight: json["tricepsRight"],
    thighLeft: json["thighLeft"],
    thighRight: json["thighRight"],
    calfLeft: json["calfLeft"],
    calfRight: json["calfRight"],
    chest: json["chest"],
    shoulder: json["shoulder"],
    bodyWeight: json["bodyWeight"],
    height: json["height"],
    bodyFatPercentage: json["bodyFatPercentage"],
    bmi: json["bmi"],
  );

  Map<String, dynamic> toMap() => {
    "user": user,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "waist": waist,
    "neck": neck,
    "hip": hip,
    "bicepsLeft": bicepsLeft,
    "bicepsRight": bicepsRight,
    "tricepsLeft": tricepsLeft,
    "tricepsRight": tricepsRight,
    "thighLeft": thighLeft,
    "thighRight": thighRight,
    "calfLeft": calfLeft,
    "calfRight": calfRight,
    "chest": chest,
    "shoulder": shoulder,
    "bodyWeight": bodyWeight,
    "height": height,
    "bodyFatPercentage": bodyFatPercentage,
    "bmi": bmi,
  };
}
