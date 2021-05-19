import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:wits_overflow/widgets/navigation.dart';
import 'package:wits_overflow/screens/home_screen.dart';
import 'package:wits_overflow/screens/sign_up_screen.dart';
import 'package:wits_overflow/utils/authentication.dart';


// class SignInScreen extends StatefulWidget {
//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Material(
//         type: MaterialType.transparency,
//         child: Center(
//           child: Container(
//             padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
//             child: Column(
//               //mainAxisAlignment: MainAxisAlignment.center,
//               //crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Flexible(
//                   flex: 1,
//                   child: Image.asset(
//                     'assets/images/wits_logo_transparent.png',
//                     scale: 2,
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 Text(
//                   'Wits Overflow',
//                   style: TextStyle(
//                     color: const Color(0xff001b5a),
//                     fontSize: 40,
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 Text(
//                   "Welcome to Wits Overflow.  The ultimate in high-tech question answering goodness.  Enter for all your knowledge seeking needs.",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Currently we\'re catering exclusively to Wits students (lucky you), so click the button below to sign in with your student gmail account and get started on your journey to unlimited knowledge...',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontStyle: FontStyle.italic),
//                 ),
//                 SizedBox(height: 40),
//                 FutureBuilder(
//                   future: Authentication.initializeFirebase(
//                       context: context),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) {
//                       return Text('Error initializing Firebase');
//                     } else if (snapshot.connectionState ==
//                         ConnectionState.done) {
//                       return GoogleSignInButton();
//                     }
//                     return CircularProgressIndicator();
//                   },
//                 ),
//               ],
//             )
//           )
//         )
//       )
//     );
//   }
// }



// ----------------------------------------------------------------------------
//            Login Widget
// -----------------------------------------------------------------------------
class SignInScreen extends StatelessWidget {
  final String loginError;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  SignInScreen(this.loginError);

  // TODO: include email-and-password in login page
  // TODO: include google-sign-in in login page


  Future<String> signInUserWithEmailAndPassword(String email, String password) async{
    String error = '';
    try{

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch (e){
      if(e.code == 'weak-password'){
        error = 'The password provided is too weak';
      }
      else if(e.code == 'email-already-in-user'){
        error =  'The account already exists for that email address';
      }
      else{
        print('[UNKNOW ERROR OCCURRED]');
        print(e);
        error = 'Unknown error occurred';
      }
    }
    return error;
  }


  @override
  Widget build(BuildContext context) {
    print('[Login widget]');
    // User ? user;
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('wits-overflow'),
      ),
      body:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // sign-in with google button
            Text(
              'login',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Times',
                fontWeight: FontWeight.w600,
              ),
            ),

            OutlinedButton(
              onPressed: () {
                Future<User ?> user = Authentication.signInWithGoogle(context: context);
                // Future<UserCredential?> userCredential = app.state.signInWithGoogle();
                user.then((value){
                  if(value != null){
                    var email = value.email;
                    var uid = value.uid;
                    print('[USER EMAIL: $email, UID: $uid]');
                    // redirect to Dashboard
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context){
                          print('[NAVIGATING TO DASHBOARD]');
                          return HomeScreen();
                        },
                      ),
                    );
                  }
                  else{
                    //
                    SnackBar(
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'Error while logging in',
                        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
                      ),
                    );
                  }
                });
              },
              child: Text('Login with google'),
            ),
            // horizontal line
            Divider(),
            // email-and-password login form
            Center(
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        // style: ,
                        controller: emailController,
                        maxLines: null,
                        maxLength: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter email';
                          }
                          else if(!value.contains('@')){
                            return 'Invalid email format';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: this.emailController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'password',

                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
                        child: ElevatedButton(
                          // style: ,
                          onPressed:(){
                            print('[POST QUESTION BUTTON PRESSED]');
                            // print(_formKey.currentState.validate().toString());
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              var email = this.emailController.text;
                              var password = this.passwordController.text;
                              print('email: $email, password: $password');
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              print('[VALID FORM DATA]');
                              // TODO: sign in the user
                              // addQuestion(title, body);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text('Processing Data')));
                            }
                            else{
                              print('[INVALID FORM DATA]');

                            }
                          },
                          child: Text('Sign up'),
                        )
                      )
                    ],
                  ),
                ),
              ),
            ),

            //
            Divider(),
            // forgot password button
            TextButton(
              onPressed: (){
                print('[Forgot password? BUTTON PRESSED]');
                // TODO: implement password reset
              },
              child: Text('Forgot password?'),
            ),


            // go to sign up page
            TextButton(
              onPressed: (){
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context){
                      return SignUp();
                    },
                  )
                );
              },
              child: Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
