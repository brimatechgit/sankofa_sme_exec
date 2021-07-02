import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/utilities/constants.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';

import 'otpPage.dart';

 final nameController = TextEditingController();
 final emailController = TextEditingController();

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

 

 

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
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                  Icons.email,
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
        ElevatedButton(
          child: Text('Enter'),
          onPressed: () async {
            //create document in db, that will be filled thoughout
            //once creation is successful show a toast box `successfully registered account`
            //move on to other page once email is validated
            //should check if email exists or not

            if (EmailValidator.validate(emailController.text)) {
              //send otp
              EmailAuth.sessionName = "Test Session";
  var res = await EmailAuth.sendOtp(receiverMail: emailController.text); 

              if (res) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OtpPage(
                          emailC: emailController.text,
                              fromPage: 'signUp', documentID: null, userList: null,
                            )));
              }
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
        )
      ]),
    );
  }
}
