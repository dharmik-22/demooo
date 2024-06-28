import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OtpCTRL extends GetxController{
  final otpController = TextEditingController();
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
}