import 'package:Pigeon/models/Users.dart';
import 'package:Pigeon/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import '../constants.dart';

class OtpVerifyScreen extends StatefulWidget {
  static const String otpPageRoute = "OTP_PAGE_ROUTE";
  final String authToken;
  final String name;
  final int otp;
  final String phone;
  final Users me;

  const OtpVerifyScreen(
      {Key key,
      @required this.otp,
      @required this.name,
      @required this.phone,
      this.me,
      @required this.authToken})
      : super(key: key);
  @override
  _OtpVerifyScreenState createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  String text = '';

  void _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Text(
          text[position],
          style: TextStyle(color: Colors.black),
        )),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      // leading: IconButton(
      //   icon: Container(
      //     padding: const EdgeInsets.all(10),
      //     decoration: BoxDecoration(
      //       borderRadius: const BorderRadius.all(Radius.circular(20)),
      //       color: MyColors.primaryColorLight.withAlpha(20),
      //     ),
      //     child: Icon(
      //       Icons.arrow_back_ios,
      //       color: MyColors.primaryColor,
      //       size: 16,
      //     ),
      //   ),
      //   onPressed: () => Navigator.of(context).pop(),
      // ),
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   brightness: Brightness.light,
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Welcome,",
                                  style: TextStyle(
                                    color: Color(0xff481984),
                                    fontSize: 26,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  widget.name.split(" ")[0],
                                  style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                      color: Color(0xff481984),
                                      fontSize: 54,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Our pigeon must have \narrived at you with an OTP. \nPlease check your inbox.",
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                Text(
                                  widget.otp.toString(),
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  otpNumberWidget(0),
                                  otpNumberWidget(1),
                                  otpNumberWidget(2),
                                  otpNumberWidget(3),
                                  otpNumberWidget(4),
                                  otpNumberWidget(5),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16, left: 18),
                                    child: Text("Wrong Number?"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16, right: 18),
                                    child: Text("Resend OTP"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: RaisedButton(
                      onPressed: () {
                        widget.otp.toString() == text
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                      authToken: widget.authToken,
                                      me: widget.me),
                                ),
                              )
                            : print("Wrong OTP");
                      },
                      color: MyColors.primaryColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Confirm',
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                color: MyColors.primaryColorLight,
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  NumericKeyboard(
                    onKeyboardTap: _onKeyboardTap,
                    textColor: MyColors.primaryColorLight,
                    rightIcon: Icon(
                      Icons.backspace,
                      color: MyColors.primaryColorLight,
                    ),
                    rightButtonFn: () {
                      setState(() {
                        text = text.substring(0, text.length - 1);
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
