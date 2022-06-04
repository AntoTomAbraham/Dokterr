import 'package:doctor_booking_app/Data/Api.dart';
import 'package:doctor_booking_app/global/Colour.dart';
import 'package:doctor_booking_app/screens/Auth/login.dart';
import 'package:doctor_booking_app/screens/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class signup extends StatelessWidget {
  //const signup({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 155, 200, 243),
        body: Container(
          height: Get.height * 1,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 21.0, right: 21.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Get.height * .1),
                  Text(
                    "Doctoro",
                    style: GoogleFonts.poppins(
                      fontSize: 42,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Get.height * .06),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Enter Your email ID",
                      fillColor: Colour.primary,
                      filled: true, // dont forget this line
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(
                      labelText: "Enter Your Password",
                      fillColor: Colour.primary,
                      filled: true, // dont forget this line
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Enter Your Name",
                      fillColor: Colour.primary,
                      filled: true, // dont forget this line
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      labelText: "Enter Your Age",
                      fillColor: Colour.primary,
                      filled: true, // dont forget this line
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Api.signUp(
                              email: _emailController.text,
                              password: _passController.text)
                          .whenComplete(() {
                        Api.addUser(
                          age: _ageController.text,
                          email: _emailController.text,
                          name: _nameController.text,
                        ).then((value) {
                          if (value == true) {
                            Get.to(Home());
                          } else {
                            Get.snackbar(
                                _emailController.text, 'Successfully created',
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        });
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text(
                        "Patient Signup",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                      onTap: () {
                        Get.to(login());
                      },
                      child: Text("Are you already a user? signin"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textlabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 12,
      ),
    );
  }
}
