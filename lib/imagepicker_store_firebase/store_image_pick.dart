import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiirebasee/imagepicker_store_firebase/image_controller.dart';
import 'package:fiirebasee/utils/toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePick extends StatelessWidget {
  ImagePick({super.key});

  final c = Get.put(ImageCTRL());
  final fireStoreRef = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Image Pick",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                c.pickImageGallery();
              },
              child: Container(
                width: 200,
                height: 200,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Obx(
                  () => c.image.value != null
                      ? Image.file(c.image.value!.absolute)
                      : const Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                final ref = FirebaseStorage.instance.ref('/Dharmik/' +
                    DateTime.now().microsecondsSinceEpoch.toString());
                UploadTask task = ref.putFile(c.image.value!.absolute);

                Future.value(task).then((value) async {
                  var newUrl = await ref.getDownloadURL();
                  fireStoreRef.doc('2204').set({
                    'id': 2204,
                    'about': newUrl.toString(),
                  }).then((value) {
                    ToastMessage().toastMessage("Uploaded Successfully");
                  }).onError((error, stackTrace) {
                    ToastMessage().toastMessage(error.toString());
                  });
                });
              },
              child: const Text("Upload Image"))
        ],
      ),
    );
  }
}
