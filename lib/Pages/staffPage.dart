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
                          backgroundColor: Colors.orange,
                          context: context,
                          builder: (context) => Container(
                              height: 400,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Image.network(
                                          documentSnapshot['img'],
                                          fit: BoxFit.fitHeight)),
                                  Container(
                                    margin: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Text(
                                          documentSnapshot['name'],
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          documentSnapshot['type'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              overflow: TextOverflow.clip),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          documentSnapshot['type'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ],
                                    ),
                                  )
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
