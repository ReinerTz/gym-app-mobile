import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/MeasurementDomain.dart';
import 'MeasurementController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Measurement App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MeasurementPage(),
    );
  }
}

class MeasurementPage extends StatelessWidget {
  final MeasurementController measurementController = Get.put(MeasurementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Measurement App')),
      body: FutureBuilder<List<MeasurementDomain?>>(
        future: measurementController.getMeasurements(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No measurements found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var measurement = snapshot.data![index];
                return ListTile(
                  title: Text('Measurement on ${measurement!.date.toString()}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // measurementController.deleteMeasurement(index);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddMeasurementDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddMeasurementDialog(BuildContext context) {
    var newMeasurement = MeasurementDomain(date: DateTime.now(), user: '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Measurement'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // Add fields for other measurements here
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // measurementController.addMeasurement(newMeasurement);
                Get.back();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
