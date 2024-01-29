import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Components/custom_button.dart';
import 'package:kode_rx/Components/custom_textfield.dart';
import 'package:kode_rx/Components/custom_tile.dart';
import 'package:kode_rx/Components/search_field.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/device_helper.dart';

class AssessmentSelection extends StatefulWidget {
  final String? title;
  AssessmentSelection({super.key, this.title});
  static AssessmentSelection get instance => Get.find();
  final searchText = TextEditingController();

  @override
  State<AssessmentSelection> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<AssessmentSelection> {
  List<String> diagnosis = [
    'Abdominal pain',
    'Acne-other',
    'cavity',
    'fissure',
    'ARDS',
  ];

  List<String> findings = [
    'Allergy',
    'Asthama',
    'Cancer',
    'Anamoly Scan',
    'Abortion'
  ];

  List<String> investigation = ['ACL - lgG', 'AFP', 'Anti HCV', 'ASO'];

  List<String> selectedTileData = [];

  late List<String> currentList;
  late List<String> filteredList;
  // The list to be displayed
  @override
  void initState() {
    super.initState();
    if (widget.title == 'Findings') {
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

//   void filterSearchResults(String query) {
//   setState(() {
//     if (query.isEmpty) {
//        print("Query is empty. Resetting filteredList.");
//       // If the query is empty, show the entire list
//       filteredList = currentList.toList();
//     } else {
//       // Filter the list based on the query
//       filteredList = currentList
//           .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//   });
// }

  @override
  Widget build(BuildContext context) {
    bool isAlreadySelected;
    return Scaffold(
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.customBackground,),
        onPressed: () => print(selectedTileData),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Add',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
      appBar: DeviceHelper.deviceAppBar(title: widget.title),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: CustomSearchField(
                filterSearchResults: filterSearchResults,
                controller: widget.searchText,
              )),
              if (filteredList.isEmpty)
                CustomButtom(
                  buttonText: 'Add',
                  onTap: () => {
                    setState(() {
                      final trimmedText = widget.searchText.text
                          .toString()
                          .trim()
                          .capitalizeFirst!;
                      currentList.insert(0, trimmedText);
                      widget.searchText.clear();
                      filteredList = List.from(currentList);
                      selectedTileData.add(trimmedText);
                    }),
                  },
                  margin: 4.0,
                )
            ],
          ),
        ),
        Flexible(
          flex: selectedTileData.isEmpty ? 1 : selectedTileData.length * 3,
          child: ListView.builder(
            itemCount: selectedTileData.length,
            itemBuilder: (context, index) {
              return CustomTile(
                tileTitle: selectedTileData[index],
                trailingIcon: GestureDetector(
                    onTap: () => setState(
                        () => selectedTileData.remove(selectedTileData[index])),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              );
            },
          ),
        ),
        // Container(
        //   padding: EdgeInsets.symmetric(vertical: 10.0),
        //   width: MediaQuery.of(context).size.width,
        //   decoration: BoxDecoration(
        //       border: Border.symmetric(
        //     horizontal: BorderSide(
        //       color: Colors.grey.shade400,
        //       width: 1.0, // Adjust the width as needed
        //     ),
        //   )),
        //   child: Text('All'),
        // ),
        Flexible(
          flex: filteredList.length * 2,
          child: ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => {
                isAlreadySelected = selectedTileData.any(
                    (selectedTitle) => selectedTitle == filteredList[index]),
                if (isAlreadySelected)
                  {duplicateDialogue(context)}
                else
                  {
                    setState(() {
                      selectedTileData.add(filteredList[index]);
                    }),
                    print(selectedTileData)
                  }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    // color: Colors.white,
                    border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1.0, // Adjust the width as needed
                  ),
                )),
                height: 70,
                // color: Colors.grey.shade200,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    filteredList[index],
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ),
            // itemBuilder: ((context, index) => CustomTile(
            //       tileTitle: filteredList[index],
            //       onTap: () => {
            //         isAlreadySelected = selectedTileData.any(
            //             (selectedTitle) =>
            //                 selectedTitle == filteredList[index]),
            //         if (isAlreadySelected)
            //           {duplicateDialogue(context)}
            //         else
            //           {
            //             setState(() {
            //               selectedTileData.add(filteredList[index]);
            //             }),
            //             print(selectedTileData)
            //           }
            //       },
            //     )),
          ),
        ),
      ]),
    );
  }

//   void addCustomTile(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5.0)),
//             title: Text('Add Custom ${widget.title}'),
//             content: CustomTextfield(hintText: 'Add ${widget.title}', obsecureText: false, keyboardType: TextInputType.name),
//             actions: <Widget>[
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.customBackground),
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close the dialog
//                 },
//                 child: const Text(
//                   'OK',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           );
//         });
//   }
}

void duplicateDialogue(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        title: const Text('Already Added'),
        // content: const Text('This medicine is already added in the list.'),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.customBackground),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
