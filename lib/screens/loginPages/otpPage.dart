import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:sankofa_sme_exec/screens/diagnosticsPage.dart';
import 'package:sankofa_sme_exec/screens/landingPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/companyRegistrationPage.dart';
import 'package:sankofa_sme_exec/screens/loginPages/signUpPage.dart';
import 'package:sankofa_sme_exec/utilities/constants.dart';
import 'package:sankofa_sme_exec/utilities/database.dart';

final otpController = TextEditingController();

//get user otp to verify they exist
class OtpPage extends StatefulWidget {
  final String fromPage;
  final emailC;
  final userList;
  final documentID;
  const OtpPage(
      {Key? key,
      required this.fromPage,
      required this.documentID,
      required this.emailC,
      required this.userList})
      : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
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
            obscureText: false,
            controller: otpController,
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
              hintText: 'Enter your OTP',
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
          //different routing for different pages
          if (this.widget.fromPage == 'signUp') {
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
            //check if otp is valid
            if (true

                // EmailAuth.validate(
                //   receiverMail: this.widget.emailC,
                //   userOTP: otpController.text)

                ) {
              //add valid user to db
              // await Database.addItem(
              //     fName: nameController.text, email: this.widget.emailC);

              //push to register only when sectoprs are filled?
              if (sectors.isNotEmpty)
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => RegistrationPage(),
                  ),
                );
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => RegistrationPage()));
            }
          } else {
            //should remove all pages in state, user cannot go back to prev page
            // if (EmailAuth.validate(
            //     receiverMail: this.widget.emailC,
            //     userOTP: otpController.text)) {
            //   Navigator.pushReplacementNamed(context, "/DiagnosticPage");
            // }
            Navigator.pushReplacementNamed(context, "/DiagnosticPage");
          }
        },
        child: Text(
          'LOGIN',
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
        title: Text('OTP'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ENTER OTP',
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
            _buildLoginBtn(context),
          ],
        ),
      ),
    );
  }
}
