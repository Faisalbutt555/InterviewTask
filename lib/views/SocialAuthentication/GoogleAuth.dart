// import 'package:bottom_bar/bottom_bar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:interview_task/views/Authentication/SignInScreen.dart';
// import 'package:interview_task/views/profileUpdateScreen.dart';
// import 'package:interview_task/widgets/snack_bar.dart';
// import 'BlogPosts.dart';

// class BottomScreen extends StatefulWidget {
//   @override
//   _BottomScreenState createState() => _BottomScreenState();
// }

// class _BottomScreenState extends State<BottomScreen> {
//   int _currentPage = 0;
//   final _pageController = PageController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: _currentPage == 0
//             ? FloatingActionButton(
//                 onPressed: () {
//                   FirebaseAuth.instance.signOut();
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => SignIn()));
//                   showCustomFlushbar(
//                       context, 'Alert', 'User is Successfulyy Logout');
//                 },
//                 child: Text(
//                   'LogOut',
//                   style: TextStyle(fontSize: 10),
//                 ),
//               )
//             : SizedBox(),
//         body: _currentPage == 0
//             ? BlogPosts()
//             : _currentPage == 1
//                 ? ProfileUpdateScreen()
//                 : SignIn(),
//         bottomNavigationBar: Container(
//           padding: EdgeInsets.only(top: 13, right: 07, left: 13),
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               InkWell(
//                 onTap: () {
//                   setState(() {
//                     _currentPage = 0;
//                   });
//                 },
//                 child: Column(
//                   children: [Icon(Icons.home), Text('Home')],
//                 ),
//               ),
//               InkWell(
//                   onTap: () {
//                     setState(() {
//                       _currentPage = 1;
//                     });
//                   },
//                   child: Column(
//                     children: [
//                       Icon(Icons.account_circle_rounded),
//                       Text('Profile')
//                     ],
//                   )),
//               InkWell(
//                   onTap: () {
//                     setState(() {
//                       _currentPage = 2;
//                     });
//                   },
//                   child: Column(
//                     children: [Icon(Icons.logout), Text('LogOut')],
//                   )),
//             ],
//           ),
//         ));
//   }
// }
