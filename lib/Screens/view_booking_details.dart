import 'package:flutter/material.dart';
import 'package:patient/Models/view_booking_details.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/view_booking_details_controller.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/details_tile.dart';
import 'package:patient/widgets/title_column.dart';

class ViewBookingDetails extends StatefulWidget {
  final String booking_id;
  const ViewBookingDetails({Key? key, required this.booking_id})
      : super(key: key);

  @override
  _ViewBookingDetailsState createState() => _ViewBookingDetailsState();
}

class _ViewBookingDetailsState extends State<ViewBookingDetails> {
  late ViewBookingDetailsModel? details;
  bool loading = true;
  ViewBookingDetailsController _con = ViewBookingDetailsController();
  initialize() async {
    details = await _con.getViewDetails(widget.booking_id, context);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonAppBarTitleText(appbarText: 'Booking Details'),
        backgroundColor: appAppBarColor,
        elevation: 0,
        leading: Builder(
            builder: (context) => commonAppBarLeading(
                iconData: Icons.arrow_back_ios_new,
                onPressed: () {
                  Navigator.pop(context);
                })),
      ),
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 2,
                          spreadRadius: 3)
                    ],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: apptealColor, width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DetailsTile(
                                  title: 'BookingId',
                                  value: details!.data.bookingId),
                              DetailsTile(
                                  title: 'Booking Date',
                                  value: details!.data.bookedDate),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DetailsTile(
                                  title: 'Booked Service Time',
                                  value: details!.data.bookedServiceTime
                                      .substring(0, 5)),
                              DetailsTile(
                                  title: 'Booking Status',
                                  value: details!.data.bookingStatus),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: apptealColor,
                        thickness: 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DetailsTile(
                                  title: 'Doctor Name',
                                  value:
                                      details!.data.doctorName.toUpperCase()),
                              DetailsTile(
                                  title: 'Patient Name',
                                  value:
                                      details!.data.patientName.toUpperCase()),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DetailsTile(
                                  title: 'Clinic Location',
                                  value: details!.data.clinicLocation
                                      .toUpperCase()),
                              DetailsTile(
                                  title: 'Patient Location',
                                  value: details!.data.patientLocation
                                      .toUpperCase()),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DetailsTile(
                              title: 'Doctor Speciality',
                              value: details!.data.specialty.toUpperCase()),
                        ],
                      ),
                      Divider(
                        color: apptealColor,
                        thickness: 2,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DetailsTile(
                              title: 'Total Amount',
                              value: "\₹${details!.data.totalAmount}"),
                          DetailsTile(
                              title: 'Amount Status',
                              value: details!.data.amountStatus),
                        ],
                      ),

                      // Text(details!.data.patientName),
                      // Text(details!.data.bookingId),
                      // Text(details!.data.amountStatus),
                      // Text(details!.data.totalAmount),
                      // Text(details!.data.clinicLocation),
                      // Text(details!.data.bookedServiceTime),
                      // Text(details!.data.patientLocation),
                      // Text(details!.data.bookingStatus),
                      // Text(details!.data.specialty),
                      // Text(details!.data.bookedDate),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
