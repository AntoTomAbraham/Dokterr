import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_app/Data/Api.dart';
import 'package:doctor_booking_app/global/Colour.dart';
import 'package:doctor_booking_app/screens/Home/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserChatScreen extends StatelessWidget {
  const UserChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chat With Doctors"),
          backgroundColor: Color.fromARGB(255, 155, 200, 243),
        ),
        body: Container(
            height: Get.height * 1,
            child: SingleChildScrollView(
                child: Column(children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("chat")
                      .where("user", arrayContains: Api.user.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      print(snapshot.hasData);
                      print(snapshot.data!.docs.length);
                      if (snapshot.data!.docs.length != 0) {
                        print("Length 00");
                        return Container(
                          height: Get.height * 1,
                          child: ListView(
                            children: snapshot.data!.docs.map((e) {
                              print(e);
                              print("inidis listvieew");
                              return ListTile(
                                onTap: () {
                                  Get.to(chatscreen(
                                    chatId: e['chatId'],
                                    uName: e['chatId']
                                        .toString()
                                        .replaceAll("_", "")
                                        .replaceAll(Api.user.email, ""),
                                  ));
                                },
                                tileColor: Colour.whiteshade,
                                leading: CircleAvatar(
                                    child: Text(e['chatId']
                                        .toString()
                                        .replaceAll("_", "")
                                        .replaceAll(Api.user.email, "")
                                        .substring(0, 1)
                                        .toUpperCase())),
                                title: Text(
                                    e['chatId']
                                        .toString()
                                        .replaceAll("_", "")
                                        .replaceAll(Api.user.email, "")
                                        .replaceAll("@gmail.com", ""),
                                    style: TextStyle(fontSize: 18)),
                              );
                            }).toList(),
                          ),
                        );
                      } else {
                        return Container(
                            height: Get.height * 1,
                            child: Center(child: Text("Start Chat")));
                      }
                    }
                  })
            ]))));
  }
}
