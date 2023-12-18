import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kode_rx/Controllers/data_fetch_controller.dart';
import 'package:kode_rx/Controllers/pdf_controller.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/Pages/pdf_genarater.dart';
import 'package:kode_rx/Pages/pdf_preview_screen.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/database/doctor_medicine_data.dart';
import 'package:kode_rx/database/medicine_data_fetch.dart';
import 'package:kode_rx/database/patient_data.dart';
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
final userRepository = Get.put(UserRepo());
final controller = Get.put(DataController());
final PDFGenerator pdfGenerator = Get.find<PDFGenerator>();

// PdfController pdfController = Get.put(PdfController());


class _MedicationListScreenState extends State<MedicationListScreen> {
  UserController userController = Get.put(UserController());
  final noteController = TextEditingController();
  
  
  
  // List<Medicine> medicines = [];
  List<Medicine> selectedMedicines = [];

  // Function to handle deletion
  void onDeleteMedicine(Medicine medicine) {
    setState(() {
      selectedMedicines.remove(medicine);
    });
  }

   void onEditMedicine(Medicine medicine) {
    setState(() {
      // Find the index of the medicine in the selectedMedicines list
      int index = selectedMedicines.indexWhere((element) => element.name == medicine.name);
      if (index != -1) {
        // Update the medicine at the found index
        selectedMedicines[index] = medicine;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    
// final userId = userController.userId.value;
    // Fetch all medicines from the database and set them initially
    controller.getUserMedicines().then((medicineData) {
      setState(() {
        GlobalMedicineList.medicines = medicineData
            .map((medicineModel) => Medicine.fromMedicineModel(medicineModel))
            .toList();

        // Set displayedMedicines initially to show all medicines
        displayedMedicines = GlobalMedicineList.medicines;
print(userController.patientName.value);
      //   DateTime currentDate = DateTime.now();
      //  String formattedDate = DateFormat.yMMMMd().add_jm().format(currentDate);
      //  userController.formatedDate.value = formattedDate;
      //  print('Formatted date $formattedDate');
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
                height: MediaQuery.of(context).size.height * 0.42,
                child: MedicationListView(
                  onSelect: (selectedMedicine) {
                    showSingleChoiceListDialog(selectedMedicine);
                    //showMedicineTimeDialog(selectedMedicine);
                  },
                ),
              ),
              SizedBox(
                  child: Container(
                      width: double.infinity,
                      color: AppColors.customBackground,
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        'Selected Medicines',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.27,
                child: SelectedMedicationsList(
                  selectedMedicines: selectedMedicines,
                  onDelete: onDeleteMedicine,
                  onEdit: onEditMedicine,
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

  // Function to show single choice list dialog

// Usage in your showSingleChoiceListDialog function
  void showSingleChoiceListDialog(Medicine medicine) {
    List<String> options = ["10Mg", "20Mg", "30Mg", "40Mg"];
    String? selectedValue;

    showDialog(
      context: context,
      builder: (context) {
        return SingleChoiceDialog(
          options: options,
          onSelected: (value) {
            selectedValue = value;
          },
          onOkPressed: () {
            // Call the showMedicineTimeDialog function with the selected value
            if (selectedValue != null) {
              showMedicineTimeDialog(medicine!);
            }
          },
        );
      },
    );
  }



// Dialog no.2 // Meal Dialogue
  void showMealDialog(Medicine medicine, List<String> selectedTimesToTake) {
    var mealType = 'before'; // Default value, can be 'before' or 'after'

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
                    RadioListTile(
                      title: Text('Before Meal'),
                      value: 'before',
                      groupValue: mealType,
                      onChanged: (value) {
                        setState(() {
                          mealType = value as String;
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('After Meal'),
                      value: 'after',
                      groupValue: mealType,
                      onChanged: (value) {
                        setState(() {
                          mealType = value as String;
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
                  medicine.beforeMeal = mealType == 'before';
                  setState(() {
                    selectedMedicines.add(medicine);
                  });
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(backgroundColor: Colors.orange),
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
  Future<void> pdfDataSubmit()  async {
    final patientData = PatientModel(
      patientName: userController.patientName.value,
      patientAge: userController.patientAge.value,
      patientGender: userController.patientGender.value,
      pastHistory: userController.patientPastHistory.value,
      phoneNumber: userController.patientPhoneNo.value
    );
    print('Data here ${userController.patientName.value}, ${userController.patientAge.value}');
       
    if (selectedMedicines.isEmpty) {
      Get.snackbar('No medicine Added', "please add medicines");
    } else {
      final notes = noteController.text.toString().trim();
      // Get.to(() => PDFGenerator(
      //       selectedMedicines: selectedMedicines,
      //       notes: noteController.text.toString().trim(),
      //     ))
    // await userRepository.addPatientDetails(userController.userId.value, patientData);
    PdfController pdfController = PdfController(selectedMedicines: selectedMedicines, notes: notes, );
      pdfController.createAndDisplayPdf();
    }

    // for (var med in selectedMedicines) {
    //   final pdfPrint = ('${med.name}, Time to take: ${med.timesToTake.join(', ')} Meal: ${med.beforeMeal ? 'Before Meal' : 'After Meal'}');
    //   print(pdfPrint);
    // }
  }
}
class SingleChoiceDialog extends StatefulWidget {
  final List<String> options;
  final Function(String?) onSelected;
  final VoidCallback? onOkPressed;

  SingleChoiceDialog({
    required this.options,
    required this.onSelected,
    this.onOkPressed,
  });

  @override
  _SingleChoiceDialogState createState() => _SingleChoiceDialogState();
}

class _SingleChoiceDialogState extends State<SingleChoiceDialog> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Value'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.options.map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            widget.onSelected(selectedValue);
            Navigator.of(context).pop();

            // Call the onOkPressed callback if provided
            if (widget.onOkPressed != null) {
              widget.onOkPressed!();
            }
          },
          child: Text('OK'),
        ),
      ],
    );
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
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                style: TextStyle(fontSize: 18),
                // decoration: const InputDecoration(labelText: 'Search Medicine', contentPadding: EdgeInsets.symmetric(vertical: 25.0),),
                decoration: InputDecoration(
                    // icon: Icon(Icons.search),
                    hintText: 'Search Medicine',
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    fillColor: Color.fromARGB(255, 238, 238, 238),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.customBackground, width: 2.0),
                      borderRadius: BorderRadius.circular(7.7),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.customBackground, width: 2.0),
                      borderRadius: BorderRadius.circular(7.7),
                    ),
                    focusColor: Colors.red),
                onChanged: (query) {
                  final filteredMedicines = GlobalMedicineList.medicines
                      .where((medicine) => medicine.name
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
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

  factory Medicine.fromMedicineModel(UserMedicineModel medicineModel) {
    return Medicine(
      medicineModel.medicineName,
      medicineModel.id!,
      medicineModel.medicineContent,
    );
  }
}

class GlobalMedicineList {
  static List<Medicine> medicines = [];
}

List<Medicine> displayedMedicines = [];

class MedicationListView extends StatelessWidget {
  final Function(Medicine) onSelect;

  MedicationListView({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio:
            3 / 2.3, // Adjust the aspect ratio based on your needs
      ),
      itemCount: displayedMedicines.length,
      itemBuilder: (context, index) {
        Medicine medicine = displayedMedicines[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
          child: Material(
            borderRadius: BorderRadius.circular(10.0),
            elevation: 5,
            child: ListTile(
              tileColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              title: Text(
                medicine.name,
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                medicine.details,
                style: const TextStyle(fontSize: 16.0),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
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
  }
}

//Selected medicine tile
class SelectedMedicationsList extends StatelessWidget {
  final List<Medicine> selectedMedicines;
  final Function(Medicine) onDelete;
  final Function(Medicine) onEdit;

  SelectedMedicationsList(
      {required this.selectedMedicines, required this.onDelete, required this.onEdit});

  // ...
void _showEditDialog(BuildContext context, Medicine medicine) {
  showDialog(
    context: context,
    builder: (context) {
      // Create controllers for editing times and meal preference
      List<String> editedTimesToTake = List.from(medicine.timesToTake);
      bool editedBeforeMeal = medicine.beforeMeal;

      return AlertDialog(
        title: Text('Edit Medicine'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Display the current times to take
                Text('Current times to take: ${editedTimesToTake.join(', ')}'),

                // Add form fields for editing times and meal preference
                // (You may want to include additional fields as needed)
                Row(
                  children: [
                    Radio(
                      value: true,
                      groupValue: editedBeforeMeal,
                      onChanged: (value) {
                        setState(() {
                          editedBeforeMeal = value as bool;
                        });
                      },
                    ),
                    Text('Before Meal'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: false,
                      groupValue: editedBeforeMeal,
                      onChanged: (value) {
                        setState(() {
                          editedBeforeMeal = value as bool;
                        });
                      },
                    ),
                    Text('After Meal'),
                  ],
                ),
                // Add form fields for editing other times if needed
              ],
            );
          },
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              // Perform the edit operation and update the medicine
              Medicine editedMedicine = Medicine(
                medicine.name,
                medicine.id,
                medicine.details,
              );
              editedMedicine.timesToTake = editedTimesToTake;
              editedMedicine.beforeMeal = editedBeforeMeal;
              
              // Call the onEdit function with the edited medicine
              onEdit(editedMedicine);

              Navigator.of(context).pop(); // Close the dialog
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}



// Delete function
   Future<void> _showDeleteConfirmationDialog(BuildContext context, Medicine medicine) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Medicine'),
          content: Text('Are you sure you want to delete ${medicine.name}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete(medicine); // Call the onDelete function
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }   

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
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  tileColor: Colors.grey.shade200,
                  title: Text(
                    medicine.name,
                    style: const TextStyle(
                        fontSize: 20, color: AppColors.customBackground),
                  ),
                  subtitle: Text(
                    'Time to take: ${medicine.timesToTake.isNotEmpty ? medicine.timesToTake.join(', ') : 'No specific time'} | Meal: ${medicine.beforeMeal ? 'Before Meal' : 'After Meal'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: AppColors.customBackground,
                        ),
                        onPressed: () {
                          _showEditDialog(context, medicine);
                          // Handle edit action
                          // You can implement the edit functionality here
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.customBackground,
                        ),
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, medicine);
                        },
                      ),
                    ],
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
