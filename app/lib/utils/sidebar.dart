// Sidebar Code
import 'package:flutter/material.dart';
import 'package:wits_overflow/screens/home_screen.dart';
import 'package:wits_overflow/screens/post_question_screen.dart';
import 'package:wits_overflow/screens/sign_in_screen.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // COMS years drop down menu items list
    var _courseYears = ['Year 1', 'Year 2', 'Year 3', 'Year 4'];

    // var _courses = ['Computer Science', 'CAM', 'Maths'];
    var _currentYearSelected = "1";
    var _currentCourseSelected = "COMS";

    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(height: 25),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            // On tap should open a dropdown menu of ...
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen())),
            },
          ),
          SizedBox(height: 25),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Post Question'),
            // On tap should open a dropdown menu of ...
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostQuestionScreen())),
            },
          ),
          Spacer(flex: 3),
          Expanded(
            child: Column(
              children: <Widget>[
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
              ],
            ),
          )
        ],
      ),
    );
  }
}

//     children: <Widget>[
// Container(
//     width: double.infinity,
//     padding: EdgeInsets.all(20),
//     color: Theme.of(context).primaryColor,
//     child: Center(
//       child: Column(
//         children: <Widget>[
//           // Course Selector
//           DropdownButton<String>(
//             items: [
//               DropdownMenuItem<String>(
//                 value: "COMS",
//                 child: Center(
//                   child: Text("Computer Science"),
//                 ),
//               ),
//               DropdownMenuItem<String>(
//                 value: "CAM",
//                 child: Center(
//                   child: Text("Applied Mathematics"),
//                 ),
//               ),
//               DropdownMenuItem<String>(
//                 value: "Math",
//                 child: Center(
//                   child: Text("Mathematics"),
//                 ),
//               ),
//             ],
//             onChanged: (_value) => {
//               _currentCourseSelected = _value.toString(),
//             },
//             hint: Text("Select Year of Study"),
//             value: _currentCourseSelected,
//           ),

//           // Year Selector
//           DropdownButton<String>(
//             items: [
//               DropdownMenuItem<String>(
//                 value: "1",
//                 child: Center(
//                   child: Text("Year 1"),
//                 ),
//               ),
//               DropdownMenuItem<String>(
//                 value: "2",
//                 child: Center(
//                   child: Text("Year 2"),
//                 ),
//               ),
//               DropdownMenuItem<String>(
//                 value: "3",
//                 child: Center(
//                   child: Text("Year 3"),
//                 ),
//               ),
//               DropdownMenuItem<String>(
//                 value: "4",
//                 child: Center(
//                   child: Text("Honours"),
//                 ),
//               ),
//             ],
//             onChanged: (_value) => {
//               _currentYearSelected = _value.toString(),
//             },
//             hint: Text("Select Year of Study"),
//             value: _currentYearSelected,
//           ),

//           // Module Selector
//           DropdownButton<String>(
//             items: [
//               DropdownMenuItem<String>(
//                 value: "",
//                 child: Center(
//                   child: Text("Year 1"),
//                 ),
//               ),
//               DropdownMenuItem<String>(
//                 value: "2",
//                 child: Center(
//                   child: Text("Year 2"),
//                 ),
//               ),
//               DropdownMenuItem<String>(
//                 value: "3",
//                 child: Center(
//                   child: Text("Year 3"),
//                 ),
//               ),
//               DropdownMenuItem<String>(
//                 value: "4",
//                 child: Center(
//                   child: Text("Honours"),
//                 ),
//               ),
//             ],
//             onChanged: (_value) => {
//               _currentYearSelected = _value.toString(),
//             },
//             hint: Text("Select Year of Study"),
//             value: _currentYearSelected,
//           ),

//           Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               // image: DecorationImage(
//               //   image: NetworkImage()),
//               //   fit: BoxFit.fill),
//             ),
//           ),
//         ],
