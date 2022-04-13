import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resturant_app/Pages/authPage.dart';
import 'package:resturant_app/Pages/menuPage.dart';
import 'package:resturant_app/Pages/personalPage.dart';
import 'package:resturant_app/Pages/reservationPage.dart';
import 'package:resturant_app/Pages/staffPage.dart';
//firebase core
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resturant App',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final Screen = [
    authPage(),
    reservationPage(),
    menuPage(),
    staffPage(),
    personalPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'main screen',
            style: TextStyle(color: Colors.brown),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Reservation',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Staff',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account Info',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.brown,
          unselectedItemColor: Color.fromARGB(255, 238, 205, 193),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return Screen[_selectedIndex];
            }
            return Screen[0];
          },
        ));
  }
}
