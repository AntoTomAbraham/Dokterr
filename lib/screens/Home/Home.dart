import 'package:doctor_booking_app/screens/Home/Homepage.dart';
import 'package:doctor_booking_app/screens/Home/NearbydoctorScreen.dart';
import 'package:doctor_booking_app/screens/Home/UserChatScreen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  List<Widget> item = [
    Homepage(),
    NearbydoctorScreen(),
    UserChatScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: item[index],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (ind) {
            setState(() {
              index = ind;
            });
          },
          currentIndex: index,
          selectedItemColor: Colors.blue,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital), label: "Nearby Doctors"),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          ]),
    );
  }
}
