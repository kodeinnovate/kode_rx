import 'package:flutter/material.dart';
import 'package:kode_rx/common_class.dart';
import 'package:kode_rx/square.dart';
import 'app_colors.dart';


class AppointmentList {
  String? date;
  String? name;
  Status? status;

  AppointmentList({this.date, this.name, this.status}); // Constructor
}



class PatientAppointmentsScreen extends StatelessWidget {
//   final List _appointments = [
// 'post 1',
//     'post 2',
//     'post 3',
//     'post 4',
//     'post 3',
//     'post 3',
//     'post 3',
//     'post 3'
//   ];

  List<AppointmentList> lists = [
    AppointmentList(name: 'Hello World1', date: '7th May', status: Status.ongoing),
    AppointmentList(name: 'Hello World2', date: '10th May', status: Status.completed),
    AppointmentList(name: 'Hello World3', date: '11th May', status: Status.ongoing),
    AppointmentList(name: 'Hello World4', date: '12th May', status: Status.pending),
    AppointmentList(name: 'Hello World5', date: '11th May', status: Status.pending),
    AppointmentList(name: 'Hello World3', date: '11th May', status: Status.completed),
    AppointmentList(name: 'Hello World3', date: '11th May', status: Status.ongoing),

  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // textDirection: TextDirection.ltr, // Or TextDirection.rtl for right-to-left text direction
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Appointments'),
          backgroundColor: AppColors.customBackground,
        ),
        body:

        Column(

          children: [
            Align(alignment: Alignment.centerLeft, child:
            Container(
              child: const Padding(padding: EdgeInsets.fromLTRB(40, 100, 0, 100),
                child:  Column(
                  children: [
                    Text('Schedule', style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
                  ],
                ),),
            )
              ,),

            Expanded(
              child: ListView.builder(
                itemCount: lists.length,
                itemBuilder: (context, index) {
                  return MySquare(child: lists[index].name, date: lists[index].date, status: lists[index].status);

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  
}