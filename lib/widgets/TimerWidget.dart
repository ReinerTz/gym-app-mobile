import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../domain/TrainingGroupDomain.dart';

class RestTimeWidget extends StatelessWidget {
  final TrainingGroupDomain trainingGroup;
  final RxInt currentCount;
  final RxBool isTimerRunning;
  final VoidCallback startTimer;
  final VoidCallback pauseTimer;
  final VoidCallback resetTimer;

  const RestTimeWidget({super.key,
    required this.trainingGroup,
    required this.currentCount,
    required this.isTimerRunning,
    required this.startTimer,
    required this.pauseTimer,
    required this.resetTimer,
  });

  Color getCounterColor() {
    final minRestInterval = trainingGroup.restInterval.min;
    final maxRestInterval = trainingGroup.restInterval.max;

    if (currentCount.value < minRestInterval) {
      return Colors.yellow;
    } else if (currentCount.value >= minRestInterval &&
        currentCount.value <= maxRestInterval) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tempo de descanso:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Recomendado entre: ${trainingGroup.restInterval.min} à ${trainingGroup.restInterval.max} segs.',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black.withOpacity(0.3),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: isTimerRunning.value ? pauseTimer : startTimer,
                      icon: Icon(
                        isTimerRunning.value ? Icons.pause : Icons.play_arrow,
                      ),
                    ),
                    Text(
                      currentCount.value.toString(),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: getCounterColor(),
                      ),
                    ),
                    IconButton(
                      onPressed: resetTimer,
                      icon: const Icon(Icons.stop),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
