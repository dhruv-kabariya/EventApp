import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File> pickImageFromGallery(int quality) async {
  File image = await ImagePicker.pickImage(
      source: ImageSource.gallery, imageQuality: quality);
  return image;
}

Future<File> pickImageFromCamera(int quality) async {
  File image = await ImagePicker.pickImage(
      source: ImageSource.camera, imageQuality: quality);
  return image;
}
