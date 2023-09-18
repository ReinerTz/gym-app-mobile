class ProgressLoadDomain {
  String? id;
  String user;
  String exercise;
  DateTime recorded;
  double load;

  ProgressLoadDomain({
    this.id,
    required this.user,
    required this.exercise,
    required this.recorded,
    required this.load,
  });

  factory ProgressLoadDomain.fromJson(Map<String, dynamic> json) {
    return ProgressLoadDomain(
      id: json['id'],
      user: json['user'],
      exercise: json['exercise'],
      recorded: DateTime.parse(json['recorded']),
      load: json['load'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'exercise': exercise,
      'recorded': recorded.toIso8601String(), // Converte a data para um formato de string
      'load': load,
    };
  }

  static List<ProgressLoadDomain> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProgressLoadDomain.fromJson(json)).toList();
  }
}
