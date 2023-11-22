import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/device_helper.dart';


class MedicationReminderApp extends StatelessWidget {
  static MedicationReminderApp get instance => Get.find();
  @override
  Widget build(BuildContext context) {
    return  MedicationListScreen();
  }
}

class MedicationListScreen extends StatefulWidget {
  @override
  _MedicationListScreenState createState() => _MedicationListScreenState();
}

class _MedicationListScreenState extends State<MedicationListScreen> {
  List<Medicine> medicines = [];
  List<Medicine> selectedMedicines = [];

  @override
  void initState() {
    super.initState();

    // Add dummy medicine data
    medicines = [
      Medicine('Medicine A'),
      Medicine('Medicine B'),
      Medicine('Medicine C'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeviceHelper.deviceAppBar(title: 'Medicine'),
      body: Column(
        children: [
          SearchField(
            medicines: medicines,
            onSearch: (filteredMedicines) {
              setState(() {
                medicines = filteredMedicines;
              });
            },
          ),
          MedicationListView(
            medicines: medicines,
            onSelect: (selectedMedicine) {
              showMedicineTimeDialog(selectedMedicine);
            },
          ),
          SelectedMedicationsList(
            selectedMedicines: selectedMedicines,
          ),
        ],
      ),
    );
  }

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
          title: Text(medicine.name),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: timeDialogKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Select times to take:'),
                    CheckboxListTile(
                      title: Text('Morning'),
                      value: isMorningSelected,
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
                      title: Text('Afternoon'),
                      value: isAfternoonSelected,
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
                      title: Text('Evening'),
                      value: isEveningSelected,
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
              child: Text('Next'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
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
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class SearchField extends StatelessWidget {
  final List<Medicine> medicines;
  final Function(List<Medicine>) onSearch;

  SearchField({required this.medicines, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: 'Search Medicine'),
      onChanged: (query) {
        final filteredMedicines = medicines
            .where((medicine) =>
            medicine.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        onSearch(filteredMedicines);
      },
    );
  }
}

class Medicine {
  final String name;
  List<String> timesToTake = [];
  bool beforeMeal = false;

  Medicine(this.name);
}

class MedicationListView extends StatelessWidget {
  final List<Medicine> medicines;
  final Function(Medicine) onSelect;

  MedicationListView({required this.medicines, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
        itemCount: medicines.length,
        itemBuilder: (context, index) {
      return ListTile(
        title: Text(medicines[index].name),
        onTap: () {
          onSelect(medicines[index]);
        },
      );
    },
    ));
  }
}

class SelectedMedicationsList extends StatelessWidget {
  final List<Medicine> selectedMedicines;

  SelectedMedicationsList({required this.selectedMedicines});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Selected Medicines:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        for (var medicine in selectedMedicines)
          ListTile(
            title: Text(medicine.name),
            subtitle: Text(
              'Time to take: ${medicine.timesToTake.isNotEmpty ? medicine.timesToTake.join(', ') : 'No specific time'} | Meal: ${medicine.beforeMeal ? 'Before Meal' : 'After Meal'}',
            ),
          ),
      ],
    );
  }
}
