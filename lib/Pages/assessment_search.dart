import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Components/custom_button.dart';
import 'package:kode_rx/Components/custom_tile.dart';
import 'package:kode_rx/Components/search_field.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/Pages/additional_assessments.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/device_helper.dart';
import 'package:kode_rx/select_medicenes.dart';

// ignore: must_be_immutable
class AssessmentSelection extends StatefulWidget {
  final String? title;
  final Function()? onTap;
  AssessmentSelection({super.key, this.title, this.onTap});
  static AssessmentSelection get instance => Get.find();
  final userRepository = Get.put(UserRepo());
  UserController userController = Get.put(UserController());
  final searchText = TextEditingController();

  @override
  State<AssessmentSelection> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<AssessmentSelection> {
  late bool findingBool = widget.title == 'Findings';
  late List<String> diagnosis = widget.userController.dbDiagnosisList.toList();

  late List<String> findings = widget.userController.dbFindingsList.toList();

  late List<String> chiefComplaints =
      widget.userController.dbChiefComplaintsList.toList();

  late List<String> investigation =
      widget.userController.dbInvestigationList.toList();

  List<String> selectedTileData = [];
  late List<String> currentList;
  late List<String> filteredList;
  List<String> hollowList = [];
  // The list to be displayed
  @override
  void initState() {
    super.initState();
    // 1) Switch Statement to check if which options is selected, option that included are 'Findings', 'Diagnosis', 'Investigation' and Chief Complaints'.
    // 2) current list is updated according to the selected options(Findings', 'Diagnosis', 'Investigation' and Chief Complaints).
    // 3) selected items in the list is saved globaly using state management.
    switch (widget.title) {
      case 'Findings':
        List<String> tempFindings =
            widget.userController.findings.toList().isNotEmpty
                ? widget.userController.findings.toList()
                : <String>[];
        currentList = findings;
        selectedTileData = tempFindings;
        break;
      case 'Investigation':
        List<String> tempInvestigation =
            widget.userController.investigation.toList().isNotEmpty
                ? widget.userController.investigation.toList()
                : <String>[];
        currentList = investigation;
        selectedTileData = tempInvestigation;
        break;
      case 'Diagnosis':
        List<String> tempDiagnosis =
            widget.userController.diagnosis.toList().isNotEmpty
                ? widget.userController.diagnosis.toList()
                : <String>[];
        currentList = diagnosis;
        selectedTileData = tempDiagnosis;
        break;
      case 'Chief Complaints':
        List<String> tempCheifComplaints =
            widget.userController.diagnosis.toList().isNotEmpty
                ? widget.userController.diagnosis.toList()
                : <String>[];
        currentList = chiefComplaints;
        selectedTileData = tempCheifComplaints;
        break;
      default:
        currentList = hollowList;
    }
    filteredList = List.from(currentList);
  }

  void filterSearchResults(String query) {
    setState(() {
      // Filter the list based on the query
      filteredList = currentList
          .where(
              (item) => item.toLowerCase().contains(query.toLowerCase().trim()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAlreadySelected;
    return Scaffold(
      // floatingActionButton:  Container(
      //   margin: const EdgeInsets.only(left: 30),
      //   height: 70,
      //   width: MediaQuery.of(context).size.width,
      //   child: CustomButtom(
      //     margin: 0,
      //       buttonText: selectedTileData.isEmpty ? 'skip' : 'Add',
      //       onTap: onTap,
      //     ),
      // ),
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
                  onTap: () async => {
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
                    switch (widget.title) {
                      'Findings' => {
                          await userRepository.updateList(
                              currentList, 'Findings'),
                          currentList = findings
                        },
                      'Investigation' => {
                          await userRepository.updateList(
                              currentList, 'Investigation'),
                          currentList = investigation,
                        },
                      'Diagnosis' => {
                          await userRepository.updateList(
                              currentList, 'Diagnosis'),
                          currentList = diagnosis,
                        },
                      'Chief Complaints' => {
                          await userRepository.updateList(
                              currentList, 'ChiefComplaints'),
                          currentList = chiefComplaints,
                        },
                      // TODO: Handle this case.
                      String() => currentList = hollowList,
                      // TODO: Handle this case.
                      null => currentList = hollowList,
                    },
                  },
                  margin: 4.0,
                )
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              if(selectedTileData.isNotEmpty) 
              Container(
                margin: EdgeInsets.only(top: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.customBackground,
                    border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1.0, // Adjust the width as needed
                  ),
                )),
                child: const Text('Selected', style: TextStyle(color: Colors.white),),
              ),
               
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: selectedTileData.length,
                itemBuilder: (context, index) {
                  return CustomTile(
                    tileTitle: selectedTileData[index],
                    trailingIcon: GestureDetector(
                        onTap: () => setState(() =>
                            selectedTileData.remove(selectedTileData[index])),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                    verticalPadding: 6.0,
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.customBackground,
                    border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1.0, // Adjust the width as needed
                  ),
                )),
                child: const Text('All', style: TextStyle(color: Colors.white),),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: filteredList.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => {
                    isAlreadySelected = selectedTileData.any((selectedTitle) =>
                        selectedTitle == filteredList[index]),
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
            ]),
          ),
        ),
        CustomButtom(
          buttonText: selectedTileData.isEmpty ? 'skip' : 'Add',
          onTap: onTap,
        ),
        const SizedBox(
          height: 20,
        )
      ]),
      
    );
  }

  void onTap() {
    if (widget.title == 'Findings') {
      widget.userController.findings.value = selectedTileData;
    } else if (widget.title == 'Investigation') {
      widget.userController.investigation.value = selectedTileData;
    } else if (widget.title == 'Diagnosis') {
      widget.userController.diagnosis.value = selectedTileData;
    } else if (widget.title == 'Chief Complaints') {
      widget.userController.chiefComplaints.value = selectedTileData;
    } else {
      return;
    }
    Get.to(() => const AdditionalAssessments());
  }
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
