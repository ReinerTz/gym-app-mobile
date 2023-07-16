// To parse this JSON data, do
//
//     final groupItemDomain = groupItemDomainFromMap(jsonString);

import 'dart:convert';

import 'package:gym_app_mobile/domain/ExerciseDomain.dart';
import 'package:gym_app_mobile/utils/util.dart';

import 'enum/ERepetitionsTypesEnum.dart';
import 'enum/MuscleGroupEnum.dart';

class GroupItemDomain {
  final List<Item> items;

  GroupItemDomain({
    required this.items,
  });

  factory GroupItemDomain.fromJson(String str) => GroupItemDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GroupItemDomain.fromMap(Map<String, dynamic> json) => GroupItemDomain(
    items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "items": List<dynamic>.from(items.map((x) => x.toMap())),
  };
}

class Item {
  final List<String> substitutes;
  final ExerciseDomain exercise;
  final List<Set> sets;
  final int? dropSet;
  final String cadence;
  final int order;
  final String id;

  Item({
    this.substitutes = const [],
    required this.exercise,
    required this.sets,
    this.dropSet,
    required this.cadence,
    required this.order,
    required this.id,
  });

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
    substitutes: List<String>.from(json["substitutes"] ?? []),
    exercise: ExerciseDomain.fromJson(json["exercise"]),
    sets: List<Set>.from(json["sets"].map((x) => Set.fromMap(x))),
    dropSet: json["dropSet"],
    cadence: json["cadence"],
    order: json["order"],
    id: json["_id"],
  );

  Map<String, dynamic> toMap() => {
    "substitutes": List<dynamic>.from(substitutes.map((x) => x)),
    "exercise": exercise,
    "sets": List<dynamic>.from(sets.map((x) => x.toMap())),
    "dropSet": dropSet,
    "cadence": cadence,
    "order": order,
    "_id": id,
  };
}

class Set {
  final Repetitions repetitions;
  final int order;
  final ERepetitionsTypes setType;
  final String id;

  Set({
    required this.repetitions,
    required this.order,
    required this.setType,
    required this.id,
  });

  factory Set.fromJson(String str) => Set.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Set.fromMap(Map<String, dynamic> json) => Set(
    repetitions: Repetitions.fromMap(json["repetitions"]),
    order: json["order"],
    setType: UtilApp.repetitionsTypesFromString(json["setType"]),
    id: json["_id"],
  );

  Map<String, dynamic> toMap() => {
    "repetitions": repetitions.toMap(),
    "order": order,
    "setType": setType,
    "_id": id,
  };
}

class Repetitions {
  final int max;
  final int min;

  Repetitions({
    required this.max,
    required this.min,
  });

  factory Repetitions.fromJson(String str) => Repetitions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Repetitions.fromMap(Map<String, dynamic> json) => Repetitions(
    max: json["max"],
    min: json["min"],
  );

  Map<String, dynamic> toMap() => {
    "max": max,
    "min": min,
  };
}
