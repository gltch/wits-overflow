// Sidebar Code
import 'package:flutter/material.dart';
import 'package:wits_overflow/screens/home_screen.dart';
import 'package:wits_overflow/screens/post_question_screen.dart';
import 'package:wits_overflow/screens/question_list_screen.dart';
import 'package:wits_overflow/screens/sign_in_screen.dart';

class SideDrawer extends StatefulWidget {
  SideDrawer({Key? key}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    void _scrollToSelectedContent({required GlobalKey expansionTileKey}) {
      final keyContext = expansionTileKey.currentContext;
      if (keyContext != null) {
        Future.delayed(Duration(milliseconds: 200)).then((value) {
          Scrollable.ensureVisible(keyContext,
              duration: Duration(milliseconds: 200));
        });
      }
    }

    // Build the expansion tiles
    ExpansionTile createExpTile(String s) {
      if (s == "COMS") {
        final GlobalKey expansionTileKey = GlobalKey();
        return ExpansionTile(
          key: expansionTileKey,
          onExpansionChanged: (value) {
            if (value) {
              _scrollToSelectedContent(expansionTileKey: expansionTileKey);
            }
          },
          title: Text("Computer Science"),
          // COMS modules
          children: [
            Container(
              height: 170,
              child: Scrollbar(
                isAlwaysShown: true,
                child: ListView(
                  padding: EdgeInsets.only(top: 0.0),
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.arrow_right_alt_outlined),
                      title: Text('Machine Learning III'),
                      // On tap should open a dropdown menu of ...
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QuestionListScreen(module: "COMS3007"))),
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.arrow_right_alt_outlined),
                      title: Text('Formal Languages and Automata III'),
                      // On tap should open a dropdown menu of ...
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QuestionListScreen(module: "COMS3003"))),
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.arrow_right_alt_outlined),
                      title: Text('Parallel Computing III'),
                      // On tap should open a dropdown menu of ...
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QuestionListScreen(module: "COMS3008"))),
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.arrow_right_alt_outlined),
                      title: Text('Discrete Computational Structures I'),
                      // On tap should open a dropdown menu of ...
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QuestionListScreen(module: "COMS1016"))),
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.arrow_right_alt_outlined),
                      title: Text('Software Design III'),
                      // On tap should open a dropdown menu of ...
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QuestionListScreen(module: "COMS3009"))),
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      } else if (s == "CAM") {
        final GlobalKey expansionTileKey = GlobalKey();
        return ExpansionTile(
          key: expansionTileKey,
          onExpansionChanged: (value) {
            if (value) {
              _scrollToSelectedContent(expansionTileKey: expansionTileKey);
            }
          },
          title: Text("Mathematics"),
          // Maths modules
          children: [
            Container(
              height: 170,
              child: Scrollbar(
                isAlwaysShown: true,
                child: ListView(
                  padding: EdgeInsets.only(top: 0.0),
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.arrow_right_alt_outlined),
                      title: Text('Calculus I'),
                      // On tap should open a dropdown menu of ...
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QuestionListScreen(module: "MATH1036"))),
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.arrow_right_alt_outlined),
                      title: Text('Algebra I'),
                      // On tap should open a dropdown menu of ...
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QuestionListScreen(module: "MATH1034"))),
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.arrow_right_alt_outlined),
                      title: Text('Multivariable Calculus II'),
                      // On tap should open a dropdown menu of ...
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QuestionListScreen(module: "MATH2007"))),
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.arrow_right_alt_outlined),
                      title: Text('Abstract Mathematics II'),
                      // On tap should open a dropdown menu of ...
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QuestionListScreen(module: "MATH2015"))),
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.arrow_right_alt_outlined),
                      title: Text('Linear Algebra II'),
                      // On tap should open a dropdown menu of ...
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QuestionListScreen(module: "MATH2019"))),
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      } else
        return ExpansionTile(title: Text("none"), children: []);
    }

    return Drawer(
      child: Column(
        children: [
          // Profile Container
          Container(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 130,
                      height: 100,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            // Change code to get profile image of user
                            image: NetworkImage(
                                'https://holy.trinity.joburg/wp-content/uploads/2017/11/Wits-University-logo.jpg'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    // Change code to get username of user
                    Text('Username',
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                    // Change code to get eamil address of user
                    Text('Email Address',
                        style: TextStyle(color: Colors.white)),
                    ListTile(
                      title: Center(
                        child: Text('Edit Profile'),
                      ),
                      onTap: () => {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => SignInScreen())),
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Home Button
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            // On tap should open a dropdown menu of ...
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen())),
            },
          ),
          // Modules Container
          ExpansionTile(
            title: Text("Modules"),
            children: <Widget>[
              Container(
                height: 180,
                child: Scrollbar(
                  isAlwaysShown: true,
                  child: ListView(
                    padding: EdgeInsets.only(top: 0.0),
                    children: <Widget>[
                      // Module: COMS
                      createExpTile("COMS"),
                      // Module: CAM
                      createExpTile("CAM"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Spacer
          // Spacer(),
          SizedBox(height: 10),
          // Logout Button & Version Information
          Expanded(
            child: Column(
              children: <Widget>[
                // SizedBox(height: 40),
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
                SizedBox(height: 5),
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
