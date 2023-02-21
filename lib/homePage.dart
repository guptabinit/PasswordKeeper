import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passwordkeeper/AddPasswordScreen.dart';
import 'package:passwordkeeper/updatePasswordScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firestore =
      FirebaseFirestore.instance.collection('password').snapshots();

  final refCollection = FirebaseFirestore.instance.collection('password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Password'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddPasswordScreen()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text("Some error occurred");
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.docs[index];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.pinkAccent,
                                    borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            "Website: ${snapshot.data!.docs[index]['website']}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text("Username: ${snapshot.data!.docs[index]['username']}",
                                            style: const TextStyle(
                                                color: Colors.white,),),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text("Password: ${snapshot.data!.docs[index]['password']}", style: const TextStyle(
                                              color: Colors.white,),),
                                        ],
                                      ),
                                    ),
                                    PopupMenuButton(
                                      icon: const Icon(Icons.more_vert),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                            value: 1,
                                            child: GestureDetector(
                                              onTap: (){
                                                Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => UpdatePasswordScreen(data: data)));
                                              },
                                                child: const Text("Update"))
                                        ),
                                        PopupMenuItem(
                                            value: 2,
                                            child: GestureDetector(
                                                onTap: (){
                                                  refCollection.doc(data['id']).delete();
                                                  setState(() {

                                                  });
                                                },
                                                child: const Text("Delete"))
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 8,
                            )
                          ],
                        );
                      });
                },
              ))),
    );
  }
}
