import 'package:Pigeon/src/screens/login/login_controller.dart';
import 'package:Pigeon/src/widgets/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:Pigeon/constants.dart';

class LoginScreen extends StatefulWidget {
  static final String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController _loginController;

  @override
  void initState() {
    super.initState();
    _loginController = LoginController(context: context);
  }

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _loginController.streamController.stream,
        builder: (context, snapshot) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            // backgroundColor: primaryColor,
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
                            "Pigeon",
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
                      child: ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              TextField(
                                controller: _loginController.phoneController,
                                // decoration: InputDecoration(labelText: 'User name'),
                                showCursor: false,
                                readOnly: true,
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
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
                                constraints:
                                    const BoxConstraints(maxWidth: 500),
                                child: RaisedButton(
                                  onPressed: () {
                                    print(
                                        _loginController.phoneController.text);
                                    _loginController.submitForm();
                                  },
                                  color: MyColors.primaryColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(14))),
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
                                            borderRadius:
                                                const BorderRadius.all(
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
                        text = text.substring(0,
                            _loginController.phoneController.text.length - 1);
                        _loginController.phoneController.text = text;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/register');
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

          // Scaffold(
          //   body: SafeArea(
          //     child: Container(
          //       child: ListView(
          //         children: <Widget>[
          //           Padding(
          //             padding: const EdgeInsets.all(15),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.stretch,
          //               children: <Widget>[
          //                 Text(
          //                   'Login',
          //                   style: TextStyle(
          //                     color: Colors.black,
          //                     fontSize: 26,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 5,
          //                 ),
          //                 Text(
          //                   'To continue, fill in the fields below.',
          //                   style: TextStyle(
          //                     fontSize: 12,
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 60,
          //                 ),
          //                 TextField(
          //                   cursorColor: Theme.of(context).primaryColor,
          //                   controller: _loginController.usernameController,
          //                   decoration: InputDecoration(labelText: 'User name'),
          //                 ),
          //                 SizedBox(
          //                   height: 15,
          //                 ),
          //                 TextField(
          //                   cursorColor: Theme.of(context).primaryColor,
          //                   controller: _loginController.passwordController,
          //                   decoration: InputDecoration(labelText: 'password'),
          //                   onSubmitted: (_) {
          //                     _loginController.submitForm();
          //                   },
          //                   obscureText: true,
          //                 ),
          //                 SizedBox(
          //                   height: 45,
          //                 ),
          //                 MyButton(
          //                   title: _loginController.formSubmitting
          //                       ? 'ENTERING...'
          //                       : 'LOG IN',
          //                   onTap: _loginController.submitForm,
          //                   disabled: !_loginController.isFormValid ||
          //                       _loginController.formSubmitting,
          //                 ),
          //                 SizedBox(
          //                   height: 35,
          //                 ),
          //                 GestureDetector(
          //                   onTap: () {
          //                     Navigator.of(context).pushNamed('/register');
          //                   },
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(10),
          //                     child: Container(
          //                       alignment: Alignment.center,
          //                       child: Text(
          //                         'Don\'t have an account yet? Create it now.',
          //                         style: TextStyle(
          //                           color: Colors.grey,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // );
        });
  }

  String text = '';

  void _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
      if (text.length > 10) return;
      _loginController.phoneController.text = text;
    });
  }
}
