import 'package:get/get.dart';
import 'package:kode_rx/Controllers/user_repo.dart';
import 'package:kode_rx/database/medicine_data_fetch.dart';

class DataController extends GetxController {
  static DataController get instance => Get.find();
  final _userRepo = Get.put(UserRepo());

  Future<List<MedicineModel>> getAllMedicine() async {
    return await _userRepo.getMedicineList();
  }
}
