class TrainingDomain {
  String id;
  String name;
  String user;
  String? description;
  List<TrainingGroup> groups;

  TrainingDomain({
    required this.id,
    required this.name,
    required this.user,
    this.description,
    required this.groups,
  });

  factory TrainingDomain.fromJson(Map<String, dynamic> json) {
    List<dynamic> groupsJson = json['groups'];
    List<TrainingGroup> groups = TrainingGroup.fromJsonList(groupsJson);

    return TrainingDomain(
      id: json['_id'],
      name: json['name'],
      user: json['user'],
      description: json['description'],
      groups: groups,
    );
  }

  static List<TrainingDomain> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TrainingDomain.fromJson(json)).toList();
  }
}

class TrainingGroup {
  String id;
  String name;
  List<String> muscleGroups;
  List<String>? items;

  TrainingGroup({
    required this.id,
    required this.name,
    required this.muscleGroups,
    this.items,
  });

  factory TrainingGroup.fromJson(Map<String, dynamic> json) {
    List<dynamic> muscleGroupsJson = json['muscleGroups'];
    List<String> muscleGroups = muscleGroupsJson.map((group) => group.toString()).toList();
    List<dynamic> itemsJson = json['items'];
    List<String> items = itemsJson.map((item) => item.toString()).toList();

    return TrainingGroup(
      id: json['_id'],
      name: json['name'],
      muscleGroups: muscleGroups,
      items: items,
    );
  }

  static List<TrainingGroup> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TrainingGroup.fromJson(json)).toList();
  }
}
