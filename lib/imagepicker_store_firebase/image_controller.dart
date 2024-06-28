import 'dart:io';

import 'package:fiirebasee/utils/toast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageCTRL extends GetxController {
  Rxn<File> image = Rxn<File>();
  final imagePicker = ImagePicker();

  Future pickImageGallery() async {
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);
    if (pickedImage != null) {
      image.value = File(pickedImage.path);
    } else {
      ToastMessage().toastMessage("No Image Selected");
    }
  }
}
