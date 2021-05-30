import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:wits_overflow/screens/course_screen.dart';
import 'package:wits_overflow/utils/sidebar.dart';
import 'package:wits_overflow/utils/static.dart';

// TODO: trim trailing spaces on course name, faculty, school name

// -----------------------------------------------------------------------------
//                    COURSE CREATE FORM STATE
// -----------------------------------------------------------------------------
class CourseCreateForm extends StatefulWidget {
  @override
  CourseCreateFormState createState() {
    return CourseCreateFormState();
  }
}

// -----------------------------------------------------------------------------
//                      COURSE CREATE FORM STATE
// -----------------------------------------------------------------------------
class CourseCreateFormState extends State<CourseCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final descriptionController = TextEditingController();
  // final schoolController = FACULTIES_SCHOOLS[FACULTIES[0].toLowerCase()][0];
  // String facultyController = FACULTIES[0];
  String schoolController = '';
  String facultyController = '';
  String yearController = 'first';

  List<DropdownMenuItem<String>> facultyDropdownMenuItems =
      <DropdownMenuItem<String>>[DropdownMenuItem(child: Text(''), value: '')];
  List<DropdownMenuItem<String>> schoolDropdownMenuItems =
      <DropdownMenuItem<String>>[DropdownMenuItem(child: Text(''), value: '')];

  CourseCreateFormState() {
    this.facultyDropdownMenuItems.addAll(FACULTIES.map((e) {
          return DropdownMenuItem(child: Text(e), value: e.toLowerCase());
        }).toList());
  }

  void updateSchoolDropdownMenuItems() {
    print('[UPDATED SCHOOL DROP DOWN MENU ITEMS]');
    if (this.facultyController != '') {
      List<String> schools =
          FACULTIES_SCHOOLS[this.facultyController.toLowerCase()]['schools'];
      print('[SCHOOLS : ${schools.toString()}]');
      this.schoolDropdownMenuItems = <DropdownMenuItem<String>>[
        DropdownMenuItem(child: Text(''), value: '')
      ];
      this.schoolDropdownMenuItems.addAll(schools.map((e) {
            return DropdownMenuItem(child: Text(e), value: e.toLowerCase());
          }).toList());
      setState(() {});
    } else {
      setState(() {
        this.schoolController = '';
        this.schoolDropdownMenuItems = <DropdownMenuItem<String>>[
          DropdownMenuItem(child: Text(''), value: '')
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text('Wits overflow---'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                // course name
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextFormField(
                    controller: nameController,
                    maxLines: null,
                    maxLength: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter name';
                      }
                      return null;
                    },
                  ),
                ),

                // course code
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextFormField(
                    controller: codeController,
                    maxLines: null,
                    maxLength: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'code',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Specify code';
                      }
                      return null;
                    },
                  ),
                ),

                // course year
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Specify year';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'year',
                      ),
                      hint: Text("Select Device"),
                      value: yearController,
                      isDense: true,
                      onChanged: (newValue) {
                        setState(() {
                          yearController = newValue!;
                        });
                        print(
                            '[DROP DOWN BUTTON ON CHANGE VALUE: $yearController]');
                      },
                      items: [
                        DropdownMenuItem(
                          child: Text('first'),
                          value: 'first',
                        ),
                        DropdownMenuItem(
                            child: Text('second'), value: 'second'),
                        DropdownMenuItem(child: Text('third'), value: 'third'),
                        DropdownMenuItem(
                            child: Text('honours'), value: 'honours'),
                        DropdownMenuItem(
                            child: Text('masters'), value: 'masters'),
                        DropdownMenuItem(
                            child: Text('doctorate'), value: 'doctorate'),
                      ],
                    ),
                  ),
                ),

                // course faculty
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Faculty',
                      ),
                      hint: Text("Select faculty"),
                      value: this.facultyController,
                      isDense: true,
                      onChanged: (newValue) {
                        print('[NEW VALUE: $newValue]');
                        this.facultyController = newValue!;
                        this.updateSchoolDropdownMenuItems();
                      },
                      items: this.facultyDropdownMenuItems,
                    ),
                  ),
                ),

                // course school
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'School',
                      ),
                      hint: Text("Select school"),
                      value: this.schoolController,
                      isDense: true,
                      onChanged: (newValue) {
                        print(
                            '[SCHOOL DROP DOWN MENU ON CHANGE NEW VALUE: $newValue]');
                        this.schoolController = newValue!;
                        this.updateSchoolDropdownMenuItems();
                      },
                      items: this.schoolDropdownMenuItems,
                    ),
                  ),
                ),

                // course description
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextFormField(
                    controller: this.descriptionController,
                    maxLines: 15,
                    minLines: 10,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'description',
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: ElevatedButton(
                    onPressed: () {
                      print('[POST QUESTION BUTTON PRESSED]');
                      if (_formKey.currentState!.validate()) {
                        var name = this.nameController.text;
                        var code = this.codeController.text;
                        var description = this.descriptionController.text;
                        var school = this.schoolController;
                        var faculty = this.facultyController;
                        var year = this.yearController.toString();
                        print(
                            'title: $name, body: $description, school: $school, faculty: $faculty, year: $year');

                        CollectionReference coursesCollection =
                            FirebaseFirestore.instance.collection('courses');
                        var data = {
                          'name': name,
                          'description': description,
                          'school': school,
                          'faculty': faculty,
                          'year': year,
                          'admin': FirebaseAuth.instance.currentUser!.uid,
                          'datetime': DateTime.now(),
                          'code': code,
                        };
                        coursesCollection.add(data).then((value) {
                          print('[SUCCESSFULLY ADDED COURSE]');

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Successfully create course')),
                          );
                          // TODO: redirect user to course profile page
                          // pop this page from navigation stack

                          // redirect to course page
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return CourseProfile(value.id);
                            },
                          ));
                        }).catchError((error) {
                          print('[ERROR OCCURRED WHILE CREATING COURSE]: ' +
                              error.toString());
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                      } else {
                        print('[INVALID FORM DATA]');
                      }
                    },
                    child: Text('Create'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
