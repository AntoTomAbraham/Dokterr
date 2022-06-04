import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_app/Data/Api.dart';
import 'package:doctor_booking_app/global/Colour.dart';
import 'package:doctor_booking_app/screens/Home/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';

class NearbydoctorScreen extends StatefulWidget {
  @override
  State<NearbydoctorScreen> createState() => _NearbydoctorScreenState();
}

class _NearbydoctorScreenState extends State<NearbydoctorScreen> {
  // const NearbydoctorScreen({Key? key}) : super(key: key);

  Location locationn = Location();
  GeoFirePoint? point;
  Geoflutterfire geop = Geoflutterfire();
  List<dynamic> data = [];

  void getNearbyDoctors() async {
    print("NearbyDoctors");
    var poss = await locationn.getLocation();
    Geoflutterfire geop = Geoflutterfire();
    // GeoFirePoint usersAddressGeoFirePoint =
    //     geo.point(latitude: 37.4219983, longitude: -122.084);
    if (mounted) {
      setState(() {
        point = geop.point(
            latitude: poss.latitude as double,
            longitude: poss.longitude as double);
      });
    }
    print(point!.data);
    print("In try");
    geop
        .collection(
            collectionRef: FirebaseFirestore.instance.collection('Services'))
        .within(center: point as GeoFirePoint, radius: 20, field: 'location')
        .listen((List<DocumentSnapshot> documentList) {
      print("I");
      print(documentList);
      if (mounted) {
        setState(() {
          data = documentList;
        });
      }
    });
  }

  void getLocation() async {
    var poss = await locationn.getLocation();
    Geoflutterfire geop = Geoflutterfire();
    if (mounted) {
      setState(() {
        point = geop.point(
            latitude: poss.latitude as double,
            longitude: poss.longitude as double);
      });
    }
  }

  @override
  void initState() {
    getLocation();
    getNearbyDoctors();
    // TODO: implement initState
    super.initState();
  }

  final geo = Geoflutterfire();
  var collectionReference = FirebaseFirestore.instance.collection('Services');
  double radius = 50;
  String field = 'position';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colour.whiteshade,
      appBar: AppBar(
        title: Text("Find Doctors Nearby"),
        backgroundColor: Color.fromARGB(255, 155, 200, 243),
      ),
      body: point == null
          ? Container(
              child: Center(
                child: Text(
                  "Enable GPS",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            )
          : Container(
              height: Get.height * 1,
              color: Colors.white,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 21.0, right: 21.0, top: 8),
                    child: Container(
                      width: Get.width * 1,
                      height: Get.height * 1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: data.length != 0
                          ? ListView(
                              children: data.map((e) {
                                return showDoctor(
                                  e['name'],
                                  e['experience'],
                                  e['treatments'],
                                  e['place'],
                                  e['timing'],
                                  e['email'],
                                );
                              }).toList(),
                            )
                          : Container(
                              child: Center(
                                  child: Text(
                                "Sorry No service in your area",
                                style: TextStyle(fontSize: 22),
                              )),
                            ),
                    ),
                  )
                ],
              )),
            ),
    );
  }

  Widget showDoctor(String name, String experience, String specialization,
      String place, String Qualifications, String id) {
    return Padding(
      padding: const EdgeInsets.only(left: 21.0, right: 21.0, top: 8),
      child: Container(
        width: Get.width * 1,
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
              text("Experience", experience),
              text("Specialization", specialization),
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
                    onPressed: () {
                      List<String> users = [id, Api.user.email as String];
                      String chatID = createID(id, Api.user.email);
                      Map<String, dynamic> chatmap = {
                        "user": users,
                        "chatId": chatID,
                      };
                      Api.createChat(chatID, chatmap);
                      Get.to(chatscreen(
                        uName: name,
                        chatId: chatID,
                      ));
                    },
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

  Widget text(String text, String field) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 120,
          child: Text(
            text,
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
          ),
        ),
        Text(":"),
        Container(
          width: 120,
          child: Center(
            child: Text(
              field,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  createID(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
