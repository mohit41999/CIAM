import 'dart:io';

import 'package:flutter/material.dart';
import 'package:patient/Models/patient_profile_model.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/ProfileSettingController/personal_setting_controller.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/widgets/title_enter_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Personal extends StatefulWidget {
  const Personal({Key? key}) : super(key: key);

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  PersonalSettingController _con = PersonalSettingController();
  bool loading = true;
  Future initialize(BuildContext context) async {
    _con.getdata(context).then((Profile) {
      setState(() {
        _con.oldname = Profile.data.firstName + ' ' + Profile.data.lastName;
        _con.firstname.text = Profile.data.firstName;
        _con.lastname.text = Profile.data.lastName;
        _con.email.text = Profile.data.email;
        _con.contactno.text = Profile.data.mobileNumber;
        _con.DOB.text = Profile.data.dob.toString();
        _con.bloodGroup.text = Profile.data.bloodGroup;
        _con.maritalStatus.text = Profile.data.maritalStatus;
        _con.height.text = Profile.data.height;
        _con.weight.text = Profile.data.weight;
        _con.emergencycontact.text = Profile.data.emergencyContact;
        _con.address.text = Profile.data.address;
        _con.age.text = Profile.data.age;
        _con.profileImage = Profile.data.profile;
        _con.gender.text = Profile.data.gender;
        Profile.data.gender == 'Male'
            ? _con.dropDownvalue = 'm'
            : _con.dropDownvalue = 'f';
        loading = false;
      });
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
        DateTime.now().year - 100,
      ),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
          data: ThemeData().copyWith(
            dialogBackgroundColor: appblueColor,
            colorScheme: ColorScheme.dark(
                primary: Colors.white,
                surface: appblueColor,
                onSurface: Colors.white,
                onPrimary: appblueColor),
          ),
          child: child!),
    );
    if (pickedDate != null)
      setState(() {
        // date = pickedDate;
        _con.DOB.text = pickedDate.toString();
        _con.age.text = (DateTime.now().year - pickedDate.year).toString();
        //
        print(pickedDate);
      });
  }

  @override
  void initState() {
    // TODO: implement initState

    initialize(context);

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
                  TitleEnterField('Firstname', 'Firstname', _con.firstname),
                  TitleEnterField('Lastname', 'Lastname', _con.lastname),
                  TitleEnterField('Email id', 'Email id', _con.email),
                  TitleEnterField(
                      'Contact Number', 'Contact Number', _con.contactno),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'DOB',
                      style: TextStyle(
                          fontSize: 14, color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 2.0),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 20.0),
                            child: Text(
                              _con.DOB.text.substring(0, 10),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TitleEnterField(
                    'Age',
                    'Age',
                    _con.age,
                    readonly: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    child: Align(
                      child: Text(
                        'Gender',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
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
                              fontWeight: FontWeight.bold, color: Colors.black),
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
                              _con.dropDownvalue = newValue.toString();
                              _con.gender.text = _con.dropDownvalue;
                              print(_con.gender.text);
                            });
                          },
                          value: _con.dropDownvalue,
                        ),
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: commonBtn(
                  //     height: 50,
                  //     borderWidth: 2,
                  //     textSize: 12,
                  //     s: _con.DOB.text.substring(0, 10),
                  //     bgcolor: Colors.white,
                  //     textColor: Colors.black.withOpacity(0.6),
                  //     onPressed: () {
                  //       _selectDate(context).then((value) {
                  //         setState(() {});
                  //       });
                  //     },
                  //     borderRadius: 10,
                  //   ),
                  // ),
                  // GestureDetector(
                  //     onTap: () {
                  //       _selectDate(context);
                  //     },
                  //     child: TitleEnterField(
                  //       'DOB',
                  //       'DOB',
                  //       _con.DOB,
                  //       readonly: true,
                  //     )),
                  TitleEnterField(
                      'Blood Group', 'Blood Group', _con.bloodGroup),
                  TitleEnterField(
                      'Marital status', 'Marital status', _con.maritalStatus),
                  TitleEnterField('Height', 'Height', _con.height),
                  TitleEnterField('Weight', 'Weight', _con.weight),
                  TitleEnterField(
                    'Emergency contact',
                    'Emergency contact',
                    _con.emergencycontact,
                    textInputType: TextInputType.number,
                  ),
                  TitleEnterField(
                    'Address',
                    'Address',
                    _con.address,
                    maxLines: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 130,
                      child: Row(
                        children: [
                          (loading)
                              ? Center(child: CircularProgressIndicator())
                              : Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: (_con.mediaFile != null)
                                                ? FileImage(
                                                    File(_con.mediaFile!.path))
                                                : NetworkImage(
                                                        _con.profileImage)
                                                    as ImageProvider,

                                            // (_con.mediaFile==null)? NetworkImage(_con.profileImage):,
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Update Profile',
                                  style: GoogleFonts.montserrat(
                                      color: Color(0xff161616).withOpacity(0.6),
                                      fontSize: 15),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: commonBtn(
                                    s: 'Choose new photo',
                                    bgcolor: Color(0xffB2B1B1),
                                    textColor: Colors.black,
                                    onPressed: () {
                                      setState(() {
                                        _showPicker(context);
                                      });
                                    },
                                    width: 187,
                                    height: 30,
                                    borderRadius: 4,
                                    textSize: 12,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
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
                          if (_con.age.text == '0') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Please Select Date of Birth')));
                          } else if (_con.height.text == '0') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Please Enter Height')));
                          } else if (_con.weight.text == '0') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Please Enter Weight')));
                          } else if (_con.bloodGroup.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Please Enter Blood Group')));
                          } else if (_con.maritalStatus.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Please Enter Marital Status')));
                          } else if (_con.address.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Please Enter Address')));
                          } else {
                            _con.submit(context);
                          }
                        });
                      },
                      borderRadius: 8,
                      textSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: navbarht + 20,
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _showPicker(context) async {
    showModalBottomSheet(
        context: context,
        useRootNavigator: false,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              height: double.maxFinite,
              child: ListView(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Photo Library'),
                      onTap: () {
                        setState(() {
                          _imgFromGallery();
                        });

                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      setState(() {
                        _imgFromCamera();
                      });

                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    height: navbarht + 20,
                  )
                ],
              ),
            ),
          );
        });
  }

  Future _imgFromCamera() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _con.mediaFile = image;
    });
  }

  Future _imgFromGallery() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _con.mediaFile = image;
    });
  }
}
