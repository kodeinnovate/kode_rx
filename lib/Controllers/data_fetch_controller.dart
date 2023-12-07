import 'package:get/get.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/database/medicine_data_fetch.dart';
import 'package:kode_rx/select_medicenes.dart';

class DataController extends GetxController {
  static DataController get instance => Get.find();
  final _userRepo = Get.put(UserRepo());

  Future<List<MedicineModel>> getAllMedicine() async {
    return await _userRepo.getMedicineList();
  }

  // Future<List<Medicine>> getAllMedicine() async {
  //   List<MedicineModel> medicineModels = await _userRepo.getMedicineList();

  //   // Convert MedicineModel to Medicine
  //   List<Medicine> medicines = medicineModels.map((model) {
  //     return Medicine(model.id!, model.medicineName);
  //   }).toList();

  //   return medicines;
  // }

  
}
