import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Models/relative_model.dart';
import 'package:patient/Screens/LAB/test_checkout.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/LabController/lab_details_controller.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/controller/ProfileSettingController/relative_setting_controller.dart';
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
  late RelativeModel relativeData;
  String relative_id = '0';
  bool loading = true;

  LabdetailsController _controller = LabdetailsController();
  Future initialize() async {
    _controller.labDetails = await _controller.getLabDetails(widget.labid);
    _controller.labTests = await _controller.getLabtests(widget.labid);
  }

  List<String> testids = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize().then((value) {
      setState(() {
        RelativeSettingController().getrelativedata(context).then((value) {
          setState(() {
            relativeData = value;
            relativeData.data.insert(
                0,
                RelativeModelData(
                    relative_id: '0',
                    relation: '',
                    relativeName: 'ME',
                    bloodGroup: '',
                    gender: '',
                    age: '',
                    maritalStatus: ''));
          });
        });
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : Stack(
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
                                title: 'City',
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
                                        fillColor: MaterialStateProperty.all(
                                            apptealColor),
                                        value: _controller
                                            .labTests.data[index].isChecked,
                                        onChanged: (v) {
                                          setState(() {
                                            _controller.labTests.data[index]
                                                .isChecked = v!;
                                            (v)
                                                ? testids.add(_controller
                                                    .labTests
                                                    .data[index]
                                                    .testId)
                                                : testids.remove(_controller
                                                    .labTests
                                                    .data[index]
                                                    .testId);
                                          });
                                        }),
                                    Text(_controller
                                        .labTests.data[index].testName)
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
                              bookingForDialog(context, testids, widget.labid);
                              // Push(
                              //     context,
                              //     TestCheckout(
                              //       labid: widget.labid,
                              //       testids: testids,
                              //       relative_id: '',
                              //     ),
                              //     withnav: false);
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

  Future bookingForDialog(
      BuildContext context, List<String> test_ids, String lab_id) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) =>
                  AlertDialog(
                    content: Container(
                      height: 150,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Test For',
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            color: Colors.black.withOpacity(0.4),
                            thickness: 1,
                          ),
                          Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: appblueColor)),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  value: relative_id,
                                  underline: Container(),
                                  style: TextStyle(
                                      color: apptealColor,
                                      fontWeight: FontWeight.bold),
                                  isExpanded: true,
                                  hint: Text('Me'),
                                  items: relativeData.data.map((e) {
                                    return DropdownMenuItem(
                                        value: e.relative_id,
                                        child:
                                            Text(e.relativeName.toUpperCase()));
                                  }).toList(),
                                  onChanged: (dynamic v) {
                                    setState(() {
                                      print(v);
                                      relative_id = v;
                                      print(relative_id.toString());
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          commonBtn(
                              s: 'Continue',
                              height: 30,
                              textSize: 14,
                              borderRadius: 5,
                              bgcolor: appblueColor,
                              textColor: Colors.white,
                              onPressed: () {
                                Pop(context);
                                Push(
                                    context,
                                    TestCheckout(
                                      testids: test_ids,
                                      labid: lab_id,
                                      relative_id: relative_id,
                                    ),
                                    withnav: false);
                              })
                        ],
                      ),
                    ),
                  ));
        });
  }
}
