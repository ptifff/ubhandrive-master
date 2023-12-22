import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homeScreen.dart';
import 'instructor_homescreen.dart';
import 'login.dart';
import 'login_instructor.dart';
import 'student_login.dart';

class AuthService {
  final auth = FirebaseAuth.instance;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  final firestore = FirebaseFirestore.instance;

  void LoginUser(context) async {
    try {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
      await auth.signInWithEmailAndPassword(
          email: email!.text, password: password!.text).then((value) {
        print("User Is Logged In");
        Navigator.pop(context);

         Navigator.of(context).pushReplacement(
         MaterialPageRoute(builder: (context) =>
             InstructorHomeScreen()), // Replace with your login screen widget
        );
      });
    } catch (e) {
      Navigator.pop(context);
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Error Message"),
          content: Text(e.toString()),
        );
      });
    }
  }

  void InstructorRegister(context) async {
    try {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
      await auth.createUserWithEmailAndPassword(
          email: email!.text, password: password!.text).then((value) {
        print("User Is Registered");
        firestore.collection("instructor").add({
          "firstname": firstname.text,
          "lastname": lastname.text,
          "email": email.text,
          "password": password.text,
          "uid": auth.currentUser!.uid
        });

        Navigator.pop(context);

         Navigator.push(context, MaterialPageRoute(builder: (c) => Login()));
      });
    } catch (e) {
      Navigator.pop(context);
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Error Message"),
          content: Text(e.toString()),
        );
      });
    }
  }


  //
  // void logOutUser(BuildContext context) async {
  //   // await auth.signOut();
  //   // Navigator.of(context).pushReplacement(
  //   //   MaterialPageRoute(builder: (context) =>
  //   //       Login()), // Replace with your login screen widget
  //   );
  // }
}

class StudentAuthService{
  final stuauth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  TextEditingController stufirstname = TextEditingController();
  TextEditingController stulastname = TextEditingController();
  TextEditingController stuemail = TextEditingController();
  TextEditingController stupassword = TextEditingController();

  void StudentLoginUser(context) async {
    try {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
      await stuauth.signInWithEmailAndPassword(
          email: stuemail!.text, password: stupassword!.text).then((value) {
        print("Student Is Logged In");
        Navigator.pop(context);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>
              HomeScreen()), // Replace with your login screen widget
        );
      });
    } catch (e) {
      Navigator.pop(context);
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Error Message"),
          content: Text(e.toString()),
        );
      });
    }
  }



  void StudentRegister(context) async {
    try {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
      await stuauth.createUserWithEmailAndPassword(
          email: stuemail!.text, password: stupassword!.text).then((value) {
        print("Student Is Registered");
        firestore.collection("student").add({
          "stufirstname": stufirstname.text,
          "stulastname": stulastname.text,
          "stuemail": stuemail.text,
          "stupassword": stupassword.text,
          "stuid": stuauth.currentUser!.uid
        });

        Navigator.pop(context);

        Navigator.push(context, MaterialPageRoute(builder: (c) => StudentLogin()));
      });
    } catch (e) {
      Navigator.pop(context);
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Error Message"),
          content: Text(e.toString()),
        );
      });
    }
  }

}