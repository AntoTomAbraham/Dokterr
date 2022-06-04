class Message {
  String? message;
  String? uid;
  Message();
  Map<String, String> toJson() =>
      {"message": message as String, "uid": uid as String};
  Message.fromSnapshot(
    snapshot,
  )   : message = snapshot.data()['message'],
        uid = snapshot.data()['sendBy'];
}
