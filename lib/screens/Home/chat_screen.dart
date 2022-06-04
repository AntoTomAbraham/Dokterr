import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_app/Data/Api.dart';
import 'package:doctor_booking_app/model/Message.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class chatscreen extends StatefulWidget {
  //const chatscreen({Key? key}) : super(key: key);
  String? uName;
  String? chatId;
  chatscreen({
    this.uName,
    this.chatId,
  });

  @override
  State<chatscreen> createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  TextEditingController messageController = TextEditingController();
  //Widget chatMessageList() {}
  sendMessage() {
    if (messageController.text != null) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Api.user.email,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      Api.createConversation(widget.chatId as String, messageMap);
    }
  }

  Stream? chatMessageStream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  chatMessageList() {
    print("Entered in to  chat message list");
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .doc(widget.chatId)
            .collection("messages")
            .orderBy("time")
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          print(snapshot.data.docs.length);
          List item = snapshot.data.docs;
          if (snapshot.hasData) {
            return Container(
              height: Get.height * .8,
              child: ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, i) {
                  return Container(
                    color: Colors.green,
                    child: Text(
                      snapshot.data.doc[i].data['message'],
                    ),
                  );
                },
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  getMessages() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .doc(widget.chatId)
            .collection("messages")
            .orderBy("time", descending: false)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: Get.height * .78,
              width: Get.width * 1,
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, ind) {
                    DocumentSnapshot snap = snapshot.data!.docs[ind];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: snap['sendBy']! == Api.user.email
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          width: 160,
                          height: 50,
                          decoration: BoxDecoration(
                              color: snap['sendBy']! == Api.user.email
                                  ? Colors.green
                                  : Colors.blue,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              snap['message'],
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return Container(
                height: Get.height * 1,
                child: Center(child: const CircularProgressIndicator()));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.uName as String),
      ),
      body: Container(
        height: Get.height * 1,
        child: Stack(
          children: [
            getMessages(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: Get.width * .7,
                      child: TextField(
                        controller: messageController,
                        autocorrect: true,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "Type your message",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 0),
                                borderRadius: BorderRadius.circular(25))),
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                        messageController.text = "";
                      },
                      child: Container(
                          width: 70,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
