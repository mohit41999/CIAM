import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/title_enter_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactUsForm extends StatefulWidget {
  const ContactUsForm({Key? key}) : super(key: key);

  @override
  State<ContactUsForm> createState() => _ContactUsFormState();
}

class _ContactUsFormState extends State<ContactUsForm> {
  void clearControllers() {
    emailId.clear();
    firstname.clear();
    lastname.clear();
    description.clear();
    contactNo.clear();
  }

  Future submit() async {
    var loader = ProgressView(context);
    var response;
    if (firstname.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('First Name Required'),
        backgroundColor: Colors.red,
      ));
    } else if (lastname.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Last Name Required'), backgroundColor: Colors.red));
    } else if (contactNo.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Contact Number Required'),
          backgroundColor: Colors.red));
    } else if (emailId.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Email Id Required'), backgroundColor: Colors.red));
    } else if (description.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Enter Description'), backgroundColor: Colors.red));
    } else {
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        loader.show();
        response = await PostData(PARAM_URL: 'contact_us.php', params: {
          'token': '123456789',
          'user_id': preferences.getString('user_id'),
          'first_name': firstname.text,
          'last_name': lastname.text,
          'contact_number': contactNo.text,
          'email': emailId.text,
          'description': description.text
        });
        loader.dismiss();
        if (response['status']) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('request submitted successfully'),
            backgroundColor: apptealColor,
          ));
          clearControllers();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response['message']),
            backgroundColor: Colors.red,
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error try again later'),
          backgroundColor: Colors.red,
        ));
        loader.dismiss();
        print(e);
      }
    }
  }

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonAppBarTitle(),
        leading: commonAppBarLeading(
            iconData: Icons.arrow_back_ios_new,
            onPressed: () {
              Pop(context);
            }),
        centerTitle: true,
        backgroundColor: appAppBarColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Contact Us',
                style: GoogleFonts.montserrat(
                    color: apptealColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            TitleEnterField('Firstname', 'Firstname', firstname),
            TitleEnterField('Lastname', 'Lastname', lastname),
            TitleEnterField('Email id', 'Email id', emailId),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Number',
                      style: TextStyle(
                          fontSize: 14, color: Colors.black.withOpacity(0.6))),
                  SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 10, maxHeight: 150),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          maxLines: 1,
                          maxLength: 10,

                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          // validator: validator,
                          // maxLength: maxLength,
                          // maxLengthEnforcement: MaxLengthEnforcement.enforced,

                          keyboardType: TextInputType.number,
                          controller: contactNo,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          decoration: InputDecoration(
                            enabled: true,
                            counterText: '',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            // enabledBorder: InputBorder.none,
                            // errorBorder: InputBorder.none,
                            // disabledBorder: InputBorder.none,
                            filled: true,

                            //labelText: labelText,
                            suffixIcon: const SizedBox(),
                            labelStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.6)),
                            hintText: 'Contact Number',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15)
                ],
              ),
            ),
            TitleEnterField(
              'Description',
              'Description',
              description,
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
                    submit();
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
}
