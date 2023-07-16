
import 'package:gym_app_mobile/utils/util.dart';

import 'enum/MuscleGroupEnum.dart';

class ExerciseDomain {
  String name;
  List<EMuscleGroup> muscleGroup;
  List<String>? tips;
  String? image;

  ExerciseDomain({
    required this.name,
    required this.muscleGroup,
    this.tips,
    this.image,
  });

  factory ExerciseDomain.fromJson(Map<String, dynamic> json) {
    return ExerciseDomain(
      name: json['name'],
      muscleGroup: List<EMuscleGroup>.from(json['muscleGroup'].map((group) => UtilApp.muscleGroupFromString(group))),
      tips: json['tips'] != null ? List<String>.from(json['tips']) : null,
      image: json['image'],
    );
  }

  static List<ExerciseDomain> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ExerciseDomain.fromJson(json)).toList();
  }

}
