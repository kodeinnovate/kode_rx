import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Pages/custom_search.dart';

class CustomTile extends StatelessWidget {
  final String tileTitle;
  final Widget? icon;
  final Widget? trailingIcon;
  final Function()? onTap;
  const CustomTile({super.key, required this.tileTitle, this.icon, this.onTap, this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Card(
          surfaceTintColor: Colors.white38,
          // color: Colors.white,
          elevation: 7.0,
          // shadowColor: Colors.grey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 6.0, vertical: 20.0),
            child: ListTile(
              leading: icon,
              title: Text(
                tileTitle,
                style: const TextStyle(fontSize: 24),
              ),
              trailing: trailingIcon,
            ),
          ),
        ),
      ),
    );
  }
}
