import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sankofa_sme_exec/screens/landingPage.dart';
import 'package:sankofa_sme_exec/temp/auth.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Future<void> performLogin(String provider, List<String> scopes,
      Map<String, String> parameters) async {
    try {
      await FirebaseAuthOAuth().openSignInFlow(provider, scopes, parameters);
    } on PlatformException catch (error) {
      /**
       * The plugin has the following error codes:
       * 1. FirebaseAuthError: FirebaseAuth related error
       * 2. PlatformError: An platform related error
       * 3. PluginError: An error from this plugin
       */
      debugPrint("${error.code}: ${error.message}");
    }
  }

  Future<void> performLink(String provider, List<String> scopes,
      Map<String, String> parameters) async {
    try {
      await FirebaseAuthOAuth()
          .linkExistingUserWithCredentials(provider, scopes, parameters);
    } on PlatformException catch (error) {
      /**
       * The plugin has the following error codes:
       * 1. FirebaseAuthError: FirebaseAuth related error
       * 2. PlatformError: An platform related error
       * 3. PluginError: An error from this plugin
       */
      debugPrint("${error.code}: ${error.message}");
    }
  }

  bool _isSigningIn = false;
  Map<String, dynamic>? _userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        'assets/firebase_logo.png',
                        height: 160,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'FlutterFire',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      'Authentication',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
              // FutureBuilder(
              //   future: Authentication.initializeFirebase(context: context),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasError) {
              //       return Text('Error initializing Firebase');
              //     } else if (snapshot.connectionState == ConnectionState.done) {
              //       return GoogleSignInButton();
              //     }
              //     return CircularProgressIndicator(
              //       valueColor: AlwaysStoppedAnimation<Color>(
              //         Colors.amber,
              //       ),
              //     );
              //   },
              // ),
              SignInButton(Buttons.Google, onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });

                // TODO: Add a method call to the Google Sign-In authentication
                User? user =
                    await Authentication.signInWithGoogle(context: context);

                setState(() {
                  _isSigningIn = false;
                });
                // if (user != null) {
                //   Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(
                //       builder: (context) => UserInfoScreen(
                //         user: user,
                //       ),
                //     ),
                //   );
                // }
                if (user != null) {
                  FirebaseFirestore.instance
                      .collection("Users")
                      .where("email", isEqualTo: user.email) //change email here
                      .get()
                      .then((value) => value.docs.forEach((element) {
                            // element.id;

                            print(element.id);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LandingPage(
                                        from: 'sign-in', docID: element.id)));
                          }));
                }
              }),
              SignInButton(
                Buttons.Facebook,
                onPressed: () async {
//                   if (kIsWeb) {
//                     FacebookPermissions? permissions =
//                         await FacebookAuth.instance.permissions;
// // or FacebookAuth.i.permissions

//                   }

                  final LoginResult result = await FacebookAuth.instance
                      .login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()

                  if (result.status == LoginStatus.success) {
                    // you are logged
                    final AccessToken accessToken = result.accessToken!;
                    final userData = await FacebookAuth.instance
                        .getUserData(fields: 'name,email, picture');

                    //put user data in the users collection in the db

                    //   Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(
                    //     builder: (context) => UserInfoScreen(
                    //       user: userData,
                    //     ),
                    //   ),
                    // );
                  }
                },
                mini: true,
              ),

              SignInButton(Buttons.Microsoft, onPressed: () async {
                await performLogin(
                    "microsoft.com", ["email"], {"locale": "en"});
              }),
            ],
          ),
        ),
      ),
    );
  }
}
