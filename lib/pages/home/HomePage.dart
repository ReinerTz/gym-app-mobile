import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app_mobile/core/routes.dart';
import 'package:gym_app_mobile/pages/home/HomeController.dart';
import 'package:gym_app_mobile/utils/util.dart';

import '../../domain/TrainingDomain.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    HomeController controller = HomeController();
    Rx<bool> expanded = false.obs;

    return Scaffold(
      appBar: AppBar(
        title: Text(UtilApp.AppName),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder<List<TrainingDomain?>>(
            future: controller.getTrainings(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.data == null) {
                return const SizedBox();
              }

              return Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final training = snapshot.data![index];
                      return Obx(
                            () {
                          return Column(
                            children: [
                              Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Meus treinos",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 23,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                child: ExpansionTile(
                                  title: Text(training!.name),
                                  subtitle: Text(training.description ?? ""),
                                  trailing: Icon(
                                    expanded.value ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
                                  ),
                                  onExpansionChanged: (bool exp) {
                                    expanded.value = exp;
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(
                                      color: Colors.grey.shade400,
                                      width: 1.0,
                                    ),
                                  ),
                                  children: training.groups
                                      .map((group) => InkWell(
                                    onTap: () => Get.toNamed("${Routes.TRAINING_GROUP}/${group.id}"),
                                    child: ListTile(
                                      tileColor: Colors.white,
                                      title: Text(group.name),
                                    ),
                                  ))
                                      .toList(),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  )
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
