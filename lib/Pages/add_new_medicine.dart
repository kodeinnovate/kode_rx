import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Components/add_mg_widget.dart';
import 'package:kode_rx/Components/custom_button.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/database/doctor_medicine_data.dart';
import 'package:kode_rx/device_helper.dart';
import 'package:kode_rx/select_medicenes.dart';

class AddNewMedicine extends StatefulWidget {
  AddNewMedicine({Key? key});
  static AddNewMedicine get instance => Get.find();
  @override
  State<AddNewMedicine> createState() => _AddNewMedicineState();
}

class _AddNewMedicineState extends State<AddNewMedicine> {
  UserController userController = Get.put(UserController());
  final userRepository = Get.put(UserRepo());

  final medicineNameController = TextEditingController();
  final medicineContentController = TextEditingController();
  final medicineMgController = TextEditingController();
  final medicineTypeController = TextEditingController();

  List<String> medicineTypes = [
    'Cream',
    'Ointement',
    'Tablet',
  ];

  String? selectedMedicineType;

  void after() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeviceHelper.deviceAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(
              children: [
                const ListTile(
                  title: Text(
                    'Medicine Name',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: medicineNameController,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            // borderSide: BorderSide(color: AppColors.customBackground),
                            ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Enter Medicine Name',
                        hintStyle: TextStyle(color: Colors.grey[500])),
                  ),
                ),
              ],
            ),
            const ListTile(
              title: Text('Medicine Details', style: TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: medicineContentController,
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        // borderSide: BorderSide(color: AppColors.customBackground),
                        ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Enter Medicine details',
                    hintStyle: TextStyle(color: Colors.grey[500])),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: const TextFieldWithList(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Medicine Type',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          // borderSide: BorderSide(color: AppColors.customBackground),
                          ),
                      //     fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Enter Medicine details',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedMedicineType,
                        iconSize: 30,
                        itemHeight: 50,
                        isExpanded: true,
                        items: medicineTypes.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedMedicineType = newValue;
                            if (newValue != null) {
                              medicineTypeController.text = newValue;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            CustomButtom(buttonText: 'Submit', onTap: medicineDataStore),
          ],
        ),
      ),
    );
  }



  Future<void> medicineDataStore() async {
    try {
      final medName = medicineNameController.text.toString().trim();
      final medContent = medicineContentController.text.toString().trim();
      final medmg = userController.mgList.value;
      final medType = medicineTypeController.text.toString().trim();
      print('$medName, $medContent, $medmg, $medType');
      final userId = userController.userId.value;
      if (medName == '' || medName.isEmpty) {
        Get.snackbar('Add Medicine Name',
            'Medicine name is required to be saved into the database');
      } else {
        // if (sourceScreen == 'MedicationReminderAppScreen') {
          if(userController.isMedicineSelected.value) {
          Get.back();
          }
        // }
        final medicine = UserMedicineModel(
          medicineName: medName,
          medicineContent: medContent,
          medicineMgList: medmg,
          medicineType: medType,
          status: '1',
        );
        await userRepository.addMedicineForUser(userId, medicine);
        // Get.put(() => MedicationReminderApp());
      }
    } catch (e) {
      print('SomeThing Went wrong $e');
      Get.snackbar('Error', 'Something went wrong, $e');
    } finally {
      //  await Future.delayed(const Duration(seconds: 6));
      await userRepository.refreshMedicines();
      // await userRepository.getUserMedicines(userController.userId.value);
    }
  }
}
