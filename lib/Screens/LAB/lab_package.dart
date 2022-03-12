import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/row_text_icon.dart';

class PackagesLabScreen extends StatefulWidget {
  const PackagesLabScreen({Key? key}) : super(key: key);

  @override
  _PackagesLabScreenState createState() => _PackagesLabScreenState();
}

class _PackagesLabScreenState extends State<PackagesLabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: commonAppBarTitle(),
        backgroundColor: appAppBarColor,
        leading: commonAppBarLeading(
            iconData: Icons.arrow_back_ios_new,
            onPressed: () {
              Pop(context);
            }),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 40,
              color: Colors.white,
              width: double.infinity,
              child: Center(
                  child: Text(
                'Available Labs',
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: appblueColor,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 10.0,
                        right: 10.0,
                        left: 10.0,
                        bottom: (index + 1 == 10) ? navbarht + 21 : 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
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
                            height: 200,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomLeft: Radius.circular(15)),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/pngs/Rectangle-77.png'),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'LAB name',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et.',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                          ),
                                        ),
                                        rowTextIcon(
                                          text: ' Location',
                                          asset: 'assets/pngs/Group 1182.png',
                                        ),
                                        Text(
                                          '\$149',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Center(
                                          child: commonBtn(
                                            s: 'Book Now',
                                            bgcolor: appblueColor,
                                            textColor: Colors.white,
                                            onPressed: () {},
                                            height: 30,
                                            width: 180,
                                            textSize: 12,
                                            borderRadius: 4,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
