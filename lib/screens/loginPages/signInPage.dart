import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:sankofa_sme_exec/functions/googleSignIn.dart';
import 'package:sankofa_sme_exec/screens/diagnosticsPage.dart';
import 'package:sankofa_sme_exec/screens/landingPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/otpPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/signUpPage.dart';
import 'package:sankofa_sme_exec/temp/auth.dart';
import 'package:sankofa_sme_exec/utilities/constants.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';
import 'package:sankofa_sme_exec/widgets/login_widgets.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool _isSigningIn = false;

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

  Widget _buildOTP() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Example@email.com',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _passwordController,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: ElevatedButton(
        onPressed: () async {
          auth.signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
          // auth.signInWithEmailLink(email: _emailController.text, emailLink: emailLink);
          //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DiagnosticsPage(docID: docID)))

          if (auth.currentUser == null) {
            print('no user signed in');
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => LandingPage(
                          from: 'sign-in',
                          docID: auth.currentUser!.uid,
                        )),
                (Route<dynamic> route) => false);

            // Navigator.of(context).pushReplacement(MaterialPageRoute(
            //     builder: (context) => LandingPage(
            //           docID: auth.currentUser!.uid,
            //         )));
          }
        },
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // _EmailLinkSignInSection(),

              Text('One Tap Sign In'),

              SizedBox(
                height: 15.0,
              ),

              SignInButton(
                Buttons.Google,
                onPressed: () async {
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
                        .where("email",
                            isEqualTo: user.email) //change email here
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
                },
              ),

              SizedBox(
                height: 15.0,
              ),
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
              ),
              SizedBox(
                height: 15.0,
              ),

              SignInButton(Buttons.Microsoft, onPressed: () async {
                await performLogin(
                    "microsoft.com", ["email"], {"locale": "en"});
              }),

              SizedBox(
                height: 15.0,
              ),

              SignInButton(Buttons.Email, onPressed: () {
                //navigate to password email page
              }),

              // Text(
              //   'Enter Email',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontFamily: 'OpenSans',
              //     fontSize: 30.0,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // TextFieldWidget(
              //     textController: _emailController,
              //     hint: 'Email@example.com',
              //     icon: Icons.email,
              //     type: TextInputType.emailAddress,
              //     obscure: false),
              // Text(
              //   'Enter Password',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontFamily: 'OpenSans',
              //     fontSize: 30.0,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // TextFieldWidget(
              //     textController: _passwordController,
              //     hint: 'password',
              //     icon: Icons.lock,
              //     type: TextInputType.visiblePassword,
              //     obscure: true),
              // SizedBox(height: 30.0),
              // _buildOTP(),
              // SizedBox(
              //   height: 30.0,
              // ),
              // SizedBox(height: 30.0),
              // // _buildPassword(),
              // // SizedBox(
              // //   height: 30.0,

              // // ),

              // _buildLoginBtn(context),

              // Flexible(

              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Text('Please enter email'),
              //       ),
              //       Container(
              //         alignment: Alignment.centerLeft,
              //         decoration: kBoxDecorationStyle,
              //         height: 60.0,
              //         child: TextField(
              //           controller: _emailController,
              //           keyboardType: TextInputType.text,
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontFamily: 'OpenSans',
              //           ),
              //           decoration: InputDecoration(
              //             border: InputBorder.none,
              //             contentPadding: EdgeInsets.only(top: 14.0),
              //             prefixIcon: Icon(
              //               Icons.email,
              //               color: Colors.white,
              //             ),
              //             hintText: 'email@email.com',
              //             hintStyle: kHintTextStyle,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Flexible(

              //     child: Padding(
              //       padding: const EdgeInsets.all(12.0),
              //       child: ElevatedButton(
              //           onPressed: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => OtpPage(
              //                           fromPage: 'signIn',
              //                         )));
              //           },
              //           child: Text('Submit')),
              //     ))
            ]),
      ),
    );
  }
}
