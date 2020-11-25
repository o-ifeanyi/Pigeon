import 'dart:async';

import 'package:Pigeon/src/data/models/custom_error.dart';
import 'package:Pigeon/src/data/models/user.dart';
import 'package:Pigeon/src/data/repositories/register_repository.dart';
import 'package:Pigeon/src/screens/home/home_view.dart';
import 'package:Pigeon/src/utils/custom_shared_preferences.dart';
import 'package:Pigeon/src/utils/state_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterController extends StateControl {
  final BuildContext context;

  RegisterRepository _registerRepository = RegisterRepository();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  bool _isFormValid = false;
  get isFormValid => _isFormValid;

  bool _formSubmitting = false;
  get formSubmitting => _formSubmitting;

  RegisterController({
    @required this.context,
  }) {
    this.init();
  }

  void init() {
    this.nameController.addListener(this.validateForm);
    this.phoneNoController.addListener(this.validateForm);
  }

  void validateForm() {
    bool isFormValid = _isFormValid;
    String name = this.nameController.value.text;
    String phoneNo = this.phoneNoController.value.text;
    if (name.trim() == "" || phoneNo.trim() == "") {
      isFormValid = false;
    } else {
      isFormValid = true;
    }
    _isFormValid = isFormValid;
    notifyListeners();
  }

  void submitForm() async {
    _formSubmitting = true;
    notifyListeners();
    String name = this.nameController.value.text;
    String phoneNo = this.phoneNoController.value.text;
    var loginResponse = await _registerRepository.register(
      name,
      phoneNo,
    );
    if (loginResponse is CustomError) {
      showAlertDialog(loginResponse.errorMessage);
    } else if (loginResponse is User) {
      await CustomSharedPreferences.setString('user', loginResponse.toString());
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (_) => false);
    }
    _formSubmitting = false;
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

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneNoController.dispose();
  }
}
