import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Controllers/data_fetch_controller.dart';
import 'package:kode_rx/Pages/pdf_genarater.dart';
import 'package:kode_rx/Pages/pdf_preview_screen.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/database/medicine_data_fetch.dart';
import 'package:kode_rx/device_helper.dart';

class MedicationReminderApp extends StatelessWidget {
  static MedicationReminderApp get instance => Get.find();

  @override
  Widget build(BuildContext context) {
    return MedicationListScreen();
  }
}

class MedicationListScreen extends StatefulWidget {
  @override
  _MedicationListScreenState createState() => _MedicationListScreenState();
}

// class MedicineList {
//   String? medicine;
//   String? medicineDescription;

//   MedicineList({this.medicine, this.medicineDescription}); // Constructor
// }
final controller = Get.put(DataController());
final PDFGenerator pdfGenerator = Get.find<PDFGenerator>();

class _MedicationListScreenState extends State<MedicationListScreen> {
  UserController userController = UserController();
  final noteController = TextEditingController();
  // List<Medicine> medicines = [];
  List<Medicine> selectedMedicines = [];

  @override
  void initState() {
    super.initState();

    // Fetch all medicines from the database and set them initially
    controller.getAllMedicine().then((medicineData) {
      setState(() {
        GlobalMedicineList.medicines = medicineData
            .map((medicineModel) => Medicine.fromMedicineModel(medicineModel))
            .toList();

        // Set displayedMedicines initially to show all medicines
        displayedMedicines = GlobalMedicineList.medicines;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeviceHelper.deviceAppBar(title: 'Select Medicine'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SearchField(
                medicines: GlobalMedicineList.medicines,
                onSearch: (filteredMedicines) {
                  print("Filtered Medicines: $filteredMedicines");
                  setState(() {
                    displayedMedicines = filteredMedicines;
                  });
                  print("Display Medicines: $displayedMedicines");
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.49,
                child: MedicationListView(
                  onSelect: (selectedMedicine) {
                    showMedicineTimeDialog(selectedMedicine);
                  },
                ),
              ),
              const Text(
                'Selected Medicines',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.17,
                child: SelectedMedicationsList(
                  selectedMedicines: selectedMedicines,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: TextField(
                        controller: noteController,
                        // obscureText: obsecureText,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.customBackground),
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            hintText: 'Add a note here',
                            hintStyle: TextStyle(color: Colors.grey[500])),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: pdfDataSubmit,
                    child: Container(
                      width: 150,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          color: AppColors.customBackground,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

// Popup menu for routine Selection
  void showMedicineTimeDialog(Medicine medicine) {
    var selectedTimesToTake = <String>[];
    var isMorningSelected = false;
    var isAfternoonSelected = false;
    var isEveningSelected = false;

    final timeDialogKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            medicine.name,
            style: const TextStyle(fontSize: 30),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: timeDialogKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Select times to take:'),
                    CheckboxListTile(
                      title: Text(
                        'Morning',
                        style: TextStyle(fontSize: 24),
                      ),
                      value: isMorningSelected,
                      activeColor: AppColors.customBackground,
                      onChanged: (value) {
                        setState(() {
                          isMorningSelected = value!;
                          updateSelectedTimes(
                            'Morning',
                            isMorningSelected,
                            selectedTimesToTake,
                          );
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Afternoon', style: TextStyle(fontSize: 24)),
                      value: isAfternoonSelected,
                      activeColor: AppColors.customBackground,
                      onChanged: (value) {
                        setState(() {
                          isAfternoonSelected = value!;
                          updateSelectedTimes(
                            'Afternoon',
                            isAfternoonSelected,
                            selectedTimesToTake,
                          );
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Evening', style: TextStyle(fontSize: 24)),
                      value: isEveningSelected,
                      activeColor: AppColors.customBackground,
                      onChanged: (value) {
                        setState(() {
                          isEveningSelected = value!;
                          updateSelectedTimes(
                            'Evening',
                            isEveningSelected,
                            selectedTimesToTake,
                          );
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (timeDialogKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                  showMealDialog(medicine, selectedTimesToTake);
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shadowColor: Colors.grey,
                  elevation: 2),
              child: Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
            // SizedBox(width: 4,),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shadowColor: Colors.grey,
                  elevation: 2),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void updateSelectedTimes(
    String time,
    bool selected,
    List<String> selectedTimes,
  ) {
    if (selected) {
      selectedTimes.add(time);
    } else {
      selectedTimes.remove(time);
    }
  }

// Dialog no.2 // Meal Dialogue
  void showMealDialog(Medicine medicine, List<String> selectedTimesToTake) {
    var isBeforeMeal = false;

    final mealDialogKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Meal Information'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: mealDialogKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Select when to take before or after meal:'),
                    CheckboxListTile(
                      title: Text('Before Meal'),
                      value: isBeforeMeal,
                      onChanged: (value) {
                        setState(() {
                          isBeforeMeal = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('After Meal'),
                      value: !isBeforeMeal,
                      onChanged: (value) {
                        setState(() {
                          isBeforeMeal = !value!;
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (mealDialogKey.currentState!.validate()) {
                  medicine.timesToTake = selectedTimesToTake;
                  medicine.beforeMeal = isBeforeMeal;
                  setState(() {
                    selectedMedicines.add(medicine);
                  });
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'Discard',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

// !Important Data transfer to Generate PDF
  void pdfDataSubmit() {
    if (selectedMedicines.isEmpty) {
      Get.snackbar('No medicine Added', "please add medicines");
    } else {
      Get.to( () => PDFGenerator(
            selectedMedicines: selectedMedicines,
            notes: noteController.text.toString().trim(),
          ));
    }
    // for (var med in selectedMedicines) {
    //   final pdfPrint = ('${med.name}, Time to take: ${med.timesToTake.join(', ')} Meal: ${med.beforeMeal ? 'Before Meal' : 'After Meal'}');
    //   print(pdfPrint);
    // }
  }
}

//Search Field
class SearchField extends StatelessWidget {
  final List<Medicine> medicines;
  final Function(List<Medicine>) onSearch;

  SearchField({required this.medicines, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                style: TextStyle(fontSize: 25),
                // decoration: const InputDecoration(labelText: 'Search Medicine', contentPadding: EdgeInsets.symmetric(vertical: 25.0),),
                decoration: InputDecoration(
                    // icon: Icon(Icons.search),
                    hintText: 'Search Medicine',
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    fillColor: Color.fromARGB(255, 238, 238, 238),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.customBackground, width: 2.0),
                      borderRadius: BorderRadius.circular(7.7),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.customBackground, width: 2.0),
                      borderRadius: BorderRadius.circular(7.7),
                    ),
                    focusColor: Colors.red),
                onChanged: (query) {
                  print("Query: $query");
                  print(
                      "Medicine Count: ${medicines.length}");
                  print("aaaaaaa : $medicines");
                  final filteredMedicines = GlobalMedicineList.medicines
                      .where((medicine) => medicine.name
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                  print(filteredMedicines.length);
                  onSearch(filteredMedicines);
                },
              ),
              //  const SizedBox(height: 20.0),
            ],
          ),
        ),
      ],
    );
  }
}

class Medicine {
  final String id;
  final String name;
  final String details;
  List<String> timesToTake = [];
  bool beforeMeal = false;

  Medicine(this.name, this.id, this.details);

  factory Medicine.fromMedicineModel(MedicineModel medicineModel) {
    return Medicine(
      medicineModel.medicineName,
      medicineModel.id!,
      medicineModel.medicineDetails,
    );
  }
}

class GlobalMedicineList {
  static List<Medicine> medicines = [];
}
 List<Medicine> displayedMedicines = [];


class MedicationListView extends StatelessWidget {
  // final List<Medicine> medicines;
  final Function(Medicine) onSelect;

// Medicine Grid below the search bar
  MedicationListView({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: controller.getAllMedicine(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       if (snapshot.hasData) {
    //         List<MedicineModel> medicineData = snapshot.data!;
    //         GlobalMedicineList.medicines = medicineData
    //             .map((medicineModel) =>
    //                 Medicine.fromMedicineModel(medicineModel))
    //             .toList();
    //         // displayedMedicines = GlobalMedicineList.medicines;
    //         print("Displayed Medicines Count: ${displayedMedicines.length}");
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: displayedMedicines.length,
              itemBuilder: (context, index) {
                Medicine medicine = displayedMedicines[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 10),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 5,
                    child: ListTile(
                      tileColor: const Color.fromARGB(255, 173, 205, 255),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      title: Text(
                        medicine.name,
                        style: const TextStyle(fontSize: 26),
                        textAlign: TextAlign.center,
                      ),
                      // ignore: prefer_const_constructors
                      subtitle: Container(
                        height: 130,
                        child: Text(
                          'Content: ${medicine.details}',
                          style: const TextStyle(fontSize: 20.0),
                          // textAlign: TextAlign.justify,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusColor: Colors.greenAccent,
                      onTap: () {
                        onSelect(displayedMedicines[index]);
                      },
                    ),
                  ),
                );
              },
            );
    //       } else if (snapshot.hasError) {
    //         return Center(
    //           child: Text(snapshot.error.toString()),
    //         );
    //       } else {
    //         return const Center(
    //           child: Text('Something went wrong'),
    //         );
    //       }
    //     } else {
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //   },
    // );
  }
}

//Selected medicine tile
class SelectedMedicationsList extends StatelessWidget {
  final List<Medicine> selectedMedicines;

  SelectedMedicationsList({required this.selectedMedicines});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //  const Text(
          //     'Selected Medicines:',
          //     style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          //   ),
          for (var medicine in selectedMedicines)
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Material(
                borderRadius: BorderRadius.circular(5.0),
                elevation: 2,
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  tileColor: Colors.grey.shade200,
                  title: Text(
                    medicine.name,
                    style: TextStyle(
                        fontSize: 24, color: AppColors.customBackground),
                  ),
                  subtitle: Text(
                    'Time to take: ${medicine.timesToTake.isNotEmpty ? medicine.timesToTake.join(', ') : 'No specific time'} | Meal: ${medicine.beforeMeal ? 'Before Meal' : 'After Meal'}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
  // void printStatement() {
  //   print(Medicine);
  // }
}
