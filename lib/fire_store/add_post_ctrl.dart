import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddPostCTRL extends GetxController{
  final addPostController = TextEditingController();
  RxBool isLoading = false.obs;
  final fireStoreRef = FirebaseFirestore.instance.collection('posts');

}