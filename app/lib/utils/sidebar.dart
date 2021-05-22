// Sidebar Code
import 'package:flutter/material.dart';
import 'package:wits_overflow/screens/home_screen.dart';
import 'package:wits_overflow/screens/post_question_screen.dart';
import 'package:wits_overflow/screens/sign_in_screen.dart';

class SideDrawer extends StatefulWidget {
  SideDrawer({Key? key}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 450,
            child: Scrollbar(
              child: ListView(
                padding: EdgeInsets.only(top: 0.0),
                children: <Widget>[
                  SizedBox(height: 25),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    // On tap should open a dropdown menu of ...
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen())),
                    },
                  ),
                  SizedBox(height: 25),
                  ExpansionTile(
                    title: Text("Modules"),
                    children: <Widget>[
                      // Module: COMS
                      ExpansionTile(
                        title: Text("Computer Science"),
                        // COMS modules
                        children: [
                          Container(
                            height: 170,
                            child: Scrollbar(
                              child: ListView(
                                padding: EdgeInsets.only(top: 0.0),
                                children: <Widget>[
                                  ListTile(
                                    leading:
                                        Icon(Icons.arrow_right_alt_outlined),
                                    title: Text('Machine Learning III'),
                                    // On tap should open a dropdown menu of ...
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PostQuestionScreen())),
                                    },
                                  ),
                                  ListTile(
                                    leading:
                                        Icon(Icons.arrow_right_alt_outlined),
                                    title: Text(
                                        'Formal Languages and Automata III'),
                                    // On tap should open a dropdown menu of ...
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PostQuestionScreen())),
                                    },
                                  ),
                                  ListTile(
                                    leading:
                                        Icon(Icons.arrow_right_alt_outlined),
                                    title: Text('Parallel Computing III'),
                                    // On tap should open a dropdown menu of ...
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PostQuestionScreen())),
                                    },
                                  ),
                                  ListTile(
                                    leading:
                                        Icon(Icons.arrow_right_alt_outlined),
                                    title: Text('Software Design III'),
                                    // On tap should open a dropdown menu of ...
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PostQuestionScreen())),
                                    },
                                  ),
                                  ListTile(
                                    leading:
                                        Icon(Icons.arrow_right_alt_outlined),
                                    title: Text('Software Design Project III'),
                                    // On tap should open a dropdown menu of ...
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PostQuestionScreen())),
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Module: CAM
                      ExpansionTile(
                        title: Text("Applied Maths"),
                        // CAM modules
                        children: [
                          Container(
                            height: 170,
                            child: Scrollbar(
                              child: ListView(
                                padding: EdgeInsets.only(top: 0.0),
                                children: <Widget>[
                                  ListTile(
                                    leading:
                                        Icon(Icons.arrow_right_alt_outlined),
                                    title: Text('Optimisation I'),
                                    // On tap should open a dropdown menu of ...
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PostQuestionScreen())),
                                    },
                                  ),
                                  ListTile(
                                    leading:
                                        Icon(Icons.arrow_right_alt_outlined),
                                    title: Text('Mechanics I'),
                                    // On tap should open a dropdown menu of ...
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PostQuestionScreen())),
                                    },
                                  ),
                                  ListTile(
                                    leading:
                                        Icon(Icons.arrow_right_alt_outlined),
                                    title: Text('Optimisation II'),
                                    // On tap should open a dropdown menu of ...
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PostQuestionScreen())),
                                    },
                                  ),
                                  ListTile(
                                    leading:
                                        Icon(Icons.arrow_right_alt_outlined),
                                    title: Text('Numerical Methods I'),
                                    // On tap should open a dropdown menu of ...
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PostQuestionScreen())),
                                    },
                                  ),
                                  ListTile(
                                    leading:
                                        Icon(Icons.arrow_right_alt_outlined),
                                    title: Text('Lagrangian Mechanics II'),
                                    // On tap should open a dropdown menu of ...
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PostQuestionScreen())),
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () => {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                        (route) => false)
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_circle_outlined),
                  title: Text('Profile'),
                  onTap: () => {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SignInScreen())),
                  },
                ),
                SizedBox(height: 25),
                Center(
                  child: Text("version information"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
