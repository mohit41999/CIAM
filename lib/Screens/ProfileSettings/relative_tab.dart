import 'dart:io';

import 'package:flutter/material.dart';
import 'package:patient/Models/patient_profile_model.dart';
import 'package:patient/Models/relative_model.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/ProfileSettingController/personal_setting_controller.dart';
import 'package:patient/controller/ProfileSettingController/relatice_setting_controller.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/widgets/title_enter_field.dart';
import 'package:image_picker/image_picker.dart';

class Relative extends StatefulWidget {
  const Relative({Key? key}) : super(key: key);

  @override
  State<Relative> createState() => _RelativeState();
}

class _RelativeState extends State<Relative> {
  TextStyle titleStyle =
      TextStyle(color: apptealColor, fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle contentStyle =
      TextStyle(color: appblueColor, fontSize: 14, fontWeight: FontWeight.bold);
  RelativeSettingController _con = RelativeSettingController();
  bool loading = true;
  late RelativeModel relativeData;

  void initialize() {
    _con.getrelativedata(context).then((value) {
      setState(() {
        relativeData = value;
        loading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  (relativeData.data.length == 0)
                      ? Container()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: relativeData.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(10),
                                  child: ExpansionTile(
                                    title: Text(
                                        relativeData.data[index].relativeName),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 2),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Relation:',
                                                  style: titleStyle,
                                                )),
                                            Expanded(
                                              child: Text(
                                                relativeData
                                                    .data[index].relation,
                                                style: contentStyle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 2),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Gender:',
                                                  style: titleStyle,
                                                )),
                                            Expanded(
                                              child: Text(
                                                relativeData.data[index].gender,
                                                style: contentStyle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 2),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'BloodGroup:',
                                                  style: titleStyle,
                                                )),
                                            Expanded(
                                              child: Text(
                                                relativeData
                                                    .data[index].bloodGroup,
                                                style: contentStyle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 2),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Age:',
                                                  style: titleStyle,
                                                )),
                                            Expanded(
                                                child: Text(
                                              relativeData.data[index].age,
                                              style: contentStyle,
                                            )),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Marital Status:',
                                                  style: titleStyle,
                                                )),
                                            Expanded(
                                              child: Text(
                                                relativeData
                                                    .data[index].maritalStatus,
                                                style: contentStyle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                          }),
                  (_con.isSelected)
                      ? Column(
                          children: [
                            TitleEnterField(
                                'Relation', 'Relation', _con.relation),
                            TitleEnterField('Relative Name', 'Relative Name',
                                _con.relative_name),
                            TitleEnterField(
                              'Age',
                              'Age',
                              _con.age,
                              textInputType: TextInputType.number,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2.0),
                              child: Align(
                                child: Text(
                                  'Gender',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              child: Material(
                                elevation: 5,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  height: 50,
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  width: double.infinity,
                                  child: DropdownButton(
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    underline: Container(),
                                    dropdownColor: Colors.white,

                                    isExpanded: true,

                                    // Initial Value
                                    hint: Text(
                                      'Gender',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),

                                    // Array list of items
                                    items: _con.genderType.map((Map items) {
                                      return DropdownMenuItem(
                                        value: items['value'],
                                        child: Text(items['type']),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (newValue) {
                                      setState(() {
                                        print(newValue);
                                        _con.dropDownvalue =
                                            newValue.toString();
                                        _con.gender.text = _con.dropDownvalue;
                                      });
                                    },
                                    value: _con.dropDownvalue,
                                  ),
                                ),
                              ),
                            ),
                            TitleEnterField(
                                'Blood Group', 'Blood Group', _con.bloodGroup),
                            TitleEnterField('Marital Status', 'Marital Status',
                                _con.maritalStatus),
                          ],
                        )
                      : Container(),
                  (_con.isSelected == false)
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: commonBtn(
                              borderRadius: 10,
                              s: 'Add Relative',
                              bgcolor: appblueColor,
                              textColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  _con.isSelected = true;

                                  // (_con.isSelected)
                                  //     ? _con.submit(context).then((value) {
                                  //   setState(() {
                                  //     initialize();
                                  //   });
                                  // })
                                  //     : () {};
                                });
                              }),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: commonBtn(
                              borderRadius: 10,
                              s: 'Add Relative',
                              bgcolor: appblueColor,
                              textColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  _con.submit(context).then((value) {
                                    setState(() {
                                      initialize();
                                    });
                                  });
                                });
                              }),
                        ),
                  SizedBox(
                    height: navbarht + 20,
                  ),
                ],
              ),
            ),
    );
  }
}
