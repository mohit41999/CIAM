import 'dart:io';

import 'package:flutter/material.dart';
import 'package:patient/Models/patient_profile_model.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/ProfileSettingController/personal_setting_controller.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/widgets/title_enter_field.dart';
import 'package:image_picker/image_picker.dart';

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
        _con.firstname.text = Profile.data.firstName;
        _con.lastname.text = Profile.data.lastName;
        _con.email.text = Profile.data.email;
        _con.contactno.text = Profile.data.mobileNumber;
        _con.gender.text = Profile.data.gender;
        _con.DOB.text = Profile.data.dob.toString();
        _con.bloodGroup.text = Profile.data.bloodGroup;
        _con.maritalStatus.text = Profile.data.maritalStatus;
        _con.height.text = Profile.data.height;
        _con.weight.text = Profile.data.weight;
        _con.emergencycontact.text = Profile.data.emergencyContact;
        _con.address.text = Profile.data.address;
        _con.age.text = Profile.data.age;
        _con.profileImage = Profile.data.profile;
        loading = false;
      });
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TitleEnterField('Firstname', 'Firstname', _con.firstname),
            TitleEnterField('Lastname', 'Lastname', _con.lastname),
            TitleEnterField('Email id', 'Email id', _con.email),
            TitleEnterField('Contact Number', 'Contact Number', _con.contactno),
            TitleEnterField('Age', 'Age', _con.age),
            TitleEnterField('Gender', 'Gender', _con.gender),
            TitleEnterField('DOB', 'DOB', _con.DOB),
            TitleEnterField('Blood Group', 'Blood Group', _con.bloodGroup),
            TitleEnterField(
                'Marital status', 'Marital status', _con.maritalStatus),
            TitleEnterField('Height', 'Height', _con.height),
            TitleEnterField('Weight', 'Weight', _con.weight),
            TitleEnterField('Emergency contact', 'Emergency contact',
                _con.emergencycontact),
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
                                          : NetworkImage(_con.profileImage)
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
                    _con.submit(context);
                  });
                },
                borderRadius: 8,
                textSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showPicker(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
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
