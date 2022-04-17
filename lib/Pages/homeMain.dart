import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resturant_app/Pages/authPage.dart';
import 'package:resturant_app/Pages/menuPage.dart';
import 'package:resturant_app/Pages/personalPage.dart';
import 'package:resturant_app/Pages/reservationPage.dart';
import 'package:resturant_app/Pages/staffPage.dart';
//firebase core
import 'package:firebase_core/firebase_core.dart';

class homeMain extends StatefulWidget {
  const homeMain({Key? key}) : super(key: key);

  @override
  State<homeMain> createState() => _homeMainState();
}

class _homeMainState extends State<homeMain> {
  int _selectedIndex = 0;

  final Screen = [menuPage(), reservationPage(), staffPage(), personalPage()];

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Reservation',
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
    );
  }
}
