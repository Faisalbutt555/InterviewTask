import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interview_task/views/Authentication/SignInScreen.dart';
import 'dart:async';

import 'package:interview_task/views/BottomScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 2), onLoadingData);
  }

  onLoadingData() {
    if (FirebaseAuth.instance.currentUser == null)
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));
    else {
      FirebaseAuth.instance.currentUser.email.toString();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: 30),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage(
                'images/img.PNG',
              ),
              scale: 2.5)),
    ));
  }
}
