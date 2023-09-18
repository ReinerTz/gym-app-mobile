import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app_mobile/core/routes.dart';
import 'package:gym_app_mobile/domain/UserDomain.dart';
import 'package:gym_app_mobile/pages/home/HomeController.dart';
import 'package:gym_app_mobile/utils/util.dart';
import 'package:gym_app_mobile/widgets/SharedDrawer.dart';

import '../../domain/TrainingDomain.dart';
import '../../domain/enum/MuscleGroupEnum.dart';



class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = HomeController();
    Rx<bool> expanded = false.obs;

    return FutureBuilder<UserDomain?>(
      future: controller.getUser(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading user'),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text('No data available'),
          );
        }

        final user = snapshot.data as UserDomain;


        return Scaffold(
          appBar: AppBar(
            title: Text(UtilApp.AppName),
          ),
          drawer: SharedDrawer(name: user.name, email: user.email, avatar: user.avatar,),
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
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error loading training group'),
                    );
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: Text('No data available'),
                    );
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
                                          title: Text(group.name),
                                          subtitle: Text(
                                            "Grupos musculares: ${UtilApp.translateMuscleGroups(group.muscleGroups)}",
                                          ),
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
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }
    );
  }

}
