import 'package:flutter/material.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/select_medicenes.dart';

class CustomSearchField extends StatelessWidget {
  final Function(String) filterSearchResults;
  final TextEditingController? controller;

  const CustomSearchField({super.key, required this.filterSearchResults, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 20),
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.search,
          color: Colors.grey.shade500,
        ),
        hintText: 'Search',
        filled: true,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        fillColor: Color.fromARGB(255, 238, 238, 238),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade500, width: 2.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: AppColors.customBackground, width: 2.0),
          borderRadius: BorderRadius.circular(7.7),
        ),
      ),
      onChanged: filterSearchResults,
    );
  }

}