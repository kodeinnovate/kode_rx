import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Controllers/data_fetch_controller.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/database/patient_data.dart';
import 'package:kode_rx/device_helper.dart';

class RxHistory extends StatefulWidget {
  const RxHistory({Key? key}) : super(key: key);
  static RxHistory get instance => Get.find();

  @override
  _RxHistoryState createState() => _RxHistoryState();
}

class _RxHistoryState extends State<RxHistory> {
  List<PatientModel> patientList = [];
  List<PatientModel> _originalPatientList =
      []; // Added to store the original patient list
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    loadPatientData();
  }

  final controller = Get.put(DataController());

  Future<void> loadPatientData() async {
    try {
      List<PatientModel> patients = await controller.getUserPatientList();
      setState(() {
        patientList = patients;
        _originalPatientList = patients; // Store the original patient list
        isLoading = false;
      });
    } catch (error) {
      print('Error loading patient data: $error');
      Get.snackbar(
          'Something went wrong', 'Error loading patient data: $error');
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  void filterSearchResults(String query) {
    setState(() {
      if (query.isNotEmpty) {
        //Search Function
        patientList = patientList
            .where((patient) =>
                patient.patientName
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                patient.phoneNumber.contains(query))
            .toList();
      } else {
        // If the query is empty, display the original patient list
        patientList = [..._originalPatientList];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeviceHelper.deviceAppBar(title: 'Rx History'),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : isError
              ? const Center(
                  child: Text('Error loading data. Please try again.'),
                )
              : GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextField(
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.customBackground),
                                ),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                hintText: 'Search',
                                hintStyle: TextStyle(color: Colors.grey[500])),
                            onChanged: filterSearchResults,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              PatientModel patient = patientList[index];

                              return Center(
                                child: Card(
                                  surfaceTintColor: Colors.white60,
                                  // color: Colors.white,
                                  elevation: 10,
                                  // shadowColor: Colors.grey,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: Text(
                                        patient.patientName,
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: AppColors.customBackground),
                                      ),
                                      subtitle: Text(
                                        'Date: ${patient.date}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      // trailing: const CircleAvatar(
                                      //   backgroundImage: AssetImage(
                                      //     'assets/images/ic_rx_prescription_icon.png', // Replace with the actual path to your image
                                      //   ),
                                      //   radius: 30,
                                      // ),
                                      trailing: const Image(
                                          image: AssetImage(
                                              'assets/images/ic_rx_prescription_icon.png')),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: patientList.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 5.0,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
