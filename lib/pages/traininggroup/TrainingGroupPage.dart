import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app_mobile/core/routes.dart';
import 'package:gym_app_mobile/domain/TrainingGroupDomain.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UtilApp.AppName),
        backgroundColor: Colors.lightGreen,
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

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
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
                              "${training.order + 1} - ${training.exercise.name}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
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
          );
        },
      ),
    );
  }
}
