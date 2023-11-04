// ignore: unused_import
import 'app_colors.dart';
import 'package:flutter/material.dart';

class DoctorCell extends StatelessWidget {
  const DoctorCell(
      {super.key,
      required this.name,
      required this.image,
      required this.profession});
  final String name;
  final String image;
  final String profession;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          height: 90,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 10,
                spreadRadius: 4,
                color: Colors.grey,
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 12.0),
                child: Image.asset(
                  image, // Replace with the actual image path
                  width: 55, // Adjust the width as needed
                  height: 55, // Adjust the height as needed
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        profession,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
