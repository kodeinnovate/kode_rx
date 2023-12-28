import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:kode_rx/Components/alert_dialogue.dart';
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
      int index = selectedMedicines
          .indexWhere((element) => element.name == medicine.name);
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
                height: MediaQuery.of(context).size.height * 0.7,
                child: MedicationListView(
                  displayedMedicines: displayedMedicines,
                  selectedMedicines: selectedMedicines,
                  onSelect: (selectedMedicine) {
                    // if (options.isEmpty) {
                    //   // Navigator.of(context).pop();
                    //   showMedicineTimeDialog(medicine!);
                    // }
                    showSingleChoiceListDialog(selectedMedicine);
                    //showMedicineTimeDialog(selectedMedicine);
                  },
                ),
              ),
              ExpansionTile(
                title: const Text(
                  'Selected Medicines',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.customBackground,
                  ),
                ),
                children: [
                  SizedBox(
                    height: selectedMedicines.isNotEmpty
                        ? MediaQuery.of(context).size.height *
                            0.15 *
                            selectedMedicines.length
                        : 0,
                    child: SelectedMedicationsList(
                      selectedMedicines: selectedMedicines,
                      onDelete: onDeleteMedicine,
                      onEdit: onEditMedicine,
                    ),
                  ),
                ],
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medicine.name,
                style: const TextStyle(
                    fontSize: 20, color: AppColors.customBackground),
              ),
              const Text('Select times to take',
                  style: TextStyle(fontSize: 16, color: Colors.black54))
            ],
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: timeDialogKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CheckboxListTile(
                      title: const Text(
                        'Morning',
                        style: TextStyle(fontSize: 18),
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
                      title: const Text('Afternoon',
                          style: TextStyle(fontSize: 18)),
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
                      title:
                          const Text('Evening', style: TextStyle(fontSize: 18)),
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
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  shadowColor: Colors.grey,
                  elevation: 2),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (timeDialogKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                  showMealDialog(medicine, selectedTimesToTake);
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.customBackground,
                  shadowColor: Colors.grey,
                  elevation: 2),
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
            // SizedBox(width: 4,),
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
    final list = medicine.mgList;
    List<String> options = list.map((dynamic item) => item.toString()).toList();
    if (options.isEmpty) {
      showMedicineTimeDialog(medicine);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return SingleChoiceDialog(
            medicineName: medicine.name,
            options: options,
            onSelected: (value) {
              medicine.mg = value;
            },
            onOkPressed: () {
              showMedicineTimeDialog(medicine);
            },
          );
        },
      );
    }
    // medicine.mg = selectedValue;
  }

// Dialog no.2 // Meal Dialogue
  void showMealDialog(Medicine medicine, List<String> selectedTimesToTake) {
    var mealType = 'before'; // Default value, can be 'before' or 'after'

    final mealDialogKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medicine.name,
                style: const TextStyle(
                    fontSize: 20, color: AppColors.customBackground),
              ),
              const SizedBox(
                height: 2.0,
              ),
              const Text('Select when to take',
                  style: TextStyle(fontSize: 16, color: Colors.black54)),
            ],
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: mealDialogKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Text('Select when to take'),
                    RadioListTile(
                      activeColor: AppColors.customBackground,
                      title: const Text(
                        'Before Meal',
                        style: TextStyle(fontSize: 18),
                      ),
                      value: 'before',
                      groupValue: mealType,
                      onChanged: (value) {
                        setState(() {
                          mealType = value as String;
                        });
                      },
                    ),
                    RadioListTile(
                      activeColor: AppColors.customBackground,
                      title: Text(
                        'After Meal',
                        style: TextStyle(fontSize: 18),
                      ),
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
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
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
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.customBackground),
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

// !Important Data transfer to Generate PDF
  Future<void> pdfDataSubmit() async {
    if (selectedMedicines.isEmpty) {
      Get.snackbar('No medicine Added', "please add medicines");
    } else {
      var isSubmitData = await showAlertPopup();
      if (isSubmitData) {
        final notes = noteController.text.toString().trim();
        PdfController pdfController = PdfController(
          selectedMedicines: selectedMedicines,
          notes: notes,
        );
        pdfController.createAndDisplayPdf();
      }
    }

    // for (var med in selectedMedicines) {
    //   final pdfPrint = ('${med.name}, Time to take: ${med.timesToTake.join(', ')} Meal: ${med.beforeMeal ? 'Before Meal' : 'After Meal'}');
    //   print(pdfPrint);
    // }
  }

  Future<bool> showAlertPopup() async {
    return await showDialog(
            context: Get.overlayContext!,
            builder: (context) => CustomDialog(
                  dialogTitle: 'Confirm',
                  dialogMessage: 'Sure you want to generate prescription?',
                  onLeftButtonPressed: () => Navigator.of(context).pop(false),
                  onRightButtonPressed: () => Navigator.of(context).pop(true),
                )) ??
        false;
  }
}

//Mg Radio buttons
class SingleChoiceDialog extends StatefulWidget {
  final List<String> options;
  final Function(String?) onSelected;
  final VoidCallback? onOkPressed;
  final String? medicineName;

  SingleChoiceDialog({
    required this.options,
    required this.onSelected,
    this.onOkPressed,
    this.medicineName,
  });

  @override
  _SingleChoiceDialogState createState() => _SingleChoiceDialogState();
}

class _SingleChoiceDialogState extends State<SingleChoiceDialog> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.medicineName!,
            style: const TextStyle(
                fontSize: 20, color: AppColors.customBackground),
          ),
          const Text(
            'Select Mg',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          )
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.options.map((option) {
            return RadioListTile<String>(
              activeColor: AppColors.customBackground,
              title: Text(
                option,
                style: const TextStyle(fontSize: 18.0),
              ),
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
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.customBackground),
          onPressed: () {
            widget.onSelected(selectedValue);
            Navigator.of(context).pop();

            // Call the onOkPressed callback if provided
            if (widget.onOkPressed != null) {
              widget.onOkPressed!();
            }
          },
          child: const Text(
            'Next',
            style: TextStyle(color: Colors.white),
          ),
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
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                   suffixIcon: Icon(Icons.search, color: Colors.grey.shade500,),
                    hintText: 'Search Medicine',
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    fillColor: Color.fromARGB(255, 238, 238, 238),
                    enabledBorder: OutlineInputBorder(
                      borderSide:  BorderSide(
                          color: Colors.grey.shade500, width: 2.0),
                      borderRadius: BorderRadius.circular(7.7),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.customBackground, width: 2.0),
                      borderRadius: BorderRadius.circular(7.7),
                    ),
              ),
                onChanged: (query) {
                  query = query.trim();
                  final filteredMedicines = GlobalMedicineList.medicines
                      .where((medicine) => medicine.name
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                  onSearch(filteredMedicines);
                },
              ),
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
  final List mgList;
  String? mg;
  List<String> timesToTake = [];
  bool beforeMeal = false;

  Medicine(
    this.name,
    this.id,
    this.details,
    this.mgList,
  );

  factory Medicine.fromMedicineModel(UserMedicineModel medicineModel) {
    return Medicine(medicineModel.medicineName, medicineModel.id!,
        medicineModel.medicineContent, medicineModel.medicineMgList);
  }
}

class GlobalMedicineList {
  static List<Medicine> medicines = [];
}

List<Medicine> displayedMedicines = [];

class MedicationListView extends StatelessWidget {
  final List<Medicine> displayedMedicines;
  final List<Medicine> selectedMedicines;
  final Function(Medicine) onSelect;

  MedicationListView({
    required this.onSelect,
    required this.displayedMedicines,
    required this.selectedMedicines,
  });

  @override
  Widget build(BuildContext context) {
    displayedMedicines
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return Obx(
      () => UserRepo.instance.medicineLoading.value
          ? const Center(
              child:
                  CircularProgressIndicator(color: AppColors.customBackground),
            )
          : GridView.builder(
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 10),
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
                        // onSelect(displayedMedicines[index]);
                        bool isAlreadySelected = selectedMedicines.any(
                            (selectedMed) => selectedMed.id == medicine.id);

                        if (isAlreadySelected) {
                          // Show a dialog indicating that the medicine is already selected
                          showDuplicateMedicineDialog(context);
                        } else {
                          // Medicine is not already selected, call the onSelect function
                          onSelect(displayedMedicines[index]);
                        }
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

//Duplicate Medicine Dialog
void showDuplicateMedicineDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Already Added'),
        content: const Text('This medicine is already added in the list.'),
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

//Selected medicine tile
// ignore: must_be_immutable
class SelectedMedicationsList extends StatelessWidget {
  final List<Medicine> selectedMedicines;
  final Function(Medicine) onDelete;
  final Function(Medicine) onEdit;
  SelectedMedicationsList(
      {super.key,
      required this.selectedMedicines,
      required this.onDelete,
      required this.onEdit});

  // ...
  String? editedMg;
  bool? editedBeforeMeal;
  List<String>? editedTimesToTake;
  Medicine? _editingMedicine;
  List<String>? options;

  ///Main Edit fuction, the data goes here
  void saveEdited(medicine) {
    Medicine editedMedicine =
        Medicine(medicine.name, medicine.id, medicine.details, medicine.mgList);
    editedMedicine.timesToTake = editedTimesToTake!;
    editedMedicine.beforeMeal = editedBeforeMeal!;
    editedMedicine.mg = editedMg;

    onEdit(editedMedicine);
  }

//Maid Edit Dialogue
  void _showEditDialog(BuildContext context, Medicine medicine) {
    //!Important
    _editingMedicine = medicine;
    options = medicine.mgList.map((dynamic item) => item.toString()).toList();
    editedTimesToTake = List.from(medicine.timesToTake);
    editedBeforeMeal = medicine.beforeMeal;
    editedMg = medicine.mg;
    if (options!.isNotEmpty) {
      _showMgListDialog(context, editedMg, options!, editedTimesToTake!);
    } else {
      _showTimesToTakeDialog(context, editedTimesToTake!);
    }
  }

// Before MealAfterMeal Edit dialogue
  void _beforeAfterMealDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _editingMedicine!.name,
                style: const TextStyle(
                  color: AppColors.customBackground,
                  fontSize: 20.0,
                ),
              ),
              const Text(
                'Select when to take',
                style: TextStyle(color: Colors.black54, fontSize: 16.0),
              )
            ],
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
                      Radio(
                        activeColor: AppColors.customBackground,
                        value: true,
                        groupValue: editedBeforeMeal,
                        onChanged: (value) {
                          setState(() {
                            editedBeforeMeal = value as bool;
                          });
                        },
                      ),
                      const Text(
                        'Before Meal',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: AppColors.customBackground,
                        value: false,
                        groupValue: editedBeforeMeal,
                        onChanged: (value) {
                          setState(() {
                            editedBeforeMeal = value as bool;
                          });
                        },
                      ),
                      const Text(
                        'After Meal',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text(
                'Discard',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                saveEdited(_editingMedicine);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.customBackground),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Edit Mg Dialog
  void _showMgListDialog(BuildContext context, String? currentMgSelection,
      List<String> mgOptions, List<String> editedTimesToTake) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _editingMedicine!.name,
                style: const TextStyle(
                    fontSize: 20, color: AppColors.customBackground),
              ),
              const Text(
                'Select Mg',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Generate radio buttons dynamically based on mgOptions
                  for (String option in mgOptions)
                    Row(
                      children: [
                        Radio<String>(
                          activeColor: AppColors.customBackground,
                          value: option,
                          groupValue: currentMgSelection,
                          onChanged: (value) {
                            setState(() {
                              currentMgSelection = value;
                              editedMg = value!;
                            });
                          },
                        ),
                        Text(
                          option,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Get.off(context);
                Navigator.of(context).pop(); // Close the dialog
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text(
                'Discard',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: AppColors.customBackground),
              onPressed: () {
                Navigator.of(context).pop();
                _showTimesToTakeDialog(context, editedTimesToTake);
                // Close the dialog
              },
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showTimesToTakeDialog(BuildContext context, List<String> timesToTake) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _editingMedicine!.name,
                style: const TextStyle(
                    fontSize: 20.0, color: AppColors.customBackground),
              ),
              const Text(
                'Select times to take',
                style: TextStyle(fontSize: 16.0, color: Colors.black54),
              ),
            ],
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Add form fields for editing times to take using checkboxes
                  CheckboxListTile(
                    activeColor: AppColors.customBackground,
                    title: const Text(
                      'Morning',
                      style: TextStyle(fontSize: 18),
                    ),
                    value: timesToTake.contains('Morning'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          timesToTake.add('Morning');
                        } else {
                          timesToTake.remove('Morning');
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    activeColor: AppColors.customBackground,
                    title:
                        const Text('Afternoon', style: TextStyle(fontSize: 18)),
                    value: timesToTake.contains('Afternoon'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          timesToTake.add('Afternoon');
                        } else {
                          timesToTake.remove('Afternoon');
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    activeColor: AppColors.customBackground,
                    title:
                        const Text('Evening', style: TextStyle(fontSize: 18)),
                    value: timesToTake.contains('Evening'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          timesToTake.add('Evening');
                        } else {
                          timesToTake.remove('Evening');
                        }
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                // saveEdited(_editingMedicine);
                Navigator.of(context).pop(); // Close the dialog
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text(
                'Discard',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _beforeAfterMealDialog(context);
                // saveEdited(_editingMedicine);
              },
              style: TextButton.styleFrom(
                  backgroundColor: AppColors.customBackground),
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

// Delete function
  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, Medicine medicine) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          dialogTitle: 'Delete Medicine',
          dialogMessage: 'Are you sure you want to delete ${medicine.name}?',
          onLeftButtonPressed: () => Navigator.of(context).pop(),
          onRightButtonPressed: () => {
            onDelete(medicine), // Call the onDelete function
            Navigator.of(context).pop(), // Close the dialog
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                    '${medicine.name} ${medicine.mg == null || medicine.mg == '' ? '' : '- ${medicine.mg}'}',
                    style: const TextStyle(
                        fontSize: 20, color: AppColors.customBackground),
                  ),
                  subtitle: Text(
                    'Time to take: ${medicine.timesToTake.isNotEmpty ? medicine.timesToTake.join(', ') : 'No specific time'} | Meal: ${medicine.beforeMeal ? 'Before Meal' : 'After Meal'}',
                    style: const TextStyle(fontSize: 16),
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
}
