import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height * 1,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 21.0, right: 21.0),
          child: Column(
            children: [
              SizedBox(height: 100),
              Text(
                "Hai Doctor!",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
