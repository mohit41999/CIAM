import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Screens/LAB/test_checkout.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/LabController/lab_details_controller.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/common_button.dart';

import '../../widgets/doctor_profile_row.dart';

class LabDetails extends StatefulWidget {
  final String labid;
  const LabDetails({Key? key, required this.labid}) : super(key: key);

  @override
  _LabDetailsState createState() => _LabDetailsState();
}

class _LabDetailsState extends State<LabDetails> {
  Color textColor = Color(0xff161616);
  LabdetailsController _controller = LabdetailsController();
  Future initialize() async {
    _controller.labDetails = await _controller.getLabDetails(widget.labid);
    _controller.labTests = await _controller.getLabtests(widget.labid);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 260,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              _controller.labDetails.data.labImage),
                          fit: BoxFit.cover)),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10),
                    child: Text(
                      _controller.labDetails.data.labName,
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: appblueColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 325,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Details',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: textColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: textColor.withOpacity(0.4),
                          thickness: 1,
                        ),
                        doctorProfileRow(
                          title: 'Email',
                          value: _controller.labDetails.data.email,
                        ),
                        doctorProfileRow(
                          title: 'Mobile No',
                          value: _controller.labDetails.data.mobileNo,
                        ),
                        doctorProfileRow(
                          title: 'Address',
                          value: _controller.labDetails.data.address,
                        ),
                        doctorProfileRow(
                          title: 'Citu',
                          value: _controller.labDetails.data.city,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'Available Tests',
                      style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: textColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      color: textColor.withOpacity(0.4),
                      thickness: 1,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _controller.labTests.data.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Checkbox(
                                  fillColor:
                                      MaterialStateProperty.all(apptealColor),
                                  value: _controller
                                      .labTests.data[index].isChecked,
                                  onChanged: (v) {
                                    setState(() {
                                      _controller
                                          .labTests.data[index].isChecked = v!;
                                    });
                                  }),
                              Text(_controller.labTests.data[index].testName)
                            ],
                          );
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: commonBtn(
                      borderRadius: 10,
                      s: 'Proceed',
                      bgcolor: appblueColor,
                      textColor: Colors.white,
                      onPressed: () {
                        Push(
                            context,
                            TestCheckout(
                              labid: widget.labid,
                              testids: [],
                            ),
                            withnav: false);
                      }),
                ),
                SizedBox(
                  height: navbarht + 20,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 30),
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: appblueColor,
                      size: 20,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(2, 5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
