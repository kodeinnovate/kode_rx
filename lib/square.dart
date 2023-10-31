import 'package:flutter/material.dart';

class MySquare extends StatelessWidget {
  final  child;
  final  date;

  MySquare({required this.child, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                date,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(30, 0, 30, 0), child: Divider(color: Colors.black54)), // Horizontal line,),
           
            Container(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  child,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
