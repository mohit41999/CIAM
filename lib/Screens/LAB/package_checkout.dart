import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/API%20repo/api_constants.dart';
import 'package:patient/Models/LAB/package_checkout_model.dart';
import 'package:patient/Models/coupons_model.dart';
import 'package:patient/Screens/confirmScreen.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/LabController/package_controller.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/controller/wallet_controller.dart';
import 'package:patient/helper/razorpay.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackageCheckout extends StatefulWidget {
  final String packageId;
  final String labId;
  final String relative_id;

  const PackageCheckout(
      {Key? key,
      required this.packageId,
      required this.labId,
      required this.relative_id})
      : super(key: key);
  @override
  _PackageCheckoutState createState() => _PackageCheckoutState();
}

class _PackageCheckoutState extends State<PackageCheckout> {
  WalletController _controller = WalletController();
  PackageController packageController = PackageController();
  late PackageCheckoutModel packageCheckout;
  int couponindex = -1;
  String couponid = '';
  late CouponsModel coupons;
  bool loading = true;
  late Razorpay _razorpay;
  String couponCode = '';
  Future<CouponsModel> getCoupons(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await PostData(PARAM_URL: 'get_coupon_list.php', params: {
      'token': Token,
      'user_id': prefs.getString('user_id'),
    });
    return CouponsModel.fromJson(response);
  }

  Future initialize() async {
    await getRazorpaycred();
    coupons = await getCoupons(context);
    await packageController
        .getPackageCheckout(
            widget.packageId, widget.labId, '', widget.relative_id)
        .then((value) {
      setState(() {
        packageCheckout = value;
        loading = false;
      });
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    // depositsuccess();
    print('order' + response.orderId.toString());
    print('paymentId' + response.paymentId.toString());
    print('signature' + response.signature.toString());
    packageController.addPackageOrder(
        packageid: widget.packageId,
        labId: widget.labId,
        relative_id: widget.relative_id,
        fees: packageCheckout.data[0].billSummary.totalFees,
        coupon_discount: packageCheckout.data[0].billSummary.couponDiscount,
        amountPaid: packageCheckout.data[0].billSummary.amountPaid,
        couponCode: couponCode);

    Pop(context);
    pushNewScreen(context,
        screen: ConfirmScreen(text: 'Success'), withNavBar: false);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    initialize();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: commonAppBarTitleText(appbarText: 'Payment Confirmation'),
        backgroundColor: appAppBarColor,
        elevation: 0,
        titleSpacing: 0,
        leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.arrow_back_ios_new,
                onPressed: () {
                  Navigator.pop(context);
                })),
      ),
      body: Container(
        color: Colors.white,
        child: (loading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  ListView(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Patient Name',
                              style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Color(0xff252525).withOpacity(0.5)),
                            ),
                            Text(
                              packageCheckout
                                  .data[0].patientDetails.patientName,
                              style: GoogleFonts.lato(
                                  fontSize: 18,
                                  color: Color(0xff252525),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Patient Phone Number',
                              style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Color(0xff252525).withOpacity(0.5)),
                            ),
                            Text(
                              packageCheckout.data[0].patientDetails.patientNo,
                              style: GoogleFonts.lato(
                                  fontSize: 18,
                                  color: Color(0xff252525),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Color(0xffEFEFEF),
                        height: 20,
                      ),
                      Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height / 4.5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Lab Details'),
                              Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Text(
                                'Lab Name',
                                style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Color(0xff252525).withOpacity(0.5)),
                              ),
                              Text(
                                packageCheckout.data[0].labDetails.labName,
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: Color(0xff252525),
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: apptealColor,
                                  ),
                                  Text(
                                      ' ${packageCheckout.data[0].labDetails.location}')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Color(0xffEFEFEF),
                        height: 20,
                      ),
                      Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height / 4.5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Package Details'),
                              Divider(
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      packageCheckout
                                          .data[0].packageDetails.packageName,
                                      style: GoogleFonts.lato(
                                          fontSize: 14,
                                          color: Color(0xff252525)
                                              .withOpacity(0.5)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '₹ ${packageCheckout.data[0].packageDetails.packagePrice}',
                                      style: GoogleFonts.lato(
                                          fontSize: 14,
                                          color: Color(0xff252525)
                                              .withOpacity(0.5)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Color(0xffEFEFEF),
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30,
                              width: 50,
                              child: Center(
                                child: Text(
                                  '%',
                                  style: GoogleFonts.montserrat(
                                      color: appblueColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: apptealColor),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          content: Container(
                                            height: 250,
                                            width: 300,
                                            child: ListView.builder(
                                                itemCount: coupons.data.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        couponindex = index;

                                                        couponid = coupons
                                                            .data[index].id;
                                                        couponCode = coupons
                                                            .data[index].title;
                                                        setState(() {
                                                          loading = true;
                                                        });
                                                        packageController
                                                            .getPackageCheckout(
                                                                widget
                                                                    .packageId,
                                                                widget.labId,
                                                                couponid,
                                                                widget
                                                                    .relative_id)
                                                            .then((value) {
                                                          setState(() {
                                                            packageCheckout =
                                                                value;
                                                            loading = false;
                                                          });
                                                        });
                                                      });

                                                      Navigator.pop(context);
                                                    },
                                                    child: ListTile(
                                                      trailing: Text(
                                                          coupons.data[index]
                                                              .couponCode
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  color:
                                                                      apptealColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      leading: Text(
                                                        coupons
                                                            .data[index].title,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                color:
                                                                    appblueColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ));
                              },
                              child: Text(
                                couponindex == -1
                                    ? 'Select Coupon'
                                    : coupons.data[couponindex].title,
                                style: GoogleFonts.montserrat(
                                    color: appblueColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            Text(couponindex == -1 ? '' : 'coupon applied'),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    couponindex = -1;
                                  });

                                  couponid = '';
                                  couponCode = '';
                                  setState(() {
                                    loading = true;
                                  });
                                  packageController
                                      .getPackageCheckout(
                                          widget.packageId,
                                          widget.labId,
                                          couponid,
                                          widget.relative_id)
                                      .then((value) {
                                    setState(() {
                                      packageCheckout = value;

                                      loading = false;
                                    });
                                  });
                                },
                                child: (couponindex == -1)
                                    ? SizedBox()
                                    : Icon(Icons.cancel))
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Color(0xffEFEFEF),
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bill Summary',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Consultation Fee',
                                      style:
                                          GoogleFonts.montserrat(fontSize: 15)),
                                  Text(
                                      '₹ ' +
                                          packageCheckout
                                              .data[0].billSummary.totalFees,
                                      style:
                                          GoogleFonts.montserrat(fontSize: 15))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Coupon Discount',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15, color: apptealColor)),
                                  Text(
                                      '-₹ ' +
                                          packageCheckout.data[0].billSummary
                                              .couponDiscount,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15, color: apptealColor))
                                ],
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.7),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('To Be Paid',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      '₹ ' +
                                          packageCheckout
                                              .data[0].billSummary.amountPaid,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Color(0xffEFEFEF),
                        height: 20,
                      ),
                      SizedBox(
                        height: navbarht + 20,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Container(
                        height: 70,
                        color: Colors.white,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total Amount\n',
                                    style: GoogleFonts.montserrat(fontSize: 15),
                                  ),
                                  Text(
                                      '₹ ' +
                                          packageCheckout
                                              .data[0].billSummary.amountPaid,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))
                                ],
                              )),
                              Expanded(
                                  child: commonBtn(
                                s: 'Proceed to Pay  ',
                                bgcolor: appblueColor,
                                textColor: Colors.white,
                                onPressed: () {
                                  payment(
                                      int.parse(packageCheckout
                                          .data[0].billSummary.amountPaid
                                          .replaceAll('.', '')),
                                      _razorpay);
                                },
                                borderRadius: 10,
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
