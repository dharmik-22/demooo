import 'package:fiirebasee/modules/homeScreen.dart';
import 'package:fiirebasee/modules/posts/post_ctrl.dart';
import 'package:fiirebasee/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostScreen extends StatelessWidget {
  PostScreen({super.key});

  final c = Get.put(PostCTRL(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "Add Posts",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: c.formKeys,
        child: Column(
          children: [
            TextFormField(
              maxLines: 3,
              controller: c.postController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pleases enter something';
                }
                return null;
              },
              decoration: const InputDecoration(
                  hintText: 'Enter something Here',
                  border: OutlineInputBorder()),
            ).paddingAll(20),
            Obx(
              () => ElevatedButton(
                  onPressed: () {
                    String id = DateTime.now().microsecondsSinceEpoch.toString();
                    if (c.formKeys.currentState!.validate()) {
                      c.isLoading(true);
                      c.databaseRef.child(id).set({
                        "desc": c.postController.text.toString(),
                        "id": id
                      }).then((value) {
                        c.isLoading(false);
                        ToastMessage().toastMessage("post added");
                        Get.off(HomeScreen());
                        c.clear();
                      }).onError((error, stackTrace) {
                        c.isLoading(false);
                        ToastMessage().toastMessage(error.toString());
                      });
                    }
                  },
                  child: c.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text("Add")),
            )
          ],
        ),
      ),
    );
  }
}
