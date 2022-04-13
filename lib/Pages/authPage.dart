import 'package:flutter/material.dart';

class authPage extends StatefulWidget {
  const authPage({Key? key}) : super(key: key);

  @override
  State<authPage> createState() => _authPageState();
}

class _authPageState extends State<authPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Authentication'),
      ),
    );
  }
}
