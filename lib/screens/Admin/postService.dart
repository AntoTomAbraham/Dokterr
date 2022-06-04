import 'package:doctor_booking_app/Data/Api.dart';
import 'package:doctor_booking_app/global/Colour.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';

class postService extends StatelessWidget {
  //const postService({Key? key}) : super(key: key);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _treatmentController = TextEditingController();
  final TextEditingController _timingController = TextEditingController();
  final TextEditingController _phnoController = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Services"),
        backgroundColor: Color.fromARGB(255, 155, 200, 243),
      ),
      body: Container(
        height: Get.height * 1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 21.0, right: 21.0),
            child: Column(
              children: [
                SizedBox(height: Get.height * .1),
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
                  controller: _qualificationController,
                  decoration: InputDecoration(
                    labelText: "Enter Your Qualification",
                    fillColor: Colour.primary,
                    filled: true, // dont forget this line
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _experienceController,
                  decoration: InputDecoration(
                    labelText: "Enter Your Experience",
                    fillColor: Colour.primary,
                    filled: true, // dont forget this line
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _treatmentController,
                  decoration: InputDecoration(
                    labelText: "Enter Your Available Treatments",
                    fillColor: Colour.primary,
                    filled: true, // dont forget this line
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: "Enter Your Location",
                    fillColor: Colour.primary,
                    filled: true, // dont forget this line
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _timingController,
                  decoration: InputDecoration(
                    labelText: "Enter Your Timings",
                    fillColor: Colour.primary,
                    filled: true, // dont forget this line
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _phnoController,
                  decoration: InputDecoration(
                    labelText: "Enter Your Phone number",
                    fillColor: Colour.primary,
                    filled: true, // dont forget this line
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Your location will be  uploaded automatically, please enable your location",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 08),
                GestureDetector(
                  onTap: () {
                    getLocation();
                    Api.postService(
                            experience: _experienceController.text,
                            location: _locationController.text,
                            name: _nameController.text,
                            phonenumber: _phnoController.text,
                            qualification: _qualificationController.text,
                            timing: _timingController.text,
                            treatments: _treatmentController.text)
                        .whenComplete(() {
                      Get.snackbar(
                          _treatmentController.text, 'Created Successfully',
                          snackPosition: SnackPosition.BOTTOM);
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colour.blue,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                        child: Text(
                      "Post Services",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
