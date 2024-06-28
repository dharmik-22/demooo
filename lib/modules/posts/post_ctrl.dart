import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PostCTRL extends GetxController {
  final postController = TextEditingController();
  RxBool isLoading = false.obs;
  GlobalKey<FormState> formKeys = GlobalKey<FormState>();
  final databaseRef = FirebaseDatabase.instance.ref('Posts');

  void clear(){
    postController.clear();
  }
}
