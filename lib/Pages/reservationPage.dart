import 'package:flutter/material.dart';
import 'package:resturant_app/Pages/authPage.dart';
import 'package:resturant_app/Pages/menuPage.dart';
import 'package:resturant_app/Pages/personalPage.dart';
import 'package:resturant_app/Pages/reservationPage.dart';
import 'package:resturant_app/Pages/staffPage.dart';

class reservationPage extends StatefulWidget {
  const reservationPage({Key? key}) : super(key: key);

  @override
  State<reservationPage> createState() => _reservationPageState();
}

class _reservationPageState extends State<reservationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Reservation Page'),
      ),
    );
  }
}
