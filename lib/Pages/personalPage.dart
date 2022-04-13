import 'package:flutter/material.dart';
import 'package:resturant_app/Pages/authPage.dart';
import 'package:resturant_app/Pages/menuPage.dart';
import 'package:resturant_app/Pages/personalPage.dart';
import 'package:resturant_app/Pages/reservationPage.dart';
import 'package:resturant_app/Pages/staffPage.dart';

class personalPage extends StatefulWidget {
  const personalPage({Key? key}) : super(key: key);

  @override
  State<personalPage> createState() => _personalPageState();
}

class _personalPageState extends State<personalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Personal Information'),
      ),
    );
  }
}
