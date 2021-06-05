import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interview_task/views/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false, theme: ThemeData(), home: MyApp()));
  });
}

Widget initialize() {
  return StreamBuilder(
      stream: Firebase.initializeApp().asStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SplashScreen();
        } else {
          return Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return initialize();
  }
}
