import 'package:fiirebasee/modules/auth/phone_no/phone_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class PhoneNoScreen extends StatelessWidget {
  PhoneNoScreen({super.key});

  final c = Get.put(PhoneNOCTRL());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Phone Screen"),
      ),
      body: Form(
        key: c.mFormKey,
        child: Column(
          children: [
            TextFormField(
              // keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter phone no';
                }
                return null;
              },
              controller: c.phoneNo,
              decoration: const InputDecoration(
                  hintText: 'Enter Phone No', border: OutlineInputBorder()),
            ).paddingAll(20),
            Obx(
              () => ElevatedButton(
                  onPressed: () {
                    if (c.mFormKey.currentState!.validate()) {
                      c.isLoading(true);
                      c.phoneNoAuth();
                    }
                  },
                  child: c.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text("send Otp")),
            )
          ],
        ),
      ),
    );
  }
}
