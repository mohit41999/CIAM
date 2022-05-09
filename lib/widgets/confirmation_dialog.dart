import 'package:flutter/material.dart';

confirmDialog(BuildContext context, var value) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
          title: CircleAvatar(
            radius: 50,
            child: Icon(
              Icons.done,
              color: Colors.white,
              size: 30,
            ),
            backgroundColor: Colors.green,
          ),
          content: Text(
            value['message'].toString().toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
