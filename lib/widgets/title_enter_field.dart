import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:patient/controller/NavigationController.dart';

class TitleEnterField extends StatelessWidget {
  final String hintText;
  final String outsideText;
  // final double height;
  // final String labelText;
  TextInputType textInputType;
  //final int maxLength;
  bool showcursor;
  bool readonly;
  bool obscure;
  Widget widget;
  final int maxLines;
  //final FormFieldValidator<String> validator;
  TextEditingController controller;
  TitleEnterField(
    this.hintText,
    this.outsideText,
    //this.labelText,
    this.controller, {
    this.textInputType = TextInputType.text,
    this.readonly = false,
    this.showcursor = true,
    this.obscure = false,
    this.widget = const SizedBox(),
    this.maxLines = 1,
    // this.validator = ValidateTextField.validateNull,
    //this.maxLength = 25
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(outsideText,
              style: TextStyle(
                  fontSize: 14, color: Colors.black.withOpacity(0.6))),
          SizedBox(height: 7),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 10, maxHeight: 150),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: TextFormField(
                  maxLines: maxLines,

                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: validator,
                  // maxLength: maxLength,
                  // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  obscureText: obscure,
                  enableSuggestions: true,
                  showCursor: showcursor,
                  readOnly: readonly,
                  keyboardType: textInputType,
                  controller: controller,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
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
                    //labelText: labelText,
                    suffixIcon: widget,
                    labelStyle: TextStyle(
                        fontSize: 14, color: Colors.black.withOpacity(0.6)),
                    hintText: hintText,
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15)
        ],
      ),
    );
  }
}
