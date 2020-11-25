import 'dart:io';

import 'package:Pigeon/src/screens/login/login_view.dart';
import 'package:Pigeon/src/screens/register/register_controller.dart';
import 'package:Pigeon/src/widgets/auth.dart';
import 'package:Pigeon/src/widgets/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  RegisterController _registerController;

  @override
  void initState() {
    super.initState();
    _registerController = RegisterController(context: context);
  }

  String name;
  String phone;
  File _imageFile;
  bool isFile = false;
  String localRes;
  String localResOk;
  final picker = ImagePicker();

  /// Get from gallery
  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    _cropImage(pickedFile.path);
  }

  /// Crop Image
  _cropImage(filePath) async {
    File croppedImage = await ImageCropper.cropImage(
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    if (croppedImage != null) {
      _imageFile = croppedImage;
      setState(() {
        isFile = true;
      });
    } else {
      print('No image selected.');
    }
  }

  var jsonData;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _registerController.streamController.stream,
        builder: (context, snapshot) {
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
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 70, right: 70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: _getFromGallery,
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                // boxShadow: [
                                //   new BoxShadow(
                                //     color: Colors.grey.shade300,
                                //     blurRadius: 24.0,
                                //     offset: Offset(5, 10),
                                //   ),
                                // ],
                                borderRadius: BorderRadius.circular(13),
                                color: _imageFile == null
                                    ? Color(0xff481984)
                                    : Colors.white,
                              ),
                              child: Center(
                                child: _imageFile == null
                                    ? Text(
                                        'Upload file',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : CircleAvatar(
                                        radius: 50,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.file(
                                            _imageFile,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.00002,
                          ),
                          Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  textFieldForRegistration(
                                      editingController:
                                          _registerController.nameController,
                                      keyType: TextInputType.name,
                                      label: "Name",
                                      errMsg: "Please Enter your Name."),
                                  textFieldForRegistration(
                                      editingController:
                                          _registerController.phoneNoController,
                                      keyType: TextInputType.phone,
                                      label: "Phone",
                                      isPhone: true,
                                      errMsg: "Please Enter your Mobile no."),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    constraints:
                                        const BoxConstraints(maxWidth: 500),
                                    child: RaisedButton(
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          _registerController.submitForm();
                                        }
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
                                              'Fly',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20)),
                                                color:
                                                    MyColors.primaryColorLight,
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      },
                      child: Text(
                        "Already riding our pigeon flight, Login here!",
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
        });
  }
}
