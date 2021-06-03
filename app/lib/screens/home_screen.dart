// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wits_overflow/utils/sidebar.dart';

// -----------------------------------------------------------------------------
//             Dashboard class
// -----------------------------------------------------------------------------
class HomeScreen extends StatefulWidget {
  // final logoutAction;

  final state = HomeScreenState(CircularProgressIndicator());

  HomeScreen() {
    print('[DASHBOARD CONSTRUCTOR]');
  }

  @override
  HomeScreenState createState() => state;
}

// -----------------------------------------------------------------------------
//    DASHBOARD STATE CLASS
// -----------------------------------------------------------------------------
class HomeScreenState extends State<HomeScreen> {
  Widget child;

  HomeScreenState(this.child);

  @override
  Widget build(BuildContext context) {
    print('[DASHBOARD STATE]');
    // CollectionReference questions =
    //     FirebaseFirestore.instance.collection('questions');
    return Scaffold(
      drawer: SideDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.blue),
      body: Center(child: Text("Wits Overflow Home Screen")),
    );
  }

  void show(Widget widget) {
    this.setState(() {
      child = widget;
    });
  }
}
