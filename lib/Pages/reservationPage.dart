import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

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

  final user = FirebaseAuth.instance.currentUser!;

  Future<void> orderNow([DocumentSnapshot? documentSnapshot]) async {
    final String? name = nameColtrol.text;
    final int? phone = int.tryParse(phoneControl.text);
    final String? date = dateColtrol.text;
    final int? person = int.tryParse(personColtrol.text);
    final String? acc = user.email;
    if (documentSnapshot != null) {
      nameColtrol.text = documentSnapshot['name'].toString();
      phoneControl.text = documentSnapshot['phone'].toString();
      dateColtrol.text = documentSnapshot['date'].toString();
      personColtrol.text = documentSnapshot['person'].toString();

      if (name != null && phone != null && date != null && person != null) {
        personColtrol.text = '';
        await _orders.add({
          "name": name,
          "phone": phone,
          "date": date,
          "person": person,
          "acc": acc
        });
      }
    }
    nameColtrol.text = '';
    phoneControl.text = '';
    dateColtrol.text = '';
    personColtrol.text = '';

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully placed an order see You soon')));
  }

  Future datePick(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    var formattedDate = formatDate(picked!, [yyyy, '-', mm, '-', dd]);

    if (picked != null) {
      setState(() {
        dateColtrol.text = formattedDate + ' ' + pickedTime.toString();
      });
    }
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
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.orange,
                                      radius: 40,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(user.email!,
                                          style: TextStyle(fontSize: 20)),
                                      Text(
                                        'Member Since: ',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.orange),
                                      ),
                                      Text(user.metadata.creationTime
                                          .toString()),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 50,
                                height: 50,
                                child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.orange),
                                    onPressed: () =>
                                        FirebaseAuth.instance.signOut(),
                                    icon: Icon(Icons.arrow_back),
                                    label: Text('Sign Out')),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 50, top: 30),
                            child: Text(
                              'Make A Reservation here',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  left: 10,
                                ),
                                width: MediaQuery.of(context).size.width / 1.8,
                                child: TextFormField(
                                  controller: dateColtrol,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Date Of Appearence',
                                  ),
                                  keyboardType: TextInputType.none,
                                ),
                              ),
                              Container(
                                child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.orange),
                                    onPressed: () {
                                      datePick(context);
                                    },
                                    icon: Icon(Icons.date_range),
                                    label: Text('Pick Date')),
                              )
                            ],
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
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            width: MediaQuery.of(context).size.width - 50,
                            child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.orange),
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
