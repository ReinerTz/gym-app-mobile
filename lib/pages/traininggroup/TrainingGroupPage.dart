import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app_mobile/core/routes.dart';
import 'package:gym_app_mobile/domain/TrainingGroupDomain.dart';
import 'package:gym_app_mobile/domain/enum/MuscleGroupEnum.dart';

import '../../utils/util.dart';
import 'TrainingGroupController.dart';

class TrainingGroupPage extends StatefulWidget {
  const TrainingGroupPage({Key? key}) : super(key: key);

  @override
  State<TrainingGroupPage> createState() => _TrainingGroupPageState();
}

class _TrainingGroupPageState extends State<TrainingGroupPage> {
  TrainingGroupController controller = TrainingGroupController();
  final id = Get.parameters['id'];

  Future<void> _refreshData() async {
    await controller.getById(id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UtilApp.AppName),
      ),
      body: FutureBuilder<TrainingGroupDomain?>(
        future: controller.getById(id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading training group'),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No data available'),
            );
          }

          final trainingGroup = snapshot.data!;
          final items = trainingGroup.items!;

          return RefreshIndicator(
            onRefresh: _refreshData,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Treino: ${trainingGroup.name}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final training = items[index];
                          final exerciseNames = training.item.items.map((item) => item.exercise.name).join(' + ');
                          List<EMuscleGroup> exerciseMuscleGroups = training.item.items
                              .map((item) => _parseMuscleGroups(item.exercise.muscleGroup))
                              .expand((muscleGroups) => muscleGroups)
                              .toList();

                          exerciseMuscleGroups = exerciseMuscleGroups.toSet().toList();

                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            margin: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 8.0,
                            ),
                            child: ListTile(
                              title: Text(
                                "${training.order + 1} - $exerciseNames",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "Grupos musculares: ${UtilApp.translateMuscleGroups(exerciseMuscleGroups)}",
                              ),
                              onTap: () {
                                Get.toNamed(
                                  Routes.GROUP_ITEM,
                                  arguments: {
                                    'trainingGroup': trainingGroup,
                                    'currentIndex': index,
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<EMuscleGroup> _parseMuscleGroups(List<dynamic> muscleGroups) {
    return muscleGroups
        .map((group) => EMuscleGroup.values.firstWhere((e) => e.toString() == group.toString()))
        .toList();
  }
}
