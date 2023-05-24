import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app_mobile/domain/TrainingGroupDomain.dart';

import '../../domain/ExerciseDomain.dart';
import '../../domain/GroupItemDomain.dart';
import '../../utils/util.dart';

class GroupItemPage extends StatelessWidget {
  final Map<EMuscleGroup, String> muscleGroupTranslations = {
    EMuscleGroup.PECTORAL: 'Peitoral',
    EMuscleGroup.BACK: 'Costas',
    EMuscleGroup.SHOULDERS: 'Ombros',
    EMuscleGroup.BICEPS: 'Bíceps',
    EMuscleGroup.TRICEPS: 'Tríceps',
    EMuscleGroup.ABDOMEN: 'Abdômen',
    EMuscleGroup.LEGS: 'Pernas',
  };

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final trainingGroup = args['trainingGroup'] as TrainingGroupDomain;
    final currentIndex = args['currentIndex'] as int;
    // final training = trainingGroup.items![currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(UtilApp.AppName),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Training Group: ${trainingGroup.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: trainingGroup.items!.length,
                itemBuilder: (context, index) {
                  final training = trainingGroup.items![index];
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              child: training.exercise.image != null
                                  ? Image.network(
                                training.exercise.image!,
                                height: 150,
                              )
                                  : Placeholder(
                                fallbackHeight: 150,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "${training.order + 1} - ${training.exercise.name}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Grupos músculares: ${_translateMuscleGroups(training.exercise.muscleGroup)}',
                                  ),
                                  SizedBox(height: 10),
                                  ExpansionTile(
                                    title: Text('Tips'),
                                    children: [
                                      for (var i = 0; i < (training.exercise.tips?.length ?? 0); i++)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                                          child: ListTile(
                                            leading: Text('${i + 1}.'),
                                            title: Text(training.exercise.tips![i]),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Séries',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  for (var set in training.sets)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${set.order + 1} - ${_formatRepetitions(set.repetitions, set.setType)}"),
                                          if (set.dropSet > 0) Text('Drop Set: ${set.dropSet}'),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _translateMuscleGroups(List<EMuscleGroup> muscleGroups) {
    final translatedGroups = muscleGroups.map((group) {
      return muscleGroupTranslations[group] ?? '';
    }).toList();

    return translatedGroups.join(", ");
  }

  String _formatRepetitions(Repetitions repetitions, ERepetitionsTypes setType) {
    final setTypeString = _translateSetType(setType);

    if (setType == ERepetitionsTypes.TIME) {
      return 'Tempo: ${repetitions.min}-${repetitions.max} (segundos)';
    } else {
      return 'Repetições: ${repetitions.min}-${repetitions.max}';
    }
  }

  String _translateSetType(ERepetitionsTypes setType) {
    switch (setType) {
      case ERepetitionsTypes.TIME:
        return 'Time';
      case ERepetitionsTypes.REPETITIONS:
        return 'Repetitions';
      default:
        return '';
    }
  }
}
