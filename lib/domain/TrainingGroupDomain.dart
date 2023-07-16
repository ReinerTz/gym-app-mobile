import 'package:gym_app_mobile/domain/GroupItemDomain.dart';
import 'package:gym_app_mobile/domain/enum/MuscleGroupEnum.dart';

import '../utils/util.dart';

class TrainingGroupDomain {
  String id;
  String name;
  List<EMuscleGroup> muscleGroups;
  List<ItemProp>? items;
  RestInterval restInterval;

  TrainingGroupDomain({
    required this.id,
    required this.name,
    required this.muscleGroups,
    required this.restInterval,
    this.items,
  });

  factory TrainingGroupDomain.fromJson(Map<String, dynamic> json) {
    List<EMuscleGroup> muscleGroups = List<EMuscleGroup>.from(
        json['muscleGroups']
            .map((group) => UtilApp.muscleGroupFromString(group)));
    List<dynamic> itemsJson = json['items'];
    List<ItemProp> items = ItemProp.fromJsonList(itemsJson);

    return TrainingGroupDomain(
      id: json['_id'],
      name: json['name'],
      muscleGroups: muscleGroups,
      items: items,
      restInterval: RestInterval.fromJson(json['restInterval']),
    );
  }

  static List<TrainingGroupDomain> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TrainingGroupDomain.fromJson(json)).toList();
  }
}

class ItemProp {
  GroupItemDomain item;
  int order;

  ItemProp({
    required this.item,
    required this.order,
  });

  factory ItemProp.fromJson(Map<String, dynamic> json) {
    return ItemProp(
      item:  GroupItemDomain.fromMap(json['item']),
      order: json['order'],
    );
  }

  static List<ItemProp> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ItemProp.fromJson(json)).toList();
  }
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
