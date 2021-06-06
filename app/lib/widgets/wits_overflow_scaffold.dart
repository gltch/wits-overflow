import 'package:flutter/material.dart';
import 'package:wits_overflow/utils/wits_overflow_data.dart';
import 'package:wits_overflow/widgets/side_drawer.dart';

// ignore: must_be_immutable
class WitsOverflowScaffold extends StatelessWidget {

  late Future<List<Map<String, dynamic>>> courses;
  late Future<List<Map<String, dynamic>>> modules;
  final Widget body;

  WitsOverflowScaffold({required this.body}) {
    courses = WitsOverflowData().fetchCourses();
    modules = WitsOverflowData().fetchModules();
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wits Overflow'),
        actions: [
          // IconButton(
            //   icon: Image.network(
            //     FirebaseAuth.instance.currentUser!.photoURL!
            //   ), 
            //   onPressed: () {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(content: Text('This is a snackbar')));
            //   }),
              VerticalDivider(color: Colors.transparent,),
          ]
        ),
      drawer: SideDrawer(courses: courses, modules: modules),
      body: this.body
    );

  }

}

