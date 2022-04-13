import 'package:flutter/material.dart';

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
