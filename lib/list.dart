import 'package:flutter/material.dart';

class List extends StatefulWidget {
  @override
  State<List> createState() => _ListState();
}

class _ListState extends State<List> {
  @override
  Widget build(BuildContext context) {
    var arrnames = ['rashid', 'shoeb', 'mohsin', 'anas', 'o', 'x', 'y', 'z'];
    return Scaffold(
        appBar: AppBar(
          title: Text('List view'),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return Center(
              child: Card(
                elevation: 10,
                shadowColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title:Text(arrnames[index]) ,
                    leading: CircleAvatar(backgroundImage: AssetImage('assets/images/2606517_5856.jpg'),radius: 30),
                    subtitle:Text('Employee') ,
                  ),
                ),
              ),
            );
          },
          itemCount: arrnames.length,
          separatorBuilder: (context, index) {
            return const Divider(
              height: 25,
              thickness: 1,
            );
          },
        ));
  }
}
