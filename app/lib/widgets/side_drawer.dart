import 'package:flutter/material.dart';

class SideDrawer extends StatefulWidget {

  @override
  _SideDrawerState createState() => _SideDrawerState();
  
}

class _SideDrawerState extends State<SideDrawer> {
  
  @override
  Widget build(BuildContext context) {
    
    return Drawer(
      child: Stack(children: [

        Positioned(
          top: 0,
          child: Text("Test")
        ),

        Text("Testing"),
        
        Positioned(
          bottom: 0,
          child: Text("Test")
        )

      ])
    );

  }

}