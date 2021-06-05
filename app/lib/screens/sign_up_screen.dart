import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wits_overflow/utils/sidebar.dart';

// -----------------------------------------------------------------------------
//             Profile class
// -----------------------------------------------------------------------------
class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<String> signUpWithEmailAndPassword(
      String email, String password) async {
    String error = '';
    try {
      // UserCredential userCredential = await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-user') {
        error = 'The account already exists for that email address';
      } else {
        print('[UNKNOW ERROR OCCURRED]');
        print(e);
        error = 'Unknow error occorred';
      }
    }
    return error;
  }

  Future<String> signUpWithGoogle(String email, String password) async {
    String error = '';
    try {
      // UserCredential userCredential = await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-user') {
        error = 'The account already exists for that email address';
      } else {
        print('[UNKNOW ERROR OCCURRED]');
        print(e);
        error = 'Unknow error occorred';
      }
    }
    return error;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text('wits-overflow'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {}, child: Text('Sign in with google')),
                Divider(),
                // email
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter email';
                    }
                    return null;
                  },
                ),
                // password
                TextFormField(
                  controller: this.passwordController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'password',
                  ),
                  validator: (value) {
                    // emapty password
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    // password does not match with confirm password
                    else if (value != this.confirmPasswordController.text) {
                      return 'Passwords don\'t match';
                    }
                    return null;
                  },
                ),
                // confirm password
                TextFormField(
                  controller: this.confirmPasswordController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'confirm password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    // when password and confirm passwords don't match
                    else if (value != this.passwordController.text) {
                      return 'Passwords don\'t match';
                    }
                    return null;
                  },
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
                    child: ElevatedButton(
                      onPressed: () {
                        print('[POST QUESTION BUTTON PRESSED]');
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          var email = this.emailController.text;
                          var password = this.passwordController.text;
                          var confirmPassword =
                              this.confirmPasswordController.text;
                          print(
                              'email: $email, password: $password, confirm password: $confirmPassword');
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          // print('[VALID FORM DATA]');

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));
                        } else {
                          print('[INVALID FORM DATA]');
                        }
                      },
                      child: Text('Sign up'),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
