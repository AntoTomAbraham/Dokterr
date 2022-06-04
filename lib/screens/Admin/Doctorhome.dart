import 'package:doctor_booking_app/global/Colour.dart';
import 'package:doctor_booking_app/screens/Admin/DoctorHomePage.dart';
import 'package:doctor_booking_app/screens/Admin/Doctorchat.dart';
import 'package:doctor_booking_app/screens/Admin/Viewservices.dart';
import 'package:doctor_booking_app/screens/Admin/postService.dart';
import 'package:doctor_booking_app/screens/Home/UserChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Doctorhome extends StatefulWidget {
  const Doctorhome({Key? key}) : super(key: key);

  @override
  State<Doctorhome> createState() => _DoctorhomeState();
}

class _DoctorhomeState extends State<Doctorhome> {
  List<Widget> item = [
    DoctorHomePage(),
    UserChatScreen(),
    postService(),
    // Viewservices(),
  ];
  int index = 0;
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
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.blue), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat, color: Colors.blue), label: "Chat"),
            BottomNavigationBarItem(
              icon: Icon(Icons.post_add, color: Colors.blue),
              label: "Post Services",
            ),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.document_scanner, color: Colors.blue),
            //     label: "View Services"),
          ]),
    );
  }
}
