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
          Get.to(() => MedicationReminderApp());
        },
        child: Card(
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border(left: BorderSide(width: 15, color: statusColor))),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
             
              title: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Text(
                "Appointment Date",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0),
              )),
              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(Icons.access_time),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(format.format(date),
                          style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 22,color: Colors.black),
                    textAlign: TextAlign.start,
                  )
                ],
              ),
              trailing: Icon(Icons.keyboard_arrow_right_rounded, size: 40.0),
            ),
          ),
        ),
      ),
    );
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
