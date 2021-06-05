import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:interview_task/views/Authentication/SignInScreen.dart';
import 'package:interview_task/widgets/snack_bar.dart';
import 'package:page_transition/page_transition.dart';

class SignUpController {
  final databasereference = FirebaseFirestore.instance;
  Future<void> signup(
      {Country selected,
      TextEditingController name,
      TextEditingController email,
      TextEditingController phonenumber,
      TextEditingController password,
      TextEditingController confirmpasword,
      BuildContext context,
      FirebaseAuth auth}) async {
    if (selected != null &&
        name.text.isNotEmpty &&
        email.text.isNotEmpty &&
        phonenumber.text.isNotEmpty &&
        password.text.isNotEmpty &&
        confirmpasword.text.isNotEmpty) {
      try {
        UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        User user = result.user;
        await databasereference.collection('User').doc(user.uid).set({
          'Name': name.text,
          'Mobile Number': selected.dialingCode + phonenumber.text,
          'Email Adress': email.text,
          'Password': password.text,
          'Confirm Password': confirmpasword.text,
        });

        Navigator.push(
          context,
          PageTransition(
            duration: Duration(seconds: 00001),
            type: PageTransitionType.rightToLeft,
            child: SignIn(),
          ),
        );
        showCustomFlushbar(context, 'Success!', 'User is Successfully Created');
        name.clear();
        phonenumber.clear();
        email.clear();
        password.clear();
        confirmpasword.clear();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showCustomFlushbar(
              context, 'Alert!', 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showCustomFlushbar(
              context, 'Alert!', 'The account already exists for that email.');
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
