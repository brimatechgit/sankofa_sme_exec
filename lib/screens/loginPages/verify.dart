//call verify once user has been signed in

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';

class Verify extends StatefulWidget {
  Verify({Key? key, required this.nameContr, required this.emailContr})
      : super(key: key);
  final nameContr;
  final emailContr;

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {},
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: () {},
  );

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    // timer = Timer.periodic(Duration(seconds: 15), (timer) {
    //   checkEmailVerified();
    // });
    super.initState();
  }

  // @override
  // void dispose() {
  //   timer.cancel;
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "an email has been sent to ${this.widget.emailContr} please verify"),
          ElevatedButton(
              onPressed: () async {
                await user.reload();
                user = auth.currentUser!;

                if (user.emailVerified) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => RegistrationPage(),
                    ),
                  );
                } else {
// set up the AlertDialog
                  AlertDialog alert = AlertDialog(
                    title: Text("Verification"),
                    content: Text(
                        "User email has not been verified. Please verify to continue"),
                    actions: [cancelButton, continueButton],
                  );

                  // show the dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }

                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //     builder: (context) => RegistrationPage()));
              },
              child: Text('I have Verified'))
        ],
      ),
    ));
  }

  // Future<void> checkEmailVerified() async {
  //   user = auth.currentUser!;
  //   await user.reload();

  //   if (user.emailVerified) {
  //     timer.cancel;

  //     //state changes when user has to verify, so app cancels here....
  //     //to-to, get the state to listen for user returns, and keep the context

  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => RegistrationPage()));
  //   }
  // }
}
