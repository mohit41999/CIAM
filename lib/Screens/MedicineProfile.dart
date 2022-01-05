import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Models/medicine_profile_model.dart';

import 'package:patient/Screens/LabProfile.dart';
import 'package:patient/Screens/order_medicine.dart';
import 'package:patient/Utils/colorsandstyles.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/controller/medicine_controller.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';

class MedicineProfile extends StatefulWidget {
  const MedicineProfile({Key? key}) : super(key: key);

  @override
  _MedicineProfileState createState() => _MedicineProfileState();
}

class _MedicineProfileState extends State<MedicineProfile> {
  late MedicineProfileModel medicinedata;
  MedicineProfileController _con = MedicineProfileController();

  @override
  void initState() {
    // TODO: implement initState
    _con.getMedicines(context).then((value) {
      setState(() {
        medicinedata = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonAppBarTitleText(appbarText: 'Medicine Profile'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appAppBarColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 40,
                width: double.infinity,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: Color(0xff161616).withOpacity(0.6),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Search',
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Color(0xff161616).withOpacity(0.6)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: medicinedata.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: (index + 1 == 10)
                        ? EdgeInsets.only(
                            left: 10, right: 10, bottom: 50, top: 10)
                        : const EdgeInsets.all(10.0),
                    child: Container(
                      height: 170,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(2, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 100,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Image.network(
                                      medicinedata.data[index].medicineImage),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            medicinedata
                                                .data[index].medicinesName,
                                            style: KHeader),
                                        Text(
                                            medicinedata
                                                .data[index].description,
                                            style: KBodyText),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${medicinedata.data[index].price}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  commonBtn(
                                    s: 'Add to Cart',
                                    bgcolor: Colors.white,
                                    textColor: appblueColor,
                                    onPressed: () {
                                      Push(context, OrderMedicine());
                                    },
                                    height: 30,
                                    textSize: 12,
                                    width: 130,
                                    borderWidth: 1,
                                    borderColor: appblueColor,
                                    borderRadius: 4,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
