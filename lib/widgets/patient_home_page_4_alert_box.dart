import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/alertTextField.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/widgets/title_enter_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future addCare(
  BuildContext context,
  String name,
  String email,
  String phone,
  String care_requirement,
  String address,
) async {
  var loader = ProgressView(context);
  loader.show();
  late Map<String, dynamic> data;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await PostData(PARAM_URL: 'add_home_care_requirements.php', params: {
    'token': Token,
    'user_id': prefs.getString('user_id'),
    'name': name,
    'email': email,
    'phone': phone,
    'care_requirement': care_requirement,
    'address': address
  }).then((value) {
    loader.dismiss();
    (value['status'])
        ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value['message']),
            backgroundColor: apptealColor,
          ))
        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value['message']),
            backgroundColor: Colors.red,
          ));
    data = value;
    print(name +
        '\n' +
        email +
        '\n' +
        phone +
        '\n' +
        care_requirement +
        '\n' +
        address);
  });
}

void patientpg4alertbox(BuildContext context,
    {required TextEditingController careController,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController phonenumberController,
    required TextEditingController addressController}) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          backgroundColor: Color(0xffF1F1F1),
          elevation: 0,
          insetPadding: EdgeInsets.all(15),
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Find In-Home Care Near You',
                    style: GoogleFonts.montserrat(
                        color: appblueColor, fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(
                  //   width: 15,
                  // ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close)),
                ],
              ),
              Divider(color: Colors.grey),
            ],
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            color: Color(0xffF1F1F1),
            //padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  alertTextField(
                      controller: careController,
                      label: 'What is the care requirement?',
                      textFieldtext: 'Enter Care required'),
                  SizedBox(
                    height: 10,
                  ),
                  alertTextField(
                      controller: nameController,
                      label: 'Name',
                      textFieldtext: 'Enter Full Name'),
                  SizedBox(
                    height: 10,
                  ),
                  alertTextField(
                      controller: emailController,
                      label: 'Email',
                      textFieldtext: 'Enter Email Id'),
                  SizedBox(
                    height: 10,
                  ),
                  alertTextField(
                      controller: phonenumberController,
                      label: 'Phone Number',
                      textFieldtext: 'Enter Phone Number'),
                  SizedBox(
                    height: 10,
                  ),
                  alertTextField(
                      controller: addressController,
                      label: 'Address',
                      textFieldtext: 'Address'),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: commonBtn(
                      s: 'Submit Care',
                      bgcolor: Color(0xff161616).withOpacity(0.6),
                      textColor: Colors.white,
                      onPressed: () {
                        print(careController.text);
                        addCare(
                                context,
                                nameController.text,
                                emailController.text,
                                phonenumberController.text,
                                careController.text,
                                addressController.text)
                            .then((value) {
                          nameController.clear();
                          emailController.clear();
                          phonenumberController.clear();
                          careController.clear();
                          addressController.clear();
                          Pop(context);
                        });
                      },
                      height: 40,
                      width: 115,
                      borderRadius: 4,
                      textSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )));
}
