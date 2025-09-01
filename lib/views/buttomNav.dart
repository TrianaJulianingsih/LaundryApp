import 'package:flutter/material.dart';
import 'package:laundry_app/views/home.dart';
import 'package:laundry_app/views/order_screen.dart';
import 'package:laundry_app/views/profile_screen.dart';

class ButtomNav extends StatefulWidget {
  const ButtomNav({super.key});
  static const id = "/buttomNav";

  @override
  State<ButtomNav> createState() => _ButtomNavState();
}

class _ButtomNavState extends State<ButtomNav> {
  // bool appBar = true;

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    OrderScreen(),
    ProfileAPIScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Dashbord"), backgroundColor: Colors.blue),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/home2.png", width: 30, height: 30),
            activeIcon: Image.asset(
              "assets/images/home1.png",
              width: 30,
              height: 30,
            ),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/order.png",
              width: 30,
              height: 30,
            ),
            activeIcon: Image.asset(
              "assets/images/order2.png",
              width: 30,
              height: 30,
            ),
            label: 'Pesanan'
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/profil.png",
              width: 30,
              height: 30,
            ),
            activeIcon: Image.asset(
              "assets/images/profile2.png",
              width: 30,
              height: 30,
            ),
            label: 'Profil'
          ),
        ],
        selectedItemColor: Colors.white, // warna text label saat aktif
        unselectedItemColor: Colors.black54,
        // onTap: _onItemTapped,
      ),
    );
  }
}
