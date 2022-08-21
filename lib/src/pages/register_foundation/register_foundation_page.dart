import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:polygon_hackathon_flutter/my_colors.dart';
import 'package:polygon_hackathon_flutter/src/pages/register_foundation/register_foundation_controller.dart';

class RegisterFoundationPage extends StatefulWidget {
  @override
  _RegisterFoundationPageState createState() => _RegisterFoundationPageState();
}

class _RegisterFoundationPageState extends State<RegisterFoundationPage> {
  RegisterFoundationController _registerFoundationController =
      new RegisterFoundationController();
  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _registerFoundationController.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DonatyColors.primaryColor1,
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Column(
              children: [
                Header(size: size),
                SizedBox(height: size.height * 0.02),
                _textfieldFoundationName(size: size),
                _textfieldEmail(size: size),
                _textfieldCountry(size: size),
                _textfieldCauseDescription(size: size),
                DividerLine(size: size),
                SizedBox(height: size.height * 0.02),
                _foundationProfileImage(
                    _registerFoundationController.profileImage, 1, context),
                _buttonCreateProduct()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonCreateProduct() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _registerFoundationController.registerFoundation,
        child: Text('Register'),
        style: ElevatedButton.styleFrom(
            primary: DonatyColors.primaryColor3,
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  Widget _textfieldFoundationName({Size size}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: TextField(
        style: TextStyle(color: DonatyColors.primaryColor4),
        controller: _registerFoundationController.nameController,
        maxLines: 1,
        maxLength: 180,
        decoration: InputDecoration(
          counterStyle: TextStyle(color: DonatyColors.primaryColor4),
          hintText: 'Name...',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: DonatyColors.primaryColor3,
          ),
          prefixIcon: Icon(
            Icons.person,
            color: DonatyColors.primaryColor3,
            size: size.width * 0.1,
          ),
        ),
      ),
    );
  }

  Widget _textfieldEmail({Size size}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: TextField(
        style: TextStyle(color: DonatyColors.primaryColor4),
        controller: _registerFoundationController.emailController,
        maxLines: 1,
        maxLength: 180,
        decoration: InputDecoration(
          counterStyle: TextStyle(color: DonatyColors.primaryColor4),
          hintText: 'Email...',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: DonatyColors.primaryColor3,
          ),
          prefixIcon: Icon(
            Icons.email,
            color: DonatyColors.primaryColor3,
            size: size.width * 0.1,
          ),
        ),
      ),
    );
  }

  Widget _textfieldCountry({Size size}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: TextField(
        style: TextStyle(color: DonatyColors.primaryColor4),
        controller: _registerFoundationController.countryController,
        maxLines: 1,
        maxLength: 180,
        decoration: InputDecoration(
          counterStyle: TextStyle(color: DonatyColors.primaryColor4),
          hintText: 'Country...',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: DonatyColors.primaryColor3,
          ),
          prefixIcon: Icon(
            Icons.map_outlined,
            color: DonatyColors.primaryColor3,
            size: size.width * 0.1,
          ),
        ),
      ),
    );
  }

  Widget _textfieldCauseDescription({Size size}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: TextField(
        style: TextStyle(color: DonatyColors.primaryColor4),
        controller: _registerFoundationController.descriptionController,
        maxLines: 1,
        maxLength: 300,
        decoration: InputDecoration(
          counterStyle: TextStyle(color: DonatyColors.primaryColor4),
          hintText: 'Description / Foundation Cause',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: DonatyColors.primaryColor3,
          ),
          prefixIcon: Icon(
            Icons.description,
            color: DonatyColors.primaryColor3,
            size: size.width * 0.1,
          ),
        ),
      ),
    );
  }

  Widget _foundationProfileImage(
      File imageFile, int fileNumber, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            _registerFoundationController.showAlertDialog(fileNumber, context);
          },
          child: imageFile != null
              ? Card(
                  elevation: 3.0,
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Image.file(
                      imageFile,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Card(
                  elevation: 3.0,
                  child: Container(
                      color: DonatyColors.primaryColor2,
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: 40,
                          color: DonatyColors.primaryColor4,
                        ),
                      )),
                ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Text(
            'Upload Foundation Profile Image',
            style: TextStyle(
              color: DonatyColors.primaryColor4,
              fontSize: 18,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class DividerLine extends StatelessWidget {
  const DividerLine({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width * 0.85,
        child: Divider(color: DonatyColors.primaryColor2, thickness: 2));
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width * 0.52,
                child: Divider(
                  color: DonatyColors.primaryColor3,
                  thickness: 2,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                "Register your Foundation",
                style: TextStyle(
                  fontSize: 18,
                  color: DonatyColors.primaryColor4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                width: size.width * 0.9,
                child: Text(
                  "Fill the following form in order to complete the registration process",
                  style: TextStyle(
                    color: DonatyColors.primaryColor4,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
