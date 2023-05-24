enum EMuscleGroup {
  PECTORAL,
  BACK,
  SHOULDERS,
  BICEPS,
  TRICEPS,
  ABDOMEN,
  LEGS
}

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
      muscleGroup: List<EMuscleGroup>.from(json['muscleGroup'].map((group) => _muscleGroupFromString(group))),
      tips: json['tips'] != null ? List<String>.from(json['tips']) : null,
      image: json['image'],
    );
  }

  static List<ExerciseDomain> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ExerciseDomain.fromJson(json)).toList();
  }

  static EMuscleGroup _muscleGroupFromString(String group) {
    switch (group) {
      case 'PECTORAL':
        return EMuscleGroup.PECTORAL;
      case 'BACK':
        return EMuscleGroup.BACK;
      case 'SHOULDERS':
        return EMuscleGroup.SHOULDERS;
      case 'BICEPS':
        return EMuscleGroup.BICEPS;
      case 'TRICEPS':
        return EMuscleGroup.TRICEPS;
      case 'ABDOMEN':
        return EMuscleGroup.ABDOMEN;
      case 'LEGS':
        return EMuscleGroup.LEGS;
      default:
        throw ArgumentError('Invalid muscle group: $group');
    }
  }
}
