import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:image_picker/image_picker.dart';


void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

String getNameFromEmail(String email) => email.split("@")[0];

//pour prendre 1 image soit multiple
Future<List<io.File>> pickImages() async {
  //instance de ImagePicker
  final ImagePicker picker = ImagePicker();
  List<io.File> images = [];
  final imageFiles = await picker.pickMultiImage();
  if (imageFiles.isNotEmpty) {
    for (final image in imageFiles) {
      images.add(io.File(image.path));
    }
  }
  return images;
}

//pour choisir un image 
Future<File?> pickImage() async {
  final ImagePicker picker = ImagePicker();
  final imageFile = await picker.pickImage(source: ImageSource.gallery);
  if (imageFile != null) {
   //return File(imageFile.path);

  }
  return null;
}


