import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:gym_app_mobile/domain/ExerciseDomain.dart';
import 'package:gym_app_mobile/domain/ProgressLoadDomain.dart';

import 'ProgressLoadController.dart';

class ProgressLoad extends StatefulWidget {
  const ProgressLoad({Key? key}) : super(key: key);

  @override
  State<ProgressLoad> createState() => _ProgressLoadState();
}

class _ProgressLoadState extends State<ProgressLoad> {
  ProgressLoadController controller = ProgressLoadController();
  final id = Get.parameters['id'];
  final exercise = Get.arguments as ExerciseDomain;

  @override
  Widget build(BuildContext context) {
    Rx<DateTime> selectedDate = DateTime.now().obs;

    Future<void> selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(1990),
        lastDate: DateTime.now(),
      );

      if (pickedDate != null && pickedDate != selectedDate) {
        selectedDate.value = pickedDate;
      }
    }

    TextEditingController loadController = TextEditingController();

    void addDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Adicionar Carga"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Obx(
                  () => InkWell(
                    onTap: () => selectDate(context),
                    // Abre o seletor de data.
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: TextEditingController(
                          text: "${selectedDate.value.toLocal()}".split(' ')[0],
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Data',
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: loadController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Peso (em kg)'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("Cancelar"),
                onPressed: () {
                  Navigator.of(context).pop(); // Fechar a caixa de diálogo
                },
              ),
              TextButton(
                child: const Text("Adicionar"),
                onPressed: () async {
                  final response = await controller.save(exercise.id,
                      selectedDate.value, double.parse(loadController.text));

                  if (response) {
                    Get.snackbar("Sucesso", "Nova carga adicionada com sucesso",
                        duration: const Duration(seconds: 6),
                        backgroundColor: Colors.lightGreen,
                        colorText: Colors.white);
                  }

                  Navigator.of(context).pop(); // Fechar a caixa de diálogo
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> confirmDelete(
        BuildContext context, ProgressLoadDomain progress) async {
      final confirmDelete = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmar Exclusão"),
            content: Text("Deseja realmente excluir esta carga?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("Cancelar"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(true);
                },
                child: Text("Confirmar"),
              ),
            ],
          );
        },
      );

      if (confirmDelete != null && confirmDelete) {
        final response = await controller.delete(progress.id!);

        if (response) {
          Get.snackbar(
            "Sucesso",
            "Carga excluída com sucesso",
            duration: const Duration(seconds: 6),
            backgroundColor: Colors.lightGreen,
            colorText: Colors.white,
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addDialog(context); // Chamar a função para exibir a caixa de diálogo
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
          child: FutureBuilder<List<ProgressLoadDomain>?>(
        future: controller.getProgressLoad(id!),
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

          final progressLoads = snapshot.data ?? [];

          return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8.0),
            child: DataTable(
              dividerThickness: 5,
              decoration: BoxDecoration(
                border: Border(
                    right: Divider.createBorderSide(context, width: 5.0),
                    left: Divider.createBorderSide(context, width: 5.0)),
              ),
              showBottomBorder: true,
              columnSpacing: 40,
              columns: const [
                DataColumn(label: Text('Data')),
                DataColumn(label: Text('Peso (KG)')),
                DataColumn(label: Text('Ações')),
              ],
              rows: progressLoads
                  .map(
                    (progress) => DataRow(
                      key: UniqueKey(),
                      cells: [
                        DataCell(Text(DateFormat('dd/MM/yyyy')
                            .format(progress.recorded))),
                        DataCell(Text(progress.load.toString())),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => confirmDelete(context, progress),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          );
        },
      )),
    );
  }
}
