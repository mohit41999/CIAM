import 'package:flutter/material.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/ProfileSettingController/lifestyle_setting_controller.dart';
import 'package:patient/widgets/common_button.dart';

class Lifestyle extends StatefulWidget {
  const Lifestyle({Key? key}) : super(key: key);

  @override
  State<Lifestyle> createState() => _LifestyleState();
}

class _LifestyleState extends State<Lifestyle> {
  LifestyleSettingController _con = LifestyleSettingController();

  @override
  void initState() {
    // TODO: implement initState

    _con.initialize(context).then((value) {
      setState(() {
        _con.loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // extendBody: true,
      // backgroundColor: Colors.transparent,
      body: (_con.loading)
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.79,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Smoking'),
                            SizedBox(
                              height: 7,
                            ),
                            Material(
                              elevation: 5,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                width: double.infinity,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,

                                    value: _con.SmokingdropdownValue,

                                    // value: dropdownValue,
                                    icon: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 18.0),
                                      child: const Icon(
                                          Icons.keyboard_arrow_down_outlined),
                                    ),

                                    // iconSize: 24,

                                    //underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _con.SmokingdropdownValue = newValue!;
                                        print(_con.SmokingdropdownValue);
                                      });
                                    },
                                    items: _con.SmokingList.map<
                                            DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18.0),
                                          child: Text(value),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Alcohol'),
                            SizedBox(
                              height: 7,
                            ),
                            Material(
                              elevation: 5,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                width: double.infinity,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,

                                    value: _con.AlcoholdropdownValue,

                                    // value: dropdownValue,
                                    icon: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 18.0),
                                      child: const Icon(
                                          Icons.keyboard_arrow_down_outlined),
                                    ),

                                    // iconSize: 24,

                                    //underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _con.AlcoholdropdownValue = newValue!;
                                        print(_con.AlcoholdropdownValue);
                                      });
                                    },
                                    items: _con.AlcoholList.map<
                                            DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18.0),
                                          child: Text(value),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Workout level'),
                            SizedBox(
                              height: 7,
                            ),
                            Material(
                              elevation: 5,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                width: double.infinity,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,

                                    value: _con.WorkOutLeveldropdownValue,

                                    // value: dropdownValue,
                                    icon: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 18.0),
                                      child: const Icon(
                                          Icons.keyboard_arrow_down_outlined),
                                    ),

                                    // iconSize: 24,

                                    //underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _con.WorkOutLeveldropdownValue =
                                            newValue!;
                                        print(_con.WorkOutLeveldropdownValue);
                                      });
                                    },
                                    items: _con.WorkOutLevelList.map<
                                            DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18.0),
                                          child: Text(value),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Sports involvement'),
                            SizedBox(
                              height: 7,
                            ),
                            Material(
                              elevation: 5,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                width: double.infinity,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,

                                    value: _con.SportsInvolvementdropdownValue,

                                    // value: dropdownValue,
                                    icon: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 18.0),
                                      child: const Icon(
                                          Icons.keyboard_arrow_down_outlined),
                                    ),

                                    // iconSize: 24,

                                    //underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _con.SportsInvolvementdropdownValue =
                                            newValue!;
                                        print(_con
                                            .SportsInvolvementdropdownValue);
                                      });
                                    },
                                    items: _con.SportsInvolvementList.map<
                                            DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18.0),
                                          child: Text(value),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      commonBtn(
                          borderRadius: 8,
                          s: 'Submit',
                          bgcolor: appblueColor,
                          textColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              _con.submit(context);
                            });
                          }),
                      SizedBox(
                        height: navbarht + 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
