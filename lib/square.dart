import 'package:flutter/material.dart';

class MySquare extends StatelessWidget {
  final child;
   MySquare({required this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 200,
          color: Colors.deepPurple[200],
          child: Text(child, style: TextStyle(fontSize: 40)),
        ),
    );
  }
}