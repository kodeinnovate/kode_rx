import 'app_colors.dart';
import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 25,),
            //Container 1
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                  child: Center(child: Text('Hello Pedo')),
                ),
              ),
            ),
             SizedBox(height: 25,),
             //Container 2
               Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                  child: Center(child: Text('Hello Pedo')),
                ),
              ),
            ),
            Row(
          children: [
            SizedBox(height: 25,),
            //Container 1
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                  child: Center(child: Text('Hello Pedo')),
                ),
              ),
            ),
             SizedBox(height: 25,),
             //Container 2
               Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                  child: Center(child: Text('Hello Pedo')),
                ),
              ),
            ),
          ],
        ),
          ],
        ),
      ),
    );
  }
}
