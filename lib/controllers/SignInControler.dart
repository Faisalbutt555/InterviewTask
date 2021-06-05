import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interview_task/views/BottomScreen.dart';
import 'package:interview_task/widgets/snack_bar.dart';
import 'package:page_transition/page_transition.dart';

class SignInController {
  final databasereference = FirebaseFirestore.instance;
  Future<void> signIn(
      {TextEditingController email,
      TextEditingController password,
      BuildContext context,
      FirebaseAuth auth}) async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      try {
        await auth.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        Navigator.push(
          context,
          PageTransition(
            duration: Duration(seconds: 00001),
            type: PageTransitionType.rightToLeft,
            child: BottomScreen(),
          ),
        );
        showCustomFlushbar(context, 'Success!', 'User is Successfully Login');
        email.clear();
        password.clear();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showCustomFlushbar(
              context, 'Alert!', 'No user found for that email..');
        } else if (e.code == 'wrong-password') {
          showCustomFlushbar(
              context, 'Alert!', 'Wrong password provided for that user.');
        }
      } catch (e) {
        showCustomFlushbar(context, 'Alert!', e.toString());
      }
    } else {
      showCustomFlushbar(
          context, 'Authenticatio Details', 'Please Complete your Form');
    }
  }
}
