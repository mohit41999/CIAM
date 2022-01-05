import 'package:flutter/material.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:patient/controller/ProfileSettingController/medical_setting_controller.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/title_enter_field.dart';

class Medical extends StatefulWidget {
  const Medical({Key? key}) : super(key: key);

  @override
  State<Medical> createState() => _MedicalState();
}

class _MedicalState extends State<Medical> {
  MedicalSettingController _con = MedicalSettingController();

  @override
  void initState() {
    // TODO: implement initState

    _con.initialize(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        children: [
          TitleEnterField(
            'Details of allergies',
            'Details of allergies',
            _con.details_of_allergies,
            maxLines: 10,
          ),
          TitleEnterField(
            'Current & Past Medications',
            'Current & Past Medications',
            _con.current_and_past_medication,
            maxLines: 10,
          ),
          TitleEnterField(
            'Past surgery or injury',
            'Past surgery or injury',
            _con.past_surgery_injury,
            maxLines: 10,
          ),
          TitleEnterField(
            'Any chronic disease',
            'Any chronic disease',
            _con.chronic_disease,
            maxLines: 10,
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: commonBtn(
              s: 'Submit',
              bgcolor: appblueColor,
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  _con.submit(context);
                });
              },
              borderRadius: 8,
              textSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
