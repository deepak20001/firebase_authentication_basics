import 'package:authentication_firebase/ui/auth/posts/add_posts.dart';
import 'package:authentication_firebase/ui/firestore/add_firestore_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../../../utils/utils.dart';
import '../auth/login_screen.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  // here snapshot asks for querysnapshot which we give it at Streambuilder
  final fireStore = FirebaseFirestore.instance.collection("users").snapshots();
  // creating collection as in add_firestore_data we get the data using collection but here we are getting snapshot so first we have to convert doc to get the collection reference
  CollectionReference ref = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Firestore Screen"),
        actions: [
          IconButton(
            // adding functionality in logout button for logging out
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: Icon(Icons.logout_outlined),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: fireStore,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text("Some Error");
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title:
                          Text(snapshot.data!.docs[index]["title"].toString()),
                      subtitle:
                          Text(snapshot.data!.docs[index]["id"].toString()),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                showMyDialog(
                                  snapshot.data!.docs[index]["title"]
                                      .toString(),
                                  snapshot.data!.docs[index]["id"].toString(),
                                );
                              },
                              leading: Icon(Icons.edit),
                              title: Text("Edit"),
                            ),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                ref
                                    .doc(snapshot.data!.docs[index]["id"]
                                        .toString())
                                    .delete();
                              },
                              leading: Icon(Icons.delete_outline),
                              title: Text("Delete"),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFirestoreDataScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

/*****************************************************************************************/
  Future<void> showMyDialog(String title, String id) async {
    // already showing the past text on dialog box to update
    editController.text = title;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update"),
          content: Container(
            child: TextField(
              controller: editController,
              decoration: InputDecoration(hintText: "Edit here"),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // debugPrint(editController.text);
                Navigator.pop(context);

                ref
                    .doc(id)
                    .update({"title": editController.text}).then((value) {
                  Utils().toastMessage("Updated");
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
