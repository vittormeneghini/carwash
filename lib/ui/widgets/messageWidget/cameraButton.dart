import 'dart:io';
import 'package:carwashapp/core/models/contractModel.dart';
import 'package:carwashapp/core/models/personModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraButton extends StatelessWidget {

  Contract contract;
  Person loggedPerson;
  
  CameraButton({this.contract, this.loggedPerson});

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    print(true);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.photo_camera,
          color: Colors.blueAccent[400],
        ),
        onPressed: getImage);
  }
}

