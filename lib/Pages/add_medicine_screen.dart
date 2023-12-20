// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kode_rx/Components/custom_button.dart';
// import 'package:kode_rx/Controllers/user_repo.dart';
// import 'package:kode_rx/data_state_store.dart';
// import 'package:kode_rx/database/doctor_medicine_data.dart';
// import 'package:kode_rx/database/medicine_data_fetch.dart';
// import 'package:kode_rx/device_helper.dart';

// class AddNewMedicine extends StatelessWidget {
//   AddNewMedicine({super.key});
//   static AddNewMedicine get instance => Get.find();
//   UserController userController = Get.put(UserController());
//   final userRepository = Get.put(UserRepo());
//   final medicineNameController = TextEditingController();
//   final medicineContentController = TextEditingController();
//   final medicineMgController = TextEditingController();
//   final medicineTypeController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: DeviceHelper.deviceAppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           const Text('Medicine Name'),
//           const SizedBox(
//             height: 10,
//           ),
//           TextField(
//             controller: medicineNameController,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           const Text('Medicine Details'),
//           TextField(
//             controller: medicineContentController,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           const Text('Medicine Mg'),
//           TextField(
//             controller: medicineMgController,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           const Text('Medicine Type'),
//           TextField(
//             controller: medicineTypeController,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           CustomButtom(buttonText: 'Submit', onTap: medicineDataStore)
//         ]),
//       ),
//     );
//   }

//   Future<void> medicineDataStore() async {
//     print(medicineContentController.text.toString().trim());
//     print(medicineNameController.text.toString().trim());
//     final userId = userController.userId.value;
//     final medicine = UserMedicineModel(
//         medicineName: medicineNameController.text.toString().trim(),
//         medicineContent: medicineContentController.text.toString().trim(), medicineMg: medicineMgController.text.toString().trim(), medicineType: medicineTypeController.text.toString().trim(), status: '');
//     await userRepository.addMedicineForUser(userId, medicine);
//   }
// }
