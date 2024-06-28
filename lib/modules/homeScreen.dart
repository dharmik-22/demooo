import 'package:fiirebasee/modules/auth/login_screen.dart';
import 'package:fiirebasee/modules/posts/posts_screen.dart';
import 'package:fiirebasee/utils/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final c = Get.put(CTRl());

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Posts');
  final searchController = TextEditingController();
  final editText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "Home Screen",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Get.off(LoginScreen());
              }).onError((error, stackTrace) {
                ToastMessage().toastMessage(error.toString());
              });
            },
            icon: const Icon(Icons.logout),
            color: Colors.white,
          )
        ],
      ),
      body: Column(
        children: [
          TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                  hintText: "Search", border: OutlineInputBorder()),
              onChanged: (String value) {
                c.updateSearchText(value);
              }).paddingAll(20),
          /*///with Stream builder
          Expanded(
              child: StreamBuilder(
            stream: ref.onValue,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                Map<dynamic, dynamic> map =
                    snapshot.data!.snapshot.value as dynamic;
                List<dynamic> list = [];
                list.clear();
                list = map.values.toList();
                return ListView.builder(
                  itemCount: snapshot.data!.snapshot.children.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(list[index]['desc']),
                      subtitle: Text(list[index]['id']),
                    );
                  },
                );
              }
            },
          )),
          const SizedBox(
            height: 30,*/
          /*),*/

          ///with FirebaseAnimatedList
          Expanded(
            child: Obx(() {
              final searchText = c.text.value.toLowerCase();
              return FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child('desc').value.toString().toLowerCase();
                  if (searchText.isEmpty || title.contains(searchText)) {
                    return ListTile(
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              child: ListTile(
                            onTap: () {
                              dialogBox(
                                title,
                                context,
                                snapshot.child('id').value.toString(),
                              );
                              //Get.back();
                            },
                            leading: const Icon(Icons.edit),
                            title: const Text('Edit'),
                          )),
                          PopupMenuItem(
                              child: ListTile(
                            onTap: () {
                              ref.child(snapshot.child('id').value.toString()).remove();
                              Get.back();
                            },
                            leading: Icon(Icons.delete),
                            title: Text('Delete'),
                          ))
                        ],
                      ),
                      title: Text(snapshot.child('desc').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(PostScreen());
        },
        child: const Text("Add"),
      ),
    );
  }

  /// update dialog
  Future<void> dialogBox(String title, context, String id) {
    editText.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Update"),
            content: Container(
              child: TextFormField(
                controller: editText,
                decoration: const InputDecoration(
                    hintText: 'Edit', border: OutlineInputBorder()),
              ).paddingAll(20),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    ref.child(id).update({
                      'desc': editText.text.toString(),
                    }).then((value) {
                      Get.back();
                      ToastMessage().toastMessage("Updated Successfully");
                    }).onError((error, stackTrace) {
                      ToastMessage().toastMessage(error.toString());
                    });
                    Get.back();
                  },
                  child: const Text('Updtae'))
            ],
          );
        });
  }

  /// delete dialog
  Future<void> deleteDialogBox(String title, context, String id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete"),
            content: Container(),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    ref.child(id).update({
                      'desc': editText.text.toString(),
                    }).then((value) {
                      ToastMessage().toastMessage("Updated Successfully");
                    }).onError((error, stackTrace) {
                      ToastMessage().toastMessage(error.toString());
                    });
                    Get.back();
                  },
                  child: const Text('Updtae'))
            ],
          );
        });
  }
}

class CTRl extends GetxController {
  RxString text = ''.obs;

  void updateSearchText(String value) {
    text.value = value;
  }
}
