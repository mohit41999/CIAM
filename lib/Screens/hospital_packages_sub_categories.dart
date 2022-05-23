import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/hospital_packages_sub_cat_model.dart';
import 'package:patient/Screens/TermsAndConditions.dart';
import 'package:patient/Screens/confirmScreen.dart';
import 'package:patient/Screens/contact_us_form.dart';
import 'package:patient/Screens/hospital_packages.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/Utils/progress_view.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/alertTextField.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/confirmation_dialog.dart';
import 'package:patient/widgets/navigation_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HospitalPackageSubCat extends StatefulWidget {
  final String cat_id;
  final String cat_name;
  final bool fromHome;

  const HospitalPackageSubCat({
    Key? key,
    required this.cat_id,
    required this.cat_name,
    this.fromHome = false,
  }) : super(key: key);

  @override
  _HospitalPackageSubCatState createState() => _HospitalPackageSubCatState();
}

class _HospitalPackageSubCatState extends State<HospitalPackageSubCat> {
  late AnimationController controller;
  late CurvedAnimation curve;
  cities city = cities.Delhi;
  TextEditingController care = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String address = '';
  late HospitalPackagesSubCatModel hospitalPackagesSubCat;

  Future<HospitalPackagesSubCatModel> getHospitalPackagesSubCat() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var response = await PostData(
        PARAM_URL: 'get_hospital_packages_sub_category.php',
        params: {
          'token': Token,
          'cat_id': widget.cat_id,
          'user_id': preferences.getString('user_id')
        });

    return HospitalPackagesSubCatModel.fromJson(response);
  }

  bool loading = true;
  Future<bool> addCareServices(
    BuildContext context, {
    required String subcareid,
    required String careid,
    required String name,
    required String city,
    required String email,
    required String phone,
    required String care_requirement,
  }) async {
    if (care_requirement.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Enter care requirement'),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Enter name'),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Enter email'),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Enter phone number'),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (care_requirement.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Postal Code must be 6 characters only'),
        backgroundColor: Colors.red,
      ));
      return false;
    } else {
      var loader = ProgressView(context);
      try {
        loader.show();
        late Map<String, dynamic> data;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await PostData(
            PARAM_URL: 'add_hospital_package_requirement.php',
            params: {
              'token': Token,
              'user_id': prefs.getString('user_id'),
              'name': name,
              'email': email,
              'phone': phone,
              'city': '1',
              'package_category_id': careid,
              'package_subcategory_id': subcareid,
              'postal_code': care_requirement,
            }).then((value) {
          loader.dismiss();
          if (value['status']) {
            loader.dismiss();
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text(value['message']),
            //   backgroundColor: apptealColor,
            // ));

            Pop(context);
            if (widget.fromHome) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ConfirmScreen(text: value['message'])));
            } else {
              Pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ConfirmScreen(text: value['message'])));
            }

            return true;
          } else {
            loader.dismiss();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(value['message']),
              backgroundColor: Colors.red,
            ));
            return false;
          }
        });
        loader.dismiss();
        return true;
      } catch (e) {
        loader.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Something went wrong... try again later'),
          backgroundColor: Colors.red,
        ));
        return false;
      }
    }
  }

  void hospitalPackageAlert(
    BuildContext context, {
    required String subcatName,
    required String subCatId,
    required TextEditingController careController,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController phonenumberController,
  }) {
    showDialog(
        context: context,
        useRootNavigator: false,
        builder: (BuildContext context) =>
            StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                  backgroundColor: Color(0xffF1F1F1),
                  elevation: 0,
                  insetPadding: EdgeInsets.all(8),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hospital Packages',
                            style: GoogleFonts.montserrat(
                                color: appblueColor,
                                fontWeight: FontWeight.bold),
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
                    height: MediaQuery.of(context).size.height / 1.8,
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
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                'Category - ',
                                style: GoogleFonts.montserrat(
                                    color: apptealColor,
                                    fontWeight: FontWeight.bold),
                              )),
                              Expanded(
                                  child: Text(
                                widget.cat_name,
                                style: GoogleFonts.montserrat(
                                    color: appblueColor,
                                    fontWeight: FontWeight.bold),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                'Sub Category - ',
                                style: GoogleFonts.montserrat(
                                    color: apptealColor,
                                    fontWeight: FontWeight.bold),
                              )),
                              Expanded(
                                  child: Text(
                                subcatName,
                                style: GoogleFonts.montserrat(
                                    color: appblueColor,
                                    fontWeight: FontWeight.bold),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Where is the care needed?'),
                          SizedBox(
                            height: 5,
                          ),
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<cities>(
                                      fillColor: MaterialStateProperty.all(
                                          appblueColor),
                                      value: cities.Delhi,
                                      groupValue: city,
                                      onChanged: (v) {
                                        setState(() {
                                          city = v!;
                                        });
                                      }),
                                  Text('Delhi')
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<cities>(
                                      fillColor: MaterialStateProperty.all(
                                          appblueColor),
                                      value: cities.Bangalore,
                                      groupValue: city,
                                      onChanged: (v) {
                                        setState(() {
                                          city = v!;
                                        });
                                      }),
                                  Text('Bangalore')
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<cities>(
                                      fillColor: MaterialStateProperty.all(
                                          appblueColor),
                                      value: cities.Gurugram,
                                      groupValue: city,
                                      onChanged: (v) {
                                        setState(() {
                                          city = v!;
                                        });
                                      }),
                                  Text('Gurugram')
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<cities>(
                                      fillColor: MaterialStateProperty.all(
                                          appblueColor),
                                      value: cities.Lucknow,
                                      groupValue: city,
                                      onChanged: (v) {
                                        setState(() {
                                          city = v!;
                                        });
                                      }),
                                  Text('Lucknow')
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<cities>(
                                      fillColor: MaterialStateProperty.all(
                                          appblueColor),
                                      value: cities.Mumbai,
                                      groupValue: city,
                                      onChanged: (v) {
                                        setState(() {
                                          city = v!;
                                        });
                                      }),
                                  Text('Mumbai')
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 55),
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,

                                // autovalidateMode: AutovalidateMode.onUserInteraction,
                                // validator: validator,
                                // maxLength: maxLength,
                                // maxLengthEnforcement: MaxLengthEnforcement.enforced,

                                enableSuggestions: true,

                                controller: care,
                                decoration: InputDecoration(
                                  enabled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: new BorderSide(
                                          color: Colors.transparent)),
                                  border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: new BorderSide(
                                          color: Colors.transparent)),
                                  // enabledBorder: InputBorder.none,
                                  // errorBorder: InputBorder.none,
                                  // disabledBorder: InputBorder.none,
                                  filled: true,
                                  labelText: 'Enter Postal Code',
                                  alignLabelWithHint: false,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,

                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.6)),
                                  // hintText: textFieldtext,
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
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
                              inputType: TextInputType.number,
                              controller: phonenumberController,
                              label: 'Phone Number',
                              textFieldtext: 'Enter Phone Number'),
                          SizedBox(
                            height: 10,
                          ),
                          commonBtn(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TermsAndConditions()));
                            },
                            s: 'Terms and Conditions',
                            textColor: appblueColor,
                            bgcolor: Colors.white,
                            borderRadius: 10,
                            height: 30,
                            textSize: 12,
                            borderColor: appblueColor,
                            borderWidth: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
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
                                addCareServices(context,
                                        subcareid: subCatId,
                                        careid: widget.cat_id,
                                        city: cityValue ?? '',
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phonenumberController.text,
                                        care_requirement: careController.text)
                                    .then((value) {
                                  if (value) {
                                    nameController.clear();
                                    emailController.clear();
                                    phonenumberController.clear();
                                    careController.clear();
                                  }
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
                  ));
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHospitalPackagesSubCat().then((value) {
      setState(() {
        hospitalPackagesSubCat = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: commonAppBarTitle(),
        backgroundColor: appAppBarColor,
        elevation: 0,
        titleSpacing: 0,
        leading: commonAppBarLeading(
            iconData: Icons.arrow_back_ios_new,
            onPressed: () {
              Pop(context);
            }),
      ),
      drawer: commonDrawer(),
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      Push(context, ContactUsForm());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: appblueColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(2, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/pngs/customer_support.jpg'),
                                      fit: BoxFit.contain,
                                    )),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Contact Us',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              Icon(
                                                Icons.phone,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'If you have any query ... you can Contact Us here',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Colors.white
                                                    .withOpacity(1)),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: GestureDetector(
                  //     onTap: () {},
                  //     child: Container(
                  //       height: 40,
                  //       width: double.infinity,
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(5),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.grey.withOpacity(0.5),
                  //             blurRadius: 10,
                  //             offset: const Offset(2, 5),
                  //           ),
                  //         ],
                  //       ),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Icon(
                  //             Icons.search,
                  //             color: Color(0xff161616).withOpacity(0.6),
                  //           ),
                  //           SizedBox(
                  //             width: 5,
                  //           ),
                  //           Text(
                  //             'Search',
                  //             style: GoogleFonts.montserrat(
                  //                 fontSize: 16,
                  //                 color: Color(0xff161616).withOpacity(0.6)),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: hospitalPackagesSubCat.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            hospitalPackageAlert(context,
                                subcatName:
                                    hospitalPackagesSubCat.data[index].name,
                                careController: care,
                                subCatId: hospitalPackagesSubCat
                                    .data[index].subPackageId,
                                nameController: name,
                                emailController: email,
                                phonenumberController: phonenumber);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            hospitalPackagesSubCat
                                                .data[index].image),
                                        radius: 50,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                hospitalPackagesSubCat
                                                    .data[index].name,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.montserrat(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            // Row(
                                            //   children: [
                                            //     rowTextIcon(
                                            //         asset:
                                            //             'assets/pngs/payments_black_24dp (1).png',
                                            //         text: 'Starting at'),
                                            //     Text(
                                            //       hospitalPackagesSubCat
                                            //           .data[index].price,
                                            //       style:
                                            //           GoogleFonts.montserrat(
                                            //               color: apptealColor,
                                            //               fontSize: 13,
                                            //               fontWeight:
                                            //                   FontWeight
                                            //                       .bold),
                                            //     )
                                            //   ],
                                            // ),
                                            // Text(
                                            //     hospitalPackagesSubCat
                                            //         .data[index].description,
                                            //     style: KBodyText),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  SizedBox(
                    height: navbarht + 20,
                  ),
                ],
              ),
            ),
    );
  }
}
