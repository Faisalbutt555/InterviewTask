import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:interview_task/controllers/SignupControler.dart';
import 'package:interview_task/views/Authentication/SignInScreen.dart';
import 'package:interview_task/views/BottomScreen.dart';
import 'package:interview_task/widgets/customTextField.dart';
import 'package:interview_task/widgets/loader.dart';
import 'package:interview_task/widgets/snack_bar.dart';
import 'package:page_transition/page_transition.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final databasereference = FirebaseFirestore.instance;

  final TextEditingController name = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpasword = TextEditingController();
  FocusNode namefocus = FocusNode();
  Country selected;
  FocusNode phonefocus = FocusNode();
  FocusNode emailfocus = FocusNode();
  FocusNode passwordfocus = FocusNode();
  FocusNode confirmpassfocus = FocusNode();
  bool showpassword = false;
  bool loader = false;
  String fname;
  String lname;
  String emaill;

  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

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
    fname = name.text = googleSignInAccount.displayName.toString();
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
        // setState(() {
        //   showCustomFlushbar(context, 'Alert', 'Already Found');
        // });
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
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 30),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Name',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    CustomTextField(
                      keybordtype: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldsubmitted: (term) {
                        namefocus.unfocus();
                        FocusScope.of(context).requestFocus(phonefocus);
                      },
                      hintText: 'Name',
                      nextNode: emailfocus,
                      data: Icons.person,
                      controller: name,
                      isObsecure: false,
                      focusNode: namefocus,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Phone Number',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (term) {
                          phonefocus.unfocus();
                          FocusScope.of(context).requestFocus(emailfocus);
                        },
                        focusNode: phonefocus,
                        controller: phonenumber,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(04),
                          filled: true,
                          fillColor: Colors.grey[800],
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[800],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.grey[800],
                            ),
                          ),
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CountryPicker(
                              showDialingCode: false,
                              showFlag: true,
                              showName: false,
                              dense: false,
                              onChanged: (Country country) {
                                setState(() {
                                  selected = country;
                                });
                              },
                              selectedCountry: selected,
                            ),
                          ),
                          suffixIcon: Icon(
                            Icons.clear,
                            color: Colors.white,
                            size: 20,
                          ),
                          focusColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Email Adress',
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
                      length: 1,
                      keybordtype: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldsubmitted: (term) {
                        passwordfocus.unfocus();
                        FocusScope.of(context).requestFocus(confirmpassfocus);
                      },
                      hintText: 'Password',
                      nextNode: confirmpassfocus,
                      data: Icons.lock,
                      controller: password,
                      isObsecure: true,
                      focusNode: passwordfocus,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Confirm Password',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        )),
                    CustomTextField(
                      length: 1,
                      keybordtype: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onFieldsubmitted: (term) {
                        confirmpassfocus.unfocus();
                      },
                      hintText: 'Confirm Password',
                      data: Icons.lock,
                      controller: confirmpasword,
                      isObsecure: true,
                      focusNode: confirmpassfocus,
                    ),
                    SizedBox(
                      height: 20,
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
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.red[900]),
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
                            await SignUpController().signup(
                              auth: firebaseAuth,
                              confirmpasword: confirmpasword,
                              context: context,
                              email: email,
                              name: name,
                              password: password,
                              phonenumber: phonenumber,
                              selected: selected,
                            );
                            setState(() {
                              loader = false;
                            });
                          },
                          child: Center(
                            child: Text(
                              'Sign Up',
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
                            'Already have an Account',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            width: 05,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    duration: Duration(seconds: 00001),
                                    type: PageTransitionType.rightToLeft,
                                    child: SignIn(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign In',
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
            ),
          )),
        ));
  }
}
