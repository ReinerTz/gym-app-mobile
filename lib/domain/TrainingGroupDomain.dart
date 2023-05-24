import 'package:gym_app_mobile/domain/GroupItemDomain.dart';

class TrainingGroupDomain {
  String id;
  String name;
  List<String> muscleGroups;
  List<GroupItemDomain>? items;

  TrainingGroupDomain({
    required this.id,
    required this.name,
    required this.muscleGroups,
    this.items,
  });

  factory TrainingGroupDomain.fromJson(Map<String, dynamic> json) {
    List<dynamic> muscleGroupsJson = json['muscleGroups'];
    List<String> muscleGroups = muscleGroupsJson.map((group) => group.toString()).toList();
    List<dynamic> itemsJson = json['items'];
    List<GroupItemDomain> items = GroupItemDomain.fromJsonList(itemsJson);

    return TrainingGroupDomain(
      id: json['_id'],
      name: json['name'],
      muscleGroups: muscleGroups,
      items: items,
    );
  }

  static List<TrainingGroupDomain> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TrainingGroupDomain.fromJson(json)).toList();
  }
}