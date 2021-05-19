import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:wits_overflow/screens/sign_in_screen.dart';
import 'package:wits_overflow/screens/home_screen.dart';



import 'package:flutter/foundation.dart' show kIsWeb;

final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

/*
* 
* https://github.com/gltch/wits-overflow/blob/system-design/assets/diagrams/StateDiagram.png?raw=true


keytool -list -v -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore


keytool -list -v -alias <your-key-name> -keystore <path-to-production-keystore>
 */

// -----------------------------------------------------------------------------
//           Auth0 Variables
// -----------------------------------------------------------------------------
const AUTH0_DOMAIN = 'dev-816n828v.us.auth0.com';
const AUTH0_CLIENT_ID = 'j8XxGZ7Nw6rcmCEIsk9grjOGddNKbmpr';

const AUTH0_REDIRECT_URI = 'com.auth0.flutterdemo://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

final app = MyApp();
var user;


// TODO: Allow email and password sign up in firebase


// -----------------------------------------------------------------------------
//             RUN APPLICATION
// -----------------------------------------------------------------------------
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(app);
}


// -----------------------------------------------------------------------------
//             MyApp
// -----------------------------------------------------------------------------
class MyApp extends StatefulWidget {
  final state = _MyAppState(new CircularProgressIndicator());

  @override
  // _MyAppState createState() => _MyAppState();
  _MyAppState createState() => this.state;
}

// -----------------------------------------------------------------------------
//                      MyAppState
// -----------------------------------------------------------------------------
class _MyAppState extends State<MyApp> {
  // bool isBusy = false;
  bool isLoggedIn = false;
  // String errorMessage;
  // String name;
  // String picture;
  Widget body;


  // ---------------------------------------------------------------------------
  //
  // ---------------------------------------------------------------------------
  _MyAppState(this.body){
    // this.body = null;
    print('[_MyAppState] constructor');
  }

  // ---------------------------------------------------------------------------
  //
  // ---------------------------------------------------------------------------
  CircularProgressIndicator showCircularProgressIndicator(){
    /*
    show loader/ progress
     */
    CircularProgressIndicator circularProgressIndicator = new CircularProgressIndicator();
    this.setState(() {
      this.body = circularProgressIndicator;
    });
    return circularProgressIndicator;
  }


  // ---------------------------------------------------------------------------
  //            BUILD
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    print('[_MyAppState]');

    return MaterialApp(
      title: 'wits-overflow',
      /*
      if user is logged in
        home =  Dashboard
      else
        home = Login
      */
      home: isLoggedIn ? HomeScreen() : Scaffold(
        body: Center(
          // child: Dashboard(logoutAction),
          child: this.body,
          // child: isBusy ? CircularProgressIndicator() : isLoggedIn ? Dashboard(logoutAction) : Login(errorMessage),
        ),
      ),
    );
  }


  // ---------------------------------------------------------------------------
  //                SIGN IN WITH GOOGLE
  // ---------------------------------------------------------------------------
  Future<UserCredential?> signInWithGoogle() async {

    print('[signInWithGoogle]');
    // show loading
    setState(() {
      this.body = CircularProgressIndicator();
    });

    FirebaseAuth auth = FirebaseAuth.instance;
    // User? user;

    if (kIsWeb) {
      print('[THIS IW WEB APPLICATION]');
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      authProvider.setCustomParameters({"prompt": 'select_account'});

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);
        user = userCredential.user;
        return userCredential;
      } catch (e) {
        print('[ERROR OCCURRED USING GOOGLE SIGN-IN. TRY AGAIN]');
        return null;
      }
    }
    else {
      print('[THIS IS ANDROID APPLICATION]');
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
          return userCredential;
        }
        on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                content:
                    'The account already exists with a different credential.',
              ),
            );
          } else if (e.code == 'invalid-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                content:
                    'Error occurred while accessing credentials. Try again.',
              ),
            );
          }
          return null;
        }
        catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              content: 'Error occurred using Google Sign-In. Try again.',
            ),
          );
          return null;
        }
      }
    }
  }

  // --------------------------------------------------------------------------
  // METHOD TO SHOW CONTENT ON THE MAIN PAGE
  // --------------------------------------------------------------------------
  void show(Widget widget){
    this.body = widget;
  }

  // --------------------------------------------------------------------------
  //  LOGOUT METHOD
  // --------------------------------------------------------------------------

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }


  // --------------------------------------------------------------------------
  //  LOGOUT METHOD
  // --------------------------------------------------------------------------
  void logoutAction() async {
    /*
    handler when a user presses the logout button
     */
    // print('[logoutAction]');
    // await secureStorage.delete(key: 'refresh_token');
    // setState(() {
    //   // go to login page
    //   this.body = Login('');
    // });
    var line = '[LOGGIN OUT USER: ' + FirebaseAuth.instance.currentUser.toString() + ']';
    print(line);
    FirebaseAuth.instance.signOut();

    // TODO: clear navigation stack
    Navigator.pushNamedAndRemoveUntil(this.context, 'Login', (route) => false,);
    // redirect user to login page
    // Navigator.push(
    //   this.context,
    //   MaterialPageRoute(
    //       builder: (context) => Login(''),
    //   ),
    // );

  }

  @override
  void initState() {
    initAction();
    super.initState();
  }


  void initAction() async {
    print('[initAction]');
    // show that the page is loading
    this.setState(() {
      this.body = CircularProgressIndicator();
    });


    await Firebase.initializeApp();
    // FirebaseAuth auth = FirebaseAuth.instance;
    // User? user;

    if(FirebaseAuth.instance.currentUser == null){
      // navigate to login
      print('[USER NOT LOGGED IN]');
      setState(() {
        // this.body = Login('');
        this.body = SignInScreen('');
      });
    }
    else{
      print('[USER IS LOGGED IN]');
      // continue to dashboard
      this.setState(() {
        this.isLoggedIn = true;
      });
    }
  }
}



// -----------------------------------------------------------------------------
// TODO: combine  multiple futures in FutureBuilder using the code below
//
// Future.wait([bar, foo])
// -----------------------------------------------------------------------------




