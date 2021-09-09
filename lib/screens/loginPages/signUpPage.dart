import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/verify.dart';
import 'package:sankofa_sme_exec/utilities/constants.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'otpPage.dart';

final nameController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();
final auth = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  Future<void> performLogin(String provider, List<String> scopes,
      Map<String, String> parameters) async {
    try {
      await FirebaseAuthOAuth()
          .openSignInFlow(provider, scopes, parameters)
          .then((value) async => {
                await Database.addItem(
                  uid: value!.uid,
                  fName: value.displayName,
                  email: value.email,
                ),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Verify(
                          nameContr: value.displayName,
                          emailContr: value.email,
                        )))
              });
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

  // Future<void> addItem({
  //   required String fName,
  //   required String email,
  // }) async {
  //   DocumentReference documentReferencer = _mainCollection.doc(email);

  //   Map<String, dynamic> data = <String, dynamic>{
  //     "First Name": fName,
  //     "email": email,
  //   };

  //   await documentReferencer
  //       .set(data)
  //       .whenComplete(() => print("Notes item added to the database"))
  //       .catchError((e) => print(e));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              child: TextField(
                controller: nameController,
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
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              child: TextField(
                controller: emailController,
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
                  hintText: 'Enter email',
                  hintStyle: kHintTextStyle,
                ),
              ),
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              child: TextField(
                controller: passwordController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  hintText: 'Enter Password',
                  hintStyle: kHintTextStyle,
                ),
              ),
            ),
          ),
          ElevatedButton(
            child: Text('Enter'),
            onPressed: () async {
              //create document in db, that will be filled thoughout
              //once creation is successful show a toast box `successfully registered account`
              //move on to other page once email is validated
              //should check if email exists or not

              if (EmailValidator.validate(emailController.text)) {
                //send otp
                // EmailAuth.sessionName = "Test Session";
                // var res = await EmailAuth.sendOtp(receiverMail: emailController.text);
                // auth.createUserWithEmailAndPassword(
                //     email: emailController.text,
                //     password: passwordController.text);

                await auth
                    .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text)
                    .then((user) async {
                  if (user != null) {
                    await Database.addItem(
                      uid: auth.currentUser!.uid,
                      fName: auth.currentUser!.displayName,
                      email: auth.currentUser!.email,
                    );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Verify(
                              nameContr: nameController,
                              emailContr: emailController,
                            )));

                    // user.user!.sendEmailVerification();

                    //sign in user //temp

                    //   if (user.user!.emailVerified) {
                    //     auth.signInWithEmailAndPassword(
                    //         email: emailController.text,
                    //         password: passwordController.text);

                    //     FirebaseFirestore.instance
                    //         .collection("Sectors")
                    //         .get()
                    //         .then((querySnapshot) {
                    //       querySnapshot.docs.forEach((result) {
                    //         //should add to the list immediately
                    //         setState(() {
                    //           sectors.add(result.get('Sector'));
                    //         });
                    //       });
                    //     });

                    //     //add valid user to db
                    //     await Database.addItem(
                    //       uid: auth.currentUser!.uid,
                    //       fName: nameController.text,
                    //       email: emailController.text,
                    //     );

                    //     //push to register only when sectoprs are filled?
                    //     if (sectors.isNotEmpty && auth.currentUser != null)
                    //       Navigator.of(context).pushReplacement(
                    //         MaterialPageRoute(
                    //           builder: (context) => RegistrationPage(),
                    //         ),
                    //       );
                    // }
                  }
                });

                // FirebaseFirestore.instance
                //     .collection("Sectors")
                //     .get()
                //     .then((querySnapshot) {
                //   querySnapshot.docs.forEach((result) {
                //     //should add to the list immediately
                //     setState(() {
                //       sectors.add(result.get('Sector'));
                //     });
                //   });
                // });

                // //add valid user to db
                // await Database.addItem(
                //   uid: auth.currentUser!.uid,
                //   fName: nameController.text,
                //   email: emailController.text,
                // );

                // //push to register only when sectoprs are filled?
                // if (sectors.isNotEmpty && auth.currentUser != null)
                //   Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(
                //       builder: (context) => RegistrationPage(),
                //     ),
                //   );
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => RegistrationPage()));

                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => Verify()));
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => RegistrationPage()));

                // if (true) {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => OtpPage(
                //                 emailC: emailController.text,
                //                 fromPage: 'signUp',
                //                 documentID: null,
                //                 userList: null,
                //               )));
                // }
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Notice"),
                      content: Text("Invalid email entered"),
                      actions: [],
                    );
                  },
                );
              }
            },
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            'One Tap Sign Up',
            style: TextStyle(fontSize: 25.0),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SignInButton(Buttons.Microsoft, onPressed: () async {
              await performLogin("microsoft.com", ["email"], {"locale": "en"});
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SignInButton(Buttons.Google, onPressed: () async {
              await performLogin("google.com", ["email"], {"locale": "en"});
            }),
          ),
        ]),
      ),
    );
  }
}
