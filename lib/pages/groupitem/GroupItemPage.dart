import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gym_app_mobile/core/routes.dart';

import 'package:gym_app_mobile/domain/TrainingGroupDomain.dart';
import 'package:gym_app_mobile/widgets/VideoPreviewWidget.dart';

import '../../domain/GroupItemDomain.dart';
import '../../domain/enum/ERepetitionsTypesEnum.dart';
import '../../utils/util.dart';
import '../../widgets/TimerWidget.dart';
import 'GroupItemController.dart';

class GroupItemPage extends StatefulWidget {
  const GroupItemPage({super.key});

  @override
  _GroupItemPageState createState() => _GroupItemPageState();
}

class ItemSetDomain {
  final Item itemProp;
  final Set set;

  ItemSetDomain({required this.itemProp, required this.set});
}

class _GroupItemPageState extends State<GroupItemPage> {
  final GroupItemController controller = Get.put(GroupItemController());
  int restDuration = 0;
  RxInt currentCount = 0.obs;

  Timer? timer;
  RxBool isTimerRunning = false.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (isTimerRunning.value) {
        currentCount.value++;
      }
    });
    isTimerRunning.value = true;
  }

  void pauseTimer() {
    timer?.cancel();
    isTimerRunning.value = false;
  }

  void resetTimer() {
    timer?.cancel();
    currentCount.value = 0;
    isTimerRunning.value = false;
  }

  Color getCounterColor(TrainingGroupDomain trainingGroup) {
    final minRestInterval = trainingGroup.restInterval.min;
    final maxRestInterval = trainingGroup.restInterval.max;

    if (currentCount < minRestInterval) {
      return Colors.yellow;
    } else if (currentCount >= minRestInterval &&
        currentCount <= maxRestInterval) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  List<ItemSetDomain> getCurrentTrainingSets(ItemProp training) {
    final List<ItemSetDomain> currentSets = [];

    for (final item in training.item.items) {
      for (var i = 0; i < item.sets.length; i++) {
        final set = item.sets[i];
        final newSet = Set(
            repetitions: set.repetitions,
            order: i,
            setType: set.setType,
            id: set.id);
        final ItemSetDomain domain = ItemSetDomain(itemProp: item, set: newSet);
        currentSets.add(domain);
      }
    }

    currentSets.sort((a, b) => a.set.order.compareTo(b.set.order));

    return currentSets;
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final trainingGroup = args['trainingGroup'] as TrainingGroupDomain;

    Widget displayTable(ItemProp training) {
      final currentSets = getCurrentTrainingSets(training);
      return Column(children: [
        RestTimeWidget(
          trainingGroup: trainingGroup,
          currentCount: currentCount,
          isTimerRunning: isTimerRunning,
          startTimer: startTimer,
          pauseTimer: pauseTimer,
          resetTimer: resetTimer,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Séries',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DataTable(
            columnSpacing: 40,
            columns: const [
              DataColumn(label: Text('Exercício')),
              DataColumn(label: Text('Série')),
              DataColumn(label: Text('Repetições')),
              DataColumn(label: Text('Cadência')),
            ],
            rows: currentSets
                .map(
                  (itemSet) => DataRow(
                    cells: [
                      DataCell(Text(itemSet.itemProp.exercise.name)),
                      DataCell(Text("${itemSet.set.order + 1}")),
                      DataCell(Text(_formatRepetitions(
                          itemSet.set.repetitions, itemSet.set.setType))),
                      DataCell(Text(itemSet.itemProp.cadence)),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ]);
    }

    Widget displayVideo(Item item) {
      return Visibility(
        visible: item.exercise.image != null && item.exercise.image != "",
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.topCenter,
          child: VideoPreviewWidget(videoUrl: item.exercise.image),
        ),
      );
    }

    Widget trainingCard(ItemProp training) {
      return Card(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: training.item.items.length ?? 0,
              itemBuilder: (context, index) {
                final item = training.item.items[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    displayVideo(item),
                    ExpansionTile(
                      title: Text(
                        "${training.order + 1} - ${item.exercise.name}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Grupos musculares: ${UtilApp.translateMuscleGroups(item.exercise.muscleGroup)}',
                      ),
                      children: [
                        for (var i = 0;
                            i < (item.exercise.tips?.length ?? 0);
                            i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ListTile(
                              leading: Text('${i + 1}.'),
                              title: Text(item.exercise.tips![i]),
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black87,
                              elevation: 15.0,
                            ),
                            onPressed: () {
                              Get.toNamed(
                                  "${Routes.PROGESS_LOAD}/${item.exercise.id}", arguments: item.exercise);
                            },
                            child: const Text(
                              'Carga',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            displayTable(training)
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Treino: ${trainingGroup.name}"),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: trainingGroup.items?.length ?? 0,
                  itemBuilder: (context, index) {
                    final training = trainingGroup.items?[index];

                    if (training == null) {
                      return const SizedBox();
                    }

                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(10),
                      child: ScrollConfiguration(
                        behavior: const ScrollBehavior(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: trainingGroup.items?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final training = trainingGroup.items?[index];
                                  if (training != null) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.all(10),
                                      child: SingleChildScrollView(
                                          child: trainingCard(training)),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  String _formatRepetitions(
      Repetitions repetitions, ERepetitionsTypes setType) {
    if (setType == ERepetitionsTypes.TIME) {
      if (repetitions.min == repetitions.max) {
        return '${repetitions.min} (segundos)';
      } else {
        return '${repetitions.min} - ${repetitions.max} (segundos)';
      }
    } else {
      if (repetitions.min == repetitions.max) {
        if (repetitions.max == 999) {
          return 'Falha';
        } else {
          return '${repetitions.min}';
        }
      } else {
        if (repetitions.min == 999 && repetitions.max == 999) {
          return 'Falha';
        } else {
          return '${repetitions.min} - ${repetitions.max}';
        }
      }
    }
  }
}
