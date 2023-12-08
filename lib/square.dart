import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/common_class.dart';
import 'package:kode_rx/device_helper.dart';
import 'package:kode_rx/patient_appointments.dart';
import 'package:kode_rx/select_medicenes.dart';

class MySquare extends StatelessWidget {
  static MySquare get instance => Get.find();
  final String name;
  final DateTime date;
  final Status status;
  final format = DateFormat('EEE, dd-MM-yy - h:m a');

  MySquare({required this.name, required this.date, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor = getStatusColor(status);

    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicationReminderApp(),
                  )
                );
          } ,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                DeviceHelper.getDeviceType == DeviceType.tablet ? 15.0 : 10.0,
              ),
            ),
            elevation: 5,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        DeviceHelper.getDeviceType == DeviceType.tablet
                            ? 20
                            : 10,
                      ),
                      bottomLeft: Radius.circular(
                        DeviceHelper.getDeviceType == DeviceType.tablet
                            ? 20
                            : 10,
                      ),
                    ),
                    color: statusColor,
                  ),
                  width:
                      DeviceHelper.getDeviceType == DeviceType.tablet ? 10 : 5,
                  height: DeviceHelper.getDeviceType == DeviceType.tablet
                      ? 200
                      : 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    DeviceHelper.getDeviceType == DeviceType.tablet
                        ? 20.0
                        : 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Appointment Date:',
                              style: TextStyle(
                                fontSize: DeviceHelper.getDeviceType ==
                                        DeviceType.tablet
                                    ? 20
                                    : 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            format.format(date),
                            style: const TextStyle(
                              fontSize: DeviceHelper.getDeviceType ==
                                      DeviceType.tablet
                                  ? 24
                                  : 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      // // This is where you add your red Container
                      // Container(
                      //   child: Divider(color: Colors.amber, thickness: 2),
                      // ),
                      
                      Text(
                          '---------------------------------------------------------------------------------------',
                          style: TextStyle(
                              color: AppColors
                                  .customDividerColor) // Use the desired gray color.
                          ),
                      SizedBox(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize:
                                DeviceHelper.getDeviceType == DeviceType.tablet
                                    ? 38
                                    : 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Color getStatusColor(Status status) {
    switch (status) {
      case Status.pending:
        return Colors.orange;
      case Status.ongoing:
        return Colors.blue;
      case Status.completed:
        return Colors.green;
      default:
        return Colors.red;
    }
  }
}
