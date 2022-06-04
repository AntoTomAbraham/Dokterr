import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_app/Data/Api.dart';
import 'package:doctor_booking_app/global/Colour.dart';
import 'package:doctor_booking_app/screens/Admin/Doctorhome.dart';
import 'package:doctor_booking_app/screens/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';

class AdminSignup extends StatefulWidget {
  @override
  State<AdminSignup> createState() => _AdminSignupState();
}

class _AdminSignupState extends State<AdminSignup> {
  //const AdminSignup({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String? field;
  Future<GeoFirePoint> getLocation() async {
    Location location = new Location();
    var pos = await location.getLocation();
    Geoflutterfire geo = Geoflutterfire();
    GeoFirePoint point = geo.point(
        latitude: pos.latitude as double, longitude: pos.longitude as double);
    return point;
  }

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
                    controller: _placeController,
                    decoration: InputDecoration(
                      labelText: "Enter Your Place",
                      fillColor: Colour.primary,
                      filled: true, // dont forget this line
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(canvasColor: Colour.primary),
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(4),
                        hint: Text("select your Field"),
                        iconDisabledColor: Colors.white,
                        iconEnabledColor: Colors.white,
                        items: <String>[
                          'Orthopediac',
                          'Pediatrician',
                          'Gynaecologist',
                          'Neurologist'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            field = val;
                            print(field);
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      getLocation();
                      Api.signUp(
                              email: _emailController.text,
                              password: _passController.text)
                          .then((val) {
                        if (val == true) {
                          Api.addDoctor(
                                  _emailController.text,
                                  _nameController.text,
                                  field!,
                                  _placeController.text)
                              .whenComplete(() {
                            //    if (value == true) {
                            Get.snackbar(
                                _emailController.text, 'Created Successfully',
                                snackPosition: SnackPosition.BOTTOM);
                            // } else {
                            //   Get.snackbar(_emailController.text,
                            //       'Failed to create Doctor',
                            //       snackPosition: SnackPosition.BOTTOM);
                            // }
                          });
                        } else {
                          Get.snackbar(_emailController.text, 'Try Again',
                              snackPosition: SnackPosition.BOTTOM);
                        }
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
                        "Doctor Signup",
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
