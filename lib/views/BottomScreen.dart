import 'package:bottom_bar/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interview_task/views/Authentication/SignInScreen.dart';
import 'package:interview_task/views/profileUpdateScreen.dart';
import 'package:interview_task/widgets/snack_bar.dart';
import 'BlogPosts.dart';

class BottomScreen extends StatefulWidget {
  @override
  _BottomScreenState createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  int _currentPage = 0;
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _currentPage == 0
          ? FloatingActionButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
                showCustomFlushbar(
                    context, 'Alert', 'User is Successfulyy Logout');
              },
              child: Text(
                'LogOut',
                style: TextStyle(fontSize: 10),
              ),
            )
          : SizedBox(),
      body: PageView(
        controller: _pageController,
        children: [
          BlogPosts(),
          ProfileUpdateScreen(),
          Container(color: Colors.greenAccent.shade700),
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.blue,
          ),
          BottomBarItem(
            icon: Icon(Icons.account_circle_rounded),
            title: Text('Profile'),
            activeColor: Colors.orange,
          ),
          BottomBarItem(
            icon: Icon(Icons.logout),
            title: Text('LogOut'),
            activeColor: Colors.greenAccent.shade700,
            darkActiveColor: Colors.greenAccent.shade400,
          ),
        ],
      ),
    );
  }
}
