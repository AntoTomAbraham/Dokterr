import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';

class Api {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static get user => _auth.currentUser;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Signup Method
  static Future<dynamic> signUp({String? email, String? password}) async {
    var a = await _auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    print(a);
    if (a.user!.email != null) {
      return true;
    } else {
      return false;
    }
  }

  //SIGN IN METHOD
  static Future<dynamic> signIn({String? email, String? password}) async {
    var signin = await _auth.signInWithEmailAndPassword(
        email: email!, password: password!);
    //print(signin.user!.email);
    if (signin.user!.email == null) {
      return false;
    } else {
      return true;
    }
  }

  //Update Doctor
  static Future<dynamic> addDoctor(
      String email, String name, String speciality, String place) async {
    print("YOu are inside adddoctor");
    // Location location = new Location();
    // var pos = await location.getLocation();
    // Geoflutterfire geo = Geoflutterfire();
    // GeoFirePoint point = geo.point(
    //     latitude: pos.latitude as double, longitude: pos.longitude as double);
    //print(point.data);
    var b = await _db.collection('Doctor').doc(email).set({
      "email": email,
      "name": name,
      "speciality": speciality,
      "place": place,
      // "location": point.data,
    });
    // print(b);
    return b;
  }

  //Update User
  static Future<dynamic> addUser(
      {String? email, String? name, String? age}) async {
    var user = await _db.collection('User').doc(email).set({
      "email": email,
      "name": name,
      "Age": age,
    });
    return user;
  }

  //Post Services
  static Future<dynamic> postService({
    String? name,
    String? phonenumber,
    String? qualification,
    String? experience,
    String? location,
    String? timing,
    String? treatments,
  }) async {
    Location locationn = Location();
    var poss = await locationn.getLocation();
    Geoflutterfire geop = Geoflutterfire();
    GeoFirePoint point = geop.point(
        latitude: poss.latitude as double, longitude: poss.longitude as double);
    print(point.data);
    var u = await _db.collection('Services').doc(Api.user.email).set({
      "email": Api.user.email,
      "name": name,
      "qualification": qualification,
      "Phno": phonenumber,
      "experience": experience,
      "place": location,
      "timing": timing,
      "treatments": treatments,
      "location": point.data,
    });
    return u;
  }

  //check user authorization
  static Future<dynamic> isUser(String emailid) async {
    var a = await _db.collection('User').doc(emailid).get();
    if (a.exists) {
      //print("yes");
      return true;
    } else {
      return false;
    }
  }

  //check doctor authorization
  static Future<dynamic> isDoctor(String emailid) async {
    var a = await _db.collection('Doctor').doc(emailid).get();
    if (a.exists) {
      //print("yes");
      return true;
    } else {
      return false;
    }
  }

  //Read All Services
  static Future<dynamic> readservices() async {
    DocumentSnapshot documentSnapshot;

    documentSnapshot =
        await _db.collection('Services').doc(Api.user.email).get();
    // if (documentSnapshot.exists) {
    return documentSnapshot.data();
    //} else {}
    //return documentSnapshot.data();
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();
    print('signout');
  }

  static createChat(String chatId, chatMap) {
    try {
      _db.collection("chat").doc(chatId).set(chatMap);
    } catch (e) {
      print(e);
    }
  }

  static createConversation(String chatId, messageMap) {
    _db.collection("chat").doc(chatId).collection("messages").add(messageMap);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getConversation(
      String chatId) {
    return _db
        .collection("chat")
        .doc(chatId)
        .collection("messages")
        .snapshots();
  }

  static List chats = [];
  static Future<dynamic> getChats() async {
    try {
      _db
          .collection("chat")
          .where("users", arrayContains: Api.user.email)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          chats.add(element.data());
        });
      });
      print(chats);
      return chats;
    } catch (e) {
      print(e);
    }
  }
}
