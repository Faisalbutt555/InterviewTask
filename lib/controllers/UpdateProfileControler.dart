import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:interview_task/views/BottomScreen.dart';
import 'package:interview_task/widgets/snack_bar.dart';
import 'package:page_transition/page_transition.dart';

class UpdateProfileControler {
  updateprofile(
    FirebaseAuth auth,
    FirebaseFirestore firebaseFirestore,
    TextEditingController name,
    TextEditingController email,
    TextEditingController phonenumber,
    TextEditingController password,
    TextEditingController confirmpasword,
    BuildContext context,
  ) async {
    final update = auth.currentUser;
    if (update != null) {
      firebaseFirestore.collection('User').doc(update.uid).update({
        'Name': name.text,
        'Mobile Number': phonenumber.text,
        'Email Adress': email.text,
        'Password': password.text,
        'Confirm Password': confirmpasword.text,
      }).then((value) {
        Navigator.push(
          context,
          PageTransition(
            duration: Duration(seconds: 00001),
            type: PageTransitionType.rightToLeft,
            child: BottomScreen(),
          ),
        );
        showCustomFlushbar(context, 'Success', 'Successfully Updated');
      }).catchError((e) {
        showCustomFlushbar(context, 'Alert!', e.toString());
      });
    }
  }
}
