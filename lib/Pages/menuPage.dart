import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class menuPage extends StatefulWidget {
  const menuPage({Key? key}) : super(key: key);

  @override
  State<menuPage> createState() => _menuPageState();
}

class _menuPageState extends State<menuPage> {
  bool isSelected = false;
  final CollectionReference _menu =
      FirebaseFirestore.instance.collection('menu');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: _menu.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Let\'s eat ',
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Nutrious food',
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InputChip(
                                label: Text('Foods'),
                                avatar: CircleAvatar(child: Text('F')),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                onPressed: () {
                                  print('Foods');
                                  isSelected = true;
                                },
                                selectedColor:
                                    Color.fromARGB(255, 255, 210, 150),
                              ),
                              InputChip(
                                label: Text('Drinks'),
                                avatar: CircleAvatar(child: Text('D')),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                onPressed: () {
                                  print('Drinks');
                                  isSelected = true;
                                },
                                selectedColor:
                                    Color.fromARGB(255, 255, 210, 150),
                              ),
                              InputChip(
                                label: Text('vegitables'),
                                avatar: CircleAvatar(child: Text('V')),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                onPressed: () {
                                  print('vegitables');
                                  isSelected = true;
                                },
                                selectedColor:
                                    Color.fromARGB(255, 255, 210, 150),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 20, top: 20, bottom: 10),
                                child: Text(
                                  'Recommended Products',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                print('see all');
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20, top: 20),
                                child: Text(
                                  'See all',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.orange),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 230,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: streamSnapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                return Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  shadowColor: Colors.orange,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        height: 160,
                                        width: 260,
                                        child: Image.network(
                                          documentSnapshot['img'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 2, left: 10),
                                        child: Text(
                                          documentSnapshot['name'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 2, left: 10),
                                        child: Text(
                                          documentSnapshot['price'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.orange),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 20, top: 20),
                                child: Text(
                                  'All available Products',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                print('see all');
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20, top: 20),
                                child: Text(
                                  'See all',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.orange),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 2.3,
                          width: MediaQuery.of(context).size.width,
                          child: GridView.builder(
                              itemCount: 13,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 1.1),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(child: Text('place for image')),
                                      Container(
                                        //margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Foods',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          'Rs. 100',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.orange),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    )),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
