import 'app_colors.dart';
import 'package:flutter/material.dart';


class CatageroieCell extends StatelessWidget {
  const CatageroieCell({super.key, required this.title, required this.image});
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 130.0,
        child: Card(
            color: AppColors.backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.network(
                    image, // Replace with the actual image path
                    width: 60, // Adjust the width as needed
                    height: 60, // Adjust the height as needed
                  ),
                ),
                // Padding(padding: EdgeInsets.symmetric(horizontal: 7), child: Divider(height: 10, thickness: 2,),),
                Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 18),
                    ))
              ],
            )),
      ),
    );
  }
}
