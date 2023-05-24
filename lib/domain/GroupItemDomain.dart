import 'package:gym_app_mobile/domain/ExerciseDomain.dart';

import '../utils/util.dart';

class GroupItemDomain {
  String id;
  ExerciseDomain exercise;
  List<Set> sets;
  RestInterval restInterval;
  int order;
  String? notes;
  String? biSet;
  List<GroupItemDomain>? substitutes;
  String cadence;

  GroupItemDomain({
    required this.id,
    required this.exercise,
    required this.sets,
    required this.restInterval,
    required this.order,
    this.notes,
    this.biSet,
    this.substitutes,
    required this.cadence,
  });

  factory GroupItemDomain.fromJson(Map<String, dynamic> json) {
    return GroupItemDomain(
      id: json['_id'],
      exercise: ExerciseDomain.fromJson(json['exercise']),
      sets: List<Set>.from(json['sets'].map((set) => Set.fromJson(set))),
      restInterval: RestInterval.fromJson(json['restInterval']),
      order: json['order'],
      notes: json['notes'],
      biSet: json['biSet'],
      substitutes: List<GroupItemDomain>.from(json['substitutes']),
      cadence: json['cadence'],
    );
  }

  static List<GroupItemDomain> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => GroupItemDomain.fromJson(json)).toList();
  }
}

class Set {
  int order;
  Repetitions repetitions;
  ERepetitionsTypes setType;
  int dropSet;

  Set({
    required this.order,
    required this.repetitions,
    required this.setType,
    required this.dropSet,
  });



  factory Set.fromJson(Map<String, dynamic> json) {
    return Set(
      order: json['order'],
      repetitions: Repetitions.fromJson(json['repetitions']),
      setType: UtilApp.enumFromString<ERepetitionsTypes>(json['setType'], ERepetitionsTypes.values),
      dropSet: json['dropSet'],
    );
  }
}

class Repetitions {
  int min;
  int max;

  Repetitions({
    required this.min,
    required this.max,
  });

  factory Repetitions.fromJson(Map<String, dynamic> json) {
    return Repetitions(
      min: json['min'],
      max: json['max'],
    );
  }
}

enum ERepetitionsTypes {
  TIME,
  REPETITIONS
}

class RestInterval {
  int min;
  int max;

  RestInterval({
    required this.min,
    required this.max,
  });

  factory RestInterval.fromJson(Map<String, dynamic> json) {
    return RestInterval(
      min: json['min'],
      max: json['max'],
    );
  }
}
