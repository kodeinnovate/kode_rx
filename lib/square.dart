import 'package:flutter/material.dart';
import 'package:kode_rx/common_class.dart';

class MySquare extends StatelessWidget {
  final name;
  final date;
  final status;
  MySquare({required this.name, required this.date, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor = getStatusColor(status);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10,
        child: Row(
          children: [
            Builder(
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    color: statusColor,
                  ),
                  width: 15,
                  height: 240,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
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
                      
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          date,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(color: Colors.black87),
                  ),
                  
                  Container(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        name,
                        style: TextStyle(fontSize: 40),
                      ),
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

  getStatusColor(Status status) {
    if (status == Status.pending)
      return Colors.orange;
    else if (status == Status.ongoing)
      return Colors.blue;
    else if (status == Status.completed)
      return Colors.green;
    else
      return Colors.red;
  }
}
