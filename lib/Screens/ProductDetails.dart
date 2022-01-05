import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:patient/Screens/order_product.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:patient/controller/NavigationController.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/navigation_drawer.dart';

final Shader linearGradient = LinearGradient(
  colors: <Color>[Color(0xff233E8B), Color(0xff1EAE98)],
).createShader(Rect.fromLTWH(0.0, 0.0, 120.0, 70.0));

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ScrollController _scrollcontroller = ScrollController();
  int _currentIndex = 0;

  List<String> listPaths = [
    "https://images.unsplash.com/photo-1566073771259-6a8506099945?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cmVzb3J0fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
    "https://images.unsplash.com/photo-1582719508461-905c673771fd?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmVzb3J0fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
    "https://images.unsplash.com/photo-1584132967334-10e028bd69f7?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cmVzb3J0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
    "https://i.pinimg.com/originals/e9/07/78/e907784d7f5e0538d8dd8c0da464eb43.jpg",
    "https://www.geolympus.com/wp-content/uploads/2016/09/Beach-Hotel-HD-Screensavers-Wallpapers.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: commonAppBarTitle(),
          backgroundColor: appAppBarColor,
          elevation: 0,
          leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.menu,
                onPressed: () {
                  setState(() {
                    Scaffold.of(context).openDrawer();
                  });
                }),
          )),
      drawer: commonDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollcontroller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // AppBar(context),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Product Name',
                      style: KmainTitle,
                    ),
                  ),
                  Product(context),
                  SizedBox(height: 20),
                  ProductDetails(context),
                  SizedBox(height: 20),
                  Offers(context),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Product Image Gallery',
                      style: KTitle,
                    ),
                  ),
                  ProductGallery(context),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Other Products',
                      style: KTitle,
                    ),
                  ),
                  OtherProducts(context),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: commonBtn(
                      s: 'Add to cart',
                      bgcolor: Colors.white,
                      textColor: appblueColor,
                      onPressed: () {},
                      height: 35,
                      textSize: 14,
                      borderRadius: 4,
                      borderColor: appblueColor,
                      borderWidth: 1,
                    ),
                  ),
                  SizedBox(height: 150),
                ],
              ),
            ),
            Positioned(bottom: 0, child: BottomBar(context))
          ],
        ),
      ),
    );
  }

  // Widget AppBar(context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(12.0),
  //     child: Container(
  //       height: 80,
  //       width: double.infinity,
  //       child: Row(
  //         children: [
  //           Container(
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(0.5),
  //                   blurRadius: 10,
  //                   offset: const Offset(2, 5),
  //                 ),
  //               ],
  //             ),
  //             height: 30,
  //             width: 30,
  //             child: Icon(Icons.segment),
  //           ),
  //           SizedBox(width: 120),
  //           Container(
  //             child: ShaderMask(
  //               blendMode: BlendMode.srcIn,
  //               shaderCallback: (bounds) => LinearGradient(colors: [
  //                 Color(0xff233E8B),
  //                 Color(0xff1EAE98),
  //               ]).createShader(
  //                 Rect.fromLTWH(0, 0, bounds.width, bounds.height),
  //               ),
  //               child: Text(
  //                 'DCP',
  //                 style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget BottomBar(context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: 70.0,
          width: MediaQuery.of(context).size.width,
          decoration:
              BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$199',
                  style: KmainTitle,
                ),
                commonBtn(
                  s: 'Buy Now',
                  bgcolor: apptealColor,
                  textColor: Colors.white,
                  onPressed: () {
                    Push(context, OrderProduct());
                  },
                  width: 155,
                  height: 52,
                  textSize: 16,
                  borderRadius: 4,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Product(context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
              //autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              height: 200.0,
              viewportFraction: 1,
            ),
            itemCount: listPaths.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('${listPaths[itemIndex]}'))),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: listPaths.map((url) {
                int index = listPaths.indexOf(url);
                return Container(
                  width: _currentIndex == index ? 8 : 6,
                  height: _currentIndex == index ? 7 : 5,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.grey
                        : Color(0xffC8C8C8),
                  ),
                );
              }).toList()),
        ],
      ),
    );
  }

  Widget ProductDetails(context) {
    return Container(
      height: 152,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Product Details',
              style: KTitle,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy'
              ' eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam '
              'voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita'
              ' kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
              ' Lorem ipsum dolor sit amet, consetetur sadipscing elitr.',
              style: KBodyText,
            )
          ],
        ),
      ),
    );
  }

  Widget Offers(context) {
    return Container(
      height: 170,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Offers',
              style: KTitle,
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(2, 5),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Offername',
                              style: TextStyle(
                                  color: Color(0xff161616).withOpacity(0.8),
                                  fontSize: 13)),
                          Text(
                              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et. ',
                              style: TextStyle(
                                  color: Color(0xff161616).withOpacity(0.4),
                                  fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget ProductGallery(context) {
    return ListView.builder(
        controller: _scrollcontroller,
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${listPaths[index]}'),
                ),
              ),
            ),
          );
        });
  }

  Widget OtherProducts(context) {
    return ListView.builder(
        controller: _scrollcontroller,
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, int) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                //borderRadius: BorderRadius.circular(5),
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
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.purple,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Product Name', style: KTitle),
                          Container(
                            child: Text(
                              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut laborecn et.',
                              style: KBodyText,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$199',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              commonBtn(
                                s: 'Buy Now',
                                bgcolor: apptealColor,
                                textColor: Colors.white,
                                onPressed: () {},
                                width: 120,
                                height: 30,
                                textSize: 12,
                                borderRadius: 4,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
