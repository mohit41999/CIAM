import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/Screens/Signup.dart';
import 'package:patient/Utils/colorsandstyles.dart';
import 'package:patient/controller/sign_in_controller.dart';
import 'package:patient/widgets/common_app_bar_title.dart';
import 'package:patient/widgets/common_button.dart';
import 'package:patient/widgets/enter_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SignInController _controller = SignInController();
  bool password = true;

  @override
  void initState() {
    // setupFirebase(context);
    // FirebaseNotificationHandling().setupFirebase(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: appAppBarColor,
        elevation: 0,
        title: commonAppBarTitle(),
      ),
      body:
          //     ListView(
          //   children: [
          //     Container(
          //       height: MediaQuery.of(context).size.height / 2.5,
          //       child: Stack(
          //         children: [
          //           Column(
          //             children: [
          //               Expanded(
          //                 child: Container(
          //                   color: appblueColor,
          //                 ),
          //               ),
          //               Expanded(
          //                 flex: 3,
          //                 child: Container(
          //                   decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.only(
          //                         bottomLeft: Radius.circular(500),
          //                         bottomRight: Radius.circular(500),
          //                       ),
          //                       color: appblueColor),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.only(bottom: 20.0),
          //             child: Align(
          //               alignment: Alignment.bottomCenter,
          //               child:
          //                   Container(child: Image.asset('assets/pngs/signin.png')),
          //             ),
          //           ),
          //           Align(
          //             alignment: Alignment.topRight,
          //             child: Padding(
          //               padding: const EdgeInsets.fromLTRB(0, 40, 20, 0),
          //               child: Container(
          //                 decoration: BoxDecoration(
          //                     border: Border.all(color: Colors.white),
          //                     borderRadius: BorderRadius.circular(20)),
          //                 child: Padding(
          //                   padding: const EdgeInsets.symmetric(
          //                       horizontal: 16.0, vertical: 2),
          //                   child: Text(
          //                     'Skip',
          //                     style: GoogleFonts.montserrat(
          //                         color: Colors.white, fontSize: 12),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //       child: Column(
          //         children: [
          //           SizedBox(
          //             height: 30,
          //           ),
          //           EnterField('Email ID', 'Email ID', _controller.email),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           EnterField(
          //             'Password',
          //             'Password',
          //             _controller.password,
          //             obscure: password,
          //             widget: IconButton(
          //                 onPressed: () {
          //                   setState(() {
          //                     (password) ? password = false : password = true;
          //                   });
          //                 },
          //                 icon: (password)
          //                     ? Icon(
          //                         FontAwesomeIcons.eyeSlash,
          //                         color: Colors.black.withOpacity(0.5),
          //                       )
          //                     : Icon(
          //                         FontAwesomeIcons.eye,
          //                         color: Colors.black.withOpacity(0.5),
          //                       )),
          //           ),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           Align(
          //             alignment: Alignment.bottomLeft,
          //             child: Text(
          //               'Forgot Password ?',
          //               textAlign: TextAlign.right,
          //               style: GoogleFonts.montserrat(color: Colors.red),
          //             ),
          //           ),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           commonBtn(
          //               s: 'Log In',
          //               width: MediaQuery.of(context).size.width / 3,
          //               bgcolor: appblueColor,
          //               textColor: Colors.white,
          //               onPressed: () {
          //                 _controller.SignIn(context);
          //                 //               // AuthenticationHelper()
          //                 //               //     .signIn(
          //                 //               //         email: _controller.email.text,
          //                 //               //         password: _controller.password.text)
          //                 //               //     .then((result) {
          //                 //               //   if (result == null) {
          //                 //               //     _controller.SignIn(context);
          //                 //               //   } else {
          //                 //               //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //                 //               //       content: Text(
          //                 //               //         result,
          //                 //               //         style: TextStyle(fontSize: 16),
          //                 //               //       ),
          //                 //               //     ));
          //                 //               //   }
          //                 //               // });
          //                 //
          //                 //               //Push(context, GeneralScreen2());
          //                 //               // Push(context, GeneralScreen());
          //               }),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           commonBtn(
          //               s: ' or Sign Up',
          //               width: MediaQuery.of(context).size.width / 3,
          //               bgcolor: Colors.transparent,
          //               textColor: appblueColor,
          //               onPressed: () {
          //                 Navigator.push(context,
          //                     MaterialPageRoute(builder: (context) => SignUpPage()));
          //                 // navigate to desired screen
          //               }),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           Row(
          //             children: [
          //               RichText(
          //                   text: TextSpan(
          //                       text: 'By continuing, you agree to our ',
          //                       style: GoogleFonts.montserrat(color: Colors.black),
          //                       children: [
          //                     TextSpan(
          //                         text: 'Privacy Policy',
          //                         style: GoogleFonts.montserrat(
          //                           color: Colors.blue,
          //                         )),
          //                   ])),
          //               Icon(Icons.question_mark),
          //             ],
          //           )
          //         ],
          //       ),
          //     ),
          //   ],
          // )
          SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign In',
                style: GoogleFonts.montserrat(
                    fontSize: 30,
                    color: appblueColor,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Please Sign In to your account !!!',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: apptealColor,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              EnterField('Email ID', 'Email ID', _controller.email),
              SizedBox(
                height: 20,
              ),
              EnterField(
                'Password',
                'Password',
                _controller.password,
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
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Forgot Password ?',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.montserrat(color: appblueColor),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Remember Me',
                textAlign: TextAlign.right,
                style: GoogleFonts.montserrat(color: Color(0xff515151)),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'or Sign In with Fingerprint or Face',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.montserrat(color: apptealColor),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/pngs/Icon ionic-md-finger-print.png',
                      height: 90),
                  Image.asset('assets/pngs/Icon material-face.png', height: 90),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              commonBtn(
                  s: 'Sign In',
                  bgcolor: appblueColor,
                  textColor: Colors.white,
                  onPressed: () {
                    _controller.SignIn(context);
                    // AuthenticationHelper()
                    //     .signIn(
                    //         email: _controller.email.text,
                    //         password: _controller.password.text)
                    //     .then((result) {
                    //   if (result == null) {
                    //     _controller.SignIn(context);
                    //   } else {
                    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //       content: Text(
                    //         result,
                    //         style: TextStyle(fontSize: 16),
                    //       ),
                    //     ));
                    //   }
                    // });

                    //Push(context, GeneralScreen2());
                    // Push(context, GeneralScreen());
                  }),
              SizedBox(
                height: 20,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                      text: 'Don\'t have an DCP account ?',
                      style: TextStyle(color: Color(0xff515151), fontSize: 18),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Sign up',
                            style: TextStyle(color: apptealColor, fontSize: 18),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPage()));
                                // navigate to desired screen
                              })
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
