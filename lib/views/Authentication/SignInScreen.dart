import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:interview_task/controllers/SignInControler.dart';
import 'package:interview_task/views/BottomScreen.dart';
import 'package:interview_task/widgets/customTextField.dart';
import 'package:interview_task/widgets/loader.dart';
import 'package:interview_task/widgets/snack_bar.dart';
import 'package:page_transition/page_transition.dart';

import 'SignUpScreen.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  FocusNode emailfocus = FocusNode();
  FocusNode passwordfocus = FocusNode();
  bool showpassword = false;
  bool loader = false;
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final databasereference = FirebaseFirestore.instance;
  String fname;
  String lname;
  String emaill;
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    print(googleSignInAccount.id);
    print(googleSignInAccount.email);
    print(googleSignInAccount.displayName);
    //  fname = name.text = googleSignInAccount.displayName.toString();
    emaill = email.text = googleSignInAccount.email.toString();
    final UserCredential authResult =
        await firebaseAuth.signInWithCredential(credential);
    final User user = authResult.user;
    final User currentUser = firebaseAuth.currentUser;
    if (currentUser != null) {
      final result = await databasereference
          .collection('User')
          .where("Email", isEqualTo: currentUser.email)
          .get();
      final document = result.docs;
      if (document.length == 0) {
        databasereference.collection('User').doc(currentUser.uid).set({
          'Name': currentUser.displayName,
          'Email Adress': currentUser.email,
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomScreen()));
        showCustomFlushbar(context, 'Success', 'User is Successfully Created');
      } else {}
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[850],
        body: ProgressHUD(
          inAsyncCall: loader,
          opacity: 0.4,
          child: SafeArea(
              child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 180),
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Email',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      )),
                  CustomTextField(
                    keybordtype: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldsubmitted: (term) {
                      emailfocus.unfocus();
                      FocusScope.of(context).requestFocus(passwordfocus);
                    },
                    hintText: 'Email Adress',
                    nextNode: passwordfocus,
                    data: Icons.email,
                    controller: email,
                    isObsecure: false,
                    focusNode: emailfocus,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Password',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      )),
                  CustomTextField(
                    keybordtype: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onFieldsubmitted: (term) {
                      passwordfocus.unfocus();
                    },
                    hintText: 'Password',
                    data: Icons.lock,
                    controller: password,
                    isObsecure: false,
                    focusNode: passwordfocus,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sig Up using Social Media',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red[900]),
                        ),
                        onPressed: () async {
                          setState(() {
                            loader = true;
                          });
                          await signInWithGoogle();
                          setState(() {
                            loader = false;
                          });
                        },
                        child: Center(
                          child: Text(
                            'Google',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.orange[900]),
                        ),
                        onPressed: () async {
                          setState(() {
                            loader = true;
                          });
                          await SignInController().signIn(
                              auth: auth,
                              context: context,
                              email: email,
                              password: password);
                          setState(() {
                            loader = false;
                          });
                        },
                        child: Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont have an Account? ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  duration: Duration(seconds: 00001),
                                  type: PageTransitionType.leftToRight,
                                  child: SignUp(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
        ));
  }
}
