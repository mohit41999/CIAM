import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Utils/colorsandstyles.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/title_column.dart';

import 'MyOrderPage.dart';

class MyMedicineOrders extends StatefulWidget {
  const MyMedicineOrders({Key? key}) : super(key: key);

  @override
  _MyMedicineOrdersState createState() => _MyMedicineOrdersState();
}

class _MyMedicineOrdersState extends State<MyMedicineOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonAppBarTitleText(appbarText: 'My Medicine Orders'),
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.arrow_back_ios_new,
                onPressed: () {
                  Navigator.pop(context);
                })),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, int) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        top: 10.0,
                        bottom: (int + 1 == 10) ? navbarht + 20 : 10),
                    child: Container(
                      height: 180,
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
                            height: 130,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 200,
                                    alignment: Alignment.center,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              'assets/pngs/pngegg (1).png',
                                            ),
                                            fit: BoxFit.contain)),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  titleColumn(
                                                    title: 'Booking Id',
                                                    value: '9956328',
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  titleColumn(
                                                    value: '27/09/2021',
                                                    title: 'Date of Booking',
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    titleColumn(
                                                      value: '\$299',
                                                      title: 'AmountPaid',
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Invoice',
                                                          style: GoogleFonts.lato(
                                                              fontSize: 12,
                                                              color: Color(
                                                                      0xff252525)
                                                                  .withOpacity(
                                                                      0.5)),
                                                        ),
                                                        Icon(
                                                          FontAwesomeIcons.eye,
                                                          size: 14,
                                                          color: appblueColor,
                                                        ),
                                                        Container(
                                                          height: 14,
                                                          width: 14,
                                                          child: Image.asset(
                                                              'assets/pngs/Icon feather-download.png'),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        titleColumn(
                                            title: 'Shipping Address',
                                            value:
                                                'Lorem ipsum dolor sit amet, consetetur.')
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                  ))),
                              onPressed: () {},
                              child: Text(
                                'Need Help ?',
                                style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: appblueColor,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
