import 'package:gym_app_mobile/domain/enum/ERepetitionsTypesEnum.dart';

import '../domain/enum/MuscleGroupEnum.dart';

class UtilApp {
  static String AppName = "Gym App";

  static T enumFromString<T>(String value, List<T> enumValues) {
    try {
      return enumValues
          .firstWhere((type) => type.toString().split('.').last == value);
    } catch (e) {
      throw Exception("Failed to convert enum");
    }
  }

  static EMuscleGroup muscleGroupFromString(String group) {
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
      case 'FOREARMS':
        return EMuscleGroup.FOREARMS;
      default:
        throw ArgumentError('Invalid muscle group: $group');
    }
  }

  static ERepetitionsTypes repetitionsTypesFromString(String repetitions) {
    switch (repetitions) {
      case 'REPETITIONS':
        return ERepetitionsTypes.REPETITIONS;
      case 'TIME':
        return ERepetitionsTypes.TIME;
      default:
        throw ArgumentError('Invalid repetitions types: $repetitions');
    }
  }

  static String translateMuscleGroups(List<EMuscleGroup> muscleGroups) {
    final Map<EMuscleGroup, String> muscleGroupTranslations = {
      EMuscleGroup.PECTORAL: 'Peitoral',
      EMuscleGroup.BACK: 'Costas',
      EMuscleGroup.SHOULDERS: 'Ombros',
      EMuscleGroup.BICEPS: 'Bíceps',
      EMuscleGroup.TRICEPS: 'Tríceps',
      EMuscleGroup.ABDOMEN: 'Abdômen',
      EMuscleGroup.LEGS: 'Pernas',
    };

    final translatedGroups = muscleGroups.map((group) {
      return muscleGroupTranslations[group] ?? '';
    }).toList();

    return translatedGroups.join(", ");
  }
}
