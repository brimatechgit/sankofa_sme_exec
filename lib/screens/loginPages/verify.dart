import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';

class Verify extends StatefulWidget {
  Verify({ Key? key }) : super(key: key);

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

    timer = Timer.periodic(Duration(seconds: 5), (timer){
      checkEmailVerified();
    });
    super.initState();
  }
@override
  void dispose() {
    timer.cancel;
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(
        "an email has been sent to ${user.email} please verify"
      ))

    );
  }
  Future<void> checkEmailVerified() async{
    user = auth.currentUser!;
    await user.reload();

    if(user.emailVerified){
      timer.cancel;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegistrationPage()));
    }
  }
}
