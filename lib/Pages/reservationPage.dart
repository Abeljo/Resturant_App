import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class reservationPage extends StatefulWidget {
  const reservationPage({Key? key}) : super(key: key);

  @override
  State<reservationPage> createState() => _reservationPageState();
}

class _reservationPageState extends State<reservationPage> {
  final TextEditingController nameColtrol = TextEditingController();
  final TextEditingController phoneControl = TextEditingController();
  final TextEditingController dateColtrol = TextEditingController();
  final TextEditingController personColtrol = TextEditingController();

  final CollectionReference _orders =
      FirebaseFirestore.instance.collection('orders');

  Future<void> orderNow([DocumentSnapshot? documentSnapshot]) async {
    final String? name = nameColtrol.text;
    final int? phone = int.tryParse(phoneControl.text);
    final String? date = dateColtrol.text;
    final int? person = int.tryParse(personColtrol.text);

    if (documentSnapshot != null) {
      nameColtrol.text = documentSnapshot['name'].toString();
      phoneControl.text = documentSnapshot['phone'].toString();
      dateColtrol.text = documentSnapshot['date'].toString();
      personColtrol.text = documentSnapshot['person'].toString();

      if (name != null && phone != null && date != null && person != null) {
        personColtrol.text = '';
        await _orders.add(
            {"name": name, "phone": phone, "date": date, "person": person});
      }
    }
    nameColtrol.text = '';
    phoneControl.text = '';
    dateColtrol.text = '';
    personColtrol.text = '';

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully placed an order see You soon')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: _orders.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 50, top: 30),
                            child: Text(
                              'Welcome To the reservation page',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            width: MediaQuery.of(context).size.width - 50,
                            child: TextField(
                              controller: nameColtrol,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            width: MediaQuery.of(context).size.width - 50,
                            child: TextFormField(
                              controller: phoneControl,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'phone number',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            width: MediaQuery.of(context).size.width - 50,
                            child: TextFormField(
                              controller: dateColtrol,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Date Of Appearence',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            width: MediaQuery.of(context).size.width - 50,
                            child: TextFormField(
                              controller: personColtrol,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Number of Person',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            width: MediaQuery.of(context).size.width - 50,
                            child: ElevatedButton.icon(
                                onPressed: () async {
                                  orderNow(documentSnapshot);
                                },
                                icon: Icon(Icons.timelapse),
                                label: Text('Reserve Now')),
                          ),
                        ],
                      );
                    });
              }

              return CircularProgressIndicator();
            }));
  }
}
