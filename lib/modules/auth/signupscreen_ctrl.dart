import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/toast.dart';
import 'login_screen.dart';

class SignupScreenCtrl extends GetxController {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  GlobalKey<FormState> sFormKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  void signUp() {
    auth.createUserWithEmailAndPassword(
            email: emailCtrl.text.toString(),
            password: passCtrl.text.toString())
        .then((value) {
      ToastMessage().toastMessage("Signup Successful");
      isLoading(false);
      Get.off(LoginScreen());
    }).onError((error, stackTrace) {
      ToastMessage().toastMessage(error.toString());
      isLoading(false);
    });
  }

}
