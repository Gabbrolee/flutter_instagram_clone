import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

pickImage(ImageSource source) async{
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file;
  try{
    _file = await _imagePicker.pickImage(source: source);
    if(_file != null) {
      return await _file.readAsBytes();
    }
  }catch(e){
    print("No image selected $e");
  }
  }


 showSnackBar(String message, BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)));
 }