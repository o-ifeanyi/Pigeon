import 'dart:async';

import 'package:Pigeon/src/data/models/custom_error.dart';
import 'package:Pigeon/src/data/models/user.dart';
import 'package:Pigeon/src/data/repositories/login_repository.dart';
import 'package:Pigeon/src/screens/home/home_view.dart';
import 'package:Pigeon/src/screens/opt/otp_view.dart';
import 'package:Pigeon/src/utils/custom_shared_preferences.dart';
import 'package:Pigeon/src/utils/state_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginController extends StateControl {
  LoginRepository _loginRepository = LoginRepository();

  final BuildContext context;

  TextEditingController phoneController = TextEditingController();

  bool _isFormValid = false;
  get isFormValid => _isFormValid;

  bool _formSubmitting = false;
  get formSubmitting => _formSubmitting;

  LoginController({
    @required this.context,
  }) {
    this.init();
  }

  void init() {
    this.phoneController.addListener(this.validateForm);
  }

  @override
  void dispose() {
    super.dispose();
    this.phoneController.dispose();
  }

  void submitForm() async {
    _formSubmitting = true;
    notifyListeners();
    String phoneNo = this.phoneController.value.text;
    var loginResponse = await _loginRepository.login(phoneNo);
    if (loginResponse is CustomError) {
      showAlertDialog(loginResponse.errorMessage);
    } else if (loginResponse is User) {
      print("user:");
      print(loginResponse);

      Navigator.of(context).pushReplacementNamed(OtpVerifyScreen.routeName);
      // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
    _formSubmitting = false;
    notifyListeners();
  }

  void validateForm() {
    bool isFormValid = _isFormValid;
    String phoneNo = this.phoneController.value.text;
    if (phoneNo.trim() == "") {
      isFormValid = false;
    } else {
      isFormValid = true;
    }
    _isFormValid = isFormValid;
    notifyListeners();
  }

  showAlertDialog(String message) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // configura o  AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Check for errors"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
