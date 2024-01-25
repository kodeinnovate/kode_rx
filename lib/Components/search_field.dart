import 'package:flutter/material.dart';
import 'package:kode_rx/app_colors.dart';

class CustomSearchField extends StatelessWidget {
  final Function(String) filterSearchResults;

  const CustomSearchField({super.key, required this.filterSearchResults});

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextField(
              style: const TextStyle(fontSize: 20),
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
                  borderRadius: BorderRadius.circular(7.7),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: AppColors.customBackground, width: 2.0),
                  borderRadius: BorderRadius.circular(7.7),
                ),
              ),
              onChanged: filterSearchResults,
            ),
          );
  }

}