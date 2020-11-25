import 'dart:async';
import 'dart:convert';

import 'package:Pigeon/src/data/models/custom_error.dart';
import 'package:Pigeon/src/data/models/user.dart';
import 'package:Pigeon/src/screens/home/home_view.dart';
import 'package:Pigeon/src/utils/custom_shared_preferences.dart';
import 'package:Pigeon/src/utils/state_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Pigeon/src/data/repositories/opt_repository.dart';

class OTPController extends StateControl {
  OTPRepository _OTPRepository = OTPRepository();

  final BuildContext context;

  User myUser;

  TextEditingController otpController = TextEditingController();

  bool _isFormValid = false;
  get isFormValid => _isFormValid;

  bool _formSubmitting = false;
  get formSubmitting => _formSubmitting;

  OTPController({
    @required this.context,
  }) {
    this.init();
  }

  void init() {
    this.otpController.addListener(this.validateForm);
    getMyUser();
  }

  getMyUser() async {
    myUser = await CustomSharedPreferences.getMyUser();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    this.otpController.dispose();
  }

  void submitForm() async {
    _formSubmitting = true;
    notifyListeners();
    String otp = this.otpController.value.text;
    var otpResponse = await _OTPRepository.otp(otp, "asd");
    if (otpResponse is CustomError) {
      showAlertDialog(otpResponse.errorMessage);
    } else if (otpResponse is User) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
    _formSubmitting = false;
    notifyListeners();
  }

  void validateForm() {
    bool isFormValid = _isFormValid;
    String otp = this.otpController.value.text;
    if (otp.trim() == "" && otp.length == 6) {
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
