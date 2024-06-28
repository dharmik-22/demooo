import 'package:fiirebasee/modules/homeScreen.dart';
import 'package:fiirebasee/utils/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'otp_ctrl.dart';

class OtpScreen extends StatelessWidget {
  final String verificationId;

  OtpScreen({
    super.key,
    required this.verificationId,
  });

  final c = Get.put(OtpCTRL());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Enter Otp"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: c.otpController,
            decoration: const InputDecoration(
                hintText: 'Enter Otp', border: OutlineInputBorder()),
          ).paddingAll(20),
          ElevatedButton(
              onPressed: () async {
                c.isLoading(true);
                final credentials = PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: c.otpController.text.toString());

                try {
                  await c.auth.signInWithCredential(credentials);
                  Get.off(HomeScreen());
                  ToastMessage().toastMessage('Login Successful');
                } catch (e) {
                  e.toString();
                  c.isLoading(false);
                  ToastMessage().toastMessage(e.toString());
                }
              },
              child: const Text("verify Otp"))
        ],
      ),
    );
  }
}
