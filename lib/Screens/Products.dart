import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Models/products_model.dart';
import 'package:patient/Screens/ProductDetails.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/controller/product_controller.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductController _con = ProductController();
  late ProductModel products;

  @override
  void initState() {
    _con.getProducts(context).then((value) {
      setState(() {
        products = value;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonAppBarTitleText(appbarText: 'Products'),
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: appAppBarColor,
        centerTitle: false,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
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
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: products.data.length,
                itemBuilder: (context, int index) {
                  var Product = products.data[index];
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        top: 10.0,
                        bottom: (index + 1 == products.data.length)
                            ? navbarht + 20
                            : 10),
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
                              // color: Colors.purple,
                              child: Image.asset(
                                'assets/pngs/Icon material-face.png',
                                height: double.infinity,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Product.productName, style: KHeader),
                                  Container(
                                    child: Html(
                                      data: Product.productDetails,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$${Product.productPrice}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      commonBtn(
                                        s: 'Buy Now',
                                        bgcolor: apptealColor,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Push(context, ProductDetails(),
                                              withnav: false);
                                        },
                                        height: 30,
                                        width: 120,
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
                }),
          )
        ],
      ),
    );
  }
}
