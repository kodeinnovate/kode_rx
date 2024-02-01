import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/device_helper.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';




class CalenderDialogue extends StatefulWidget {
  final dynamic Function()? func;
  CalenderDialogue({super.key, this.func});
   
  static CalenderDialogue get instance => Get.find();

  @override
  State<CalenderDialogue> createState() => _CalenderDialogueState();
}

class _CalenderDialogueState extends State<CalenderDialogue> {
  UserController userController = Get.put(UserController());

late CleanCalendarController calendarController;
  @override
  void initState() {
    super.initState();
  calendarController = CleanCalendarController(
    minDate: DateTime.now(),
    maxDate: DateTime.now().add(const Duration(days: 365)),
    rangeMode: false,
    // onRangeSelected: (firstDate, secondDate) {},
    onDayTapped: (date) {
    String followUpDate = (DateFormat.yMMMMd().format(date));
    userController.followUpDate.value = followUpDate;
      print(followUpDate);
    },
    // readOnly: true,
    onPreviousMinDateTapped: (date) {},
    onAfterMaxDateTapped: (date) {},
    weekdayStart: DateTime.monday,
    initialFocusDate: DateTime.now(),
    initialDateSelected: DateTime.now(),
    // initialDateSelected: DateTime(2022, 3, 15),
    // endDateSelected: DateTime(2022, 3, 20),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // shape: (),
      // backgroundColor: Colors.red,
      appBar: DeviceHelper.deviceAppBar(title: 'Follow-up date'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                        onPressed: () {},
                        child: Text(
                          'Skip',
                          style: const TextStyle(color: AppColors.customBackground),
                        ),
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      
                      
                      
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
                        onPressed: widget.func,
                        child: Text(
                          'Save',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
