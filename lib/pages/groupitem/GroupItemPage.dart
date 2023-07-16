import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gym_app_mobile/domain/TrainingGroupDomain.dart';
import 'package:gym_app_mobile/widgets/VideoPreviewWidget.dart';
import 'package:video_player/video_player.dart';

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

class _GroupItemPageState extends State<GroupItemPage> {
  final GroupItemController controller = Get.put(GroupItemController());
  int restDuration = 0;
  RxInt currentCount = 0.obs;

  Timer? timer;
  RxBool isTimerRunning = false.obs;

  bool showRestTime = true; // Add this variable to control visibility

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

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final trainingGroup = args['trainingGroup'] as TrainingGroupDomain;

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
                  if (training != null) {
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
                                        child: Card(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                            const NeverScrollableScrollPhysics(),
                                            itemCount:
                                            training.item.items?.length ??
                                                0,
                                            itemBuilder: (context, index) {
                                              final item =
                                              training.item.items?[index];
                                              if (item != null) {
                                                return Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Visibility(
                                                      visible: item.exercise
                                                          .image !=
                                                          null &&
                                                          item.exercise.image !=
                                                              "",
                                                      child: Container(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(10),
                                                        alignment:
                                                        Alignment.topCenter,
                                                        child:
                                                        VideoPreviewWidget(
                                                            videoUrl: item
                                                                .exercise
                                                                .image),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Text(
                                                        "${training.order + 1} - ${item.exercise.name}",
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        ),
                                                      ),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            'Grupos musculares: ${UtilApp.translateMuscleGroups(item.exercise.muscleGroup)}',
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          ExpansionTile(
                                                            title: const Text(
                                                                'Dicas'),
                                                            children: [
                                                              for (var i = 0;
                                                              i <
                                                                  (item.exercise.tips
                                                                      ?.length ??
                                                                      0);
                                                              i++)
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                      4.0),
                                                                  child:
                                                                  ListTile(
                                                                    leading: Text(
                                                                        '${i + 1}.'),
                                                                    title: Text(item
                                                                        .exercise
                                                                        .tips![i]),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 10),

                                                          // Extracting the RestTimeWidget and controlling its visibility.
                                                          if (showRestTime)
                                                            RestTimeWidget(
                                                              trainingGroup: trainingGroup,
                                                              currentCount: currentCount,
                                                              isTimerRunning: isTimerRunning,
                                                              startTimer: startTimer,
                                                              pauseTimer: pauseTimer,
                                                              resetTimer: resetTimer,
                                                            ),

                                                          const SizedBox(
                                                              height: 10),
                                                          const Text(
                                                            'Séries',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                          DataTable(
                                                            columns: const [
                                                              DataColumn(
                                                                  label: Text(
                                                                      'Série')),
                                                              DataColumn(
                                                                  label: Text(
                                                                      'Repetições')),
                                                              DataColumn(
                                                                  label: Text(
                                                                      'Cadência')),
                                                            ],
                                                            rows: item.sets
                                                                .map((set) {
                                                              final repetitions =
                                                              _formatRepetitions(
                                                                  set.repetitions,
                                                                  set.setType);
                                                              final cadence =
                                                                  item.cadence;

                                                              return DataRow(
                                                                cells: [
                                                                  DataCell(Text(
                                                                      "${set.order + 1}")),
                                                                  DataCell(Text(
                                                                      repetitions)),
                                                                  DataCell(Text(
                                                                      cadence)),
                                                                ],
                                                              );
                                                            }).toList(),
                                                          ),
                                                          if (item.dropSet !=
                                                              null &&
                                                              item.dropSet! > 0)
                                                            Text(
                                                                'Drop Set: ${item.dropSet}'),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return const SizedBox();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
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

