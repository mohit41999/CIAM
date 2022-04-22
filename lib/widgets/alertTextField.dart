import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class alertTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String textFieldtext;
  final TextInputType inputType;

  const alertTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.textFieldtext,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(label),
        SizedBox(
          height: 5,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 55),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: TextFormField(
              keyboardType: inputType,
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

              controller: controller,
              decoration: InputDecoration(
                enabled: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: new BorderSide(color: Colors.transparent)),
                border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: new BorderSide(color: Colors.transparent)),
                // enabledBorder: InputBorder.none,
                // errorBorder: InputBorder.none,
                // disabledBorder: InputBorder.none,
                filled: true,
                labelText: textFieldtext,
                alignLabelWithHint: false,
                floatingLabelBehavior: FloatingLabelBehavior.never,

                labelStyle: TextStyle(
                    fontSize: 12, color: Colors.black.withOpacity(0.6)),
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
      ],
    );
  }
}
