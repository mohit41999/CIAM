import 'package:flutter/material.dart';
import 'package:patient/Utils/colorsandstyles.dart';

void GuestAlertBox(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
          elevation: 0,
          insetPadding: EdgeInsets.all(0),
          child: Container(
            width: double.infinity,
            height: 400,
            //padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close)),
                      SizedBox(width: 125),
                      Text(
                        'Guest',
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Adults',
                      ),
                      Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.remove_circle_outline_outlined,
                                color: Colors.grey),
                            Text('1'),
                            Icon(Icons.add_circle_outline, color: Colors.grey),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Children',
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Age 2-12',
                          ),
                        ],
                      ),
                      Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.remove_circle_outline_outlined,
                                color: Colors.grey),
                            Text('0'),
                            Icon(Icons.add_circle_outline, color: Colors.grey),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Infants',
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Under 2',
                          ),
                        ],
                      ),
                      Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.remove_circle_outline_outlined,
                                color: Colors.grey),
                            Text('0'),
                            Icon(Icons.add_circle_outline, color: Colors.grey),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Clear"),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: appblueColor,
                        ),
                        height: 30,
                        width: 80,
                        child: Center(
                            child: Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2,
                              fontSize: 10),
                        )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )));
}
