import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EnterField extends StatelessWidget {
  final String hintText;
  final String labelText;
  TextInputType textInputType;
  //final int maxLength;
  bool showcursor;
  bool readonly;
  bool obscure;
  Widget widget;
  //final FormFieldValidator<String> validator;
  TextEditingController controller;
  EnterField(
    this.hintText,
    this.labelText,
    this.controller, {
    this.textInputType = TextInputType.text,
    this.readonly = false,
    this.showcursor = true,
    this.obscure = false,
    this.widget = const SizedBox(
      width: 0,
    ),
    // this.validator = ValidateTextField.validateNull,
    //this.maxLength = 25
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
          minHeight: 10, maxHeight: 50, maxWidth: double.maxFinite),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [],
        ),
        child: TextFormField(
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
          decoration: InputDecoration(
            enabled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: EdgeInsets.all(4),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    new BorderSide(color: Colors.black.withOpacity(0.5))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    new BorderSide(color: Colors.black.withOpacity(0.5))),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: new BorderSide(color: Colors.transparent)),
            // enabledBorder: InputBorder.none,
            // errorBorder: InputBorder.none,
            // disabledBorder: InputBorder.none,
            filled: true,
            labelText: labelText,
            suffixIcon: widget,

            labelStyle: GoogleFonts.montserrat(
                fontSize: 14, color: Colors.black.withOpacity(0.6)),
            hintText: hintText,
            hintStyle: GoogleFonts.montserrat(
                fontSize: 14, color: Colors.black.withOpacity(0.6)),
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
