import 'package:flutter/material.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'utils.dart';
import 'device_helper.dart';
import 'package:intl/intl.dart';

class CreateAppointment extends StatefulWidget {
  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

bool onClick = false;
bool onHover = false;

class TimeSlots {
  int? id;
  DateTime? date;
  bool? isSelected;

  TimeSlots({this.id, this.date, this.isSelected});
}

List<TimeSlots> timeSlotList = [
  TimeSlots(
      id: 122, date: DateTime.parse('2023-11-07 13:00:04Z'), isSelected: true),
  TimeSlots(
      id: 122, date: DateTime.parse('2023-11-07 13:30:04Z'), isSelected: false),
  TimeSlots(
      id: 122, date: DateTime.parse('2023-11-07 14:00:04Z'), isSelected: false),
  TimeSlots(
      id: 122, date: DateTime.parse('2023-11-07 14:30:04Z'), isSelected: false),
  TimeSlots(
      id: 122, date: DateTime.parse('2023-11-07 15:00:04Z'), isSelected: false),
  TimeSlots(
      id: 122, date: DateTime.parse('2023-11-07 15:00:04Z'), isSelected: false),
  TimeSlots(
      id: 122, date: DateTime.parse('2023-11-07 15:30:04Z'), isSelected: false),
  TimeSlots(
      id: 122, date: DateTime.parse('2023-11-07 16:00:04Z'), isSelected: false),
  TimeSlots(
      id: 122, date: DateTime.parse('2023-11-07 16:30:04Z'), isSelected: false),
  TimeSlots(
      id: 122, date: DateTime.parse('2023-11-07 17:00:04Z'), isSelected: false),
  TimeSlots(
      id: 122, date: DateTime.parse('2023-11-07 17:30:04Z'), isSelected: false),
];

//  List<bool> isSelectedList = List.generate(timeSlotList.length, (i) => false); // For multiple pill selection
int selectedGridItemIndex = -1;

final format = DateFormat('hh:mm a');

class _TableBasicsExampleState extends State<CreateAppointment> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool showOverlay = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: DeviceHelper.deviceAppBar(),
        body: Stack(
          children: [
            // if (showOverlay) GradientContainer(),
            Column(
              children: [
                TableCalendar(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  calendarStyle: const CalendarStyle(
                      todayDecoration: BoxDecoration(
                          color: AppColors.customBackground,
                          shape: BoxShape.circle),
                      selectedDecoration: BoxDecoration(
                          color: AppColors.customBackground,
                          shape: BoxShape.circle)),
                  selectedDayPredicate: (day) {
                    // Use `selectedDayPredicate` to determine which day is currently selected.
                    // If this returns true, then `day` will be marked as selected.

                    // Using `isSameDay` is recommended to disregard
                    // the time-part of compared DateTime objects.
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      // Call `setState()` when updating the selected day
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      // Call `setState()` when updating calendar format
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    // No need to call `setState()` here
                    _focusedDay = focusedDay;
                  },
                ),
                // SizedBox(
                //   height: 40.0,
                // ),
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                      child: Text(
                    'Choose Schedule',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )),
                ),
                // Expanded(
                //   child: SizedBox(
                //     width: 140,

                //     child: ListView.builder(
                //       // scrollDirection: Axis.horizontal,
                //       itemCount: 20,

                //       itemBuilder: (context, index) => Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Container(
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(5.0),
                //               color: Colors.blue),
                //           height: 40,
                //           child: Center(
                //             child: Text(
                //               'Hello',
                //               style: TextStyle(color: Colors.white, fontSize: 16),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: 260,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 6 /
                                    3.5 // Adjust the number of columns as needed
                                ),

                        itemCount: timeSlotList.length,
                        // Set the number of grid items
                        itemBuilder: (context, index) {
                          // Define the content of each grid item
                          return GestureDetector(
                            onTap: () => setState(() {
                              // isSelectedList[index] = !isSelectedList[index]; //For multiple pill selection
                              selectedGridItemIndex = index;
                            }),
                            // onHover: (value) => setState(() {
                            //   onHover = !onHover;
                            // }),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: index == selectedGridItemIndex &&
                                            !timeSlotList[index].isSelected!
                                        ? AppColors.customBackground
                                        : Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: 2)),
                                height: 40,
                                child: Center(
                                  child: Text(
                                    format.format(timeSlotList[index].date!),
                                    style: TextStyle(
                                      color: timeSlotList[index].isSelected!
                                          ? Colors.grey
                                          : index == selectedGridItemIndex &&
                                                  !timeSlotList[index]
                                                      .isSelected!
                                              ? Colors.white
                                              : Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // if (showOverlay)
                //    Positioned(
                //       child: Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(5.0),
                //           color: Colors.white,
                //         ),
                //         height: 200,
                //         child: Center(
                //           child: Column(
                //             children: [
                //                Center(
                //                       child: Icon(
                //                         Icons.check_circle,
                //                         color: Colors.green,
                //                         size: 40,
                //                       ),
                //                     ),
                //               Center(
                //                   child: Text(
                //                 'Appointment Booked!!',
                //                 style: TextStyle(
                //                   fontSize: 24,
                //                 ),
                //               )),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),

                // if (showOverlay) //can be use for samll
                //   Positioned.fill(
                //     child: Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(5.0),
                //         color: Colors.white,
                //       ),
                //       child: Center(
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Center(
                //               child: Icon(
                //                 Icons.check_circle,
                //                 color: Colors.green,
                //                 size: 40,
                //               ),
                //             ),
                //             Center(
                //               child: Text(
                //                 'Appointment Booked!!',
                //                 style: TextStyle(
                //                   fontSize: 24,
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),

                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                //   child: Container(
                //       width: 300,
                //       height: 70,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(5.0),
                //           color: Colors.blue),
                //       child: Center(
                //           child: Text(
                //         'Book Appointment',
                //         style: TextStyle(fontSize: 22),
                //       ))),
                // )

                Center(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showOverlay = true;
                      });

                      // Simulate a delay before hiding the overlay
                      Future.delayed(const Duration(seconds: 3), () {
                        setState(() {
                          showOverlay = false;
                        });

                        // Navigate back to '/patientAppointmentScreen' after hiding overlay
                        Navigator.of(context)
                            .pushReplacementNamed('/patientHome');
                      });
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 16.0),
                          child: Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: AppColors.customBackground,
                            ),
                            child: Center(
                              child: Text(
                                'Book Appointment',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (showOverlay) GradientContainer()
          ],
        ),
      ),
    );
  }
}

class GradientContainer extends StatelessWidget {
  @override
  Widget build(context) {
    return (Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Appointment Booked!!',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
