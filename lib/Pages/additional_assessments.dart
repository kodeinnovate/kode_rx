import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kode_rx/Components/custom_button.dart';
import 'package:kode_rx/Components/custom_tile.dart';
import 'package:kode_rx/Pages/custom_search.dart';
import 'package:kode_rx/app_colors.dart';
import 'package:kode_rx/device_helper.dart';
import 'package:kode_rx/select_medicenes.dart';

class AdditionalAssessments extends StatefulWidget {
  const AdditionalAssessments({super.key});
  static AdditionalAssessments get instance => Get.find();

  @override
  State<AdditionalAssessments> createState() => _AdditionalAssessmentsState();
}

class _AdditionalAssessmentsState extends State<AdditionalAssessments> {
  double iconsize = 35.0;
  Color iconColor = AppColors.customBackground;
  late List<Map<String, dynamic>> tileData;

  @override
  void initState() {
    super.initState();

    // Initialize tileData in initState
    tileData = [
      {
        'tileTitle': 'Findings',
        'icon': Icon(
          Icons.search_rounded,
          size: iconsize,
          color: iconColor,
        ),
      },
      {
        'tileTitle': 'Investigation',
        'icon': Icon(
          Icons.inbox,
          size: iconsize,
          color: iconColor,
        ),
      },
      {
        'tileTitle': 'Diagnosis',
        'icon': Icon(
          Icons.note_add_rounded,
          size: iconsize,
          color: iconColor,
        ),
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeviceHelper.deviceAppBar(title: 'Additional Assessments'),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tileData.length,
              itemBuilder: ((context, index) => CustomTile(
                    tileTitle: tileData[index]['tileTitle'],
                    icon: tileData[index]['icon'],
                    onTap: () => Get.to(() => AssessmentSelection(
                          title: tileData[index]['tileTitle'],
                        )),
                  )),
            ),
          ),
          CustomButtom(buttonText: 'Next', onTap: onTap),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  void onTap() {
    Get.to(() => MedicationReminderApp());
  }
}
