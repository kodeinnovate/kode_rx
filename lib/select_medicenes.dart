import 'package:flutter/material.dart';

class SelectMedicineScreen extends StatefulWidget {
  @override
  _SelectMedicineScreenState createState() => _SelectMedicineScreenState();
}

class _SelectMedicineScreenState extends State<SelectMedicineScreen> {
  List<String> suggestedMedicines = [
    'Medicine A',
    'Medicine B',
    'Medicine C',
    'Medicine D',
  ];
  List<String> selectedMedicines = [];
  String selectedMedicine = "";
  String selectedTime = "Morning";
  String selectedMealPreference = "Before Meal";
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Medicines'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Search for Medicines'),
              onChanged: (value) {
                setState(() {
                  selectedMedicine = value;
                });
              },
            ),
            if (selectedMedicine.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemCount: suggestedMedicines.length,
                itemBuilder: (context, index) {
                  final medicine = suggestedMedicines[index];
                  if (medicine.toLowerCase().contains(selectedMedicine.toLowerCase())) {
                    return ListTile(
                      title: Text(medicine),
                      onTap: () {
                        setState(() {
                          selectedMedicines.add(medicine);
                          // Clear the search field after selection
                          selectedMedicine = "";
                        });
                      },
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: selectedMedicines.length,
              itemBuilder: (context, index) {
                final medicine = selectedMedicines[index];
                return ListTile(
                  title: Text(medicine),
                  onTap: () {
                    setState(() {
                      selectedMedicines.removeAt(index);
                    });
                  },
                );
              },
            ),
            DropdownButton<String>(
              value: selectedTime,
              onChanged: (value) {
                setState(() {
                  selectedTime = value!;
                });
              },
              items: ["Morning", "Afternoon", "Evening"].map((time) {
                return DropdownMenuItem(
                  value: time,
                  child: Text(time),
                );
              }).toList(),
            ),
            Column(
              children: <Widget>[
                Text('Select Meal Preference:'),
                Row(
                  children: <Widget>[
                    Radio(
                      value: "Before Meal",
                      groupValue: selectedMealPreference,
                      onChanged: (value) {
                        setState(() {
                          selectedMealPreference = value!;
                        });
                      },
                    ),
                    Text('Before Meal'),
                    Radio(
                      value: "After Meal",
                      groupValue: selectedMealPreference,
                      onChanged: (value) {
                        setState(() {
                          selectedMealPreference = value!;
                        });
                      },
                    ),
                    Text('After Meal'),
                  ],
                ),
              ],
            ),
            TextField(
              controller: notesController,
              decoration: InputDecoration(labelText: 'Additional Notes'),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  print('Selected Medicines: $selectedMedicines');
                  print('Time: $selectedTime');
                  print('Meal Preference: $selectedMealPreference');
                  print('Notes: ${notesController.text}');
                },
                child: Text('Print'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
