import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/toast.dart';
import 'otp_screen.dart';

class PhoneNOCTRL extends GetxController{
  final phoneNo = TextEditingController();
  RxBool isLoading = false.obs;
  GlobalKey<FormState> mFormKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  void phoneNoAuth(){
    auth.verifyPhoneNumber(
      phoneNumber: phoneNo.text,
      verificationCompleted: (_){},
      verificationFailed: (e) {
        ToastMessage().toastMessage(e.toString());
      },
      codeSent: (String verificationId, int? token){
        Get.to(OtpScreen(verificationId: verificationId,));
      },
      codeAutoRetrievalTimeout: (e) {
        ToastMessage().toastMessage(e.toString());
      },
    );
  }
}