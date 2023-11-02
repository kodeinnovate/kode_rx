import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/common_class.dart';

class MySquare extends StatelessWidget {
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
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: statusColor,
              ),
              width: 15,
              height: 160,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Appointment Date:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),

                      // const SizedBox(height: 10),

                      Text(
                        format.format(date),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Container(
                    height: 5, // Adjust the height of the "divider" as needed
                    color: AppColors.customDividerColor, // You can set the color to your preference
                    margin: const EdgeInsets.symmetric(
                        vertical: 10), // Adjust margin as needed
                  ),
                  SizedBox(
                    // height: 40,
                    // padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      name,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
