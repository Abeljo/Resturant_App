import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class staffPage extends StatefulWidget {
  const staffPage({Key? key}) : super(key: key);

  @override
  State<staffPage> createState() => _staffPageState();
}

class _staffPageState extends State<staffPage> {
  final CollectionReference _staff =
      FirebaseFirestore.instance.collection('staff');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _staff.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          elevation: 5,
                          // backgroundColor: Colors.orange,
                          context: context,
                          builder: (context) => Container(
                              height: 600,
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      documentSnapshot['name'],
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      documentSnapshot['type'],
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color.fromARGB(
                                              255, 114, 111, 111)),
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height -
                                        365,
                                    width: MediaQuery.of(context).size.width,
                                    child: CachedNetworkImage(
                                      imageUrl: documentSnapshot['img'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              )));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: Center(
                        child: Card(
                          child: ListTile(
                            title: Text(documentSnapshot['name']),
                            subtitle: Text(documentSnapshot['type']),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(documentSnapshot['img']),
                            ),
                          ),
                          shadowColor: Colors.orange,
                        ),
                      ),
                    ),
                  );
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
