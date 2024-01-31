import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

class CalenderDialogue extends StatelessWidget {
  final dynamic Function()? func;
  CalenderDialogue({super.key, this.func});
  static CalenderDialogue get instance => Get.find();
  final calendarController = CleanCalendarController(
    minDate: DateTime.now(),
    maxDate: DateTime.now().add(const Duration(days: 30)),
    onRangeSelected: (firstDate, secondDate) {},
    onDayTapped: (date) {
      print(date);
    },
    // readOnly: true,
    onPreviousMinDateTapped: (date) {},
    onAfterMaxDateTapped: (date) {},
    weekdayStart: DateTime.monday,
    initialFocusDate: DateTime.now(),
    // initialDateSelected: DateTime(2022, 3, 15),
    // endDateSelected: DateTime(2022, 3, 20),
  );

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      // shape: (),
      // backgroundColor: Colors.red,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ScrollableCleanCalendar(
              calendarController: calendarController,
              layout: Layout.BEAUTY,
              calendarCrossAxisSpacing: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                
                
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Skip',
                    style: const TextStyle(color: AppColors.customBackground),
                  ),
                ),
                TextButton(
                  onPressed: () {Navigator.pop(context);},
                  child: Text(
                    'Go Back',
                    style: const TextStyle(color: AppColors.customBackground),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: AppColors.customBackground),
                  onPressed: func,
                  child: Text(
                    'Save',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
