import 'package:flutter/material.dart';

class menuPage extends StatefulWidget {
  const menuPage({Key? key}) : super(key: key);

  @override
  State<menuPage> createState() => _menuPageState();
}

class _menuPageState extends State<menuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Menu Page'),
      ),
    );
  }
}
