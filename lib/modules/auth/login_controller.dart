import 'package:fiirebasee/modules/homeScreen.dart';
import 'package:fiirebasee/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreenCtrl extends GetxController {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  GlobalKey<FormState> lFormKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  void login() {
    auth
        .signInWithEmailAndPassword(
            email: emailCtrl.text.toString(),
            password: passCtrl.text.toString())
        .then((value) {
          Get.off(HomeScreen());
          ToastMessage().toastMessage(value.user!.email.toString());
      isLoading(false);
    }).onError((error, stackTrace) {
      ToastMessage().toastMessage(error.toString());
    });
  }
}
