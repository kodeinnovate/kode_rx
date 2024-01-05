import 'package:get/get.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/data_state_store.dart';
import 'package:kode_rx/database/doctor_medicine_data.dart';
import 'package:kode_rx/database/medicine_data_fetch.dart';
import 'package:kode_rx/database/patient_data.dart';

class DataController extends GetxController {
  static DataController get instance => Get.find();
  UserController userController = Get.put(UserController());
  final _userRepo = Get.put(UserRepo());
// final userId = userController.userId.value;
  Future<List<MedicineModel>> getAllMedicine() async {
    return await _userRepo.getMedicineList();
  }
//Gets the user specific medicine
  Future<List<UserMedicineModel>> getUserMedicines() async {
    
    final userId = userController.userId.value;
    return await _userRepo.getUserMedicines(userId);
  }

  Future<List<PatientModel>> getUserPatientList() async {
    final userId = userController.userId.value;
    return await _userRepo.getUserPatients(userId);
  }

}
