import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Components/custom_button.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/database/medicine_data_fetch.dart';
import 'package:kode_rx/device_helper.dart';

class AddNewMedicine extends StatelessWidget {
  AddNewMedicine({super.key});
  static AddNewMedicine get instance => Get.find();
  final userRepository = Get.put(UserRepo());
  final medicineNameController = TextEditingController();
  final medicineDetailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeviceHelper.deviceAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Medicine Name'),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: medicineNameController,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Medicine Details'),
          TextField(
            controller: medicineDetailController,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButtom(buttonText: 'Submit', onTap: medicineDataStore)
        ]),
      ),
    );
  }

  Future<void> medicineDataStore() async {
    print(medicineDetailController.text.toString().trim());
    print(medicineNameController.text.toString().trim());
    final medicine = MedicineModel(
        medicineName: medicineNameController.text.toString().trim(),
        medicineDetails: medicineDetailController.text.toString().trim());
    await userRepository.addMedicine(medicine);
  }
}
