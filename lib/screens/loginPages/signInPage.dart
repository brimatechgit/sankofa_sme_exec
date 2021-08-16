

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/diagnosticsPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/otpPage.dart';
import 'package:sankofa_sme_exec/utilities/constants.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

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
          auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
         // auth.signInWithEmailLink(email: _emailController.text, emailLink: emailLink);
          //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DiagnosticsPage(docID: docID)))
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegistrationPage()));
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
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Enter Email',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 30.0),
        _buildOTP(),
        SizedBox(
          height: 30.0,

        ),
         SizedBox(height: 30.0),
        _buildPassword(),
        SizedBox(
          height: 30.0,

        ),

        _buildLoginBtn(context),

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
    );
  }
}
