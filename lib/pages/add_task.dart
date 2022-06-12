import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:taskman/Models/tasks_model.dart';
import 'package:taskman/controllers/tasks_controler.dart';
import 'package:uuid/uuid.dart';

class AddTask extends StatelessWidget {
  final Function() notifyParent;
  AddTask({Key? key, required this.notifyParent}) : super(key: key);

  TasksController tc = TasksController.instance;

  final titleFieldController = TextEditingController();
  final discretionFieldController = TextEditingController(text: "");
  final priorityFieldController = TextEditingController(text: "5");
  var uuid = const Uuid();
  List<DateTime>? dateTimeList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 25,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: titleFieldController,
            maxLines: 1,
            style: const TextStyle(fontSize: 24),
            decoration:
                const InputDecoration(labelText: "Enter your task title"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: discretionFieldController,
            maxLines: 5,
            style: const TextStyle(fontSize: 20),
            decoration:
                const InputDecoration(labelText: "Enter your task discretion"),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              dateTimeList = await showOmniDateTimeRangePicker(
                context: context,
                primaryColor: Colors.cyan,
                backgroundColor: Colors.grey[900],
                calendarTextColor: Colors.white,
                tabTextColor: Colors.white,
                unselectedTabBackgroundColor: Colors.grey[700],
                buttonTextColor: Colors.white,
                timeSpinnerTextStyle:
                    const TextStyle(color: Colors.white70, fontSize: 18),
                timeSpinnerHighlightedTextStyle:
                    const TextStyle(color: Colors.white, fontSize: 24),
                is24HourMode: false,
                isShowSeconds: false,
                startInitialDate: DateTime.now(),
                startFirstDate:
                    DateTime(1600).subtract(const Duration(days: 3652)),
                startLastDate: DateTime.now().add(
                  const Duration(days: 3652),
                ),
                endInitialDate: DateTime.now(),
                endFirstDate:
                    DateTime(1600).subtract(const Duration(days: 3652)),
                endLastDate: DateTime.now().add(
                  const Duration(days: 3652),
                ),
                borderRadius: const Radius.circular(16),
              );
            },
            child: const Text("Show DateTime Range Picker"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: priorityFieldController,

            decoration:
                const InputDecoration(labelText: "Enter your task priority"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              Task newTask = Task(
                id: uuid.v1(),
                title: titleFieldController.text,
                description: titleFieldController.text,
                createdAt: dateTimeList![0].toString(),
                deadLine: dateTimeList![1].toString(),
                priority: int.parse(priorityFieldController.text),
              );
              await tc.addTask(newTask);
              notifyParent();
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }

  static String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
