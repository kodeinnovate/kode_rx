import 'app_colors.dart';
import 'package:flutter/material.dart';

class CatageroieCell extends StatelessWidget {
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
                  padding: EdgeInsets.all(20.0),
                  child: Image.asset(
                    'assets/images/kodeinnovate.png', // Replace with the actual image path
                    width: 60, // Adjust the width as needed
                    height: 60, // Adjust the height as needed
                  ),
                ),
                // Padding(padding: EdgeInsets.symmetric(horizontal: 7), child: Divider(height: 10, thickness: 2,),),
                
              const  Padding(padding: EdgeInsets.all(20.0), child: Text('Checkup', style: TextStyle(fontSize: 18),))
              ],
            )),
      ),
    );
  }
}
