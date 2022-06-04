import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_app/global/Colour.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colour.whiteshade,
      body: Container(
        height: Get.height * 1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height * .4,
                width: Get.width * 1,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 155, 200, 243),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * .2,
                      ),
                      Text(
                        "Find your Favourite Doctor",
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: Get.height * .5,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Services')
                      .snapshots(),
                  builder: (builder, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView(
                        children: snapshot.data!.docs.map((e) {
                          return showDoctor(
                            e['name'],
                            e['experience'],
                            e['qualification'],
                            e['qualification'],
                            e['place'],
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showDoctor(String name, String experience, String specialization,
      String place, String Qualifications) {
    return Padding(
      padding: const EdgeInsets.only(left: 21.0, right: 21.0, top: 8),
      child: Container(
        width: Get.width * .9,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              text("Name", name),
              text("Specialization", specialization),
              text("experience", experience),
              text("Qualifications", Qualifications),
              text("Place", place),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Book",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Message",
                      style: TextStyle(color: Colors.green),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget text(String field, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 120,
          child: Text(
            field,
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ),
        Text(
          ":",
          style: GoogleFonts.poppins(fontSize: 16),
        ),
        Container(
          width: 50,
          child: Text(
            text,
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
