import 'package:flutter/material.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/ProfileSettingController/personal_setting_controller.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/widgets/title_enter_field.dart';

class Personal extends StatefulWidget {
  const Personal({Key? key}) : super(key: key);

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  PersonalSettingController _con = PersonalSettingController();

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
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/pngs/Rectangle 51.png'),
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
                              onPressed: () {},
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
}
