import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class authPage extends StatefulWidget {
  const authPage({Key? key}) : super(key: key);

  @override
  State<authPage> createState() => _authPageState();
}

class _authPageState extends State<authPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: 'Enter your email',
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              //Do something with the user input.
            },
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              hintText: 'Enter your Password',
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              //Do something with the user input.
            },
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton.icon(
            onPressed: signIn,
            icon: const Icon(
              Icons.lock_open,
              size: 32,
            ),
            label: const Text(
              'sign in',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      )),
    );
  }
}
