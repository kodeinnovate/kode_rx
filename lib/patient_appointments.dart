import 'package:flutter/material.dart';
import 'package:kode_rx/common_class.dart';
import 'package:kode_rx/device_helper.dart';
import 'package:kode_rx/square.dart';
import 'app_colors.dart';
import 'package:get/get.dart';

class AppointmentList {
  DateTime? date;
  String? name;
  Status? status;

  AppointmentList({this.date, this.name, this.status}); // Constructor
}

// ignore: must_be_immutable
class PatientAppointmentsScreen extends StatelessWidget {
  static PatientAppointmentsScreen get instance => Get.find();
  List<AppointmentList> lists = [
    AppointmentList(
        name: 'Sophia Hunter',
        date: DateTime.parse('2023-11-07 20:18:04Z'),
        status: Status.ongoing),
    AppointmentList(
        name: 'Sarah Matthews',
        date: DateTime.parse('2021-07-13T13:15:54.000000Z'),
        status: Status.completed),
    AppointmentList(
        name: 'Ted Miles',
        date: DateTime.parse('2023-11-08 20:18:04Z'),
        status: Status.ongoing),
    AppointmentList(
        name: 'Shaun Robinson',
        date: DateTime.parse('2023-11-09 20:18:04Z'),
        status: Status.pending),
    AppointmentList(
        name: 'Shelia Elliott',
        date: DateTime.parse('2023-11-10 20:18:04Z'),
        status: Status.pending),
    AppointmentList(
        name: 'Lance Nichols',
        date: DateTime.parse('2023-11-20 20:18:04Z'),
        status: Status.completed),
    AppointmentList(
        name: 'Alberto Cortez',
        date: DateTime.parse('2023-11-20 20:18:04Z'),
        status: Status.ongoing),
  ];

  PatientAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeviceHelper.deviceAppBar(title: 'Appointments'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: lists.length,
              itemBuilder: (context, index) {
                return MySquare(
                    name: lists[index].name!,
                    date: lists[index].date!,
                    status: lists[index].status!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
