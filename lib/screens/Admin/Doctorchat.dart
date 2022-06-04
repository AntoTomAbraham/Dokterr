import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorChat extends StatelessWidget {
  const DoctorChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Chat"),
        backgroundColor: Color.fromARGB(255, 155, 200, 243),
      ),
      body: Container(
        height: Get.height * 1,
        child: SingleChildScrollView(
            child: Column(
          children: [],
        )),
      ),
    );
  }
}
