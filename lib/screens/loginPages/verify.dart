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
          Text("an email has been sent to ${user.email} please verify"),
          ElevatedButton(
              onPressed: () async {
                if (user.emailVerified) {
                  FirebaseFirestore.instance
                      .collection("Sectors")
                      .get()
                      .then((querySnapshot) {
                    querySnapshot.docs.forEach((result) {
                      //should add to the list immediately
                      setState(() {
                        sectors.add(result.get('Sector'));
                      });
                    });
                  });

                  //add valid user to db
                  await Database.addItem(
                    uid: user.uid,
                    fName: this.widget.nameContr.text,
                    email: this.widget.emailContr.text,
                  );

                  //push to register only when sectoprs are filled?
                  if (sectors.isNotEmpty && auth.currentUser != null)
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => RegistrationPage(),
                      ),
                    );
                }

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => RegistrationPage()));
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
