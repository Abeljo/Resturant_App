import 'package:flutter/material.dart';

class staffPage extends StatefulWidget {
  const staffPage({Key? key}) : super(key: key);

  @override
  State<staffPage> createState() => _staffPageState();
}

class _staffPageState extends State<staffPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Staff Page'),
      ),
    );
  }
}
