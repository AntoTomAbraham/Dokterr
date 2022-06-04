import 'package:doctor_booking_app/Data/Api.dart';
import 'package:doctor_booking_app/global/Colour.dart';
import 'package:doctor_booking_app/screens/Admin/Doctorhome.dart';
import 'package:doctor_booking_app/screens/Auth/AdminSignup.dart';
import 'package:doctor_booking_app/screens/Auth/login.dart';
import 'package:doctor_booking_app/screens/Auth/signup.dart';
import 'package:doctor_booking_app/screens/Home/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Adminlogin extends StatelessWidget {
  //const Adminlogin({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
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
                  SizedBox(height: Get.height * .2),
                  Text(
                    "Doctoro",
                    style: GoogleFonts.poppins(
                      fontSize: 42,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Get.height * .1),
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
                  GestureDetector(
                    onTap: () {
                      Api.signIn(
                              email: _emailController.text,
                              password: _passController.text)
                          .then((val) {
                        print("Sigin completed");
                        if (val == true) {
                          Api.isDoctor(_emailController.text).then((value) {
                            print("isDoctor");
                            print(value);
                            if (value == true) {
                              Get.to(Doctorhome());
                            } else {
                              Get.snackbar(_emailController.text,
                                  'You are not a Patient',
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          });
                        } else {
                          Get.snackbar(
                              _emailController.text, 'Please Register yourself',
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      });
                      //  Get.to(Doctorhome());
                    },
                    child: Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text(
                        "Doctor Login",
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
                        Get.to(AdminSignup());
                      },
                      child: Text("Are you a new doctor? signup")),
                  SizedBox(height: Get.height * .2),
                  GestureDetector(
                      onTap: () {
                        Get.to(login());
                      },
                      child: Text("Are you a patient? Login")),
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
