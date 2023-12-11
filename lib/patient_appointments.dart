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

  PatientAppointmentsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: AppColors.customBackground,
          title: Text('Appointments',style: const TextStyle(fontSize: 30.0, color: Colors.white)),
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 20.0), // Increase the text size here
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Ongoing'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTab(Status.pending),
            _buildTab(Status.ongoing),
            _buildTab(Status.completed),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(Status status) {
    // Filter the list based on the provided status
    List<AppointmentList> filteredList =
    lists.where((appointment) => appointment.status == status).toList();

    // Sort the filtered list by date and time in descending order
    filteredList.sort((a, b) => b.date!.compareTo(a.date!));

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              return MySquare(
                name: filteredList[index].name!,
                date: filteredList[index].date!,
                status: filteredList[index].status!,
              );
            },
          ),
        ),
      ],
    );
  }
}