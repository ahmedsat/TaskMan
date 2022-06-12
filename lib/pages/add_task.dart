import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class AddTask extends StatelessWidget {
  AddTask({Key? key}) : super(key: key);
  final titleFieldController = TextEditingController();
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
          TextFormField(
            controller: titleFieldController,
            maxLines: 1,
            style: const TextStyle(fontSize: 24),
            decoration: const InputDecoration(
              hintText: "title",
            ),
          ),
          TextFormField(
            controller: titleFieldController,
            maxLines: 5,
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              hintText: "discretion",
            ),
          ),
          //! --------------------------------------
          ElevatedButton(
            onPressed: () async {
              List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
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
              print(dateTimeList);
            },
            child: const Text("Show DateTime Range Picker"),
          ),
        ],
      ),
    );
  }
}
