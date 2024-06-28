import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiirebasee/fire_store/add_post_screen.dart';
import 'package:fiirebasee/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenFireStore extends StatelessWidget {
  HomeScreenFireStore({super.key});

  final fireStoreRef =
  FirebaseFirestore.instance.collection('posts').snapshots();
  final refs = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "FireStore HomeScreen",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: fireStoreRef, builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
            }
            if(snapshot.hasError){
              return const Text('Something Wents sWrong');
            }
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      /// upadte data
                      /*onTap: (){
                        refs.doc(snapshot.data!.docs[index]['id'].toString()).update(
                            {
                              'about' : 'Hello Dharmik Yadav'
                            }).then((value) {
                              ToastMessage().toastMessage("Data Upadated ");
                        }).onError((error, stackTrace) {
                          ToastMessage().toastMessage(error.toString());
                        });
                      },*/

                      /// delete data
                      onTap: (){
                        refs.doc(snapshot.data!.docs[index]['id'].toString()).delete().then((value) {
                          ToastMessage().toastMessage("data deleted successfully");
                        }).onError((error, stackTrace){
                          ToastMessage().toastMessage(error.toString());
                        });
                      },
                      title: Text(snapshot.data!.docs[index]['about'].toString()),
                      subtitle: Text(snapshot.data!.docs[index].id.toString()),
                    );
                  },
              
              ),
            );
          },),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddPost());
        },
        child: const Text("Add"),
      ),
    );
  }
}
