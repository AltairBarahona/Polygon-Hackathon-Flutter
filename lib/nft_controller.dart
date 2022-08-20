import 'dart:io';

import 'package:flutter/material.dart';
import 'package:polygon_hackathon_flutter/nft_model.dart';
import 'package:image_picker/image_picker.dart';

import 'src/global_widgets/my_snackbar.dart';

class NftController {
  BuildContext context;
  Function refresh;
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  MoneyMaskedTextController priceController = new MoneyMaskedTextController();

  File imageFile1;
  PickedFile pickedFile;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
  }

  void createNft() async {
    String name = nameController.text;
    String description = descriptionController.text;
    double price = priceController.numberValue;
    if (name.isEmpty || description.isEmpty || price == 0) {
      MySnackbar.show(context, 'Debe ingresar todos los campos');
      return;
    }
    if (imageFile1 == null) {
      MySnackbar.show(context, 'Selecciona 3 imágenes');
      return;
    }
    Nft product = new Nft(
      name: name,
      description: description,
      price: price,
      // idCategory: int.parse(idCategory));
    );
  }

  Future selectImage(ImageSource imageSource, int fileNumber) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      if (fileNumber == 1) {
        imageFile1 = File(pickedFile.path);
      }
    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog(int fileNumber) {
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

class MoneyMaskedTextController extends TextEditingController {
  MoneyMaskedTextController(
      {double initialValue = 0.0,
      this.decimalSeparator = ',',
      this.thousandSeparator = '.',
      this.rightSymbol = '',
      this.leftSymbol = '',
      this.precision = 2}) {
    _validateConfig();

    this.addListener(() {
      this.updateValue(this.numberValue);
      this.afterChange(this.text, this.numberValue);
    });

    this.updateValue(initialValue);
  }

  final String decimalSeparator;
  final String thousandSeparator;
  final String rightSymbol;
  final String leftSymbol;
  final int precision;

  Function afterChange = (String maskedValue, double rawValue) {};

  double _lastValue = 0.0;

  void updateValue(double value) {
    double valueToUse = value;

    if (value.toStringAsFixed(0).length > 12) {
      valueToUse = _lastValue;
    } else {
      _lastValue = value;
    }

    String masked = this._applyMask(valueToUse);

    if (rightSymbol.length > 0) {
      masked += rightSymbol;
    }

    if (leftSymbol.length > 0) {
      masked = leftSymbol + masked;
    }

    if (masked != this.text) {
      this.text = masked;

      var cursorPosition = super.text.length - this.rightSymbol.length;
      this.selection = new TextSelection.fromPosition(
          new TextPosition(offset: cursorPosition));
    }
  }

  double get numberValue {
    List<String> parts =
        _getOnlyNumbers(this.text).split('').toList(growable: true);

    parts.insert(parts.length - precision, '.');

    return double.parse(parts.join());
  }

  _validateConfig() {
    bool rightSymbolHasNumbers = _getOnlyNumbers(this.rightSymbol).length > 0;

    if (rightSymbolHasNumbers) {
      throw new ArgumentError("rightSymbol must not have numbers.");
    }
  }

  String _getOnlyNumbers(String text) {
    String cleanedText = text;

    var onlyNumbersRegex = new RegExp(r'[^\d]');

    cleanedText = cleanedText.replaceAll(onlyNumbersRegex, '');

    return cleanedText;
  }

  String _applyMask(double value) {
    List<String> textRepresentation = value
        .toStringAsFixed(precision)
        .replaceAll('.', '')
        .split('')
        .reversed
        .toList(growable: true);

    textRepresentation.insert(precision, decimalSeparator);

    for (var i = precision + 4; true; i = i + 4) {
      if (textRepresentation.length > i) {
        textRepresentation.insert(i, thousandSeparator);
      } else {
        break;
      }
    }

    return textRepresentation.reversed.join('');
  }
}
