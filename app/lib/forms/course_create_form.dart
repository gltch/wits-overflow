
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:wits_overflow/widgets/navigation.dart';
import 'package:wits_overflow/screens/course_screen.dart';


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
  final schoolController = TextEditingController();
  final facultyController = TextEditingController();
  var yearController = 'first';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('wits-overflow'),
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

                // course code
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
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
                        print('[DROP DOWN BUTTON ON CHANGE VALUE: $yearController]');
                      },
                      items: [
                        DropdownMenuItem(child: Text('first'), value: 'first',),
                        DropdownMenuItem(child: Text('second'), value: 'second'),
                        DropdownMenuItem(child: Text('third'), value: 'third'),
                        DropdownMenuItem(child: Text('honours'), value: 'honours'),
                        DropdownMenuItem(child: Text('masters'), value: 'masters'),
                        DropdownMenuItem(child: Text('doctorate'), value: 'doctorate'),
                      ],
                    ),
                  ),
                ),


                // course faculty
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextFormField(
                    controller: this.facultyController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'faculty',

                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Specify faculty';
                      }
                      return null;
                    },
                  ),
                ),


                // course school
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextFormField(
                    controller: this.schoolController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'school',

                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Specify school';
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Describe course';
                      }
                      return null;
                    },
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
                          var school = this.schoolController.text;
                          var faculty = this.facultyController.text;
                          var year = this.yearController.toString();
                          print('title: $name, body: $description, school: $school, faculty: $faculty, year: $year');

                          CollectionReference coursesCollection = FirebaseFirestore.instance.collection('courses');
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
                          coursesCollection.add(data).then((value){
                            print('[SUCCESSFULLY ADDED COURSE]');

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Successfully create course')
                              ),
                            );
                            // TODO: redirect user to course profile page
                            // pop this page from navigation stack

                            // redirect to course page
                            Navigator.push(
                                context, MaterialPageRoute(
                              builder: (context){
                                return CourseProfile(value.id);
                              },
                            )
                            );
                          })
                              .catchError((error){
                            print('[ERROR OCCURRED WHILE CREATING COURSE]: '+ error.toString());
                          });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(
                              'Processing Data')));
                        }
                        else {
                          print('[INVALID FORM DATA]');
                        }
                      },
                      child: Text('Create'),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
