import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resturant_app/Pages/authPage.dart';
import 'package:resturant_app/Pages/menuPage.dart';
import 'package:resturant_app/Pages/personalPage.dart';
import 'package:resturant_app/Pages/reservationPage.dart';
import 'package:resturant_app/Pages/staffPage.dart';
//firebase core
import 'package:firebase_core/firebase_core.dart';

class personalPage extends StatefulWidget {
  const personalPage({Key? key}) : super(key: key);

  @override
  State<personalPage> createState() => _personalPageState();
}

class _personalPageState extends State<personalPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: CircleAvatar(
                backgroundColor: Colors.brown,
                radius: 50,
                child: Icon(
                  Icons.person,
                  size: 60,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(user.email!, style: TextStyle(fontSize: 20)),
              ],
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Member Since: ',
          style: TextStyle(fontSize: 18),
        ),
        Text(user.metadata.creationTime.toString()),
        SizedBox(
          height: 100,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 50,
          height: 50,
          child: ElevatedButton.icon(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: Icon(Icons.arrow_back),
              label: Text('Sign Out')),
        )
      ],
    ));
  }
}
