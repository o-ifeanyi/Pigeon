import 'package:flutter/material.dart';

Widget dataText({
  TextEditingController editingController,
  TextInputType keyType,
  bool isPhone = false,
  bool showCursor = true,
  bool readOnly = false,
  String errMsg,
  String label,
}) {
  bool showHint = false;
  return TextFormField(
    maxLength: isPhone ? 10 : null,
    controller: editingController,
    keyboardType: keyType,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return errMsg;
      }
      return null;
    },
    onEditingComplete: () {
      showHint = true;
    },
    decoration: InputDecoration(
      hintText: label,
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.amber,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xff481984),
        ),
      ),
      helperText: isPhone
          ? ""
          : showHint
              ? "Nice name " + editingController.text + "!"
              : "",
      labelText: label,
    ),
  );
}
