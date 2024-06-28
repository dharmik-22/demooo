import 'package:fiirebasee/modules/auth/login_screen.dart';
import 'package:fiirebasee/modules/auth/signup_sscreen.dart';
import 'package:fiirebasee/imagepicker_store_firebase/store_image_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'fire_store/add_post_screen.dart';
import 'fire_store/home_screen_firestore.dart';
import 'modules/homeScreen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final c = Get.put(SplashScreenCtrl());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Firebase Tutorial"),
      ),
    );
  }
}

class SplashScreenCtrl extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    navigateToSignup();
  }

  void navigateToSignup() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      await Future.delayed(const Duration(seconds: 3));
      Get.off(() => ImagePick());
    } else {
      await Future.delayed(const Duration(seconds: 3));
      Get.off(() => LoginScreen());
    }
  }
}
