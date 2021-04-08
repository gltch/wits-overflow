/// -----------------------------------
///          External Packages        
/// -----------------------------------

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

/// -----------------------------------
///           Auth0 Variables
/// -----------------------------------
const AUTH0_DOMAIN = 'dev-816n828v.us.auth0.com';
const AUTH0_CLIENT_ID = 'j8XxGZ7Nw6rcmCEIsk9grjOGddNKbmpr';

const AUTH0_REDIRECT_URI = 'com.auth0.flutterdemo://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';
/// -----------------------------------
///           Profile Widget           
/// -----------------------------------
class Profile extends StatelessWidget {
  final logoutAction;
  final String name;
  final String picture;

  Profile(this.logoutAction, this.name, this.picture);

  @override
  Widget build(BuildContext context) {
    print('[profile widget]');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 4.0),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(picture ?? ''),
            ),
          ),
        ),
        SizedBox(height: 24.0),
        Text('Name: $name'),
        SizedBox(height: 48.0),
        ElevatedButton(
          onPressed: () {
            logoutAction();
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}

/// -----------------------------------
///            Login Widget           
/// -----------------------------------
class Login extends StatelessWidget {
  final loginAction;
  final String loginError;

  const Login(this.loginAction, this.loginError);

  @override
  Widget build(BuildContext context) {
      print('[Login widget]');
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              loginAction();
            },
            child: Text('Login'),
          ),
          Text(loginError ?? ''),
        ],
      );
    }
}
/// -----------------------------------
///                 App                
/// -----------------------------------

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
    @override
    _MyAppState createState() => _MyAppState();
}

/// -----------------------------------
///              App State            
/// -----------------------------------

class _MyAppState extends State<MyApp> {
  bool isBusy = false;
  bool isLoggedIn = false;
  String errorMessage;
  String name;
  String picture;

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
          title: 'wits-stackoverflow',
          home: Scaffold(
              body: Center(
                  child: isBusy ? CircularProgressIndicator() : isLoggedIn ? Profile(logoutAction, name, picture) : Login(loginAction, errorMessage),
              ),
          ),
      );
  }
  //--------------------------------------------------------
  // PARSE ID TOKEN METHOD
  //
  //--------------------------------------------------------
  Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  // --------------------------------------
  //  GET USER DETAILS METHOD
  // --------------------------------------
  Future<Map<String, dynamic>> getUserDetails(String accessToken) async {
      final url = 'https://$AUTH0_DOMAIN/userinfo';
      final response = await http.get(
          url,
          headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
          return jsonDecode(response.body);
      } else {
          throw Exception('Failed to get user details');
      }
  }

  // --------------------------------------
  //  LOGIN METHOD
  // --------------------------------------
  Future<void> loginAction() async {
      // print('[loginAction]');
      setState(() {
          isBusy = true;
          errorMessage = '';
      });

      try {
          final AuthorizationTokenResponse result =
          await appAuth.authorizeAndExchangeCode(
              AuthorizationTokenRequest(
                AUTH0_CLIENT_ID,
                AUTH0_REDIRECT_URI,
                issuer: 'https://$AUTH0_DOMAIN',
                scopes: ['openid', 'profile', 'offline_access'],
                promptValues: ['login']
              ),
          );

          print(result);
          print(parseIdToken(result.idToken));
          print(result.accessToken);
          print(result.refreshToken);


          final idToken = parseIdToken(result.idToken);
          final profile = await getUserDetails(result.accessToken);
          await secureStorage.write(
              key: 'refresh_token', value: result.refreshToken);

          setState(() {
              isBusy = false;
              isLoggedIn = true;
              name = idToken['name'];
              picture = profile['picture'];
          });
      } catch (e, s) {
          // errors you might get
          // - PlatformException
          //
          print('login error: $e - stack: $s');

          setState(() {
              isBusy = false;
              isLoggedIn = false;
              errorMessage = e.toString();
          });
      }
  }

  // --------------------------------------
  //  LOGOUT METHOD
  // --------------------------------------
  void logoutAction() async {
      print('[logoutAction]');
      await secureStorage.delete(key: 'refresh_token');
      setState(() {
          isLoggedIn = false;
          isBusy = false;
      });
  }
  @override
  void initState() {
      initAction();
      super.initState();
  }

  void initAction() async {
      print('[initAction]');
      final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
      if (storedRefreshToken == null) {
          print('there is no stored refresh token');
          return;
      }
      setState(() {
          isBusy = true;
      });

      try {
          final response = await appAuth.token(TokenRequest(
              AUTH0_CLIENT_ID,
              AUTH0_REDIRECT_URI,
              issuer: AUTH0_ISSUER,
              refreshToken: storedRefreshToken,
          ));

        final idToken = parseIdToken(response.idToken);
        final profile = await getUserDetails(response.accessToken);

        secureStorage.write(key: 'refresh_token', value: response.refreshToken);

        setState(() {
            isBusy = false;
            isLoggedIn = true;
            name = idToken['name'];
            picture = profile['picture'];
        });
      } catch (e, s) {
          print('error on refresh token: $e - stack: $s');
          logoutAction();
      }
  }
}