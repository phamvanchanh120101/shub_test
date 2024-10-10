import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:task2_validate_form/presentation/widgets/button_base.dart';

class DateTimePicker {
  static Future<DateTime?> pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return null;

    final time = await pickTime(context);
    if (time == null) return null;

    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
      time.second,
    );
  }

  static Future<DateTime?> pickDate(BuildContext context) => showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

  static Future<DateTime?> pickTime(BuildContext context) async {
    DateTime? pickedTime = DateTime.now();
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 300,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Chọn thời gian',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: CupertinoTheme(
                    data: const CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        pickerTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    child: CupertinoTimerPicker(
                      mode: CupertinoTimerPickerMode.hms,
                      initialTimerDuration: Duration(
                        hours: pickedTime!.hour,
                        minutes: pickedTime!.minute,
                        seconds: pickedTime!.second,
                      ),
                      onTimerDurationChanged: (Duration newDuration) {
                        pickedTime = DateTime(
                          pickedTime!.year,
                          pickedTime!.month,
                          pickedTime!.day,
                          newDuration.inHours,
                          newDuration.inMinutes % 60,
                          newDuration.inSeconds % 60,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonBase(
                      backgroundColor: Colors.grey,
                      text: "Huỷ",
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    ButtonBase(
                      text: "OK",
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    return result == true ? pickedTime : null;
  }
}
