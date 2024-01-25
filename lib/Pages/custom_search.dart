import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Components/custom_tile.dart';
import 'package:kode_rx/Components/search_field.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/device_helper.dart';

class CustomSearch extends StatefulWidget {
  final String? title;
  const CustomSearch({super.key, this.title});
  static CustomSearch get instance => Get.find();

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  List<String> diagnosis = ['Abdominal pain', 'Acne-other', 'cavity','fissure','ARDS',];

  List<String> findings = ['Allergy', 'Asthama', 'Cancer','Anamoly Scan','Abortion'];

  List<String> investigation = ['ACL - lgG', 'AFP', 'Anti HCV', 'Anti HSV','ASO'];

  late List<String> currentList; 
    late List<String> filteredList;
 // The list to be displayed
  @override
  void initState() {
    super.initState();
    if(widget.title == 'Findings') {
      currentList = findings;
    } 
    if (widget.title == 'Investigation') {
      currentList = investigation;
    } 
    if (widget.title == 'Diagnosis') {
    currentList = diagnosis; // Initial list

    }

    filteredList = List.from(currentList);
  }

  void filterSearchResults(String query) {
    setState(() {
      // Filter the list based on the query
      filteredList = currentList
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeviceHelper.deviceAppBar(title: widget.title),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          CustomSearchField(filterSearchResults: filterSearchResults),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: ((context, index) => GestureDetector(
                onTap: () => {print(filteredList[index])},
                child: CustomTile(
                      tileTitle: filteredList[index], onTap: () => Get.snackbar(filteredList[index], 'Message'),
                    ),
              )),
            ),
          ),
        ]),
      ),
    );
  }
}
