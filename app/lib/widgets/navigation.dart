


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// -----------------------------------------------------------------------------
//          External Packages
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'package:wits_overflow/screens/home_screen.dart';
import 'package:wits_overflow/screens/courses_screen.dart';
import 'package:wits_overflow/screens/sign_in_screen.dart';
import 'package:wits_overflow/screens/user_info_screen.dart';

// -----------------------------------------------------------------------------
//             NavDrawer class
// -----------------------------------------------------------------------------
class NavDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child:Text(
                'Wits Overflow',
                style: TextStyle(color: Colors.lightBlue, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              // color: Colors.white,
              // image: DecorationImage(
              //     fit: BoxFit.fill,
              //     image: AssetImage('assets/images/cover.jpg')
              // )
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context){
                    return HomeScreen();
                  },
                ),
              );
            },
          ),

          // uer profile
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text('Profile'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context){
                    return UserInfoScreen(user: FirebaseAuth.instance.currentUser!,);
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Courses'),
            onTap: () {
              // Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context){
                      return Courses();
                    }
                ),
              );
            },
          ),


          // LOGIN BUTTON
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Login'),
            onTap: () {
              // go to login page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context){
                    return SignInScreen();
                    // return SignIn();
                  }
                ),
              );
            },
          ),

          // LOGOUT BUTTON
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              // TODO: clear navigation stack
              FirebaseAuth.instance.signOut();
              GoogleSignIn().signOut();
              Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return SignInScreen();
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}

