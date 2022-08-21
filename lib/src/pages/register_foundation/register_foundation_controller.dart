import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polygon_hackathon_flutter/src/global_widgets/my_snackbar.dart';
import 'package:polygon_hackathon_flutter/src/models/foundation.dart';
import 'package:polygon_hackathon_flutter/src/models/response_api.dart';
import 'package:polygon_hackathon_flutter/src/provider/foundations_provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterFoundationController {
  BuildContext context;
  Function refresh;
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  File profileImage;
  PickedFile pickedFile;
  ProgressDialog _progressDialog;
  FoundationsProvider _foundationsProvider = new FoundationsProvider();
  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _progressDialog = new ProgressDialog(context: context);
    _foundationsProvider.init(context);
  }

  void registerFoundation() async {
    String name = nameController.text;
    String email = emailController.text;
    String country = countryController.text;
    String description = descriptionController.text;
    if (name.isEmpty ||
        email.isEmpty ||
        country.isEmpty ||
        description.isEmpty) {
      MySnackbar.show(context, 'Complete all information');
      return;
    }
    if (profileImage == null) {
      MySnackbar.show(context, 'Select foundation profile image');
      return;
    }

    FoundationElement foundation = new FoundationElement(
      name: name,
      email: email,
      country: country,
      description: description,
      ethAddress: "asd",
    );
    // _progressDialog.show(max: 100, msg: 'Espere un momento');
    try {
      ResponseApi responseDonatyApi = await _foundationsProvider
          .registerFoundation(foundation, profileImage);
      if (responseDonatyApi == null) {
        // _progressDialog.close();
        MySnackbar.show(context, "Error con respuesta de API");

        return;
      }
      if (responseDonatyApi.success != null && responseDonatyApi.success) {
        // _progressDialog.close();
        MySnackbar.show(context, responseDonatyApi.message);
      } else if (responseDonatyApi.message != null) {
        // _progressDialog.close();

        MySnackbar.show(context, responseDonatyApi.message);
      } else {
        // _progressDialog.close();
        MySnackbar.show(context, "Error con respuesta de API 2");
      }
    } catch (e) {
      // _progressDialog.close();
      MySnackbar.show(context, e.toString());
    }
    // _progressDialog.close();
  }

  void resetValues() {
    nameController.text = '';
    emailController.text = '';
    countryController.text = '';
    descriptionController.text = '';
    profileImage = null;
    refresh();
  }

  Future selectImage(ImageSource imageSource, int fileNumber) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      if (fileNumber == 1) {
        profileImage = File(pickedFile.path);
      }
    }
    // Navigator.pop(context);
    refresh();
  }

  void showAlertDialog(int fileNumber, BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery, fileNumber);
        },
        child: Text('GALERIA'));
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera, fileNumber);
        },
        child: Text('CAMARA'));
    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [galleryButton, cameraButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
