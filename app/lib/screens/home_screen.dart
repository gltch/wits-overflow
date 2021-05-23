import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wits_overflow/utils/sidebar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.blue),
      body: Center(child: Text("Wits Overflow Home Screen")),
    );
  }
}
