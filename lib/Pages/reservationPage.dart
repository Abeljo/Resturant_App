import 'package:flutter/material.dart';

class reservationPage extends StatefulWidget {
  const reservationPage({Key? key}) : super(key: key);

  @override
  State<reservationPage> createState() => _reservationPageState();
}

class _reservationPageState extends State<reservationPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Reservation Page'),
      ),
    );
  }
}
