import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:interview_task/controllers/UpdateProfileControler.dart';

import 'package:interview_task/widgets/customTextField.dart';
import 'package:interview_task/widgets/loader.dart';
import 'package:interview_task/widgets/snack_bar.dart';

class ProfileUpdateScreen extends StatefulWidget {
  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  void initState() {
    super.initState();
    setState(() {
      loader = true;
    });
    fetchUserInfo();
    setState(() {
      loader = false;
    });
  }

  String fname;
  String fnumb;
  String femaill;
  String pass;
  String cnfpass;
  fetchUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .get()
          .then((value) {
        fname = name.text = value.data()['Name'];
        fnumb = phonenumber.text = value.data()['Mobile Number'];
        femaill = email.text = value.data()['Email Adress'];
        pass = password.text = value.data()['Password'];
        cnfpass = confirmpasword.text = value.data()['Confirm Password'];
      }).catchError((e) {
        showCustomFlushbar(context, 'Alert!', e.toString());
      });
    }
  }

  // updateprofile() async {
  //   final update = FirebaseAuth.instance.currentUser;
  //   if (update != null) {
  //     FirebaseFirestore.instance.collection('User').doc(update.uid).update({
  //       'Name': name.text,
  //       'Mobile Number': phonenumber.text,
  //       'Email Adress': email.text,
  //       'Password': password.text,
  //       'Confirm Password': confirmpasword.text,
  //     }).then((value) {
  //       Navigator.push(
  //         context,
  //         PageTransition(
  //           duration: Duration(seconds: 00001),
  //           type: PageTransitionType.rightToLeft,
  //           child: BottomScreen(),
  //         ),
  //       );
  //       showCustomFlushbar(context, 'Success', 'Successfully Updated');
  //     }).catchError((e) {
  //       showCustomFlushbar(context, 'Alert!', e.toString());
  //     });
  //   }
  // }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final databasereference = FirebaseFirestore.instance;
  TextEditingController name = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Update Profile',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        backgroundColor: Colors.grey[850],
        body: ProgressHUD(
          inAsyncCall: loader,
          opacity: 0.4,
          child: SafeArea(
              child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 30),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
                      hintText: 'Number',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      // prefixIcon: Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: CountryPicker(
                      //     showDialingCode: false,
                      //     showFlag: true,
                      //     showName: false,
                      //     dense: false,
                      //     onChanged: (Country country) {
                      //       setState(() {
                      //         selected = country;
                      //       });
                      //     },
                      //     selectedCountry: selected,
                      //   ),
                      // ),
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
                  isObsecure: showpassword,
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
                        await UpdateProfileControler().updateprofile(
                            firebaseAuth,
                            databasereference,
                            name,
                            email,
                            phonenumber,
                            password,
                            confirmpasword,
                            context);
                        setState(() {
                          loader = false;
                        });
                      },
                      child: Center(
                        child: Text(
                          'Update Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      )),
                ),
              ],
            ),
          )),
        ));
  }
}
