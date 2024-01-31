import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kode_rx/Components/search_field.dart';
import 'package:kode_rx/Controllers/data_fetch_controller.dart';
import 'package:kode_rx/Pages/rxhistory_pdf_preview.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/database/patient_data.dart';
import 'package:kode_rx/device_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

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

  DateTime parseDate(String dateStr) {
    try {
      return DateFormat.yMMMMd().add_jm().parse(dateStr);
    } catch (e) {
      print('Error parsing date: $e');
      // Handle the error, possibly return a default date or rethrow the exception.
      throw Exception('Error parsing date');
    }
  }

  Future<void> loadPatientData() async {
    try {
      List<PatientModel> patients = await controller.getUserPatientList();
      patients.sort((a, b) => parseDate(b.date).compareTo(parseDate(a.date)));
      patients = patients.where((patients) {
        if (patients.status == '0') {
          return false;
        } else if (patients.status == '1') {
          return true;
        } else {
          return true;
        }
      }).toList();
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
      query = query.trim();
      if (query.isNotEmpty) {
        // Search Function
        patientList = _originalPatientList
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
              child: CircularProgressIndicator(
                color: AppColors.customBackground,
              ),
            )
          : isError
              ? const Center(
                  child: Text('Error loading data. Please try again.'),
                )
              : GestureDetector(
                  onTap: () => {
                    FocusScope.of(context).unfocus(),
                  },
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: CustomSearchField(filterSearchResults: filterSearchResults,),
                      ),
                      const SizedBox(height: 20),
                      patientList.isEmpty
                          ? const Center(
                              child: Text(
                                'No past History Found',
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          : Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  PatientModel patient = patientList[index];
                  
                                  return GestureDetector(
                                    onTap: () => patient.pdfUrl != null
                                        ? _launchUrl(patient.pdfUrl!)
                                        : Get.snackbar('No Pdf Available',
                                            'No pdf available on old patient data'),
                                    child: Center(
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
                                                  color: AppColors
                                                      .customBackground),
                                            ),
                                            subtitle: Text(
                                              'Date: ${patient.date}',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            trailing: const Image(
                                                image: AssetImage(
                                                    'assets/images/ic_rx_prescription_icon.png')),
                                          ),
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
    );
  }

  Future<void> permissionHandle(pdfUrl) async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      print('Storage permission Access');
      Get.to(() => MyPdfViewer(pdfUrl: pdfUrl));

      // Storage permission granted, navigate to the appropriate screen.
    } else {
      // Storage permission denied, handle accordingly.
      // Get.to(() => MyPdfViewer(pdfUrl: pdfUrl));
      print('Storage permission denied');
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
