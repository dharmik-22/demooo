import 'package:fiirebasee/fire_store/add_post_ctrl.dart';
import 'package:fiirebasee/fire_store/home_screen_firestore.dart';
import 'package:fiirebasee/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AddPost extends StatelessWidget {
  AddPost({super.key});

  final c = Get.put(AddPostCTRL());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Column(
        children: [
          TextFormField(
            maxLines: 3,
            controller: c.addPostController,
            decoration: const InputDecoration(
              hintText: 'Add Something',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return ' please enter something';
              }
              return null;
            },
          ).paddingAll(20),
          Obx(
            () =>  ElevatedButton(
                onPressed: () {
                  c.isLoading(true);
                  final id = DateTime.now().microsecondsSinceEpoch.toString();
                  c.fireStoreRef.doc(id).set({
                    "about": c.addPostController.text.toString(),
                    "id": id,
                  }).then((value) {
                    c.isLoading(false);
                    ToastMessage().toastMessage("Data Added Successfully");
                    Get.to(HomeScreenFireStore());
                  }).onError((error, stackTrace) {
                    c.isLoading(false);
                    ToastMessage().toastMessage(error.toString());
                  });
                },
                child: c.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text("Add Posts")),
          )
        ],
      ),
    );
  }
}
