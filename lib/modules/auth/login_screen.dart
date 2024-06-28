import 'package:fiirebasee/modules/auth/login_controller.dart';
import 'package:fiirebasee/modules/auth/signup_sscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final c = Get.put(LoginScreenCtrl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login Screen",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Form(
        key: c.lFormKey,
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
              },
              decoration: const InputDecoration(
                  hintText: "Password", border: OutlineInputBorder()),
            ).paddingAll(20),
            InkWell(
                onTap: () {
                  Get.to(SignUpScreen());
                },
                child: const Text("already have an account ? SIGNUP")),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => ElevatedButton(
                  onPressed: () {

                    if (c.lFormKey.currentState!.validate()) {
                      c.isLoading(true);
                      c.login();
                    }
                  },
                  child: c.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text("Login")),
            )
          ],
        ),
      ),
    );
  }
}
