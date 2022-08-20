import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:polygon_hackathon_flutter/my_colors.dart';

import '../../../nft_controller.dart';

class UploadNftPage extends StatefulWidget {
  UploadNftPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UploadNftPageState createState() => _UploadNftPageState();
}

class _UploadNftPageState extends State<UploadNftPage> {
  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  NftController _con = new NftController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _textfieldNftName(),
              _textfieldNftDescription(),
              _textfieldNftPrice(),
              _selectNftImage(_con.imageFile1, 1),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buttonCreateNft(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _textfieldNftName() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: DonatyColors.primaryColor2,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _con.nameController,
        maxLines: 1,
        maxLength: 180,
        decoration: InputDecoration(
            hintText: 'New Nft Name',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
              color: DonatyColors.primaryColor3,
            ),
            suffixIcon: Icon(Icons.local_pizza_outlined,
                color: DonatyColors.primaryColor1)),
      ),
    );
  }

  Widget _textfieldNftDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: DonatyColors.primaryColor2,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _con.descriptionController,
        maxLines: 2,
        maxLength: 255,
        decoration: InputDecoration(
            hintText: 'Nft Description',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
              color: DonatyColors.primaryColor3,
            ),
            suffixIcon: Icon(Icons.description_outlined,
                color: DonatyColors.primaryColor1)),
      ),
    );
  }

  Widget _textfieldNftPrice() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: DonatyColors.primaryColor2,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _con.priceController,
        keyboardType: TextInputType.phone,
        maxLines: 1,
        decoration: InputDecoration(
            hintText: 'Nft price',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
              color: DonatyColors.primaryColor3,
            ),
            suffixIcon: Icon(Icons.monetization_on_outlined,
                color: DonatyColors.primaryColor1)),
      ),
    );
  }

  Widget _selectNftImage(File imageFile, int fileNumber) {
    return GestureDetector(
      onTap: () {
        _con.showAlertDialog(fileNumber);
      },
      child: imageFile != null
          ? Card(
              elevation: 3.0,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                // height: MediaQuery.of(context).size.width * 0.5,
                // width: MediaQuery.of(context).size.width * 0.5,
                child: Image.file(
                  imageFile,
                  fit: BoxFit.contain,
                ),
              ),
            )
          : Card(
              elevation: 3.0,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.26,
                child: Image(
                  image: AssetImage('assets/img/imagen.png'),
                ),
              ),
            ),
    );
  }

  /// It creates a button that when pressed will create an NFT.
  Widget _buttonCreateNft() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.createNft,
        child: Text('Create Nft'),
        style: ElevatedButton.styleFrom(
            primary: DonatyColors.primaryColor1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }
}
