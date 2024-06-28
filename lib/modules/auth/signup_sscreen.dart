import 'package:fiirebasee/modules/auth/phone_no/phoneno_login.dart';
import 'package:fiirebasee/modules/auth/signupscreen_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final c = Get.put(SignupScreenCtrl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Signup Screen",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Form(
        key: c.sFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: c.emailCtrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter email";
                }
                return null;
              },
              decoration: const InputDecoration(
                  hintText: "Email", border: OutlineInputBorder()),
            ).paddingAll(20),
            TextFormField(
              controller: c.passCtrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter password";
                }
                return null;
              },
              decoration: const InputDecoration(
                  hintText: "Password", border: OutlineInputBorder()),
            ).paddingAll(20),
            InkWell(
                onTap: () {
                  Get.to(LoginScreen());
                },
                child: const Text("already have an account ? LOGIN")),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.to(PhoneNoScreen());
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)
                ),
                child: const Center(child: Text("Log in with phone no")),
              ).paddingAll(20),
            ),
            Obx(
              () => ElevatedButton(
                  onPressed: () {
                    if (c.sFormKey.currentState!.validate()) {
                      c.isLoading(true);
                      c.signUp();
                    }
                  },
                  child: c.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text("Signup")),
            ),
          ],
        ),
      ),
    );
  }
}
