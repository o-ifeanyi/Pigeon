import 'package:Pigeon/constants.dart';
import 'package:Pigeon/screens/registrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:numeric_keyboard/numeric_keyboard.dart';

import 'optScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _phoneTextController;
  void initState() {
    super.initState();
    _phoneTextController = TextEditingController();
  }

  void dispose() {
    _phoneTextController.dispose();
    super.dispose();
  }

  String phone;
  String localRes;
  String localResOk;
  var jsonData;

  void _sendReq() {
    http.post(nodeEndPoint + "/api/user/login",
        body: {"phoneNo": _phoneTextController.text}).then((res) {
      if (res.statusCode == 400)
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(
                  res.body,
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "Create an account",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ),
                      );
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "Ok",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      print(res.statusCode);
      // res.headers.forEach((k, v) => print('$k: $v'));
      jsonData = json.decode(res.body);
      localRes = res.statusCode.toString();
      localResOk = res.body.toString();
      if (localRes == "200" || localResOk == jsonData['body']) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerifyScreen(
              authToken: res.headers['auth-token'],
              name: jsonData['name'],
              otp: jsonData['otp'],
              phone: phone,
            ),
          ),
        );
      }
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Welcome to",
                      style: TextStyle(
                        color: Color(0xff481984),
                        fontSize: 26,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      title,
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          color: Color(0xff481984),
                          fontSize: 54,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              flex: 1,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 70, right: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _phoneTextController,
                              showCursor: false,
                              readOnly: true,
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              // controller: _textEditingController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Phone Number';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Phone Number",
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff481984),
                                  ),
                                ),
                                labelText: 'Phone',
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              constraints: const BoxConstraints(maxWidth: 500),
                              child: RaisedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _sendReq();
                                  }
                                },
                                color: MyColors.primaryColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14))),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Receive OTP',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
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
                          ],
                        ),
                      ),
                    ),
                  ],
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
                  text =
                      text.substring(0, _phoneTextController.text.length - 1);
                  _phoneTextController.text = text;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationScreen(),
                    ),
                  );
                },
                child: Text(
                  "Wanna! ride Pigeon? Register here",
                  style: TextStyle(
                    color: Color(0xff481984),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String text = '';

  void _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
      if (text.length > 10) return;
      _phoneTextController.text = text;
    });
  }
}
