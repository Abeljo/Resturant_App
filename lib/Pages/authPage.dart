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
  final NemailController = TextEditingController();
  final NpasswordController = TextEditingController();

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

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: NemailController.text.trim(),
      password: NpasswordController.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have successfully Created Account')));

    Navigator.of(context).pop();
  }

  bool obs = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 50,
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                //Do something with the user input.
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width - 120,
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Password',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: obs,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.remove_red_eye,
                  color: Colors.orange,
                ),
                onPressed: () {
                  setState(() {
                    obs = false;
                  });
                },
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(primary: Colors.orange),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Don\'t have an account?'),
              FlatButton(
                onPressed: () {
                  showGeneralDialog(
                    barrierColor: Colors.black.withOpacity(0.5),
                    transitionBuilder: (context, a1, a2, widget) {
                      return Transform.scale(
                        scale: a1.value,
                        child: Opacity(
                          opacity: a1.value,
                          child: AlertDialog(
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: const Text(
                              'Sign Up',
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 20),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: NemailController,
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
                                  controller: NpasswordController,
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
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.orange),
                                  onPressed: () {
                                    signUp();
                                    NemailController.clear();
                                    NpasswordController.clear();
                                  },
                                  icon: const Icon(
                                    Icons.lock_open,
                                    size: 32,
                                  ),
                                  label: const Text(
                                    'sign up',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    transitionDuration: Duration(milliseconds: 200),
                    barrierDismissible: true,
                    barrierLabel: '',
                    context: context,
                    pageBuilder: (context, animation1, animation2) {
                      return Container();
                    },
                  );
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Colors.orange, fontSize: 20),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
