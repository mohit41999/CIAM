import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/NavigationController.dart';
import 'package:patient/controller/sign_up_controller.dart';
import 'package:patient/widgets/commonAppBarLeading.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/enter_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpController _con = SignUpController();
  bool password = true;
  bool confirmpassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonAppBarTitle(),
        leading: commonAppBarLeading(
            iconData: Icons.arrow_back_ios_new,
            onPressed: () {
              Pop(context);
            }),
        centerTitle: true,
        backgroundColor: appAppBarColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign Up',
                style: GoogleFonts.montserrat(
                    fontSize: 30,
                    color: Color(0xff233E8B),
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'New to DCP ? Please provide your details !!!',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: apptealColor,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              EnterField(
                'Firstname',
                'Firstname',
                _con.firstname,
              ),
              SizedBox(
                height: 20,
              ),
              EnterField(
                'Lastname',
                'Lastname ',
                _con.lastname,
              ),
              SizedBox(
                height: 20,
              ),
              EnterField('Email ID', 'Email ID', _con.email_Id),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Material(
                    elevation: 5,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    child: CountryCodePicker(
                      onChanged: (v) {
                        print(v.toString());
                        _con.countrycode = v.dialCode.toString();

                        print(_con.countrycode);
                      },
                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      initialSelection: 'IN',
                      favorite: ['+91', 'IN'],
                      // optional. Shows only country name and flag
                      showCountryOnly: false,
                      showFlagDialog: true,
                      showFlag: false,
                      // optional. Shows only country name and flag when popup is closed.
                      showOnlyCountryWhenClosed: false,
                      // optional. aligns the flag and the Text left
                      alignLeft: false,
                      textStyle: GoogleFonts.montserrat(
                          fontSize: 14, color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: EnterField(
                    'Mobile Number',
                    'Mobile Number',
                    _con.mobile_number,
                    textInputType: TextInputType.number,
                  )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              EnterField(
                'Password',
                'Password',
                _con.password,
                obscure: password,
                widget: IconButton(
                    onPressed: () {
                      setState(() {
                        (password) ? password = false : password = true;
                      });
                    },
                    icon: (password)
                        ? Icon(FontAwesomeIcons.eyeSlash)
                        : Icon(FontAwesomeIcons.eye)),
              ),
              SizedBox(
                height: 20,
              ),
              EnterField(
                'Confirm Password',
                'Confirm Password',
                _con.confirmpassword,
                obscure: confirmpassword,
                widget: IconButton(
                    onPressed: () {
                      setState(() {
                        (confirmpassword)
                            ? confirmpassword = false
                            : confirmpassword = true;
                      });
                    },
                    icon: (confirmpassword)
                        ? Icon(FontAwesomeIcons.eyeSlash)
                        : Icon(FontAwesomeIcons.eye)),
              ),
              SizedBox(
                height: 40,
              ),
              commonBtn(
                  s: 'Sign Up',
                  bgcolor: appblueColor,
                  textColor: Colors.white,
                  onPressed: () {
                    _con.Signup(context);
                    // AuthenticationHelper()
                    //     .signUp(
                    //         email: _con.email_Id.text,
                    //         password: _con.password.text,
                    //         username: _con.firstname.text + _con.lastname.text)
                    //     .then((result) {
                    //   if (result == null) {
                    //     _con.Signup(context);
                    //   } else {
                    //     Scaffold.of(context).showSnackBar(SnackBar(
                    //       content: Text(
                    //         result,
                    //         style: TextStyle(fontSize: 16),
                    //       ),
                    //     ));
                    //   }
                    // });

                    // Push(context, SignInScreen());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
