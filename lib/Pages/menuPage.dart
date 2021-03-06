import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:maps_launcher/maps_launcher.dart';

class menuPage extends StatefulWidget {
  const menuPage({Key? key}) : super(key: key);

  @override
  State<menuPage> createState() => _menuPageState();
}

class _menuPageState extends State<menuPage> {
  bool isSelected = false;
  final CollectionReference _menu =
      FirebaseFirestore.instance.collection('menu');

  String bg = 'all';

  String drink = 'Delicious Food';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('menu')
              .where('belong', isEqualTo: bg)
              .snapshots(),
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
                          margin: EdgeInsets.only(top: 5, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Let\'s have ',
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${drink}',
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
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 20, primary: Colors.orange),
                                  onPressed: () {
                                    setState(() {
                                      bg = 'all';
                                      drink = 'Delicious Food';
                                    });
                                  },
                                  icon: Icon(Icons.fastfood),
                                  label: Text('Foods')),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 20, primary: Colors.orange),
                                  onPressed: () {
                                    setState(() {
                                      bg = 'drink';
                                      drink = 'Wonderfull Drink';
                                    });
                                  },
                                  icon: Icon(Icons.local_drink),
                                  label: Text('Drinks')),
                            ],
                          ),
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
                                  child: Icon(
                                    Icons.arrow_downward,
                                    size: 30,
                                    color: Colors.orange,
                                  )),
                            )
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 1.3,
                          width: MediaQuery.of(context).size.width,
                          child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: streamSnapshot.data!.docs.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 1.1),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                return GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            child: Column(
                                              children: [
                                                Icon(Icons.linear_scale),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 2, left: 10),
                                                  child: Text(
                                                    documentSnapshot['name'],
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10, left: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'ETB: ',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                        documentSnapshot[
                                                            'price'],
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  height: 250,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      50,
                                                  child:  CachedNetworkImage(
                                                    imageUrl:
                                                        documentSnapshot['img'],
                                                    fit: BoxFit.cover,
                                                  ), 
                                                      /* Image.network(
                                                    documentSnapshot['img'],
                                                    fit: BoxFit.cover,
                                                  ), */
                                                ),
                                                SizedBox(height: 50),
                                                ElevatedButton.icon(
                                                  style: ElevatedButton.styleFrom(
                                                      minimumSize: Size(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              50,
                                                          50),
                                                      primary: Colors
                                                          .orange //elevated btton background color
                                                      ),
                                                  onPressed: () {
                                                    MapsLauncher
                                                        .launchCoordinates(
                                                            9.036424479831105,
                                                            38.75042749414433);
                                                  },
                                                  icon:
                                                      Icon(Icons.location_city),
                                                  label: Text('View on map'),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Card(
                                    elevation: 20,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 130,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child:  CachedNetworkImage(
                                            imageUrl: documentSnapshot['img'],
                                            fit: BoxFit.cover,
                                          ),
                                              /* Image.network(
                                            documentSnapshot['img'],
                                            fit: BoxFit.cover,
                                          ), */
                                        ),
                                        Container(
                                          //margin: EdgeInsets.only(top: 10),
                                          child: Text(
                                            documentSnapshot['name'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                'ETB: ',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.orange[500]),
                                              ),
                                              Text(
                                                documentSnapshot['price'],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.orange),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
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
